rm(list = ls())

# 0 packages ----
library(tidyverse)
library(zoo)

# 1 descriptive lsoa lookups ----
# 1a import all the data to create descr stats by lsoa ----

# import the frail attendances across time by lsoa
lsoas <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_apc_individuals.csv", 
  header = FALSE)  |> 
  transmute(lsoa2011 = V1, 
            lsoa2021 = V2, 
            gp_code = V3, 
            frail_individuals = as.numeric(V4))

lsoas <- lsoas |> 
  group_by(lsoa2021, gp_code) |> 
  summarise(frail_individuals = sum(frail_individuals)) |> 
  ungroup() |> 
  subset(substr(x = lsoa2021, start = 1, stop = 1) == "E")

# import the 2021 imd data
# downloaded from https://communitiesopendata-communities.hub.arcgis.com/datasets/4da63019f25546aa92a922a5ea682950_0/about
imd21 <- read.csv(
  file = "1b_Raw_Data/control_vars/LSOA_IMD2025_OSGB1936_-7580747902701771840.csv") |> 
  transmute(lsoa2021 = LSOA.Code, 
            lsoa_name = LSOA.Name, 
            imd_rank_2021 = as.numeric(LSOA.IMD.Ranking), 
            imd_decile_2021 = as.numeric(IMD.Decile) )


# extract rurality
# downloaded from https://www.ons.gov.uk/methodology/geography/geographicalproducts/ruralurbanclassifications/2021ruralurbanclassification
# this includes lsoas in wales
rurality21 <- readxl::read_xlsx(
  path = "1b_Raw_Data/control_vars/rucallsupplementarytables.xlsx", 
  sheet = 5, 
  skip = 2) |> 
  transmute(lsoa2021 = LSOA21CD, 
            rurality = `Rural Urban flag`)

# gp populations
gp_pops <- lsoas |>
  group_by(gp_code) |> 
  summarise(frail_inds_across_all_gp = sum(frail_individuals)) |> 
  ungroup()


# 1b join together descriptive lsoa data  ----

lookups <- left_join(
  x = imd21, y = rurality21, 
  by = "lsoa2021")
# left join in order to drop the welsh lsoas

lsoas_with_controls <- left_join(
  x = lsoas, y = lookups, 
  by = "lsoa2021")

lsoas_with_ctrls_pop <- left_join(
  x = lsoas_with_controls, y = gp_pops, 
  by = "gp_code")

# aggregate at the gpr code level ---

# deprivation
depr_gp_code <- left_join(
  x = gp_pops |> 
        mutate(deprivation = "deprived"), 
  y = lsoas_with_ctrls_pop |>
    mutate(deprivation = ifelse(test = imd_decile_2021 <= 2, 
                                yes = "deprived", 
                                no = "not deprived")) |> 
    group_by(gp_code, deprivation) |> 
    summarise(frail_individuals = sum(frail_individuals, na.rm = T), 
              frail_inds_across_all_gp = nth(frail_inds_across_all_gp, 1)) |>
    ungroup() |> 
    subset(deprivation == "deprived")) |> 
  mutate(frail_individuals = ifelse(test = is.na(frail_individuals), 
                                    yes = 0, 
                                    no = frail_individuals)) |> 
  mutate(depr_prop = frail_individuals/frail_inds_across_all_gp) |> 
  select(gp_code, depr_prop, frail_inds_across_all_gp)

# rurality
rural_gp_code <- left_join(
  x = gp_pops |> 
    mutate(rurality = "Rural"), 
  y = lsoas_with_ctrls_pop |>
    group_by(gp_code, rurality) |> 
    summarise(frail_individuals = sum(frail_individuals, na.rm = T), 
              frail_inds_across_all_gp = nth(frail_inds_across_all_gp, 1)) |>
    ungroup() |> 
    subset(rurality == "Rural")) |> 
  mutate(frail_individuals = ifelse(test = is.na(frail_individuals), 
                                    yes = 0, 
                                    no = frail_individuals)) |> 
  mutate(rural_prop = frail_individuals/frail_inds_across_all_gp) |> 
  select(gp_code, rural_prop, frail_inds_across_all_gp)

gp_codes.0 <- full_join(depr_gp_code, rural_gp_code) |> 
  select(gp_code, frail_inds_across_all_gp, 
         depr_prop, rural_prop)

# remove everything ap1rt from the desired outcome
rm(list = setdiff(ls(), c("gp_codes.0")))

# 2 construct gp to icb lookup BUT BETTER ----

# 2a import dataset ----
# import all the gp to sub icb lookup
gp_lookup <- read.csv(
  "1b_Raw_Data/control_vars/gp_to_ccg_lookup.csv", 
  header = FALSE) |>
  transmute(gp_code = V1, 
            gp_name = V2, 
            sicb_1415 = V3, 
            sicb_1516 = V4, 
            sicb_1617 = V5, 
            sicb_1718 = V6, 
            sicb_1819 = V7, 
            sicb_1920 = V8, 
            sicb_2021 = V9, 
            sicb_2122 = V10, 
            sicb_2223 = V11, 
            sicb_2324 = V12, 
            sicb_2425 = V13)

# rename as gps by sicb
gps_by_sicb <- gp_lookup |> 
  transmute(gp_code = gp_code, 
            sicb_code = sicb_1718 ) |> 
  # this manually allocates GPs to integrated locality partnerships (via PCN groups) as no CCG or sub-ICBs
  mutate(sicb_code = case_when(
    sicb_code != "11M" ~ sicb_code,
    gp_code %in% c("L84030", 
                   "L84041", 
                   "L84059", 
                   "L84003", 
                   "L84022") ~ "Cheltenham", 
    gp_code %in% c("L84036", 
                   "L84015", 
                   "L84048", 
                   "L84040",
                   "L84004") ~ "Cheltenham",
    gp_code %in% c("L84049", 
                   "L84058", 
                   "L84008", 
                   "L84033") ~ "Cheltenham", 
    gp_code %in% c("L84043", 
                   "L84038", 
                   "L84068", 
                   "L84031", 
                   "L84072") ~ "Cotswolds", 
    gp_code %in% c("L84018", 
                   "L84053", 
                   "L84012", 
                   "L84063", 
                   "L84010") ~ "Cotswolds", 
    gp_code %in% c("L84046", 
                   "L84024", 
                   "L84028", 
                   "L84045") ~ "Dean", 
    gp_code %in% c("L84029", 
                   "L84085", 
                   "L84011", 
                   "L84021") ~ "Dean", 
    gp_code %in% c("L84026") ~ "Gloucester", 
    gp_code %in% c("Y02519", 
                   "L84081", 
                   "L84034", 
                   "L84052") ~ "Gloucester", 
    gp_code %in% c("L84606", 
                   "L84084", 
                   "L84047", 
                   "L84014", 
                   "L84067") ~ "Gloucester",  # this is the actual N&S Gloucester
    gp_code %in% c("L84050") ~ "Gloucester", 
    gp_code %in% c("L84617", 
                   "L84009") ~ "Gloucester", 
    gp_code %in% c("L84060", 
                   "L84027", 
                   "L84075", 
                   "L84051") ~ "Stroud", 
    gp_code %in% c("L84077", 
                   "L84080", 
                   "L84065", 
                   "L84613") ~ "Stroud", 
    gp_code %in% c("L84039", 
                   "L84016", 
                   "L84005", 
                   "L84025", 
                   "L84007") ~ "Stroud", 
    gp_code %in% c("L84023", 
                   "L84054", 
                   "L84037", 
                   "L84006", 
                   "Y05212") ~ "Tewkesbury", 
    .default = "Other Gloucestershire"))

# import further details on the sub icb locations
sicb_lookup <- read.csv("1b_Raw_Data/control_vars/ccg_to_icb.csv", 
                       header = FALSE)  |>
  transmute(sicb_code = V1, 
            sicb_name = V2, 
            icb_code = V13) |> 
  # remove gloucestershire sub icb as I will re-add the ILPs as sub ICBs
  subset(icb_code != "Y05578")

sicb_lookup <- tibble(
  sicb_code = c(sicb_lookup$sicb_code, 
                "Cheltenham", 
                "Cotswolds", 
                "Dean", 
                "Gloucester", 
                "Stroud", 
                "Tewkesbury"),
  sicb_name = c(sicb_lookup$sicb_name, 
                "Gloucestershire - Cheltenham", 
                "Gloucestershire - Cotswolds", 
                "Gloucestershire - Dean", 
                "Gloucestershire - Gloucester", 
                "Gloucestershire - Stroud", 
                "Gloucestershire - Tewkesbury"), 
  icb_code = c(sicb_lookup$icb_code, 
               "QR1", "QR1", "QR1", 
               "QR1", "QR1", "QR1") ) 

# 2b wrangle into a single dataset ----
# join together the gp locations with further sicb info
gps_by_sicb2 <- left_join(
  x = gps_by_sicb, y = sicb_lookup, 
  by = c("sicb_code")) |> 
  # remove all the welsh local health boards
  subset( (substr(x = sicb_code, start = 1, stop = 2) == "7A") == FALSE ) 

# join sicb info and descr info
sicb_lookup <- left_join(
  x = gps_by_sicb2, 
  y = gp_codes.0, 
  by = "gp_code") |> 
  mutate(depr_inds = depr_prop * frail_inds_across_all_gp, 
         rural_inds = rural_prop * frail_inds_across_all_gp) |> 
  group_by(sicb_code, sicb_name, icb_code) |> 
  summarise(frail_inds_across_all_gp = sum(frail_inds_across_all_gp, na.rm = T), 
            depr_frail_inds = sum(depr_inds, na.rm = T), 
            rural_frail_inds = sum(rural_inds, na.rm = T))

gps_by_sicb2 <- gps_by_sicb2 |> 
  select(gp_code, sicb_code)

# remove everything ap1rt from the desired outcome
rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup")))

# 3 import all the data for the outcomes ---- 

# 3a readmissions ----
apc_readmissions <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_apc_28_day_readmissions.csv", 
  header = FALSE) |> 
  transmute(YearMon = as.character(paste0(substr(x = V1, start = 1, stop = 4), 
                                          "-",
                                          substr(x = V1, start = 6, stop = 7))), 
            gp_code = V2, 
            apc_readmissions = V3) |>
  mutate(YearMon = zoo::as.yearmon(YearMon))

sicb_outcome.1 <- left_join(
  x = apc_readmissions, 
  y = gps_by_sicb2, 
  by = "gp_code") |> 
  group_by(sicb_code, YearMon) |> 
  summarise(apc_readmissions = sum(apc_readmissions)) |> 
  ungroup()

# remove everything apart from the desired outcome
rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup",
                          "sicb_outcome.1")))

# 3b admissions ----
apc_admissions <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_apc_admissions.csv", 
  header = FALSE) |> 
  transmute(YearMon = as.character(paste0(substr(x = V2, start = 1, stop = 4), 
                                          "-",
                                          substr(x = V2, start = 5, stop = 6))), 
            gp_code = V1, 
            apc_admissions = V3) |>
  mutate(YearMon = zoo::as.yearmon(YearMon))

sicb_outcome.2 <- left_join(
  x = apc_admissions, 
  y = gps_by_sicb2, 
  by = "gp_code") |> 
  group_by(sicb_code, YearMon) |> 
  summarise(apc_admissions = sum(apc_admissions)) |> 
  ungroup()

# remove everything apart from the desired outcome
rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup", 
                          "sicb_outcome.1", "sicb_outcome.2")))

# 3c admissions by discharge location ----
apc_discharges_disch_loc <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_apc_discharges_by_discharge_location.csv", 
  header = FALSE) |> 
  transmute(YearMon = as.character(paste0(substr(x = V2, start = 1, stop = 4), 
                                          "-",
                                          substr(x = V2, start = 5, stop = 6))),  
            gp_code = V1, 
            discharge_location = gsub(pattern = " ", 
                                      replacement = "_", 
                                      x = V3),
            apc_discharges = V4) |> 
  mutate(YearMon = zoo::as.yearmon(YearMon)) 

sicb_outcome.3 <- left_join(
  x = apc_discharges_disch_loc, 
  y = gps_by_sicb2, 
  by = "gp_code") |> 
  group_by(sicb_code, YearMon, discharge_location) |> 
  summarise(apc_discharges = sum(apc_discharges)) |> 
  ungroup() |> 
  pivot_wider(id_cols = c("YearMon", "sicb_code"),
              names_from = "discharge_location", 
              values_from = "apc_discharges") |> 
  mutate(admissions_equals_discharge = ifelse(is.na(admissions_equals_discharge), 
                                                    yes = 0, 
                                                    no = admissions_equals_discharge), 
         exclude = ifelse(is.na(exclude), 
                          yes = 0, 
                          no = exclude), 
         not_usual_residence = ifelse(is.na(not_usual_residence), 
                          yes = 0, 
                          no = not_usual_residence), 
         to_care_home = ifelse(is.na(to_care_home), 
                          yes = 0, 
                          no = to_care_home), 
         usual_residence = ifelse(is.na(usual_residence), 
                          yes = 0, 
                          no = usual_residence), 
         care_home_to_care_home = ifelse(is.na(care_home_to_care_home), 
                          yes = 0, 
                          no = care_home_to_care_home), 
         foster_care = ifelse(is.na(foster_care), 
                          yes = 0, 
                          no = foster_care), 
         hospice_to_hospice = ifelse(is.na(hospice_to_hospice), 
                          yes = 0, 
                          no = hospice_to_hospice)
         )

rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup", 
                          "sicb_outcome.1", 
                          "sicb_outcome.2", 
                          "sicb_outcome.3")))

# 3d days in hospital ----
apc_hospital_days <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_apc_days_in_hospital.csv", 
  header = FALSE) |> 
  transmute(YearMon = as.character(paste0(substr(x = V2, start = 1, stop = 4), 
                                          "-",
                                          substr(x = V2, start = 5, stop = 6))), 
            gp_code = V1, 
            apc_hospital_days = V3) |>
  mutate(YearMon = zoo::as.yearmon(YearMon))

sicb_outcome.4 <- left_join(
  x = apc_hospital_days, 
  y = gps_by_sicb2, 
  by = "gp_code") |> 
  group_by(sicb_code, YearMon) |> 
  summarise(apc_hospital_days = sum(apc_hospital_days)) |> 
  ungroup()

# remove everything apart from the desired outcome
rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup", 
                          "sicb_outcome.1", 
                          "sicb_outcome.2", 
                          "sicb_outcome.3", 
                          "sicb_outcome.4")))

# 3e admissions by drd ----
apc_discharges_by_drd <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_apc_discharges_by_drd.csv", 
  header = FALSE) |> 
  transmute(YearMon = as.character(paste0(substr(x = V1, start = 1, stop = 4), 
                                          "-",
                                          substr(x = V1, start = 5, stop = 6))), 
            gp_code = V2, 
            drd = gsub(pattern = " ", 
                       replacement = "_", 
                       x = V3), 
            apc_discharges = V4) |>
  mutate(YearMon = zoo::as.yearmon(YearMon))

sicb_outcome.5 <- left_join(
  x = apc_discharges_by_drd,
  y = gps_by_sicb2, 
  by = "gp_code") |> 
  group_by(YearMon, sicb_code, drd) |> 
  summarise(apc_discharges = sum(apc_discharges)) |> 
  ungroup() |> 
  pivot_wider(id_cols = c("YearMon", "sicb_code"),
              names_from = "drd", 
              values_from = "apc_discharges") |> 
  mutate(Discharged_on_admission_date = ifelse(is.na(Discharged_on_admission_date), 
                                               yes = 0, 
                                               no = Discharged_on_admission_date), 
         Discharged_on_DRD = ifelse(is.na(Discharged_on_DRD), 
                          yes = 0, 
                          no = Discharged_on_DRD), 
         No_DRD = ifelse(is.na(No_DRD), 
                                      yes = 0, 
                                      no = No_DRD), 
         Discharged_after_DRD = ifelse(is.na(Discharged_after_DRD), 
                               yes = 0, 
                               no = Discharged_after_DRD), 
         Discharged_before_DRD = ifelse(is.na(Discharged_before_DRD), 
                                  yes = 0, 
                                  no = Discharged_before_DRD) ) |> 
  select(YearMon, sicb_code, 
         Discharged_on_admission_date, 
         No_DRD, 
         Discharged_after_DRD, Discharged_on_DRD, Discharged_before_DRD)

rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup", 
                          "sicb_outcome.1", 
                          "sicb_outcome.2", 
                          "sicb_outcome.3", 
                          "sicb_outcome.4", 
                          "sicb_outcome.5")))

# 3f ed admissions ----
ed_admissions <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_ed_admissions.csv", 
  header = FALSE) |> 
  transmute(YearMon = as.character(paste0(substr(x = V2, start = 1, stop = 4), 
                                          "-",
                                          substr(x = V2, start = 5, stop = 6))), 
            gp_code = V1, 
            ed_admissions = V3) |>
  mutate(YearMon = zoo::as.yearmon(YearMon))

sicb_outcome.6 <- left_join(
  x = ed_admissions, 
  y = gps_by_sicb2, 
  by = "gp_code") |> 
  group_by(sicb_code, YearMon) |> 
  summarise(ed_admissions = sum(ed_admissions)) |> 
  ungroup()

# remove everything apart from the desired outcome
rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup", 
                          "sicb_outcome.1", 
                          "sicb_outcome.2", 
                          "sicb_outcome.3", 
                          "sicb_outcome.4", 
                          "sicb_outcome.5", 
                          "sicb_outcome.6")))

# 3g ed admissions by ambulance ----
ed_attendances_by_ambulance <- read.csv(
  file = "1b_Raw_Data/grouped_by_gp/frail_ed_admissions_by_ambulance.csv", 
  header = FALSE) |> 
  transmute(YearMon = as.character(paste0(substr(x = V2, start = 1, stop = 4), 
                                          "-",
                                          substr(x = V2, start = 5, stop = 6))), 
            gp_code = V1, 
            ed_admissions_by_ambulance = V3) |>
  mutate(YearMon = zoo::as.yearmon(YearMon))

sicb_outcome.7 <- left_join(
  x = ed_attendances_by_ambulance, 
  y = gps_by_sicb2, 
  by = "gp_code") |> 
  group_by(sicb_code, YearMon) |> 
  summarise(ed_admissions_by_ambulance = sum(ed_admissions_by_ambulance)) |> 
  ungroup()

# remove everything apart from the desired outcome
rm(list = setdiff(ls(), c("gps_by_sicb2", "sicb_lookup", 
                          "sicb_outcome.1", 
                          "sicb_outcome.2", 
                          "sicb_outcome.3", 
                          "sicb_outcome.4", 
                          "sicb_outcome.5", 
                          "sicb_outcome.6", 
                          "sicb_outcome.7")))

# 4 the final dataset together ----
# 4a join all the outcome data together ----

# all the results
result <- reduce(
  .x = list(sicb_outcome.1,
            sicb_outcome.2,
            sicb_outcome.3,
            sicb_outcome.4,
            sicb_outcome.5,
            sicb_outcome.6,
            sicb_outcome.7), 
  .f = full_join,
  by = c("sicb_code", "YearMon") )

# 4b wrangle the joined dataset ----
result2 <- right_join(
  x = result, 
  y = tibble(
    sicb_code = rep(x = unique(result$sicb_code), 
                    each = length(unique(result$YearMon))), 
    YearMon = zoo::as.yearmon(rep(x = unique(result$YearMon), 
                                  times = length(unique(result$sicb_code))) )), 
  by = c("sicb_code", "YearMon")) |> 
  subset(is.na(sicb_code) == FALSE) 

result3 <- result2 |>
  mutate(apc_readmissions = replace_na(apc_readmissions, 0),             
         apc_admissions = replace_na(apc_admissions , 0),              
         admissions_equals_discharge = replace_na(admissions_equals_discharge , 0),   
         care_home_to_care_home = replace_na(care_home_to_care_home , 0),        
         exclude = replace_na(exclude , 0),                       
         not_usual_residence = replace_na(not_usual_residence , 0),           
         to_care_home = replace_na(to_care_home , 0),                  
         usual_residence = replace_na( usual_residence, 0),               
         foster_care = replace_na(foster_care , 0),                   
         hospice_to_hospice = replace_na(hospice_to_hospice , 0),            
         apc_hospital_days = replace_na(apc_hospital_days , 0),             
         Discharged_on_admission_date = replace_na(Discharged_on_admission_date , 0),  
         No_DRD = replace_na(No_DRD , 0),                        
         Discharged_after_DRD = replace_na(Discharged_after_DRD , 0),          
         Discharged_on_DRD = replace_na(Discharged_on_DRD , 0),            
         Discharged_before_DRD = replace_na(Discharged_before_DRD , 0),      
         ed_admissions = replace_na(ed_admissions , 0),               
         ed_admissions_by_ambulance = replace_na(ed_admissions_by_ambulance , 0)) 
  
result4 <- result3 |>   
  subset(YearMon > "Mar 2018")

result4 <- left_join(
  x = result4, 
  y = sicb_lookup) |> 
  mutate(treat_group = sicb_code %in% c("06A",          # Wolverhampton (Black Country)
                                        "99H",          # Surrey Downs (Surrey)
                                        "99G", "99F",   # South East Essex (in MSE) is one of "07G" "06Q" "99F" "99E" "99G"
                                        "00X",          # Central Lancashire (in LSC) is one of "00X" "01A" "01E" "00Q" "00R" "01K" "02G" "02M"
                                        "Gloucester",   # N&S Gloucester PCN is in Gloucester ILP (Gloucestershire)
                                        "08J", "08P",   # Kingston "08J" & Richmond "08P" (SWL)
                                        "02Y", "03F"    # Hull & East Riding (HNY)
                                                    ), 
         place_name2 = case_when(
           sicb_code == "06A" ~ "Wolverhampton", 
           sicb_code == "99H" ~ "Surrey Downs", 
           sicb_code %in% c("99G", "99F") ~ "South East Essex", 
           sicb_code == "00X" ~ "Central Lancashire", 
           sicb_code %in% c("Gloucester") ~ "Gloucester", 
           sicb_code %in% c("08J", "08P") ~ "Kingston & Richmond", 
           sicb_code %in% c("02Y", "03F") ~ "Hull & East Riding"), 
         place_name = case_when(
           sicb_code == "06A" ~ "Wolverhampton", 
           sicb_code == "99H" ~ "Surrey Downs", 
           sicb_code %in% c("99G") ~ "Southend", 
           sicb_code %in% c("99F") ~ "Castle Point & Rochford", 
           sicb_code == "00X" ~ "Chorley & South Ribble", 
           sicb_code %in% c("Gloucester") ~ "Gloucester", 
           sicb_code %in% c("08J") ~ "Kingston",
           sicb_code %in% c("08P") ~ "Richmond", 
           sicb_code %in% c("03F") ~ "Hull", 
           sicb_code %in% c("02Y") ~ "East Riding"))

result4 |> 
  group_by(YearMon) |> 
  summarise(apc_admissions = sum(apc_admissions), 
            ed_admissions = sum(ed_admissions), 
            Discharged_after_DRD = sum(Discharged_after_DRD)) |> 
  ungroup() |>
  ggplot(mapping = aes(x = YearMon)) + 
  geom_line(mapping = aes(y = apc_admissions)) + 
  geom_line(mapping = aes(y = ed_admissions),
            col = "blue") + 
  theme_minimal()

# remove everything apart from the desired outcome
rm(list = setdiff(ls(), c("sicb_lookup", "result4")))

# 4c  save the joined datasets ----
write.csv(
  x = sicb_lookup, 
  file = "2b_Wrangled_Data/sicb_lookup.csv", 
  row.names = FALSE)
write.csv(
  x = result4, 
  file = "2b_Wrangled_Data/sicb_yearmon_outcomes.csv", 
  row.names = FALSE)

# 5a create icb aggregated ----

# import dataset
result5 <- result4 |> 
  mutate(apc_los = apc_hospital_days/apc_admissions) |> 
  mutate(Usual_disch = admissions_equals_discharge + care_home_to_care_home + 
           usual_residence + hospice_to_hospice, 
         Not_usual_disch = not_usual_residence + to_care_home + foster_care) |> 
  mutate(total_relevant_disch = Usual_disch + Not_usual_disch) |> 
  mutate(YearMon = zoo::as.yearmon(YearMon)) |> 
  subset(YearMon >= "Apr 2019" & YearMon <= "Oct 2025") |>
  select(1:4, 13, 19:30, 32)

view(result5)

result6 <- result5 |> 
  group_by(icb_code, YearMon) |>
  summarise(
    # outcomes
            apc_readmissions = sum(apc_readmissions), 
            apc_admissions = sum(apc_admissions), 
            apc_hospital_days = sum(apc_hospital_days), 
            ed_admissions = sum(ed_admissions), 
            ed_admissions_by_ambulance = sum(ed_admissions_by_ambulance), 
            Usual_disch = sum(Usual_disch), 
            total_relevant_disch = sum(total_relevant_disch),
    # descriptive variables
            frail_inds_across_all_gp = sum(frail_inds_across_all_gp), 
            depr_frail_inds = sum(depr_frail_inds), 
            rural_frail_inds = sum(rural_frail_inds)) |> 
  ungroup() |> 
  mutate(
    # reformat outcomes to make it clearer 
         apc_hospital_los.avg = apc_hospital_days/apc_admissions, 
         discharged_usual_place_residence.pcnt = 100 * (Usual_disch/total_relevant_disch), 
         ed_attends_by_ambulance.pcnt = 100 * (ed_admissions_by_ambulance/ed_admissions), 
    # reformat descr vars to make it clearer
         frailty_weighted_depr_score = depr_frail_inds/frail_inds_across_all_gp,
         frailty_weighted_rural_score = rural_frail_inds/frail_inds_across_all_gp)

result7 <- left_join(
  x = result6, 
  y = subset(unique(result4[, c("icb_code", "place_name2")]), is.na(place_name2)==FALSE), 
  by = "icb_code") |> 
  mutate(Frailty_Accelerator = is.na(place_name2)==FALSE)

write.csv(
  x = result7, 
  file = "2b_Wrangled_Data/results_by_icb.csv", 
  row.names = FALSE)


ggplot(data = result7, 
       mapping = aes(x = YearMon, 
                     y = apc_admissions, 
                     group = icb_code, 
                     col = icb_code)) + 
  geom_line() + 
  facet_grid(Frailty_Accelerator~.) + 
  theme_minimal()

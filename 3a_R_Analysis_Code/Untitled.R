
# 1 basic setup ----

rm(list = ls())

library(tidyverse)

# import dataset
d1 <- read_csv(
  file = "2b_Wrangled_Data/sicb_yearmon_outcomes.csv") |> 
  subset(frail_inds_across_all_gp > 10000) |> 
  mutate(apc_los = apc_hospital_days/apc_admissions) |> 
  mutate(Usual_disch = admissions_equals_discharge + care_home_to_care_home + 
           usual_residence + hospice_to_hospice, 
         Not_usual_disch = not_usual_residence + to_care_home + foster_care) |> 
  mutate(total_relevant_disch = Usual_disch + Not_usual_disch) |> 
  mutate(YearMon = zoo::as.yearmon(YearMon)) |> 
  subset(YearMon >= "Apr 2019" & YearMon <= "Oct 2025") |>
  select(1:4, 13, 19:30, 32)

d2 <- left_join(
  x = d1, 
  y = tibble(
    YearMon = unique(d1$YearMon), 
    time = 1:length(unique(d1$YearMon)) ))

d3 <- left_join(
  x = d2, 
  y = unique(d1 |> select(sicb_code, place_name)) |> 
    arrange(place_name) |> 
    mutate(unit_id = 1:length(unique(sicb_code))))

d4 <- d3 |> 
  mutate(treat_group = as.numeric(treat_group), 
         start_date = ifelse(test = is.na(place_name), 
                             yes = NA, 
                             no = 73)) |> 
  mutate(treated = ifelse(test = is.na(start_date), 
                          yes = 0, 
                          no = as.numeric(time>start_date)))

# 2 poisson: apc admissions ----

# delete everything unwanted and reimport
rm(list = setdiff(ls(), c("d4")))
source("Functions/Poisson_Functions.R")
treated_units = c(1:10)

# define dataset
d <- d4 |> 
  select(20, 19, 
         13, 21, 22, 
         1, 2, 
         apc_admissions) |> 
  mutate(actual.poisson = apc_admissions)

a <- Sys.time()
output <- Multi_SDID_Poisson(d = d,
                             treated_list = treated_units, 
                             lambda_list = c(-Inf))
b <- Sys.time()
b-a

write.csv(output, 
          "3b_Analysed_Outputs/apc_admissions_impact.csv")
Aggregate_Central_Poisson(output)

# placebo tests 
a <- Sys.time()
placebos <- Placebo_Poisson2(d = d, 
                             main_result = output)
b <- Sys.time()
b-a

write.csv(placebos , 
          "3b_Analysed_Outputs/apc_admissions_placebos.csv")

cf <- Multi_SDID_Poisson_VC(d = d,
                            n_starts = 1, 
                            treated_list = treated_units, 
                            lambda_list = c(-Inf) )
cf2 <- left_join(
  x = cf, 
  y = d |> select(time, YearMon) |> unique()
)

cf2 |> 
  ggplot(mapping = aes(x = YearMon)) + 
  geom_line(mapping = aes(y = actual_sum), 
            col = "darkgreen") + 
  geom_line(mapping = aes(y = predicted_sum), 
            col = "blue") + 
  theme_minimal()

write.csv(cf2, 
          "3b_Analysed_Outputs/apc_admissions_cf.csv", 
          row.names = FALSE)

# 3 poisson: apc readmissions ----

# delete everything unwanted and reimport
rm(list = setdiff(ls(), c("d4")))
source("Functions/Poisson_Functions.R")
treated_units = c(1:10)

# define dataset
d <- d4 |> 
  select(20, 19, 
         13, 21, 22, 
         1, 2, 
         apc_readmissions) |> 
  mutate(actual.poisson = apc_readmissions)

a <- Sys.time()
output <- Multi_SDID_Poisson(d = d,
                             treated_list = treated_units, 
                             lambda_list = c(-Inf))
b <- Sys.time()
b-a

write.csv(output, 
          "3b_Analysed_Outputs/apc_readmissions_impact.csv")
Aggregate_Central_Poisson(output)

# placebo tests 
a <- Sys.time()
placebos <- Placebo_Poisson2(d = d, 
                             main_result = output)
b <- Sys.time()
b-a

write.csv(placebos , 
          "3b_Analysed_Outputs/apc_readmissions_placebos.csv")

cf <- Multi_SDID_Poisson_VC(d = d,
                            n_starts = 1, 
                            treated_list = treated_units, 
                            lambda_list = c(-Inf) )
cf2 <- left_join(
  x = cf, 
  y = d |> select(time, YearMon) |> unique()
)

cf2 |> 
  ggplot(mapping = aes(x = YearMon)) + 
  geom_line(mapping = aes(y = actual_sum), 
            col = "darkgreen") + 
  geom_line(mapping = aes(y = predicted_sum), 
            col = "blue") + 
  theme_minimal()

write.csv(cf2, 
          "3b_Analysed_Outputs/apc_readmissions_cf.csv", 
          row.names = FALSE)

# 4 poisson: ed admissions ----

# delete everything unwanted and reimport
rm(list = setdiff(ls(), c("d4")))
source("Functions/Poisson_Functions.R")
treated_units = c(1:10)

# define dataset
d <- d4 |> 
  select(20, 19, 
         13, 21, 22, 
         1, 2, 
         ed_admissions) |> 
  mutate(actual.poisson = ed_admissions)

a <- Sys.time()
output <- Multi_SDID_Poisson(d = d,
                             treated_list = treated_units, 
                             lambda_list = c(-Inf))
b <- Sys.time()
b-a

write.csv(output, 
          "3b_Analysed_Outputs/ed_admissions_impact.csv")
Aggregate_Central_Poisson(output)

# placebo tests 
a <- Sys.time()
placebos <- Placebo_Poisson2(d = d, 
                             main_result = output)
b <- Sys.time()
b-a

write.csv(placebos , 
          "3b_Analysed_Outputs/ed_admissions_placebos.csv")

cf <- Multi_SDID_Poisson_VC(d = d,
                            n_starts = 1, 
                            treated_list = treated_units, 
                            lambda_list = c(-Inf) )
cf2 <- left_join(
  x = cf, 
  y = d |> select(time, YearMon) |> unique()
)

cf2 |> 
  ggplot(mapping = aes(x = YearMon)) + 
  geom_line(mapping = aes(y = actual_sum), 
            col = "darkgreen") + 
  geom_line(mapping = aes(y = predicted_sum), 
            col = "blue") + 
  theme_minimal()

write.csv(cf2, 
          "3b_Analysed_Outputs/ed_admissions_cf.csv", 
          row.names = FALSE)


# 5 poisson: apc hospital days ----

# delete everything unwanted and reimport
rm(list = setdiff(ls(), c("d4")))
source("Functions/Poisson_Functions.R")
treated_units = c(1:10)

# define dataset
d <- d4 |> 
  select(20, 19, 
         13, 21, 22, 
         1, 2, 
         apc_hospital_days) |> 
  mutate(actual.poisson = apc_hospital_days)

a <- Sys.time()
output <- Multi_SDID_Poisson(d = d,
                             treated_list = treated_units, 
                             lambda_list = c(-Inf))
b <- Sys.time()
b-a

write.csv(output, 
          "3b_Analysed_Outputs/apc_hospital_days_impact.csv")
Aggregate_Central_Poisson(output)

# placebo tests 
a <- Sys.time()
placebos <- Placebo_Poisson2(d = d, 
                             main_result = output)
b <- Sys.time()
b-a

write.csv(placebos , 
          "3b_Analysed_Outputs/apc_hospital_days_placebos.csv")

cf <- Multi_SDID_Poisson_VC(d = d,
                            n_starts = 1, 
                            treated_list = treated_units, 
                            lambda_list = c(-Inf) )
cf2 <- left_join(
  x = cf, 
  y = d |> select(time, YearMon) |> unique()
)

cf2 |> 
  ggplot(mapping = aes(x = YearMon)) + 
  geom_line(mapping = aes(y = actual_sum), 
            col = "darkgreen") + 
  geom_line(mapping = aes(y = predicted_sum), 
            col = "blue") + 
  theme_minimal()

write.csv(cf2, 
          "3b_Analysed_Outputs/apc_hospital_days_cf.csv", 
          row.names = FALSE)

# 6 binomial: ed attendendance by ambulance ----

# delete everything unwanted and reimport
rm(list = setdiff(ls(), c("d4")))
source("Functions_Binomial/Binomial_Functions.R")
treated_units = c(1:10)

# define dataset
d <- d4 |> 
  select(20, 19, 
         13, 21, 22, 
         1, 2, 
         ed_admissions_by_ambulance, 
         ed_admissions) |> 
  mutate(actual.binomial = ed_admissions_by_ambulance, 
         trials = ed_admissions)

a <- Sys.time()
output <- Multi_SDID_Binomial(d = d,
                              treated_list = treated_units, 
                              n_starts = 1)
b <- Sys.time()
b-a

write.csv(output, 
          "3b_Analysed_Outputs/ed_attends_by_ambulance_impact.csv")
Aggregate_Central_Binomial(output)

# placebo tests 
a <- Sys.time()
placebos <- Placebo_Binomial2(d = d, 
                              main_result = output)
b <- Sys.time()
b-a

write.csv(placebos , 
          "3b_Analysed_Outputs/ed_attends_by_ambulance_placebos.csv")

a <- Sys.time()
agg_plac <- Aggregate_Placebos_Binomial(placebos = placebos, 
                                        iter = 1000)
b <- Sys.time()
b-a

cf <- Multi_SDID_Binomial_VC(d = d,
                            n_starts = 1, 
                            treated_list = treated_units )
cf2 <- left_join(
  x = cf, 
  y = d |> select(time, YearMon) |> unique()
)

cf2 |> 
  ggplot(mapping = aes(x = YearMon)) + 
  geom_line(mapping = aes(y = actual_sum/trials_sum), 
            col = "darkgreen") + 
  geom_line(mapping = aes(y = predicted_sum/trials_sum), 
            col = "blue") + 
  theme_minimal()

write.csv(cf2, 
          "3b_Analysed_Outputs/ed_attends_by_ambulance_cf.csv", 
          row.names = FALSE)

# 7 binomial: discharges to usual place of residence ----

# delete everything unwanted and reimport
rm(list = setdiff(ls(), c("d4")))
source("Functions_Binomial/Binomial_Functions.R")
treated_units = c(1:10)

# define dataset
d <- d4 |> 
  select(20, 19, 
         13, 21, 22, 
         1, 2, 
         Usual_disch, 
         total_relevant_disch) |> 
  mutate(actual.binomial = Usual_disch, 
         trials = total_relevant_disch)

a <- Sys.time()
output <- Multi_SDID_Binomial(d = d,
                              treated_list = treated_units, 
                              n_starts = 1)
b <- Sys.time()
b-a

write.csv(output, 
          "3b_Analysed_Outputs/discharges_by_residence_impact.csv")
Aggregate_Central_Binomial(output)

# placebo tests 
a <- Sys.time()
placebos <- Placebo_Binomial2(d = d, 
                              main_result = output)
b <- Sys.time()
b-a

write.csv(placebos , 
          "3b_Analysed_Outputs/discharges_by_residence_placebos.csv")

a <- Sys.time()
agg_plac <- Aggregate_Placebos_Binomial(placebos = placebos, 
                                        iter = 1000)
b <- Sys.time()
b-a

cf <- Multi_SDID_Binomial_VC(d = d,
                             n_starts = 1, 
                             treated_list = treated_units )
cf2 <- left_join(
  x = cf, 
  y = d |> select(time, YearMon) |> unique()
)

cf2 |> 
  ggplot(mapping = aes(x = YearMon)) + 
  geom_line(mapping = aes(y = actual_sum/trials_sum), 
            col = "darkgreen") + 
  geom_line(mapping = aes(y = predicted_sum/trials_sum), 
            col = "blue") + 
  theme_minimal()

write.csv(cf2, 
          "3b_Analysed_Outputs/discharges_by_residence_cf.csv", 
          row.names = FALSE)

# 8 gaussian: apc los ----

# delete everything unwanted and reimport
rm(list = setdiff(ls(), c("d4")))
library(synthdid)
treated_units = c(1:10)

# define dataset
d <- d4 |> 
  select(20, 19, 
         13, 21, 22, 
         1, 2, 
         apc_hospital_days, 
         apc_admissions,
         apc_los) 

d |> 
  group_by(YearMon, time, treat_group) |> 
  summarise(apc_hospital_days = sum(apc_hospital_days), 
            apc_admissions = sum(apc_admissions)) |>
  ungroup() |> 
  mutate(apc_los = apc_hospital_days/apc_admissions) |> 
  ggplot(mapping = aes(x = YearMon, 
                       y = apc_los, 
                       group = treat_group, 
                       col = treat_group)) + 
  geom_line()

apc_los_summary <- d |> 
  group_by(treated == 1) |> 
  summarise(apc_hospital_days = sum(apc_hospital_days), 
            apc_admissions = sum(apc_admissions)) |>
  ungroup() |> 
  mutate(apc_los = apc_hospital_days/apc_admissions)
write.csv(apc_los_summary, 
          "3b_Analysed_Outputs/los_summary.csv", 
          row.names = FALSE)
  

setup = synthdid::panel.matrices(
  panel = as.data.frame(d), 
  unit = 1, 
  time = 2, 
  outcome = 8, 
  treatment = 5)
tau.hat = synthdid::synthdid_estimate(
  Y = setup$Y, 
  N0 = setup$N0, 
  T0 = setup$T0)
saveRDS(tau.hat, "3b_Analysed_Outputs/los_tau_hat.RDS")

se = sqrt(vcov(tau.hat, method='jackknife'))


plot(tau.hat, 
     overlay = 1, 
     se.method = "none",
     control.name='Counterfactual', 
     treated.name='Observed', 
     effect.alpha=0, 
     onset.alpha=1, 
     trajectory.alpha=1, 
     lambda.comparable=FALSE) + 
  scale_y_continuous(name = "Average length of stay in hospital (completed days)") + 
  scale_x_continuous(name = "Date", 
                     breaks = c(0,20,40,60,80), 
                     labels = c("Apr 2019", 
                                "Nov 2020", 
                                "Jul 2022", 
                                "Mar 2024", 
                                "Nov 2025")) + 
  ggtitle("Average hospital length of stay for frail patients", 
          subtitle = "Across all places affected by the FIC")

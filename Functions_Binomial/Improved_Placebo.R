

Improved_Placebo.bn <- function(d){

# select staret dates
start_dates <- as.integer(unique(d$start_date))
start_dates <- subset(start_dates, is.na(start_dates) == FALSE)
  
  # create lookup
  d <- d
  # treated_list <- treated_list
  treated_list = unique(subset(d, treat_group == 1)$unit_id)
  #n_starts <- n_starts 
  n_starts = 1
  
  all_units <- unique(d$unit_id)
  ctrl_units <- setdiff(all_units, treated_list)
  
  
  list_results <- tibble(
    cf.est = numeric(), 
    obs = numeric(), 
    vc_post_avg = numeric(), 
    treated_post_trials.sum = numeric(), 
    binomial_sdid_att = numeric(), 
    post_timepoints = numeric(), 
    unit = numeric(), 
    start_date = numeric())
  
  message()
  
  for (j in start_dates){
  
    start_date_here = j
  
  for (i in ctrl_units){
    
    d2 <- subset(d, unit_id %in% ctrl_units) |>
      mutate(treat_group = ifelse(test = unit_id == i, 
                                  yes = 1, 
                                  no = unit_id), 
             unit_id = ifelse(test = unit_id == i,
                              yes = 1, 
                              no = unit_id)) 
    d3 <- d2|> 
      mutate(start_date = ifelse(test = unit_id == 1,
                                 yes = start_date_here, 
                                 no = NA),
             treated =  ifelse(test = unit_id == 1 & time >= start_date_here, 
                               yes = 1, 
                               no = 0))
    
    # run analysis
    output <- Multi_SDID_Binomial(d = d3, 
                                  treated_list = 1, 
                                  n_starts = n_starts) |> 
      mutate(unit = i, 
             start_date = start_date_here)

    
    list_results <-  rbind(list_results, output)
  }
  
  }
  
  return(list_results)
  
}


Placebo_Binomial2 <- function(d, 
                             main_result, 
                             needy = TRUE){
  
  # identify treated unit 
  treated_units <- unique((subset(d, treated == 1)$unit_id))
  
  # Placebo Inference
  starts_lambdas <- tibble(
    equiv_unit = treated_units,
    starts = 1 + max(d$time) - main_result$post_timepoints, 
    lambdas = log10(main_result$lambda_used))
  
  # select start dates
  start_dates <- as.integer(unique(d$start_date))
  start_dates <- subset(start_dates, is.na(start_dates) == FALSE)
  
  # create lookup
  d <- d
  # treated_list <- treated_list
  treated_list = unique(subset(d, treat_group == 1)$unit_id)
  #n_starts <- n_starts 
  n_starts = 1
  
  all_units <- unique(d$unit_id)
  ctrl_units <- setdiff(all_units, treated_list)
  
  list_results <- tibble(
    cf.est = numeric(), 
    obs = numeric(), 
    vc_post_avg = numeric(), 
    treated_post_trials.sum = numeric(), 
    binomial_sdid_att = numeric(), 
    post_timepoints = numeric(), 
    pre_obs = numeric(), 
    pre_vc = numeric(),
    unit = numeric(), 
    start_date = numeric())
  
  starts_lambdas2 <- tibble(
    equiv_unit = rep(x = starts_lambdas$equiv_unit, 
                     each = length(ctrl_units)), 
    starts = rep(x = starts_lambdas$starts, 
                 each = length(ctrl_units)), 
    lambdas = rep(x = starts_lambdas$lambdas, 
                  each = length(ctrl_units)), 
    ctrl_unit = rep(x = ctrl_units, 
                    times = nrow(starts_lambdas))
  )
  
  starts_lambdas <- starts_lambdas2 |> 
    select(2:4) |> 
    unique()
  
  message(paste(nrow(starts_lambdas), "placebo tests to conduct"))
  
  for (j in 1:nrow(starts_lambdas)){
    
    # equiv_unit = starts_lambdas$equiv_unit[j]
    start_date_here = starts_lambdas$starts[j]
    lambda = starts_lambdas$lambdas[j]
    i = starts_lambdas$ctrl_unit[j]
    
    
    d2 <- subset(d, unit_id %in% ctrl_units) |>
      mutate(treat_group = ifelse(test = unit_id == i, 
                                  yes = 1, 
                                  no = unit_id), 
             unit_id = ifelse(test = unit_id == i,
                              yes = 1, 
                              no = unit_id)) 
    d3 <- d2|> 
      mutate(start_date = ifelse(test = unit_id == 1,
                                 yes = start_date_here, 
                                 no = NA),
             treated =  ifelse(test = unit_id == 1 & time >= start_date_here, 
                               yes = 1, 
                               no = 0))
    
    # run analysis
    output <- Binomial_SDID3(d = d3, 
                            n_starts = n_starts) |> 
      mutate(ctrl_unit = i, 
             start_date = start_date_here)
    
    
    list_results <-  rbind(list_results, output)
    
    if(needy==TRUE){message(paste("placebo test", j, "completed"))}
    
  }
  
  list_results2 <- starts_lambdas2 |> 
    transmute(equiv_unit, ctrl_unit, 
              lambda_used = 10^lambdas, 
              post_timepoints = (1 + max(d$time)) - starts)
  
  list_results3 <- left_join(list_results2, list_results)
  
  return(list_results3)
  
}








Placebo_Poisson2 <- function(d, 
                             main_result, 
                             needy = TRUE){
  
  # identify treated unit 
  treated_units <- unique((subset(d, treated == 1)$unit_id))
  
  # Placebo Inference
  starts_lambdas <- tibble(
    equiv_unit = treated_units,
    starts = 1 + max(d$time) - main_result$post_timepoints, 
    lambdas = log10(main_result$lambda_used))
  
  # select start dates
  start_dates <- as.integer(unique(d$start_date))
  start_dates <- subset(start_dates, is.na(start_dates) == FALSE)
  
  # create lookup
  d <- d
  # treated_list <- treated_list
  treated_list = unique(subset(d, treat_group == 1)$unit_id)
  #n_starts <- n_starts 
  n_starts = 1
  
  all_units <- unique(d$unit_id)
  ctrl_units <- setdiff(all_units, treated_list)
  
  list_results <- tibble(
    cf.est = numeric(), 
    obs = numeric(), 
    vc_mean = numeric(), 
    poisson_sdid_att = numeric(), 
    post_timepoints = numeric(), 
    pre_obs = numeric(), 
    pre_vc = numeric(),
    unit = numeric(), 
    start_date = numeric())
  
  starts_lambdas2 <- tibble(
    equiv_unit = rep(x = starts_lambdas$equiv_unit, 
                     each = length(ctrl_units)), 
    starts = rep(x = starts_lambdas$starts, 
                 each = length(ctrl_units)), 
    lambdas = rep(x = starts_lambdas$lambdas, 
                  each = length(ctrl_units)), 
    ctrl_unit = rep(x = ctrl_units, 
                    times = nrow(starts_lambdas))
  )
  
  starts_lambdas <- starts_lambdas2 |> 
    select(2:4) |> 
    unique()
  
  message(paste(nrow(starts_lambdas), "placebo tests to conduct"))
  
  for (j in 1:nrow(starts_lambdas)){
    
    # equiv_unit = starts_lambdas$equiv_unit[j]
    start_date_here = starts_lambdas$starts[j]
    lambda = starts_lambdas$lambdas[j]
    i = starts_lambdas$ctrl_unit[j]
    
    
    d2 <- subset(d, unit_id %in% ctrl_units) |>
      mutate(treat_group = ifelse(test = unit_id == i, 
                                  yes = 1, 
                                  no = unit_id), 
             unit_id = ifelse(test = unit_id == i,
                              yes = 1, 
                              no = unit_id)) 
    d3 <- d2|> 
      mutate(start_date = ifelse(test = unit_id == 1,
                                 yes = start_date_here, 
                                 no = NA),
             treated =  ifelse(test = unit_id == 1 & time >= start_date_here, 
                               yes = 1, 
                               no = 0))
    
    # run analysis
    output <- Poisson_SDID4(d = d3, 
                            n_starts = n_starts, 
                            lambda_list = c(lambda)) |> 
      mutate(ctrl_unit = i, 
             start_date = start_date_here)
    
    
    list_results <-  rbind(list_results, output)
    
    if(needy==TRUE){message(paste("placebo test", j, "completed"))}
    
  }
  
  list_results2 <- starts_lambdas2 |> 
    transmute(equiv_unit, ctrl_unit, 
              lambda_used = 10^lambdas, 
              post_timepoints = (1 + max(d$time)) - starts)
  
  list_results3 <- left_join(list_results2, list_results)
  
  return(list_results3)
  
}



  

  


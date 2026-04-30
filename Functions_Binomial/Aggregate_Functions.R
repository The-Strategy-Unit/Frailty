Aggregate_Placebos_Binomial <- function(placebos, 
                                       iter=1000){
  
  output2 <- tibble(
    obs_success = numeric(), 
    cf_success = numeric(), 
    trials = numeric(), 
    unit_timepoints = numeric(), 
    obs_fails = numeric(), 
    cf_fails = numeric(), 
    obs_odds = numeric(), 
    cf_odds = numeric(), 
    scaled_effect = numeric())
  
  for (i in 1:iter){
    
    output2[i,] <- placebos |> 
      group_by(equiv_unit) |> 
      sample_n(size = 1) |> 
      ungroup() |> 
      Aggregate_Central_Binomial()
  }
  
  return(output2)
  
}

Aggregate_Central_Binomial <- function(output){
  
  k <- output |> 
    mutate(obs_outcome = obs * treated_post_trials.sum, 
           cf_outcome = cf.est * treated_post_trials.sum, 
           timepoints = post_timepoints) |>
    summarise(obs_success = sum(obs_outcome), 
              cf_success = sum(cf_outcome), 
              trials = sum(treated_post_trials.sum),
              unit_timepoints = sum(post_timepoints)) |> 
    mutate(obs_fails = trials - obs_success,
           cf_fails = trials - cf_success,
           obs_odds = obs_success/obs_fails, 
           cf_odds = cf_success/cf_fails, 
           scaled_effect = log(obs_odds/cf_odds) )
  
  return(k)
  
}

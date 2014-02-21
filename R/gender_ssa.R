gender_ssa <- function(data, years, certainty) {
  
  data$name <- as.character(data$name)
  data$year <- as.integer(data$year)
  
  if (class(years) == "numeric") {
    
    # Calculate the male and female proportions for the given range of years
    ssa_select <- gender::ssa_national %.%
      filter(year >= years[1], year <= years[2]) %.%
      group_by(name) %.%
      summarise(female = sum(female),
                male = sum(male)) %.%
      mutate(proportion_male = round((male / (male + female)), digits = 4),
             proportion_female = round((female / (male + female)), digits = 4)) %.%
      mutate(gender = ifelse(proportion_female == 0.5, "either",
                             ifelse(proportion_female > 0.5, "female", "male")))      
    
    results <- left_join(data, ssa_select, by = "name")
    
  } else if (class(years) == "logical") {
    
    # Join the data to SSA data by name and year, then calculate proportions
    results <- 
    left_join(data, gender::ssa_national, by = c("name", "year")) %.%
      mutate(proportion_male = round((male / (male + female)), digits = 4),
             proportion_female = round((female / (male + female)), digits = 4)) %.%
      mutate(gender = ifelse(proportion_female == 0.5, "either",
                             ifelse(proportion_female > 0.5, "female", "male")))  
  }
  
  # Delete the male and female columns since we won't report them to the user
  results$male <- NULL
  results$female <- NULL
  
  # Delete the certainty columns unless the user wants them
  if(!certainty) {
    results$proportion_male <- NULL
    results$proportion_female <- NULL
  }  
  
  return(results)
    
}

encode_gender_ssa <- function(data, name_field, years, certainty) {
  require(dplyr)
  
  # Calculate the male and female proportions for the given range of years
  ssa_select <- gender::ssa_national %.%
    filter(year >= years[1], year <= years[2]) %.%
    group_by(name) %.%
    summarise(female = sum(female),
              male = sum(male)) %.%
    mutate(proportion_male = round((male / (male + female)), digits = 4),
           proportion_female = round((female / (male + female)), digits = 4)) %.%
    mutate(gender = sapply(proportion_female, male_or_female))
  
  # Delete the male and female columns since we won't report them to the user
  ssa_select$male <- NULL
  ssa_select$female <- NULL
  
  # Delete the certainty columns unless the user wants them
  if(!certainty) {
    ssa_select$proportion_male <- NULL
    ssa_select$proportion_female <- NULL
  }  
    
  # Merge with user's data
  merge(data, ssa_select, all.x = TRUE, by.x = name_field, by.y = "name")
}

# Helper function to determine whether a name is male or female in a given year
male_or_female <- function(proportion_female) {
  if (proportion_female > 0.5) {
    return("female")
  } else if(proportion_female == 0.5000) {
    return("either")
  } else {
    return("male")
  }
}

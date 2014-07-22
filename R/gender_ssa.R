#' Find the gender of frst names using Social Security data
#' 
#' This internal function implements the \code{method = "ssa"} option of 
#' \code{\link{gender}}. See that function for documentation.
#' 
#' @param data A character string of a first name or a data frame with a column 
#'   named \code{name} with a character vector containing first names. The names
#'   must all be lowercase.
#' @param years This argument can be either a single year, a range of years in 
#'   the form \code{c(1880, 1900)}, or the value \code{TRUE}. If no value is 
#'   specified, then the names will be looked up for the period 1932 to 2012. If
#'   a year or range of years is specified, then the names will be looked up for
#'   that period. If the value is \code{TRUE}, then the function will look for a
#'   column in the data frame named \code{year} containing an integer vector of 
#'   the year of birth associated with each name. This permits you to do a 
#'   precise lookup for each person in your data set. Dates may range from 1880 
#'   to 2012; if earlier or later dates are included in a column in the data 
#'   frame, they will not be matched.
#' @param certainty A boolean value, which determines whether or not to return 
#'   the proportion of male and female uses of names in addition to determining 
#'   the gender of names.
#' @param correct_skew A boolean value which determines whether or not to 
#'   correct the skewed gender ratios of the SSA data. Default value is to do
#'   the correction.
gender_ssa <- function(data, years, certainty, correct_skew = TRUE) {
  
  # If we're going to correct the skew, calculate the correction factors
  if(correct_skew) {
    correx <- get_correction_factors(years)
  } else {
    correx <- c(1, 1); names(correx) <- c("female", "male")
  }
  
  if (class(years) == "numeric") {
    
    # Calculate the male and female proportions for the given range of years
    ssa_select <- gender::ssa_national %>%
      filter(year >= years[1], year <= years[2]) %>%
      group_by(name) %>%
      summarise(female = sum(female) * correx['female'],
                male = sum(male) * correx['male']) %>%
      mutate(proportion_male = round((male / (male + female)), digits = 4),
             proportion_female = round((female / (male + female)), digits = 4)) 
    
    results <- left_join(data, ssa_select, by = "name")
    
  } else if (class(years) == "logical") {
    
    # Join the data to SSA data by name and year, then calculate proportions
    results <- left_join(data, gender::ssa_national, by = c("name", "year")) %>%
      mutate(male_c = male * get_correction_factors(c(year, year))['male'],
             female_c = female * get_correction_factors(c(year, year))['female']) %>%
      mutate(proportion_male = round((male_c / (male_c + female_c)), digits = 4),
             proportion_female = round((female_c / (male_c + female_c)), digits = 4)) #%>%
#       select(-male_c, -female_c)
  } 
  
  # Now predict the gender
  results <- results %>%
    mutate(gender = ifelse(proportion_female == 0.5, "either",
                           ifelse(proportion_female > 0.5, "female", "male")))      
  
  # Delete the male and female columns since we won't report them to the user. 
  # Under no circumstances would we want to report these values to the user,
  # since we have corrected them to get an even gender ratio, so they no longer
  # represent the raw number of names for a given range of years.
  results$male <- NULL
  results$female <- NULL
  
  # Delete the certainty columns unless the user wants them
  if(!certainty) {
    results$proportion_male <- NULL
    results$proportion_female <- NULL
  }  
  
  return(results)
    
}

#' Calculate the correction factors for a year or range of years
#' 
#' The SSA data is skewed by gender, especially for years before 1935. This 
#' internal function figures out the factor by which the gender ratio should be 
#' multiplied in order to assume that the ratio of male to female births for 
#' those years was 1:1.
#' 
#' @param years The range of years. This value will be passed to it by the
#'   gender_ssa function.
#'   
get_correction_factors <- function(years) {
  selection <- gender::ssa_national %>%
    filter(year >= years[1], year <= years[2])
  
  ratio_female <- sum(selection$female) / sum(selection$female + selection$male)
  ratio_male   <- 1 - ratio_female
  
  correction_factors <- c(0.5 / ratio_female, 0.5 / ratio_male)
  names(correction_factors) <- c("female", "male")
  return(correction_factors)
}

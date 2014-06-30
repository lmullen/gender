#' Find the gender of first names using Census data
#' 
#' This internal function implements the \code{method = "ipums"} option of 
#' \code{\link{gender}}. See that function for documentation.
#' 
#' @param data A character string of a first name or a data frame with a column 
#'   named \code{name} with a character vector containing first names. The names 
#'   must all be lowercase. 
#' @param years This argument can be either a single year, a range of years in 
#'   the form \code{c(1880, 1900)}, or the value \code{TRUE}. If no value is 
#'   specified, then the names will be looked up for the period 1789 to 1930 If
#'   a year or range of years is specified, then the names will be looked up for
#'   that period. If the value is \code{TRUE}, then the function will look for 
#'   a column in the data frame named \code{year} containing an integer vector
#'   of the year of birth associated with each name. This permits you to do a 
#'   precise lookup for each person in your data set. Dates may range from 1789 
#'   to 1930; if earlier or later dates are included in a column in the data 
#'   frame, they will not be matched.
#' @param certainty A boolean value, which determines whether or not to return
#'   the proportion of male and female uses of names in addition to determining
#'   the gender of names.
gender_ipums_usa <- function(data, years, certainty) {
  if (class(years) == "numeric") {
    if (years[1] < 1789 || years[2] > 1930) {stop("Please provide a year range between 1789 and 1930")}
    # Calculate the male and female proportions for the given range of years
    ipums_usa_select <- gender::ipums_usa %.%
      filter(year >= years[1], year <= years[2]) %.%
      group_by(name) %.%
      summarise(female = sum(female),
                male = sum(male)) %.%
      mutate(proportion_male = round((male / (male + female)), digits = 4),
             proportion_female = round((female / (male + female)), digits = 4)) %.%
      mutate(gender = ifelse(proportion_female == 0.5, "either",
                             ifelse(proportion_female > 0.5, "female", "male")))      
    
    results <- left_join(data, ipums_usa_select, by = "name")
    
  } else if (class(years) == "logical") {
    
    # Join the data to ipums_usa data by name and year, then calculate proportions
    results <- 
    left_join(data, gender::ipums_usa, by = c("name", "year")) %.%
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

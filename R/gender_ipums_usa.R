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

  # An internal function to predict the gender of one name
  apply_ipums <- function(n) {

    # Calculate the male and female proportions for the given range of years
    results <- gender::ipums_usa %>%
      filter(name == n,
             year >= years[1], year <= years[2])

    # If the name isn't in the data set, use that information rather than
    # silently dropping a row
    if (nrow(results) == 0) {
      results <- data.frame(name = n,
                            female = NA,
                            male = NA,
                            proportion_male = NA,
                            proportion_female = NA)
    }

    results <- results %>%
      group_by(name) %>%
      # Multiply the number of males and females by the correction factors
      summarise(female = sum(female),
                male = sum(male)) %>%
      mutate(proportion_male = round((male / (male + female)), digits = 4),
             proportion_female = round((female / (male + female)), digits = 4)) %>%
      # Now predict the gender
      mutate(gender = ifelse(proportion_female == 0.5, "either",
                             ifelse(proportion_female > 0.5, "female", "male")))

    # Delete the male and female columns since we won't report them to the user.
    # Under no circumstances would we want to report these values to the user:
    # since we have corrected them to get an even gender ratio, so they no
    # longer represent the raw number of names for a given range of years.
    results <- results %>% select(-male, -female)

    # Delete the certainty columns unless the user wants them
    if(!certainty) results <- results %>% select(-proportion_male, -proportion_female)

    # Include the years used in the data frame
    results <- results %>% mutate(year_min = years[1], year_max = years[2])

    return(as.list(results))

  }

  # Use the function directly if there is one name; use lapply if there are > 1.
  # Return the results as a list or a list of lists.
  if (length(data) == 1) {
    return(as.list(apply_ipums(data)))
  } else {
    return(as.list(lapply(data, apply_ipums)))
  }
  
}

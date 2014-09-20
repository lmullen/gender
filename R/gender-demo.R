#' Demo finding the gender of first names using SSA data
#'
#' This internal function implements the \code{method = "demo"} option of
#' \code{\link{gender}}. See that function for documentation.
#'
#' @param name A character string of a first name. Case insensitive.
#' @param years This argument can be either a single year or a range of years in
#'   the form \code{c(1880, 1900)}. If no value is specified, then the names
#'   will be looked up for the period 1932 to 2012. If a year or range of years
#'   is specified, then the names will be looked up for that period. Dates may
#'   range from 1880 to 2012. For years before 1930, the IPUMS method is
#'   probably better.
#' @param certainty A boolean value, which determines whether or not to return
#'   the proportion of male and female uses of names in addition to determining
#'   the gender of names.
gender_demo <- function(name, years, certainty) {

  # An internal function to predict the gender of one name
  apply_demo <- function(n) {

    # Calculate the male and female proportions for the given range of years
    results <- basic_names %>%
      filter(name == tolower(n),
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

    # Use the original capitalization of the name
    results$name <- n

    return(as.list(results))

  }

  # Use the function directly if there is one name; use lapply if there are > 1.
  # Return the results as a list or a list of lists.
  if (length(name) == 1) {
    return(as.list(apply_demo(name)))
  } else {
    return(as.list(lapply(name, apply_demo)))
  }

}

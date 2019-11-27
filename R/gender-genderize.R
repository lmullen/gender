# Find the gender of first names using Genderize.io API
#
# This internal function implements the \code{method = "genderize"} option of
# \code{\link{gender}}. See that function for documentation.
#
# @param name A character string of a first name.
# @param countries The countries to look up the names for following ISO 
#   3166-1 alpha-2 country codes. One (e.g., "US") or multiple countries
#   through a character vector (e.g., \code{c("US", "SE")}) may be used.
#   Omitted in API call if specified as NA (default).
# @return A list or (for multiple names) a list of lists containing the name
#   property and the predicted gender property, along with the proportion of
#   the uses of the name that is male and female.
gender_genderize <- function(names, countries = NA) {

  endpoint <- "https://api.genderize.io"

  apply_genderize <- function(n, c) {
    if (!missing(c) && !is.na(c)) {
	  r <- httr::GET(endpoint, query = list(name = n, country_id = c))
	} else {
	  r <- httr::GET(endpoint, query = list(name = n))
	}
	
    httr::stop_for_status(r)
    result <- httr::content(r, as = "text") %>%
      jsonlite::fromJSON(., simplifyVector = FALSE)

    # Convert genderize's return into our format
    if (is.null(result$gender)) {
      result$gender <- NA_character_
      result$proportion_male <- NA_real_
      result$proportion_female <- NA_real_
    } else if (result$gender == "female") {
      result$proportion_female = as.numeric(result$probability)
      result$proportion_male   = 1 - result$proportion_female
    } else if (result$gender == "male") {
      result$proportion_male   = as.numeric(result$probability)
      result$proportion_female = 1 - result$proportion_male
    }
    result$probability <- NULL
    result$count <- NULL
	result$country_id <- NULL

    as_tibble(result)
  }

  if (length(names) == 1) {
    if (missing(countries) || is.na(countries)) {
      return(apply_genderize(names))
    } else if (length(countries) == 1) {
	  return(apply_genderize(names, countries))
    } else {
	  return(apply_genderize(names, countries[1]))
    }
 } else {
    if (missing(countries) || is.na(countries)) {
      return(bind_rows(lapply(names, apply_genderize)))
    } else if (length(countries) == 1) {
      return(bind_rows(lapply(names, apply_genderize, c = countries)))
    } else {
	  return(bind_rows(mapply(apply_genderize, names, countries, 
	                   SIMPLIFY = FALSE)))
    }
  }

}

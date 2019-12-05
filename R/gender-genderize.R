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
# @param api_key If provided as character, key will be used for genderize.io
#   requests.
# @return A list or (for multiple names) a list of lists containing the name
#   property and the predicted gender property, along with the proportion of
#   the uses of the name that is male and female.
gender_genderize <- function(names, countries = NA, api_key = NA) {

  endpoint <- "https://api.genderize.io"
  api_key <- ifelse(missing(api_key), NA, api_key)
  progress_bar <- progress::progress_bar$new(total = length(names))

  apply_genderize <- function(n, c) {
    progress_bar$tick()

    query_params = list(name = n)
    if (!missing(c) && !is.na(c)) {
      query_params$country_id = c
    }
    if (!is.na(api_key)) {
      query_params$apikey = api_key
    }
    r <- httr::GET(endpoint, query = query_params)

    httr::stop_for_status(r)
    result <- httr::content(r, as = "text") %>%
      jsonlite::fromJSON(., simplifyVector = FALSE)

    # Convert genderize's return into our format
    if (is.null(result$gender)) {
      result$gender <- NA_character_
      result$proportion_female <- NA_real_
      result$proportion_male <- NA_real_
    } else if (result$gender == "female") {
      result$proportion_female = as.numeric(result$probability)
      result$proportion_male   = 1 - result$proportion_female
    } else if (result$gender == "male") {
      male = as.numeric(result$probability)
      result$proportion_female = 1 - male
      result$proportion_male   = male
    }
    result$probability <- NULL
    result$count <- NULL
	  result$country_id <- NULL

    as_data_frame(result)
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
	    return(bind_rows(mapply(apply_genderize, names, countries, SIMPLIFY = FALSE)))
    }
  }
}

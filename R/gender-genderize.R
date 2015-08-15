# Find the gender of first names using Genderize.io API
#
# This internal function implements the \code{method = "genderize"} option of
# \code{\link{gender}}. See that function for documentation.
#
# @param name A character string of a first name.
# @return A list or (for multiple names) a list of lists containing the name
#   property and the predicted gender property, along with the proportion of
#   the uses of the name that is male and female.
gender_genderize <- function(names) {

  endpoint <- "http://api.genderize.io"

  apply_genderize <- function(n) {
    r <- httr::GET(endpoint, query = list(name = n))
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

    as_data_frame(result)
  }

  if (length(names) == 1) {
    return(apply_genderize(names))
  } else {
    return(bind_rows(lapply(names, apply_genderize)))
  }

}

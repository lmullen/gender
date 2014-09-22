#' Find the gender of first names using Genderize.io API
#'
#' This internal function implements the \code{method = "genderize"} option of
#' \code{\link{gender}}. See that function for documentation.
#'
#' @param name A character string of a first name.
#' @param certainty A boolean value, which determines whether or not to return
#'   the proportion of male and female uses of names in addition to determining
#'   the gender of names.
#' @return A list or (for multiple names) a list of lists containing the name
#'   property and the predicted gender property, along with the proportion of
#'   the uses of the name that is male and female.
gender_genderize <- function(name, certainty) {

  endpoint <- "http://api.genderize.io"

  apply_genderize <- function(n) {
    r <- httr::GET(endpoint, query = list(name = n))
    httr::stop_for_status(r)
    result <- httr::content(r, as = "text") %>%
      jsonlite::fromJSON(., simplifyVector = FALSE)

    # Convert genderize's return into our format
    if (result$gender == "female") {
      result$proportion_female = as.numeric(result$probability)
      result$proportion_male   = 1 - result$proportion_female
    } else if (result$gender == "male") {
      result$proportion_male   = as.numeric(result$probability)
      result$proportion_female = 1 - result$proportion_male
    }
    result$probability <- NULL
    result$count <- NULL

    if(!certainty) {
      result$proportion_female <- NULL
      result$proportion_male <- NULL
    }

    result
  }

  if (length(name) == 1) {
    return(as.list(apply_genderize(name)))
  } else {
    return(as.list(lapply(name, apply_genderize)))
  }

}

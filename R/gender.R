#' Find the gender of frst names
#' 
#' This function looks up the gender of either a single first name or of a 
#' column of first names in a data frame. Optionally it can take a year, a 
#' range of years, or a column of years in the data frame to take into account
#' variation in the use of names over time.
#' 
#' @param data A character string of a first name or a data frame with a column 
#'   named \code{name} with a character vector containing first names. The names 
#'   must all be lowercase. 
#' @param years This argument can be either a single year, a range of years in 
#'   the form \code{c(1880, 1900)}, or the value \code{TRUE}. If no value is 
#'   specified, then the names will be looked up for the period 1932 to 2012. If
#'   a year or range of years is specified, then the names will be looked up for
#'   that period. If the value is \code{TRUE}, then the function will look for 
#'   a column in the data frame named \code{year} containing an integer vector
#'   of the year of birth associated with each name. This permits you to do a 
#'   precise lookup for each person in your data set. Dates may range from 1880 
#'   to 2012; if earlier or later dates are included in a column in the data 
#'   frame, they will not be matched.
#' @param method This value can be either \code{"ssa"}, in which case the 
#'   function will look up names based on Social Security Administration name 
#'   data, or \code{"kantrowitz"}, in which case the function will use the 
#'   Kantrowitz corpus of male and female names.
#' @param certainty A boolean value, which determines whether or not to return
#'   the proportion of male and female uses of names in addition to determining
#'   the gender of names.
#' @keywords gender
#' @export
#' @examples
#' library(dplyr)
#' gender("madison")
#' gender("madison", years = c(1900, 1985))
#' gender("madison", years = 1985)
#' gender(sample_names_data)
#' gender(sample_names_data, years = TRUE)
#' gender(sample_names_data, certainty = FALSE)
#' gender(sample_names_data, method = "kantrowitz")
gender <- function(data, years = c(1932, 2012), method = "ssa",
                   certainty = TRUE) {
  
  # If data is a character vector, then convert it to a data frame. 
  # If the data is not a character vector or a data frame, throw an error.
  if ("character" %in% class(data)) {
    data <- as.data.frame(data, optional = T, stringsAsFactors = FALSE)
    colnames(data) <- "name"
  } else if (!("data.frame" %in% class(data))) {
    stop("Data must be a character vector or a data frame.")
  }
  
  # Hand off the arguments to functions based on method, and do error checking
  if (method == "ssa") {
    # Check for errors in the year argument
    if (length(years) == 1) years <- c(years, years)
    if (length(years) > 2) {
      stop("Year should be a numeric vector with no more than two values.")
    } else if (years[1] > years[2]) {
      stop("The first value for years should be smaller than the second value.")
    } else {
      gender_ssa(data = data, years = years, certainty = certainty)
    }
  } else if (method == "kantrowitz") {
    if (!missing(years)) {
      warning("The year is not taken into account with the Kantrowitz method.") 
    }
    gender_kantrowitz(data = data)
  } else if (method == "ipums") {
    # Check for errors in the year argument
    if (length(years) == 1) years <- c(years, years)
    if (length(years) > 2) {
      stop("Year should be a numeric vector with no more than two values.")
    } else if (years[1] > years[2]) {
      stop("The first value for years should be smaller than the second value.")
    } else {
      gender_ipums_usa(data = data, years = years, certainty = certainty)
    }
  } else {
    stop("Method ", method, " is not recognized. Try ?gender for help.")
  }
}

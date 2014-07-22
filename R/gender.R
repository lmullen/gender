#' Find the gender of frst names
#' 
#' This function looks up the gender of either a single first name or of a 
#' column of first names in a data frame. Optionally it can take a year, a 
#' range of years, or a column of years in the data frame to take into account
#' variation in the use of names over time. It can determine the likely gender
#' of a name from several different data sets.
#' 
#' @param data A character string of a first name or a data frame with a column 
#'   named \code{name} with a character vector containing first names. The names 
#'   must all be lowercase. 
#' @param years This argument can be either a single year, a range of years in 
#'   the form \code{c(1880, 1900)}, or the value \code{TRUE}. If no value is 
#'   specified, then for the \code{ssa} method it will use the period 1932 to 2012
#'    and for the \code{ipums} method it will use the period 1789 to 1930. If
#'   a year or range of years is specified, then the names will be looked up for
#'   that period. If the value is \code{TRUE}, then the function will look for 
#'   a column in the data frame named \code{year} containing an integer vector
#'   of the year of birth associated with each name. This permits you to do a 
#'   precise lookup for each person in your data set. Valid dates in the columns
#'   will depend on the method used to determine the gender; if earlier or later
#'   dates are included in a column in the data frame, they will not be matched.
#' @param method This value determines the data set that is used to predict the 
#'   gender of the name. The \code{"ssa"} method looks up names based from the U.S.
#'   Social Security Administration baby name data. (This method is based on an
#'   implementation by Cameron Blevins.) The \code{"ipums"} method looks up names 
#'   from the U.S. Census data in the Integrated Public Use Microdata Series. (This
#'   method was contributed by Benjamin Schmidt.) The \code{"kantrowitz"} method,
#'   in which case the function uses the Kantrowitz corpus of male and female names.
#' @param certainty A boolean value, which determines whether or not to return
#'   the proportion of male and female uses of names in addition to determining
#'   the gender of names.
#' @keywords gender
#' @import dplyr
#' @export
#' @examples
#' library(dplyr)
#' gender("madison")
#' gender("madison", years = c(1900, 1985))
#' gender("madison", years = 1985)
#' gender(sample_names_data)
#' gender(sample_names_data, years = TRUE)
#' gender(sample_names_data, certainty = FALSE)
#' gender(sample_names_data, method = "ipums", years = TRUE)
#' gender(sample_names_data, method = "kantrowitz")
gender <- function(data, years = c(1932, 2012), method = "ssa",
                   certainty = TRUE) {
  
  # If data is a character vector, then convert it to a data frame for easy
  # joining. If the data is not a character vector throw an error.
  if ("character" %in% class(data)) {
    data <- as.data.frame(data, optional = T, stringsAsFactors = FALSE)
    colnames(data) <- "name"
  } else {
    stop("Data must be a character vector.")
  }
  
  # Check the validity of the years argument
  if (length(years) == 1) years <- c(years, years) 
  if (length(years) > 2) {
    stop("Year should be a numeric vector with no more than two values.")
  } 
  if (years[1] > years[2]) {
    stop("The first value for years should be smaller than the second value.")
  } 
  if (missing(years)) {
    if(method == "ssa")   years <- c(1932, 2012) 
    if(method == "ipums") years <- c(1789, 1930)
  }

  # Hand off the arguments to functions based on method, and do error checking
  if (method == "ssa") {
    if (years[1] < 1880 || years[2] > 2012) {
      stop("Please provide a year range between 1880 and 2012")
    }
    gender_ssa(data = data, years = years, certainty = certainty)
  } else if (method == "kantrowitz") {
    if (!missing(years)) warning("Kantrowitz method does not account for year.") 
    gender_kantrowitz(data = data)
  } else if (method == "ipums") {
    if (years[1] < 1789 || years[2] > 1930) {
      stop("Please provide a year range between 1789 and 1930")
    }
    gender_ipums_usa(data = data, years = years, certainty = certainty)
  } else {
    stop("Method ", method, " is not recognized. Try ?gender for help.")
  }

}

#' Predict gender from first names using historical data
#'
#' This function predicts the gender of a first name given a year or range of
#' years in which the person was born. The prediction can use one of several
#' data sets suitable for different time periods or geographical regions. See
#' the package vignette for suggestions on using this function with multiple
#' names and for a discussion of which data set is most suitable for your
#' research question. When using certains methods, the \code{genderdata} data
#' package is required; you will be prompted to install it if it is not already
#' available.
#'
#' @param names First names as a character vector. Names are case insensitive.
#' @param years The birth year of the name whose gender is to be predicted. This
#'   argument can be either a single year, a range of years in the form
#'   \code{c(1880, 1900)}. If no value is specified, then for the \code{ "ssa"}
#'   method it will use the period 1932 to 2012; acceptable years for the SSA
#'   method range from 1880 to 2012, but for years before 1930 the IPUMS method
#'   is probably more accurate. For the \code{"ipums"} method the default range
#'   is the period 1789 to 1930, which is also the range of acceptable years.
#'   For the \code{"napp"} method the default range is the period 1758 to 1910,
#'   which is also the range of acceptable years. If a year or range of years is
#'   specified, then the names will be looked up for that period.
#' @param method This value determines the data set that is used to predict the
#'   gender of the name. The \code{"ssa"} method looks up names based from the
#'   U.S. Social Security Administration baby name data. (This method is based
#'   on an implementation by Cameron Blevins.) The \code{"ipums"} method looks
#'   up names from the U.S. Census data in the Integrated Public Use Microdata
#'   Series. (This method was contributed by Ben Schmidt.) The
#'   \code{"kantrowitz"} method uses the Kantrowitz corpus of male and female
#'   names. The \code{"genderize"} method uses the Genderize.io
#'   <\url{http://genderize.io/}> API, which is based on "user profiles across
#'   major social networks." The \code{"demo"} method is uses the top 100 names
#'   in the SSA method; it is provided only for demonstration purposes when the
#'   \code{genderdata} package is not installed and it is not suitable for
#'   research purposes.
#' @param countries The countries for which datasets are being used. For the
#'   \code{"ssa"} and \code{"ipums"} methods, the only valid option is
#'   \code{"United States"} which will be assumed if no argument is specified.
#'   For the \code{"napp"} method, you may specify a character vector with any
#'   of the following countries: \code{"Canada"}, \code{"United Kingdom"},
#'   \code{"Germany"}, \code{"Iceland"}, \code{"Norway"}, \code{"Sweden"}. For
#'   the \code{"kantrowitz"} and \code{"genderize"} methods, no country should
#'   be specified.
#' @return Returns a data frame containing the results of predicting the gender.
#'   The exact components of the returned list will depend on the specific
#'   method used. They include the following: \item{name}{The name for which the
#'   gender has been predicted.} \item{proportion_male}{The proportion of male
#'   names for the given range of years.} \item{proportion_female}{The
#'   proportion of female names for the given range of years.} \item{gender}{The
#'   predicted gender based on the proportion of male and female names. Possible
#'   values are \code{"male"} and \code{"female"} for proportions above
#'   \code{0.5}, \code{"either"} for proportions that are exactly \code{0.5},
#'   and \code{NA} for combinations of names and years for which a gender cannot
#'   be predicted using the given method.} \item{year_min}{The lower bound
#'   (inclusive) of the year range used for the prediction.} \item{year_max}{The
#'   upper bound (inclusive) of the year range used for the prediction.}
#' @export
#' @examples
#' gender("madison", method = "demo", years = 1985)
#' gender("madison", method = "demo", years = c(1900, 1985))
#' # SSA method
#' \dontrun{gender("madison", method = "demo", years = c(1900, 1985))}
#' # IPUMS method
#' \dontrun{gender("madison", method = "ipums", years = 1860)}
#' # NAPP method
#' \dontrun{gender("madison", method = "napp", countries = c("Sweden", "Denmark"))}
gender <- function(names, years = c(1932, 2012),
                   method = c("ssa", "ipums", "napp", "kantrowitz",
                              "genderize", "demo"),
                   countries = c("United States", "Canada", "United Kingdom",
                                 "Germany", "Iceland", "Norway", "Sweden"))
  {

  method <- match.arg(method)

  # If we need the genderdata package, check that it is installed
  if (!method %in% c("demo", "genderize")) {
    check_genderdata_package()
  }

  # Check that the name is a character vector
  if (class(names) != "character") stop("Data must be a character vector.")

  # Check the validity of the years argument
  if (length(years) == 1) years <- c(years, years)
  if (length(years) > 2) {
    stop("Year should be a numeric vector with no more than two values.")
  }
  if (years[1] > years[2]) {
    stop("The first value for years should be smaller than the second value.")
  }
  if (missing(years)) {
    switch(method,
           ssa = years <- c(1932, 2012),
           ipums = years <- c(1789, 1930),
           napp = years <- c(1758, 1910)
           )
  }

  # Hand off the arguments to functions based on method, and do error checking
  if (method == "ssa") {
    if (years[1] < 1880 || years[2] > 2012) {
      stop("Please provide a year range between 1880 and 2012.")
    }
    if (!missing(countries) && countries != "United States") {
      stop("SSA data is only available for the United States of America.")
    }
    gender_ssa(names = names, years = years)
  } else if (method == "demo") {
    if (years[1] < 1880 || years[2] > 2012) {
      stop("Please provide a year range between 1880 and 2012.")
    }
    if (!missing(countries) && countries != "United States") {
      stop("Demo data is only available for the United States of America.")
    }
    gender_demo(names = names, years = years)
  } else if (method == "kantrowitz") {
    if (!missing(years))
      stop("Kantrowitz method does not account for year.")
    if (!missing(countries))
      stop("Kantrowitz method does not account for country.")
    gender_kantrowitz(names = names)
  } else if (method == "ipums") {
    if (years[1] < 1789 || years[2] > 1930) {
      stop("Please provide a year range between 1789 and 1930.")
    }
    if (!missing(countries) && countries != "United States") {
      stop("IPUMS data is only available for the United States of America.")
    }
    gender_ipums_usa(names = names, years = years)
  } else if (method == "napp") {
    if (years[1] < 1758 || years[2] > 1910)
      stop("Please provide a year range between 1758 and 1910.")
    if (missing(countries))
      countries <- countries[countries != "United States"]
    countries <- match.arg(countries, several.ok = TRUE)
    if ("United States" %in% countries)
      stop("NAPP data is only available for European countries. See ",
           "the documentation.")
    gender_napp(names = names, years = years, countries = countries)
  }else if (method == "genderize") {
    if (!missing(years))
      stop("Genderize method does not account for year.")
    if (!missing(countries))
      stop("Genderize method does not account for country.")
    gender_genderize(names = names)
  }
}

# Hide variables from R CMD check
if (getRversion() >= "2.15.1") {
  c("year", "male", "female", "proportion_female", "proportion_male",
    "ssa_national", "kantrowitz", ".", "ipums_usa", "ratio_male",
    "ratio_female", "name", "year_min", "year_max", "country", "napp") %>%
  utils::globalVariables()
}

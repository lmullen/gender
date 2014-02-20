encode_gender <- function(data, name_field, years = c(1970, 2012), 
                          method = "ssa", certainty = TRUE) {
  if (method == "ssa") {
    # Check for errors in the year argument
    if (length(years) == 1) years <- c(years, years)
    if (length(years) > 2) {
      stop("Year should be a numeric vector with no more than two values.")
    } else if (years[1] > years[2]) {
      stop("The first value for years should be smaller than the second value.")
    } else {
      encode_gender_ssa(data = data, name_field = name_field, years = years,
                        certainty = certainty)
    }
  } else if (method == "kantrowitz") {
    if (!missing(years)) {
      warning("The year is not taken into account with the Kantrowitz method.") 
    }
    encode_gender_kantrowitz(data = data, name_field = name_field)
  } else {
    stop("Method ", method, " is not recognized. Try ?encode_gender for help.")
  }
}

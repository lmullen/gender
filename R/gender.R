encode_gender <- function(data, name_field, year = c(1970, 2012), 
                          method = "ssa") {
  if (method == "ssa") {
    # Check for errors in the year argument
    if (length(year) > 2) {
      stop("Year should be a numeric vector with no more than two values.")
    } else if (year[1] > year[2]) {
      stop("The first value for year should be smaller than the second value.")
    } else {
      encode_gender_ssa(data = data, name_field = name_field, year = year)
    }
  } else if (method == "kantrowitz") {
    if (!missing(year)) {
      warning("The year is not taken into account with the Kantrowitz method.") 
    }
    encode_gender_kantrowitz(data = data, name_field = name_field)
  } else {
    stop("Method ", method, " is not recognized. Try ?encode_gender for help.")
  }
}

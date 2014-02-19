encode_gender <- function(first_names, year = c(1970, 2012), method = "ssa") {
  if (method == "ssa") {
    # Check for errors in the year argument
    if (length(year) > 2) {
      stop("Year should be a numeric vector with no more than two values.")
    } else if (year[1] > year[2]) {
      stop("The first value for year should be smaller than the second value.")
    } else {
      encode_gender_ssa(first_names, year)
    }
  } else if (method == "corpus") {
    if (!missing(year)) {
      warning("The year is not taken into account with the corpus method.") 
    }
    encode_gender_corpus(first_names)
  } else {
    stop("Method ", method, " is not recognized. Try ?encode_gender for help.")
  }
}

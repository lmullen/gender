gender <- function(data, name_field = "name", years = c(1970, 2012), 
                          method = "ssa", certainty = TRUE) {
  
  # If data is a character vector, then convert it to a data frame. 
  # If the data is not a character vector or a data frame, throw an error.
  if (class(data) == "character") {
    data <- as.data.frame(data, optional = T)
    colnames(data) <- "name"
  } else if (class(data) != "data.frame") {
    stop("This function expects data to be a character vector or a data frame.")
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
      gender_ssa(data = data, name_field = name_field, years = years,
                 certainty = certainty)
    }
  } else if (method == "kantrowitz") {
    if (!missing(years)) {
      warning("The year is not taken into account with the Kantrowitz method.") 
    }
    gender_kantrowitz(data = data, name_field = name_field)
  } else {
    stop("Method ", method, " is not recognized. Try ?encode_gender for help.")
  }
}

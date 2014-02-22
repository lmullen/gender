gender <- function(data, years = c(1932, 2012), method = "ssa",
                   certainty = TRUE) {
  
  require(dplyr)
  
  # If data is a character vector, then convert it to a data frame. 
  # If the data is not a character vector or a data frame, throw an error.
  if (class(data) == "character") {
    data <- as.data.frame(data, optional = T, stringsAsFactors = FALSE)
    colnames(data) <- "name"
  } else if (class(data) != "data.frame") {
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
  } else {
    stop("Method ", method, " is not recognized. Try ?gender for help.")
  }
}

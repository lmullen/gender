#' Find the gender of frst names using Kantrowitz names corpus
#' 
#' This internal function implements the \code{method = "kantrowitz"} option of 
#' \code{\link{gender}}. See that function for documentation.
#' 
#' @param data A character string of a first name or vector of character
#'   strings.
#' @return A list or (for multiple names) a list of lists containing the name
#'   property and the predicted gender property.
gender_kantrowitz <- function(data) {
  
  # An internal function to predict the gender of one name
  apply_kantrowitz <- function(n) {
    
    results <- gender::kantrowitz %>% filter(name == n) 
    
    # If the name isn't in the data set, return use that information rather than
    # silently dropping a row
    if (nrow(results) == 0) {
      results <- data.frame(name = n, gender = "not in data")
    }
    
    return(as.list(results))
    
  }
  
  # Use the function directly if there is one name; use lapply if there are > 1.
  # Return the results as a list or a list of lists.
  if (length(data) == 1) {
    return(as.list(apply_kantrowitz(data)))
  } else { 
    return(as.list(lapply(data, apply_kantrowitz)))
  }
  
}

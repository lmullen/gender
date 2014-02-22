#' Find the gender of frst names using Kantrowitz names corpus
#' 
#' This internal function implements the \code{method = "kantrowitz"} option of 
#' \code{\link{gender}}. See that function for documentation.
gender_kantrowitz <- function(data) {
  
  left_join(data, gender::kantrowitz, by = "name")
  
}

#' Find the gender of frst names using Kantrowitz names corpus
#' 
#' This internal function implements the \code{method = "kantrowitz"} option of 
#' \code{\link{gender}}. See that function for documentation.
#' 
#' @param data A character string of a first name or a data frame with a column 
#'   named \code{name} with a character vector containing first names. The names 
#'   must all be lowercase. 
gender_kantrowitz <- function(data) {
  
  left_join(data, gender::kantrowitz, by = "name")
  
}

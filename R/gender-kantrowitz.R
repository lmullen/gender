# Find the gender of frst names using Kantrowitz names corpus
#
# This internal function implements the \code{method = "kantrowitz"} option of
# \code{\link{gender}}. See that function for documentation.
#
# @param name A character string of a first name.
# @return A list or (for multiple names) a list of lists containing the name
#   property and the predicted gender property.
gender_kantrowitz <- function(names) {

  # An internal function to predict the gender of one name
  apply_kantrowitz <- function(n) {

    results <- genderdata::kantrowitz %>% filter(name == tolower(n))

    # If the name isn't in the data set, return use that information rather than
    # silently dropping a row
    if (nrow(results) == 0) {
      results <- data.frame(name = n, gender = NA)
    }

    # Use the original capitalization of the name
    results$name <- n

    results

  }

  # Use the function directly if there is one name; use lapply if there are > 1.
  # Return the results as a list or a list of lists.
  if (length(names) == 1) {
    return(apply_kantrowitz(names))
  } else {
    return(bind_rows(lapply(names, apply_kantrowitz)))
  }

}

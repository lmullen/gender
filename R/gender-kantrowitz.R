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

    result <- genderdata::kantrowitz %>%
      filter(name == tolower(n))

    # If the name isn't in the data set, return that information rather than
    # silently dropping a row
    if (nrow(results) == 0) {
      result <- tibble(name = n, gender = NA_character_)
    }

    # Use the original capitalization of the name
    result$name <- n

    return(result)

  }

  n_names <- length(names)

  if (n_names == 1) {
    return(apply_kantrowitz(names))
  } else if (n_names < 5) {
    return(
      lapply(names, apply_kantrowitz) %>%
             bind_rows()
      )
  } else {
    return(
      tibble(name = names) %>%
      mutate(lower_name = tolower(name)) %>%
      left_join(genderdata::kantrowitz,
                by = c("lower_name" = "name")) %>%
      select(-lower_name)
    )
  }

}

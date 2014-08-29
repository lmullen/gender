gender_genderize <- function(name) {
  require(httr)
  require(jsonlite)
  require(dplyr)
  endpoint <- "http://api.genderize.io"

  apply_genderize <- function(n, country = country, lang = lang) {
    r <- GET(endpoint, query = list(name = n))
    stop_for_status(r)
    content(r, as = "text") %>%
      jsonlite::fromJSON(., simplifyVector = FALSE)
  }

  if (length(name) == 1) {
    return(as.list(apply_genderize(name)))
  } else {
    return(as.list(lapply(name, apply_genderize)))
  }

}


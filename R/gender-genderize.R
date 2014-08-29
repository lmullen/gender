gender_genderize <- function(name) {
  require(httr)
  require(jsonlite)
  require(magrittr)
  endpoint <- "http://api.genderize.io"
  r <- GET(endpoint, query = list(name = name))
  stop_for_status(r)
  content(r, as = "text") %>%
    jsonlite::fromJSON(., simplifyVector = FALSE)
}


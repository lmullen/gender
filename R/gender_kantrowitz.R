gender_kantrowitz <- function(data) {
  merge(data, gender::kantrowitz, all.x = TRUE, by = "name")
}

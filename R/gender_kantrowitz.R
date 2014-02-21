gender_kantrowitz <- function(data, name_field) {
  merge(data, gender::kantrowitz, all.x = TRUE,
        by.x = name_field, by.y = "name")
}

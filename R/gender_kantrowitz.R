gender_kantrowitz <- function(data) {
  
  left_join(data, gender::kantrowitz, by = "name")
  
}

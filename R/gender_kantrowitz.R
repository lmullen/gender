gender_kantrowitz <- function(data) {
  
  require(dplyr)
  
  left_join(data, gender::kantrowitz, by = "name")
  
}

require(dplyr)

# sample_names_data <- data.frame(
#   name = c("john", "john", "jane", "jane", "madison", "madison", "madison", "zzz",
#            "lindsay", "lindsay", "lindsay"),
#   year = as.integer(c(1890, 1990, 1890, 1990, 1890, 1980, 1990, 1600, 1600, 
#                       1950, 2015)),
#   stringsAsFactors = FALSE
#   ) %.%
#   arrange(name)

data(sample_names_data)

test_list <- list(name = "madison", year = "1900")
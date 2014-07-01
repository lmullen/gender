require(dplyr)

# How to create the data frame saved as sample_names_data.rda
# sample_names_data <- data.frame(
#   name = c("john", "john", "john", "john", "jane", "jane", "jane", "jane", "madison", "madison", "madison", "madison", "lindsay", "lindsay", "lindsay", "lindsay", "zzz"),
#   year = as.integer(c(1790, 1870, 1950, 2010, 1790, 1870, 1950, 2010, 1790, 1870, 1950, 2010, 1790, 1870, 1950, 2010, 1600)),
#   stringsAsFactors = FALSE
#   ) %>%
#   arrange(name)
# save(sample_names_data, file = "data/sample_names_data.rda")

test_list <- list(name = "madison", year = "1900")
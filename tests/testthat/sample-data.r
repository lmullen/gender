require(dplyr)

sample_names_data <- c("john", "john", "john", "john", "jane", "jane", "jane",
                       "jane", "madison", "madison", "madison", "madison",
                       "lindsay", "lindsay", "lindsay", "lindsay")
sample_years_ssa  <- c(rep(c(1930, 1960, 1990, 2010), 4))
sample_years_ipums  <- c(rep(c(1790, 1830, 1880, 1910), 4))


merle_test <- data.frame(
  name = c("merle", "merle", "merle", "merle", "merle"),
  year = as.integer(c(1880, 1890, 1900, 1901, 1910)),
  stringsAsFactors = FALSE
  )

test_list <- list(name = "madison", year = "1900")

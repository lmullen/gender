source("../sample-data.r")
context("Social Security Administration")

# Using a range of years passed as an argument
results_range <- gender(test_data, method = "ssa", years = c(1932, 2012))

# Using a column of years in the input data frame
results_column <- gender(test_data, method = "ssa", years = TRUE)

# Removing the proportion columns from the results
results_minimal <- gender(test_data, method = "ssa", certainty = FALSE)

test_that("SSA method returns valid data frame", {
  
  expect_that(results_range, is_a("data.frame"))
  expect_that(results_column, is_a("data.frame"))
  expect_that(results_minimal, is_a("data.frame"))
  
  # Don't drop any data if there aren't matches
  expect_that(nrow(test_data), equals(nrow(results_range)))
  expect_that(nrow(test_data), equals(nrow(results_column)))
  expect_that(nrow(test_data), equals(nrow(results_minimal)))
  
  expect_that(colnames(results_range),
              is_equivalent_to(c("name", "year", "proportion_male",
                                 "proportion_female", "gender")))
  expect_that(colnames(results_column),
              is_equivalent_to(c("name", "year", "proportion_male",
                                 "proportion_female", "gender")))
  expect_that(colnames(results_minimal),
              is_equivalent_to(c("name", "year","gender")))
  
})

test_that("SSA results vary over time", {
  
  expect_that(results_range$gender,
              is_equivalent_to(c("female", "female",
                                 "male", "male",
                                 "female", "female", "female",
                                 "female", "female", "female", NA)))
  
  expect_that(results_column$gender,
              is_equivalent_to(c("female", "female",
                                 "male", "male",
                                 NA, "female", NA,
                                 "male", "male", "female", NA)))
  
})

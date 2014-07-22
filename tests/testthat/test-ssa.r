source("sample-data.r")
context("SSA method")

# Using a range of years passed as an argument
results_range <- gender(sample_names_data, method = "ssa",
                        years = c(1932, 2012))

# Removing the proportion columns from the results
results_minimal <- gender(sample_names_data, method = "ssa",
                          certainty = FALSE)

test_that("SSA method returns valid data frame", {
  
  expect_that(results_range, is_a("data.frame"))
  expect_that(results_column, is_a("data.frame"))
  expect_that(results_minimal, is_a("data.frame"))
  
  # Don't drop any data if there aren't matches
  expect_that(nrow(sample_names_data), equals(nrow(results_range)))
  expect_that(nrow(sample_names_data), equals(nrow(results_column)))
  expect_that(nrow(sample_names_data), equals(nrow(results_minimal)))
  
  expect_that(colnames(results_column),
              is_equivalent_to(c("name", "year", "proportion_male",
                                 "proportion_female", "gender")))
  expect_that(colnames(results_minimal),
              is_equivalent_to(c("name", "year","gender")))
  
})

test_that("SSA results vary over time", {
  
  expect_that(results_range$gender,
              is_equivalent_to(c("female", "female", "female", "female", "male",
                                 "male", "male",  "male", "female", "female", 
                                 "female", "female", "female", "female",  "female",
                                 "female", NA)))
  
  expect_that(results_column$gender,
              is_equivalent_to(c(NA, NA, "female", "female", NA, NA, "male",
                                 "male", NA, NA, "female", "female", NA, NA, "male",
                                 "female", NA)))
  
})

test_that("SSA method uses default range of 1932 to 2012 if dates not provided", {
  expect_that(gender("cameron", method = "ssa", years = c(1932, 2012)),
              equals(gender("cameron", method = "ssa")))
  # Be sure that changing the years changes the results
  expect_that(isTRUE(all.equal(
    gender("cameron", method = "ssa"),
    gender("cameron", method = "ssa", years = c(1950,1960))
    )), is_false())
})

test_that("Correct predictions from skewed SSA data", {
  expect_that(gender("merle", method = "ssa", years = 1901)$gender,
              equals("male"))
  expect_that(gender("merle", method = "ssa", years = c(1901, 1903))$gender,
              equals("male"))
  expect_that(gender(merle_test, method = "ssa", years = TRUE)$gender,
              is_equivalent_to(c("male", "male", "male", "male", "male")))
})

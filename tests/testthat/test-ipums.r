source("sample-data.r")
context("IPUMS method")

test_that("IPUMS method checks for correct date range", {
  expect_that(gender("madison", method = "ipums", years = c(1600, 1900)),
              throws_error("Please provide a year range between 1789 and 1930"))
  expect_that(gender("madison", method = "ipums", years = c(1790, 1950)),
              throws_error("Please provide a year range between 1789 and 1930"))
})

test_that("IPUMS method uses default range of 1789 to 1930 if dates not provided", {
  expect_that(gender("benjamin", method = "ipums", years = c(1789, 1930)),
              equals(gender("benjamin", method = "ipums")))
  # Be sure that changing the years changes the results
  expect_that(isTRUE(all.equal(
    gender("benjamin", method = "ipums"),
    gender("benjamin", method = "ipums", years = c(1850, 1860))
    )), is_false())
})

# Using a range of years passed as an argument
results_range <- gender(sample_names_data, method = "ipums",
                        years = c(1860, 1890))

# Using a column of years in the input data frame
results_column <- gender(sample_names_data, method = "ipums",
                         years = TRUE)

# Removing the proportion columns from the results
results_minimal <- gender(sample_names_data, method = "ipums",
                          certainty = FALSE)

test_that("IPUMS method returns valid data frame", {
  
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

test_that("IPUMS results vary over time", {
  
  expect_that(results_range$gender,
              is_equivalent_to(c("female", "female", "female", "female", "male",
                                 "male", "male",  "male", "male", "male", "male",
                                 "male", "male", "male", "male",  "male", NA)))
  
  expect_that(results_column$gender,
              is_equivalent_to(c("female", "female", NA, NA, "male", "male", NA,
                                 NA, NA, "male",  NA, NA, NA, "male", NA, NA, NA)))
  
})

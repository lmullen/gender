source("sample-data.r")
context("Kantrowitz")

results <- gender(sample_names_data, method = "kantrowitz")

test_that("Kantrowitz method returns valid data frame", {
  
  expect_that(results, is_a("data.frame"))
  
  # Don't drop any data if there aren't matches
  expect_that(nrow(sample_names_data), equals(nrow(results)))
  
  expect_that(colnames(results),
              is_equivalent_to(c("name", "year", "gender")))
  
  expect_that(results$gender,
              is_equivalent_to(c("female", "female", "female", "female", "male",
                                 "male", "male","male", "either", "either", "either",
                                 "either", "male", "male", "male", "male", NA)))
})

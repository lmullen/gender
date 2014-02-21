source("../sample-data.r")
context("Kantrowitz")

results <- gender(test_data, method = "kantrowitz")

test_that("Kantrowitz method returns valid data frame", {
  expect_that(results, is_a("data.frame"))
  expect_that(colnames(results),
              is_equivalent_to(c("name", "year", "gender")))
  expect_that(results$gender,
              is_equivalent_to(c("female", "female",
                                 "male", "male",
                                 "male", "male", "male",
                                 NA)))
  # Don't drop any data if there aren't matches
  expect_that(nrow(test_data), equals(nrow(results)))
})

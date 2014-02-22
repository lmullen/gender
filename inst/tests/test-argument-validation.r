source("../sample-data.r")
context("Argument validation")

test_that("warns if Kantrowitz method includes years", {
  expect_that(gender(data = "julie", years = c(1880,1900), method = 
                            "kantrowitz"),
              gives_warning("The year is not taken into account"))
  expect_that(gender(data = "julie", years = TRUE, method = 
                            "kantrowitz"),
              gives_warning("The year is not taken into account"))
})

test_that("error if data is not a data frame or character vector", {
  expect_that(gender(data = 1900),
              throws_error("Data must be a character vector or a data frame."))
  expect_that(gender(data = test_list),
              throws_error("Data must be a character vector or a data frame."))
})

test_that("error if years are not either boolean, range, or single year", {
  expect_that(gender(test_data, years = c(1900, 1950, 2000)),
              throws_error("Year should be a numeric vector with"))
  expect_that(gender(test_data, years = c(1950, 1900)),
              throws_error("The first value for years should be smaller"))
})

test_that("error if method is not recognized", {
  expect_that(gender(test_data, method = "census"),
              throws_error("Method .+ is not recognized"))
})

test_that("function works with a single year", {
  expect_that(gender("madison", years = 2000)$gender,
              equals("female"))
})

source("sample-data.r")
context("Argument validation")

test_that("warns if Kantrowitz method includes years", {
  expect_that(gender(name = "julie", years = c(1880,1900), method =
                            "kantrowitz"),
              gives_warning("Kantrowitz method does not account for year."))
})

test_that("error if data is not a character vector", {
  expect_that(gender(name = 1900),
              throws_error("Data must be a character vector."))
})

test_that("error if years are not either range or single year", {
  expect_that(gender(sample_names_data, years = c(1900, 1950, 2000)),
              throws_error("Year should be a numeric vector with"))
  expect_that(gender(sample_names_data, years = c(1950, 1900)),
              throws_error("The first value for years should be smaller"))
})

test_that("error if method is not recognized", {
  expect_that(gender(sample_names_data, method = "my_nonworking_method"),
              throws_error("Method .+ is not recognized"))
})

test_that("function works with a single year", {
  expect_that(gender("madison", method = "ssa", years = 2000)$gender,
              equals("female"))
})

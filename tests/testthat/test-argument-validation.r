source("sample-data.r")
context("Argument validation")

test_that("error if Kantrowitz method includes years", {
  expect_that(gender(name = "julie", years = c(1880,1900), method =
                            "kantrowitz"),
              throws_error("Kantrowitz method does not account for year."))
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
              throws_error("Error in match.arg"))
})

test_that("function works with a single year", {
  expect_that(gender("madison", method = "ssa", years = 2000)$gender,
              equals("female"))
})

test_that("countries are mapped with their respective methods", {
  expect_error(gender("Madison", method = "ssa", countries = "Sweden"),
               "SSA data is only available")
  expect_error(gender("Madison", method = "ipums", countries = "Denmark"),
               "IPUMS data is only available")
  expect_error(gender("Madison", method = "kantrowitz", countries = "Denmark"),
               "Kantrowitz method does not account for country")
  expect_error(gender("Madison", method = "genderize", countries = "USA"),
               "Genderize method does not account for country")
  expect_error(gender("Madison", method = "napp", countries = "United States"),
               "NAPP data is only available for European countries.")
  expect_error(gender("Madison", method = "napp", countries = "New South Wales"))
})

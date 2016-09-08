source("sample-data.r")
context("NAPP method")

# Test a single name
single        <- gender("Leslie", method = "napp", years = c(1870, 1871))

# Test a missing name
missing       <- gender("zzzzz", method = "napp", years = 1890)

test_that("a single name can be encoded", {
  # Madison was male in the NAPP period
  expect_that(single$gender, equals("male"))
})

test_that("a single name returns the name, gender, and proportions", {
  expect_is(single, "data.frame")
  expect_that(length(single), equals(6))
  expect_that(names(single), equals(c("name", "proportion_male",
                                      "proportion_female", "gender",
                                      "year_min", "year_max")))
})

test_that("the returned value has items with the correct types", {
  expect_is(single$name, "character")
  expect_is(single$proportion_female, "numeric")
  expect_is(single$proportion_male, "numeric")
  expect_is(single$gender, "character")
  expect_is(single$year_min, "numeric")
  expect_is(single$year_max, "numeric")
})

test_that("a name not in the data set returns an empty data frame", {
  expect_equal(nrow(missing), 0)
})

test_that("capitalization of name matches what was passed to it", {
  expect_equal(gender("Marie", method = "napp")$name, "Marie")
})

test_that("different countries can be specified", {
  sweden <- gender("Hilde", method = "napp", countries = "Sweden")
  scandinavia <- gender("Claude", method = "napp",
                        countries = c("Sweden", "Norway"))
  expect_false(sweden$proportion_male == scandinavia$proportion_male)
})

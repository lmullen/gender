source("sample-data.r")
context("IPUMS method")

# Test a single name
single        <- gender("Madison", method = "ipums", years = c(1880, 1881))

# Test a missing name
missing       <- gender("zzzzz", method = "ipums", years = 1880)

test_that("a single name can be encoded", {
  # Madison was male in the IPUMS period
  expect_that(single$gender, equals("male"))
})

test_that("a single name returns a list with the name, gender, and proportions", {
  expect_is(single, "data.frame")
  expect_that(length(single), equals(6))
  expect_that(names(single), equals(c("name", "proportion_male",
                                      "proportion_female", "gender",
                                      "year_min", "year_max")))
})

test_that("the returned list has items with the correct types", {
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
  expect_equal(gender("Marie", method = "ipums")$name, "Marie")
})

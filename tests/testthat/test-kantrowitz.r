source("sample-data.r")
context("Kantrowitz")

# Test a single name
single        <- gender("madison", method = "kantrowitz")

# Test multiple names with same years
multiple_same <- gender(sample_names_data, method = "kantrowitz")

test_that("a single name can be encoded", {
  expect_that(single$gender, equals("male"))
})

test_that("a single name returns a list with the name and gender", {
  expect_is(single, "data.frame")
  expect_that(length(single), equals(2))
  expect_that(names(single), equals(c("name", "gender")))
})

test_that("multiple names returns a data.frame", {
  expect_is(multiple_same, "data.frame")
  expect_equal(nrow(multiple_same), length(sample_names_data))
  expect_equal(names(multiple_same), c("name", "gender"))
})

test_that("capitalization of name matches what was passed to it", {
  expect_equal(gender("Marie", method = "kantrowitz")$name, "Marie")
})

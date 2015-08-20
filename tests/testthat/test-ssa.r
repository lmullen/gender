source("sample-data.r")
context("SSA method")

# Test a single name
single        <- gender("Madison", method = "ssa", years = c(2000, 2001))

# Test multiple names with different years
multiple_diff <- Map(gender, sample_names_data, sample_years_ssa,
                     method = "ssa") %>%
  do.call(rbind.data.frame, .)

test_that("a single name can be encoded", {
  # Madison was female in the SSA period
  expect_that(single$gender, equals("female"))
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

test_that("Correct predictions from skewed SSA data", {
  # For rationale see https://github.com/ropensci/gender/issues/9
  expect_that(gender("merle", method = "ssa", years = 1901)$gender,
              equals("male"))
  expect_that(gender("merle", method = "ssa", years = c(1901, 1903))$gender,
              equals("male"))
})

test_that("capitalization of name matches what was passed to it", {
  marie <- gender("Marie", years = 1978, method = "ssa")
  expect_equal(marie$name, "Marie")
})

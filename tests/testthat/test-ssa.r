source("sample-data.r")
context("SSA method")

# Test a single name
single        <- gender("madison", method = "ssa")

# Test multiple names with same years
multiple_same <- gender(sample_names_data, years = c(1980, 2000), method = "ssa")

# Test multiple names with different years
multiple_diff <- Map(gender, sample_names_data, sample_years_ssa, method = "ssa") %>%
  do.call(rbind.data.frame, .)

# Test a missing name
missing       <- gender("zzzzz", method = "ssa")

test_that("a single name can be encoded", {
  expect_that(single$gender, equals("female"))
})

test_that("a single name returns a list with the name, gender, and proportions", {
  expect_that(class(single), equals("list"))
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
})

test_that("multiple names returns a list of lists", {
  expect_that(class(multiple_same), equals("list"))
  expect_that(length(multiple_same), equals(length(sample_names_data)))
  expect_that(names(multiple_same[[1]]), equals(c("name", "proportion_male",
                                                  "proportion_female", "gender",
                                                  "year_min", "year_max")))
})

test_that("names vary over time", {
  require(dplyr)
  madison_names <- multiple_diff %>%
    filter(name == "madison")
  expect_that(as.character(madison_names$gender), is_equivalent_to(
    c("male", "male", "female", "female")))
})

test_that("a name not in the data set is marked as such and not dropped", {
  expect_that(missing$gender, is_equivalent_to(NA))
})

test_that("SSA method uses default range of 1932 to 2012 if dates not provided", {
  expect_that(gender("cameron", method = "ssa", years = c(1932, 2012)),
              equals(gender("cameron", method = "ssa")))

  # Be sure that changing the years changes the results
  expect_that(isTRUE(all.equal(
    gender("cameron", method = "ssa"),
    gender("cameron", method = "ssa", years = c(1950,1960))
    )), is_false())
})

test_that("Correct predictions from skewed SSA data", {
  # For rationale see https://github.com/ropensci/gender/issues/9
  expect_that(gender("merle", method = "ssa", years = 1901)$gender,
              equals("male"))
  expect_that(gender("merle", method = "ssa", years = c(1901, 1903))$gender,
              equals("male"))
})

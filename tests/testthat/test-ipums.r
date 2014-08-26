source("sample-data.r")
context("IPUMS method")

# Test a single name
single        <- gender("madison", method = "ipums")

# Test uppercase name
uppercase     <- gender("Madison", method = "ipums")

# Test multiple names with same years
multiple_same <- gender(sample_names_data, years = c(1860, 1880),
                        method = "ipums")

# Test multiple names with different years
multiple_diff <- Map(gender, sample_names_data, sample_years_ipums,
                     method = "ipums") %>%
  do.call(rbind.data.frame, .)

# Test a missing name
missing       <- gender("zzzzz", method = "ipums")

test_that("a single name can be encoded", {
  # Madison was male in the IPUMS period
  expect_that(single$gender, equals("male"))
})

test_that("name is case-insensitive", {
  expect_that(single$proportion_female, equals(uppercase$proportion_female))
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
  expect_is(single$year_min, "numeric")
  expect_is(single$year_max, "numeric")
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
    c(NA, "male", "male", "male")))
})

test_that("a name not in the data set is marked as such and not dropped", {
  expect_that(missing$gender, is_equivalent_to(NA))
})

test_that("IPUMS uses default range of 1789 to 1930 if dates not provided", {
  expect_that(gender("cameron", method = "ipums", years = c(1789, 1930)),
              equals(gender("cameron", method = "ipums")))

  # Be sure that changing the years changes the results
  expect_that(isTRUE(all.equal(
    gender("cameron", method = "ipums"),
    gender("cameron", method = "ipums", years = c(1850,1860))
    )), is_false())
})

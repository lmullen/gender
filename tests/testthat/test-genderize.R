context("Genderize method")

single <- gender("leslie", method = "genderize")

single_country <- gender("leslie", method = "genderize", countries = "US")

failed <- gender("does not exist", method = "genderize")

test_that("a single name returns a data frame with the name, gender, and proportions", {
  expect_is(single, "data.frame")
  expect_that(names(single), equals(c("name", "gender", "proportion_female",
                                      "proportion_male")))
})

test_that("leslie is a female name according to genderize", {
  expect_that(single$gender, equals("female"))
})

test_that("genderize returns values of correct type", {
  expect_that(class(single$name), equals("character"))
  expect_that(class(single$gender), equals("character"))
  expect_that(class(single$proportion_female), equals("numeric"))
  expect_that(class(single$proportion_male), equals("numeric"))
})

test_that("genderize does not have an error with names that don't exist", {
  expect_is(failed, "data.frame")
  expect_equal(nrow(failed), 1)

  expect_that(class(failed$name), equals("character"))
  expect_that(class(failed$gender), equals("character"))
  expect_that(class(failed$proportion_female), equals("numeric"))
  expect_that(class(failed$proportion_male), equals("numeric"))

  expect_that(failed$name, equals("does not exist"))
  expect_that(failed$gender, equals(NA_character_))
  expect_that(failed$proportion_female, equals(NA_real_))
  expect_that(failed$proportion_male, equals(NA_real_))
})

test_that("county codes can be included and return the same correct data frame", {
  expect_is(single_country, "data.frame")
  expect_that(names(single_country),
              equals(c("name", "gender", "proportion_female", "proportion_male")))
})

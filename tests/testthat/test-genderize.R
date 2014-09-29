context("Genderize method")

single <- gender("leslie", method = "genderize")

test_that("a single name returns a list with the name, gender, and proportions", {
  expect_that(class(single), equals("list"))
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

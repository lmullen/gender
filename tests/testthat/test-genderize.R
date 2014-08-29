context("Genderize method")

single <- gender("leslie", method = "genderize")
multiple <- gender(c("leslie", "Peter"), method = "genderize")

test_that("a single name returns a list with the name, gender, and proportions", {
  expect_that(class(single), equals("list"))
  expect_that(names(single), equals(c("name", "gender", "proportion_female",
                                      "proportion_male")))
})

test_that("multiple names returns a list of lists", {
  expect_that(class(multiple), equals("list"))
  expect_that(length(multiple), equals(2))
  expect_that(names(multiple[[1]]), equals(names(single)))
})

test_that("leslie is a female name according to genderize", {
  expect_that(single$gender, equals("female"))
  expect_that(single$proportion_female, equals(0.9))
})

test_that("genderize returns values of correct type", {
  expect_that(class(single$name), equals("character"))
  expect_that(class(single$gender), equals("character"))
  expect_that(class(single$proportion_female), equals("numeric"))
  expect_that(class(single$proportion_male), equals("numeric"))
})

test_that("genderize can delete certainty columns", {
  expect_that(length(gender("peter", method = "genderize", certainty = FALSE)),
              equals(2))
})

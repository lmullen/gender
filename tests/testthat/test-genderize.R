context("Genderize method")

test_that("truth is true", {
  expect_that(TRUE, equals(TRUE))
})

single <- gender("peter", method = "genderize")

test_that("genderize method returns a list", {
  expect_that(single, is_a("list"))
})

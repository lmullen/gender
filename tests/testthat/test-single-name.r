context("Single name")

test_that("a single name can be encoded", {
  expect_that(gender("madison"),
              is_a("data.frame"))
  expect_that(gender("madison", method = "kantrowitz")$gender,
              equals("male"))
  expect_that(gender("madison", method = "ssa", years = c(1880, 1950))$gender,
              equals("male"))
  expect_that(gender("madison", method = "ssa", years = c(1990, 2000))$gender,
              equals("female"))
  expect_that(gender("madison", method = "ssa", years = 2000)$proportion_female,
              equals(0.9931))
  expect_that(gender("madison", method = "ipums", years = c(1800, 1850))$gender,
              equals("male"))
  expect_that(gender("madison", method = "ipums", years = c(1800, 1850))$proportion_male,
              equals(0.9927))
})

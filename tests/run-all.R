library(testthat)
if (requireNamespace("genderdata", quietly = TRUE)) {
  test_check("gender")
} else {
  test_check("gender", filter = "demo")
}

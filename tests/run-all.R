library(testthat)
if (requireNamespace("genderdata", quietly = TRUE)) {
  test_check("gender", filter = "demo")
} else {
  test_check("gender", filter = "demo")
}

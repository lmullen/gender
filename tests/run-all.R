library(testthat)
if("genderdata" %in% installed.packages()) {
  test_check("gender")
} else {
  test_check("gender", filter = "demo")
}

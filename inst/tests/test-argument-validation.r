context("Checking arguments to functions")

test_that("method kantrowitz warns if years are provided", {
  expect_that(encode_gender(data = "julie", years = c(1880,1900), method = 
                            "kantrowitz"),
              gives_warning("The year is not taken into account"))

  
})

source("sample-data.r")
context("Gender DF")

results <- gender_df(sample_names_df,
                     name_col = "names", year_col = "years",
                     method = "ssa")

test_that("makes correct predictions", {
    results2 <- results %>% filter(name == "madison")
  expect_equal(results2$gender, c("male", "female"))
})

test_that("works with different arguments and methods", {
  names(sample_names_df) <- c("firstname", "years")
  sample_names_df$years <- sample_names_df$years - 100
  sample_names_df$min <- sample_names_df$years - 3
  sample_names_df$max <- sample_names_df$years + 3

  results <- gender_df(sample_names_df,
                       name_col = "firstname",
                       year_col = c("min", "max"),
                       method = "ipums")

  expect_is(results, "data.frame")
})

test_that("only operates on distinct combinations of names/years", {
  big <- gender_df(sample_names_df_big,
                   name_col = "names", year_col = "years")
  expect_identical(results, big)
})

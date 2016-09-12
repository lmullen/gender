#' Predict gender on each element of vector, with automatic defaults
#'
#' This function selects sane defaults for the years and/or countries
#' supplied. It calls `gender_df` under the hood, so it is efficient at
#' eliminating duplicate calls. The vectorized results are suitable to
#' use in a dplyr `mutate` call.
#'
#' All passed arguments should be of the same length, or else of length
#' 1, in which case they will be recycled. For example, if all the
#' names are from the United States, just pass "United States" to countries:
#' but if half are Norwegian and half are Swedish, pass a vector of the
#' same length as the names.
#'
#' @export
#'
#' @param names First names as a character vector. Names are case insensitive.
#' @param years The birth year of the name whose gender is to be predicted.
#'  Default is 2000.
#' @param year_ends Optionally, a second set of years to make a range prediction.
#'  This is useful if you are uncertain about a birth year, or if a name is rare and you
#'  want to search a range of years. Defaults to the equivalent value of years.
#' @param countries The countries for which datasets are being used. Default is
#'  "United States"
#'  will call the "ipums" method between 1789 and 1930, and "ssa" between 1931 and 2011.
#'  "Canada", "United Kingdom", "Denmark", "Iceland", "Norway", and "Sweden"
#'  will call the 'napp' method between 1758 and 1910.
#' @param threshold Certainty required before a name is reported as 'male' or 'female.'
#'  If .8, for example, 80% of occurrences of a name must be female before the name
#'  returns female; otherwise the value will be NA.
#'
#' @return A vector of the same length as the longest passed argument. Each
#' value will be 'male', 'female', or NA.
#'
#' @examples
#'
#' # Two men and a woman:
#'
#' gender_vector(c("Peter","Paul","Mary"))
#'
#' # One of these names is not like the others.
#'
#' gender_vector(c("John","Paul","George","Ringo"))
#'
#' # This one is slow--I'm not sure why, but clearly
#' # something isn't optimized for the same name on many
#' # years.
#' gender_vector("Leslie",years = 1850:1980)
#'
#' gender_vector(c("Jean"),years = 1900, countries =
#' c("United States", "Sweden"))
#'
gender_vector <- function(
  names,
  years = 2000,
  year_ends = years,
  countries = "United States",
  threshold = .5) {
  # A function that takes a list of years and names and vectorizes the assignment of gender.

  # We take either one per element or many of the same length. data_frame can handle this.

  input = data_frame(
    name=names,
    year=years,
    year_end = years,
    country = countries) %>%
    mutate(
      id=1:n(),
      midpoint=round(year+year_end)/2
    ) # Track an ID to make sure output is the same order as input.


  mins_frame = data_frame(
    method = c("ssa","ipums","napp","NA"),
    maxx = c(2012,1930,1910,NA),
    minn = c(1880,1789,1758,NA))

  # Would it be best to pre-build this data_frame and just access it as needed?
  # Overhead is pretty low, I suspect
  best_method = data_frame(
    midpoint = 1931:2012,
    method = "ssa",
    country = "United States"
  ) %>% rbind(
    data_frame(
      midpoint = 1789:1930,
      method = "ipums",
      country = "United States"
    ) %>% rbind(
      data_frame(midpoint=rep(1776:1910,each=3),
                 method="napp",
                 country=rep(c("Sweden","Norway","Canada"),length(1758:1910))
      )
    )
  )

  gender_df_results =
    input %>% ungroup %>%
    # Merge to find the best method for every country-year combo
    inner_join(best_method, by = c("country","midpoint")) %>%
    group_by(method,country) %>%
    do(gender_df(., year_col = c("year","year_end"), name_col = "name", method = .$method[1])) %>%
    ungroup %>%
    filter(abs(proportion_male-.5)>abs(threshold-.5)) %>%
    mutate(year=year_min,year_end=year_max) %>%
    select(year,year_end,name,gender,country)

  # Merge those results back in with a left join, which imputes NAs.
  newversion = input %>%
    left_join(gender_df_results,by=c("name","year","year_end","country")) %>%
    arrange(id) # Unnecessary, because dplyr keeps the sorting of the lefternmost
    # frame; but I'm not confident that behavior is mandated in all circumstances.

  # Return just the gender column.
  newversion$gender
}


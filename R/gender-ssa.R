# Find the gender of first names using Social Security data
#
# This internal function implements the \code{method = "ssa"} option of
# \code{\link{gender}}. See that function for documentation.
#
# @param names A character string of a first name. Case insensitive.
# @param years This argument can be either a single year or a range of years in
#   the form \code{c(1880, 1900)}. If no value is specified, then the names
#   will be looked up for the period 1932 to 2012. If a year or range of years
#   is specified, then the names will be looked up for that period. Dates may
#   range from 1880 to 2012. For years before 1930, the IPUMS method is
#   probably better.
# @param correct_skew A boolean value which determines whether or not to
#   correct the skewed gender ratios of the SSA data. Default is to do the
#   correction, which is recommended.
gender_ssa <- function(names, years, correct_skew = TRUE) {

  # If we're going to correct the skew, calculate the correction factors;
  # otherwise just give them a value of one.
  if (correct_skew) {
    correx <- get_correction_factors(years)
  } else {
    correx <- c(1, 1); names(correx) <- c("female", "male")
  }

  genderdata::ssa_national %>%
    filter(name %in% tolower(names),
           year >= years[1],
           year <= years[2]) %>%
    group_by(name) %>%
    summarise(female = sum(female) * correx['female'],
              male = sum(male) * correx['male']) %>%
    mutate(proportion_male = round((male / (male + female)),
                                      digits = 4),
              proportion_female = round((female / (male + female)),
                                        digits = 4)) %>%
    mutate(gender = ifelse(proportion_female == 0.5, "either",
                           ifelse(proportion_female > 0.5, "female",
                                  "male"))) %>%
    mutate(year_min = years[1], year_max = years[2]) %>%
    rename(join_name = name) %>%
    left_join(data_frame(name = names, join_name = tolower(names)),
              by = "join_name") %>%
    select(name, proportion_male, proportion_female, gender, year_min, year_max)

}

# Calculate the correction factors for a year or range of years
#
# The SSA data is skewed by gender, especially for years before 1935. This
# internal function figures out the factor by which the gender ratio should be
# multiplied in order to assume that the ratio of male to female births for
# those years was 1:1.
#
# @param years The range of years. This value will be passed to it by the
#   gender_ssa function.
#
get_correction_factors <- function(years) {
  genderdata::ssa_national %>%
    filter(year >= years[1],
           year <= years[2]) %>%
    summarise(female = sum(female),
              male = sum(male)) %>%
    transmute(ratio_female = female / (male + female),
              ratio_male = 1 - ratio_female) %>%
    transmute(female = 0.5 / ratio_female,
              male = 0.5 / ratio_male) %>%
    unlist()
}

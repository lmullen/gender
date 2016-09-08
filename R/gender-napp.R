# Find the gender of first names using NAPP data
#
# This internal function implements the \code{method = "napp"} option of
# \code{\link{gender}}. See that function for documentation.
#
# @param names A character string of a first name. Case insensitive.
# @param years This argument can be either a single year or a range of years in
#   the form \code{c(1758, 1910)}. If no value is specified, then the names
#   will be looked up for the period 1758 to 1910. If a year or range of years
#   is specified, then the names will be looked up for that period. Dates may
#   range from 1758 to 1910.
# @param countries The countries to look up the names for. Multiple countries
#   can be specified.
gender_napp <- function(names, years, countries) {

  genderdata::napp %>%
    filter(name %in% tolower(names),
           year >= years[1],
           year <= years[2],
           country %in% countries) %>%
    group_by(name) %>%
    summarise(female = sum(female),
              male = sum(male)) %>%
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

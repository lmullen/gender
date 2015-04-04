# Demo finding the gender of first names using SSA data
#
# This internal function implements the \code{method = "demo"} option of
# \code{\link{gender}}. See that function for documentation.
#
# @param name A character string of a first name. Case insensitive.
# @param years This argument can be either a single year or a range of years in
#   the form \code{c(1880, 1900)}. If no value is specified, then the names
#   will be looked up for the period 1932 to 2012. If a year or range of years
#   is specified, then the names will be looked up for that period. Dates may
#   range from 1880 to 2012. For years before 1930, the IPUMS method is
#   probably better.
# @param certainty A boolean value, which determines whether or not to return
#   the proportion of male and female uses of names in addition to determining
#   the gender of names.
gender_demo <- function(names, years) {

  basic_names %>%
    filter(name %in% tolower(names),
           year >= years[1],
           year <= years[2]) %>%
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

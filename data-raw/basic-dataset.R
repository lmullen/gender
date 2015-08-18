library(dplyr)
library(genderdata)

# Most commonly used names
top_names <- genderdata::ssa_national %>%
  group_by(name) %>%
  summarize(total = sum(male) + sum(female)) %>%
  arrange(desc(total)) %>%
  head(100)

# Get just those names from the ssa_national dataset
basic_names <- genderdata::ssa_national %>%
  filter(name %in% c(top_names$name, "jordan", "madison", "hillary", "monroe"))

save(basic_names, file = "R/sysdata.rda", compress = TRUE)

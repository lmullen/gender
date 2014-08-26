## ----, echo=FALSE, results='hide', message=FALSE-------------------------
library(gender)
library(dplyr)
library(ggplot2)

## ----, echo = FALSE, warning = FALSE, error = FALSE, message = FALSE-----
gender::ssa_national %>%
  filter(name == "madison") %>%
  mutate(proportion_female = female / (female + male)) %>%
ggplot(aes(x = year, y = proportion_female)) +
  geom_line() +
  ggtitle("Proportion of female uses of Madison ") +
  xlab(NULL) + ylab(NULL)

## ------------------------------------------------------------------------
gender("Madison")

## ------------------------------------------------------------------------
gender("Madison", method = "ipums", years = 1850)
gender("Madison", method = "ssa", years = 1950)
gender("Madison", method = "ssa", years = 2000)

## ----, echo=FALSE--------------------------------------------------------
source("../tests/testthat/sample-data.r")

## ------------------------------------------------------------------------
sample_names_df

## ------------------------------------------------------------------------
library(magrittr) # to use the %>% pipe operator
gender(sample_names_df$names, method = "ssa", years = c(1930, 2010)) %>%
  head()

## ------------------------------------------------------------------------
gender(sample_names_df$names,
       method = "ssa",
       years = c(1930, 2010)) %>%
  do.call(rbind.data.frame, .)

## ------------------------------------------------------------------------
results <- Map(gender,
               sample_names_df$names,
               years = sample_names_df$years,
               method = "ssa") %>%
  do.call(rbind.data.frame, .)
results

## ------------------------------------------------------------------------
joined <- merge(sample_names_df, results, 
                by.x = c("names", "years"), by.y = c("name", "year_min"))
joined

## ----, eval = FALSE------------------------------------------------------
#  data(package = "gender")

## ------------------------------------------------------------------------
data(ssa_national)
ssa_national


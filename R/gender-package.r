#' Gender: predict gender from names using historical data
#'
#' Encodes gender based on names and dates of birth, using U.S. Census or Social
#' Security data sets.
#'
#' @name gender
#' @docType package
#' @title Gender: predict gender by name from historical data
#' @author \email{lincoln@@lincolnmullen.com}
#' @keywords gender
#' @import dplyr
#' @import jsonlite
#' @import httr
#' @import babynames
NULL

#' IPUMS US census national names dataset
#'
#' A data set containing the number of instances of male and female names born
#' in the years 1789 to 1940 for people included in the decennial IPUMS censuses
#' Numbers. IPUMS includes 1% and 5% samples for each year: for every birth year, counts
#' from all relevant censuses with people under 62 years old are included.
#' Contributed by Ben Schmidt.
#'
#' @docType data
#' @keywords datasets
#' @name ipums_usa
#' @source Steven Ruggles, J. Trent Alexander, Katie Genadek, Ronald Goeken, Matthew B. Schroeder, and Matthew Sobek. Integrated Public Use Microdata Series: Version 5.0 [Machine-readable database]. Minneapolis, MN: Minnesota Population Center [producer and distributor], 2010.
#' @format A data frame with c. 1.3m observations and 4 variables
NULL

#' Katrowitz names corpus
#'
#' A data set containing 7,579 unique names compiled into two lists of male and
#' female names by Mark Kantrowitz and Bill Ross in 1991, also used in Python's
#' Natural Language Toolkit.
#'
#' @docType data
#' @keywords datasets
#' @name kantrowitz
#' @source Mark Kantrowitz and Bill Ross,
#'   \url{http://www.cs.cmu.edu/afs/cs/project/ai-repository/ai/areas/nlp/corpora/names/0.html}
#' @format A data frame with 7,579 observations and 2 variables
NULL

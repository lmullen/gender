#' Gender: find gender by name and date
#' 
#' Encodes gender based on names and dates of birth, using the Social
#' Security Administration's data set of first names by year and state. By
#' using the SSA data instead of lists of male and female names, this package
#' is able to more accurately guess the gender of a name, and it is able to
#' report the probability that a name was male or female. Based on an technique
#' devised by Cameron Blevins.
#' 
#' @name gender
#' @docType package
#' @title Gender: find gender by name and date
#' @author \email{lincoln@@lincolnmullen.com}
#' @keywords gender
NULL

#' Social Security Administration national names dataset
#' 
#' A data set containing the number of instances of male and female names born
#' in the years 1880 to 2012 for people who have received Social Security 
#' Numbers. The SSA includes only names were used more than five times in a 
#' given year. The data set contains 91,320 unique names in total.
#' 
#' @docType data
#' @keywords datasets
#' @name ssa_national
#' @source Social Security Administration, 
#'   \url{http://catalog.data.gov/dataset/baby-names-from-social-security-card-applications-national-level-data}
#' @format A data frame with 1,603,026 observations and 4 variables
NULL

#' Social Security Administration state names dataset
#' 
#' A data set containing the number of instances of male and female names born
#' in each state for the years 1910 to 2012 for people who have received Social
#' Security Numbers. The SSA includes only names were used more than five times
#' in a given state in a given year. 
#' 
#' @docType data
#' @keywords datasets
#' @name ssa_state
#' @source Social Security Administration, 
#'   \url{http://catalog.data.gov/dataset/baby-names-from-social-security-card-applications-data-by-state-and-district-of-}
#' @format A data frame with 5,267,234 observations and 5 variables
NULL

#' Social Security Administration national names dataset
#' 
#' A data set containing the number of instances of male and female names born
#' in the years 1880 to 2012 for people who have received Social Security 
#' Numbers. The SSA includes only names were used more than five times in a 
#' given year. The data set contains 91,320 unique names in total.
#' 
#' @docType data
#' @keywords datasets
#' @name ssa_national
#' @source Social Security Administration, 
#'   \url{http://catalog.data.gov/dataset/baby-names-from-social-security-card-applications-national-level-data}
#' @format A data frame with 1,603,026 observations and 4 variables
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

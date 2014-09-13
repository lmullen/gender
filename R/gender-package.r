#' Gender: predict gender from names using historical data
#'
#' Encodes gender based on names and dates of birth, using U.S. Census or Social
#' Security data sets. Requires separate downlaod of datasets, which should be
#' done automatically and can be done manually by running
#' \code{install_genderdata_package()}.
#'
#' @name gender
#' @docType package
#' @title Gender: predict gender by name from historical data
#' @author \email{lincoln@@lincolnmullen.com}
#' @keywords gender
#' @import devtools
#' @import dplyr
#' @import jsonlite
#' @import httr
"gender"

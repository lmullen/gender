#' Gender: predict gender from names using historical data
#'
#' Encodes gender based on names and dates of birth, using U.S. Census or Social
#' Security data sets. Requires separate downlaod of datasets, which should be
#' done automatically and can be done manually by running
#' \code{install_genderdata_package()}.
#'
#' This package attempts to infer gender (or more precisely, sex assigned at
#' birth) based on first names using historical data, typically data that was
#' gathered by the state. This method has many limitations, and before you use
#' this package be sure to take into account the following guidelines.
#'
#' (1) Your analysis and the way you report it should take into account the
#' limitations of this method, which include its reliance of data created by the
#' state and its inability to see beyond the state-imposed gender binary. At a
#' minimum, be sure to read our article explaining the limitations of this
#' method, as well as the review article that is critical of this sort of
#' methodology, both cited below.
#'
#' (2) Do not use this package to study individuals: it is at most useful for
#' studying populations in the aggregate.
#'
#' (3) Resort to this method only when the alternative is not a more nuanced and
#' justifiable approach to studying gender, but where the alternative is not
#' studying gender at all. For instance, for many historical sources this
#' approach might be the only way to get a sense of the sex ratios in a
#' population. But ask whether you really need to use this method, whether you
#' are using it responsibly, or whether you could use a better approach instead.
#'
#' Blevins, Cameron, and Lincoln A. Mullen, “Jane, John … Leslie? A Historical
#' Method for Algorithmic Gender Prediction,” *Digital Humanities Quarterly* 9,
#' no. 3 (2015).
#' http://www.digitalhumanities.org/dhq/vol/9/3/000223/000223.html
#'
#' Mihaljević, Helena, Marco Tullney, Lucía Santamaría, and Christian
#' Steinfeldt. “Reflections on Gender Analyses of Bibliographic Corpora.”
#' *Frontiers in Big Data* 2 (August 28, 2019): 29.
#' https://doi.org/10.3389/fdata.2019.00029.
#'
#'
#' @docType package
#' @name gender-package
#' @title Gender: predict gender by name from historical data
#' @author \email{lincoln@@lincolnmullen.com}
#' @import dplyr
#' @importFrom utils data
#' @importFrom utils menu
NULL

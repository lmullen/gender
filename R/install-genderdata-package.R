#' Install datasets for predicting gender
#'
#' If the genderdata package is not installed, install it from GitHub using
#' devtools. If it is not up to date, reinstall it.
#' @export
install_genderdata_package <- function() {
  genderdata_version <- "0.1"
  if (! "genderdata" %in% utils::installed.packages()) {
    message("Installing datasets for predicting gender from GitHub")
    devtools::install_github("lmullen/gender-data-pkg")
  } else if (utils::packageVersion("genderdata") < genderdata_version) {
    message("Updating dataset for predicting gender from GitHub")
    devtools::install_github("lmullen/gender-data-pkg")
  }
}

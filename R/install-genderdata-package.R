#' Install datasets for predicting gender
#'
#' If the genderdata package is not installed, install it from GitHub using
#' devtools. If it is not up to date, reinstall it.
#' @export
install_genderdata_package <- function() {
  current_genderdata_version <- "0.1"
  if (! "genderdata" %in% installed.packages()) {
    message("Installing datasets for predicting gender from GitHub")
    devtools::install_github("lmullen/gender-data-pkg")
  } else if (packageVersion("genderdata") < current_genderdata_version) {
    message("Updating dataset for predicting gender from GitHub")
    devtools::install_github("lmullen/gender-data-pkg")
  }
}

.onattach <- function(libname, pkgname) {
  packageStartupMessage("Works beautifully")
  install_genderdata_package()
}

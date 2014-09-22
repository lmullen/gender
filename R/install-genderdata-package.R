#' Check whether to install data for gender function and install if necessary
#'
#' If the genderdata package is not installed, install it from GitHub using
#' devtools. If it is not up to date, reinstall it.
#' @export
check_genderdata_package <- function() {
  genderdata_version <- "0.1"
  if (! "genderdata" %in% utils::installed.packages()) {
    message("The genderdata package needs to be installed from GitHub.")
    gender::install_genderdata_package()
  } else if (utils::packageVersion("genderdata") < genderdata_version) {
    message("The genderdata package needs to be updated from GitHub.")
    gender::install_genderdata_package()
  }
}

#' Install the genderdata package after checking with the user
#' @export
install_genderdata_package <- function() {
  input <- menu(c("Yes", "No"), title = "Install the genderdata package?")
  if (input == 1) {
    message("Installing the genderdata package.")
    tryCatch(devtools::install_github("lmullen/gender-data-pkg"),
             error = function(e) {
      stop("Failed to install the genderdata package. Please try installing
            the package for yourself using the following command:
            \n
            devtools::install_github(\"lmullen/gender-data-pkg\")")
    })
  } else {
    stop("The genderdata package is necessary for your chosen method.")
  }
}

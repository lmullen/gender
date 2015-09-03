#' Check whether to install data for gender function and install if necessary
#'
#' If the genderdata package is not installed, install it from GitHub using
#' devtools. If it is not up to date, reinstall it.
#' @export
check_genderdata_package <- function() {
  genderdata_version <- "0.5.0"
  if (!requireNamespace("genderdata", quietly = TRUE)) {
    message("The genderdata package needs to be installed.")
    install_genderdata_package()
  } else if (utils::packageVersion("genderdata") < genderdata_version) {
    message("The genderdata package needs to be updated.")
    install_genderdata_package()
  }
}

#' Install the genderdata package after checking with the user
#' @export
install_genderdata_package <- function() {
  instructions <- paste(" Please try installing the package for yourself",
                        "using the following command: \n",
  "    install.packages(\"genderdata\", repos = \"http://packages.ropensci.org\",",
  "type = \"source\")")

  error_func <- function(e) {
    stop(paste("Failed to install the genderdata package.\n", instructions))
  }

  if (interactive()) {
    input <- utils::menu(c("Yes", "No"),
                         title = "Install the genderdata package?")
    if (input == 1) {
      message("Installing the genderdata package.")
      tryCatch(utils::install.packages("genderdata",
                                       repos = "http://packages.ropensci.org",
                                       type = "source"),
               error = error_func, warning = error_func)
    } else {
      stop(paste("The genderdata package is necessary for that method.\n",
                 instructions))
    }
  } else {
    stop(paste("Failed to install the genderdata package.\n", instructions))
  }
}

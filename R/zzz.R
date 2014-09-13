.onLoad <- function(libname = find.package("gender"),
                    pkgname = "gender") {
  invisible(install_genderdata_package())
}

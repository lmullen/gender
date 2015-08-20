#' Use gender prediction with data frames
#'
#' In a common use case for gender prediction, you have a data frame with a
#' column for first names and a column for birth years (or, two columns
#' specifying a minimum and a maximum potential birth year). This function wraps
#' the \code{\link{gender}} function to efficiently apply it to such a data
#' frame. The result is a data frame with one prediction of the gender for each
#' unique combination of first name and birth year. The resulting data frame can
#' then be merged back into your original data frame.
#'
#' @param data A data frame containing first names and birth year or range of
#'   potential birth years.
#' @param name_col A string specifying the name of the column containing the
#'   first names.
#' @param year_col Either a single string specifying the birth year associated
#'   with the first name, or character vector with two elements: the names of
#'   the columns with the minimum and maximum years for the range of potential
#'   birth years.
#' @param method One of the historical methods provided by this package:
#'   \code{"ssa"}, \code{"ipums"}, \code{"napp"}, or \code{"demo"}. See
#'   \code{\link{gender}} for details.
#' @seealso \code{\link{gender}}
#' @export
#' @return A data frame with columns from the output of the \code{gender}
#'   function, and one row for each unique combination of first names and birth
#'   years.
#' @examples
#' library(dplyr)
#' demo_df <- data_frame(names = c("Hillary", "Hillary", "Hillary",
#'                                 "Madison", "Madison"),
#'                       birth_year = c(1930, 2000, 1930, 1930, 2000),
#'                       min_year = birth_year - 1,
#'                       max_year = birth_year + 1,
#'                       stringsAsFactors = FALSE)
#'
#' # Using the birth year for the predictions.
#' # Notice that the duplicate value for Hillary in 1930 is removed
#' gender_df(demo_df, method = "demo",
#'           name_col = "names", year_col = "birth_year")
#'
#' # Using a range of years
#' gender_df(demo_df, method = "demo",
#'           name_col = "names", year_col = c("min_year", "max_year"))
gender_df <- function(data, name_col = "name", year_col = "year",
                      method = c("ssa", "ipums", "napp", "demo")) {

  method <- match.arg(method)
  stopifnot("data.frame" %in% class(data),
            name_col %in% names(data),
            length(year_col) >= 1,
            length(year_col) <= 2,
            year_col %in% names(data))
  if (length(year_col) == 1) year_col <- c(year_col, year_col)

  name_year_grouping <- list(name_col, year_col[1], year_col[2])
  year_grouping <- list(year_col[1], year_col[2])

  data %>%
    distinct_(.dots = name_year_grouping) %>%
    group_by_(.dots = year_grouping) %>%
    do(results = gender(.[[name_col]],
                        years = c(.[[year_col[1]]][1], .[[year_col[2]]][1]),
                        method = method)) %>%
    do(bind_rows(.$results)) %>%
    ungroup()
}

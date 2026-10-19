#' Healthy years lost for every 100 infections
#'
#' Divides healthy years lost (DALYs) by the number of infections. The result
#' shows how harmful one infection is, not how common it is.
#'
#' @param data A data frame with the same columns as `hai_burden`.
#' @return A data frame with one row per survey sample and infection. The
#'   column `dalys_per_100` is the number of healthy years lost for every 100
#'   infections.
#' @examples
#' harm_per_infection(hai_burden)
#' @importFrom dplyr select mutate arrange desc
#' @importFrom tidyr pivot_wider
#' @export
harm_per_infection <- function(data) {
  data |>
    # keep only the columns needed, so each infection becomes one row after pivot_wider
    select(survey, infection, measure, estimate) |>
    pivot_wider(names_from = measure, values_from = estimate) |>
    mutate(dalys_per_100 = round(DALYs / Infections * 100)) |>
    select(survey, infection, Infections, DALYs, dalys_per_100) |>
    arrange(survey, desc(dalys_per_100))
}
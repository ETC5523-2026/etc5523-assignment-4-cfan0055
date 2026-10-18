#' Plot the burden of hospital infections for one measure
#'
#' Draws one bar for each infection and survey sample. The bars are sorted
#' so that the largest burden is at the top.
#'
#' @param data A data frame with the same columns as `hai_burden`.
#' @param burden_measure The measure to plot. One of "Infections", "Deaths"
#'   or "DALYs".
#' @param show_interval If `TRUE`, adds the 95% uncertainty interval to each bar.
#' @return A `ggplot2` plot object.
#' @examples
#' plot_burden(hai_burden, burden_measure = "Infections")
#' # Urinary tract infection has the most cases
#'
#' plot_burden(hai_burden, burden_measure = "DALYs", show_interval = TRUE)
#' # Bloodstream infection moves up when harm is measured
#' @importFrom dplyr filter
#' @importFrom forcats fct_reorder
#' @importFrom ggplot2 ggplot aes geom_col geom_linerange position_dodge labs scale_fill_manual theme_minimal
#' @export
plot_burden <- function(data, burden_measure = "DALYs", show_interval = FALSE) {
  plot_data <- data |>
    filter(measure == burden_measure)

  survey_colours <- c(
    "Germany (national sample)" = "#0B4F6C",
    "Germany (convenience sample)" = "#7FB3C8",
    "EU/EEA average" = "#B8B8B8"
  )

  p <- ggplot(plot_data, aes(x = estimate, y = fct_reorder(infection, estimate), fill = survey)) +
    geom_col(position = position_dodge(width = 0.9)) +
    scale_fill_manual(values = survey_colours) +
    labs(x = paste(burden_measure, "per 100,000 people each year"), y = NULL, fill = "Survey sample") +
    theme_minimal(base_size = 12)

  if (show_interval) {
    p <- p +
      geom_linerange(aes(xmin = lower, xmax = upper), position = position_dodge(width = 0.9))
  }

  p
}
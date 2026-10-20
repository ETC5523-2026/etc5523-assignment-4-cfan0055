#' Launch the hospital infection explorer
#'
#' Opens a Shiny app that lets you compare five hospital infections by number
#' of cases, deaths and healthy years lost.
#'
#' @return Starts the app in your browser. Nothing is returned.
#' @examples
#' if (interactive()) {
#'   run_app()
#' }
#' @importFrom shiny runApp
#' @importFrom bslib bs_theme
#' @export
run_app <- function() {
  app_dir <- system.file("app", package = "haiburden")
  runApp(app_dir, display.mode = "normal")
}
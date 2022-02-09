#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  mod_csvfile_server("csvfile_ui_1")

  session$onSessionEnded(function() {
    stopApp()
  })
}

#' @import shiny

app_server <- function(input, output,session) {
  # To be copied in the server
  mod_csvfile_server("csvfile_ui_1")
  ## # List the first level callModules here
  ## callModule(mod_csvfile_module_server, "csvfile_module_ui_1")

  session$onSessionEnded(function() {
    stopApp()
  })
}

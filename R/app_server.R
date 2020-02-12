#' @import shiny

app_server <- function(input, output,session) {
  # List the first level callModules here
  callModule(mod_csvfile_module_server, "csvfile_module_ui_1")

  observeEvent(input$browser,{
    browser()
  })

session$onSessionEnded(function() {
    stopApp()
})
}

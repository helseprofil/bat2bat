#' @import shiny
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      shinyjs::useShinyjs(),
      h3("Batch mot batch"),
      mod_csvfile_ui("csvfile_ui_1"),
      ## mod_csvfile_module_ui("csvfile_module_ui_1"),
      actionButton("browser", "browser"),
      tags$script("$('#browser').hide();")
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'bat2bat')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}

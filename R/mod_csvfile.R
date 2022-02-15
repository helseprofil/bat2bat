#' Read CSV files
#'
#' @description Read all csv files with data.table
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_csvfile_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      column(4,
             fileInput(ns("csv1"),
                       label = "Valg CSV filer:",
                       multiple = FALSE,
                       width = '100%',
                       buttonLabel = "Søk",
                       placeholder = "Fjorårets fil her"),
             div(style = "margin-top: -21px;"),
             fileInput(ns("csv2"),
                       label = NULL,
                       multiple = FALSE,
                       width = '100%',
                       buttonLabel = "Søk",
                       placeholder = "Årets fil her")
             ),
      column(3,
             textInput(ns("tabs"), "TABS (bruk koma hvis flere)"),
             actionButton(ns("goButton"), "Kjør",
                          icon = icon("play")),
             actionButton(ns("resetButton"), "Reset",
                          icon = icon("rotate-left")),
             ),
      column(3,
             textInput(ns("downName"), "Filnavn: "),
             #Download
             downloadButton(ns("downloadData"), "Laste ned CSV")
             )
    ),

    hr(),
    shiny::dataTableOutput(ns("batch_tbl"))
  )
}

#' csvfile Server Functions
#'
#' @noRd
mod_csvfile_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    raw <- reactiveValues(dt = NULL)

    ## Get data ----------------
    observeEvent(input$csv1, {
      raw$data1 = data.table::fread(input$csv1$datapath[1], fill=TRUE)

      ## Change varname to capital case
      data.table::setnames(raw$data1, names(raw$data1), toupper(names(raw$data1)))
    })

    observeEvent(input$csv2, {
      raw$data2 = data.table::fread(input$csv2$datapath[1], fill=TRUE)

      ## Change varname to capital case
      data.table::setnames(raw$data2, names(raw$data2), toupper(names(raw$data2)))
    })


    ## Tabs input ---------------
    observeEvent(input$tabs, {
      raw$tabs = input$tabs
    })


    ## Reset -----------------
    observeEvent(input$resetButton, {
      raw$data1 = NULL
      raw$data2 = NULL
      raw$tabs = NULL
      shinyjs::reset('csv1')
      shinyjs::reset('csv2')
      shinyjs::reset('tabs')

    })



    ## Give new GEO to old data --------------------
    old_data <- reactive({

      ## Give new GEO to older dataset
      dtb4 = merge(raw$data1, mixFil,
                   by.x = "GEO",
                   by.y = "kodeb4",
                   all.x = TRUE)


      ## Exclude duplicated GEO
      oldMedGeo=dtb4[bort==0,]

      data.table::setnames(oldMedGeo, c("GEO", "kode2020"), c("GEO_b4", "GEO"))

      oldMedGeo

    })


    all_data <- eventReactive(input$goButton, {

      ## Check for key variables in the datasett
      fileKey = names(raw$data2)
      valgKey = intersect(stdkey, fileKey)

      if (length(raw$tabs)){
        innKeys = trimws(unlist(strsplit(raw$tabs, "[,]")))
        allKeys = c(valgKey, innKeys)
      } else {
        allKeys = valgKey
      }

      #Column names that aren't keys
      diffKeys=setdiff(fileKey, allKeys)

      oldDT = setDT(old_data())
      newDT = setDT(raw$data2)
      ## Merge both datasets
      allFil = data.table::merge.data.table(oldDT,newDT, by = allKeys, all.y = TRUE)


      ## legger GEO_b4 first col
      keyCol=c("GEO_b4", allKeys)

      ### Reorder coloumn
      filcolAll=names(allFil)
      filcolValg=setdiff(filcolAll, keyCol)

      sortColValg=sort(filcolValg)
      nyCol=c(keyCol, sortColValg)
      data.table::setcolorder(allFil, nyCol) #reorder col

      for (i in diffKeys){
        indVar=grep(paste0("^",i,""), names(allFil))[2]
        doVar=grep(paste0("^",i,""), names(allFil), value = TRUE)
        var1=doVar[1]
        var2=doVar[2]
        diffCol=paste0(i,"_diff")
        allFil[, (diffCol) := base::get(var1)-base::get(var2)]
        colB4=names(allFil)[1:indVar]
        data.table::setcolorder(allFil, c(colB4, diffCol))
      }


      ## exclude mix fylker
      ## allFil[, !"bort", with=FALSE]
      allFil[bort==0, ][, bort := NULL]

      ## ## Exclude duplicated GEO2020
      ## allFil[, dupp := 0]
      ## allFil[!duplicated(GEO), dupp := 1]
      ## allFil[GEO %in% c(1103, 5001), dupp := 1] #Stavanger and Trondheim
      ## allFil[dupp==1, ][, dupp := NULL]


    })


    ## Get all diff columns
    diff_name <- eventReactive(input$goButton, {
      grep('_diff$', names(all_data()), value = TRUE)
    })



    ## All Data for reset
    observeEvent(input$goButton, {
      raw$allDT=all_data()
    })

    ## Reset all-data  -----------------
    observeEvent(input$resetButton, {
      raw$allDT = NULL
    })


    ## Tabell output
    output$batch_tbl <- shiny::renderDataTable({
      if (is.null(raw$allDT)) return()

      shiny::datatable(raw$allDT, rownames = FALSE,
                       options=list(
                         pageLength=50,
                         searching=FALSE,
                         language = list(
                           paginate = list(previous = 'Tilbake', `next` = 'Neste'),
                           info = 'Viser rad _START_ til _END_ av _TOTAL_'
                         ))) %>%
        formatStyle(diff_name(), backgroundColor="#b1dfff")
    } )

    # Download -----
    output$downloadData <- downloadHandler(

      filename = function() {
        paste(input$downName, ".csv", sep="")
      },
      content = function(file){
        data.table::fwrite(all_data(), file = file, sep=";")
        ## write.csv(all_data(), file, row.names=FALSE)
      }
    )



    output$txt <- renderText({
      diff_name()
    })
  })
}

## To be copied in the UI
# mod_csvfile_ui("csvfile_ui_1")

## To be copied in the server
# mod_csvfile_server("csvfile_ui_1")

library(shiny)

fluidPage(
  titlePanel("BIOSLING - BIOpsy SLice partitionING"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Select a file"),
      
      # you cannot call data() in your ui. 
      # You would have to wrap this in renderUI inside of your server and use
      # uiOutput here in the ui
      sliderInput("groups", "Number of groups:", min = 2, max = 20, value = 4)
    ),
    mainPanel(
      titlePanel("Data input"),
      DT::dataTableOutput("original_table"),
      titlePanel("Partioning table"),
      DT::dataTableOutput("part_table"),
      titlePanel("Weights table"),
      DT::dataTableOutput("weight_table")
    )
  )
)
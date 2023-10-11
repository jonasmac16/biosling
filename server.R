library(shiny)
source("src/binning_functions.R")

function(input, output) {
  
  input_file <- reactive({
    if (is.null(input$file)) {
      return("")
    }
    
    # actually read the file
    read.csv(file = input$file$datapath)
  })
  
  comp <- reactive({
    if (is.null(input$file)) {
      return("")
    }
    
    # actually read the file
    # read.csv(file = input$file$datapath)
    data_input <- read.csv(file = input$file$datapath)
    
    data_comp <- partition_biopsies(data_input, input$groups)
    
    data_comp
  })
  
  
  
  output$part_table <- DT::renderDataTable({
    
    # render only if there is data available
    req(comp())
    
    # reactives are only callable inside an reactive context like render
    
    
    part_data <- comp()
    
    part_data
  })
  
  output$weight_table <- DT::renderDataTable({
    
    # render only if there is data available
    req(comp())
    
    # reactives are only callable inside an reactive context like render
    weight_data <- comp() %>% group_by(group) %>% summarise (weight = sum(weights))
    
    weight_data
  })
  
  output$original_table <- DT::renderDataTable({
    
    # render only if there is data available
    req(input_file())
    
    # reactives are only callable inside an reactive context like render
    data <- input_file()
    
    data
  })
  
  
}
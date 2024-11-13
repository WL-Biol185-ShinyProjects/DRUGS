library(shiny)
library(dplyr)
library(leaflet)
source("home.R")
source("medicalUses.R")
source("tab3.R")
source("tab4.R")
source("tab5.R")
source("tab6.R")
source("tab7.R")


symptom_list <- readRDS("DrugSubandSide.RDS")

function(input, output, session) {
  illnessNameSubset <- unique(symptom_list[1:100, 50:54])
  
  observe({
    updateSelectizeInput(session,
                         "drugIllness",
                         choices = illnessNameSubset,
    )
  })
  
  observe ({
    filterName <- filter(DrugSubandSide, 
                         use0 == input$drugIllness | 
                           use1 == input$drugIllness |
                           use2 == input$drugIllness |
                           use3 == input$drugIllness |
                           use4 == input$drugIllness
    )
    drugNameFiltered <- filterName[1:100, 2]
    updateSelectizeInput(session, 
                         "drugName", 
                         choices = unique(drugNameFiltered)
    )
    

  })
  
}
  
  
 
function(input, output, session) {
  
  # Sample data to use for the map layers (e.g., different data points for drug usage)
  sample_data <- data.frame(
    lat = c(37.773, 37.783, 37.793),
    lng = c(-79.441, -79.442, -79.443),
    usage = c(20, 40, 60),
    year = c(2010, 2015, 2020)
  )
  
  # Render the leaflet map based on selected layer and usage range
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = -79.442778, lat = 37.783889, zoom = 8) %>%
      
      # Add dynamic map layer based on selected input
      addCircleMarkers(data = sample_data,
                       lat = ~lat, lng = ~lng,
                       color = ~ifelse(usage >= input$usageRange[1] & usage <= input$usageRange[2], "blue", "red"),
                       radius = 8, popup = ~paste("Year:", year, "<br>Usage:", usage))
  })
  
  # Render the Plotly graph showing drug usage trends
  output$drugTrendPlot <- renderPlotly({
    # Filter data based on usage range selected by the user
    filtered_data <- sample_data[sample_data$usage >= input$usageRange[1] & sample_data$usage <= input$usageRange[2], ]
    
    # Create a plot showing drug usage over time
    plot_ly(data = filtered_data, x = ~year, y = ~usage, type = 'scatter', mode = 'lines+markers') %>%
      layout(title = "Drug Usage Trend",
             xaxis = list(title = "Year"),
             yaxis = list(title = "Drug Usage"))
  })
}
function(input, output, session) {
  
  # Reactive data for filtering based on input
  filteredData <- reactive({
    drug_data %>%
      filter(drug_name == input$mapLayer,
             usage >= input$usageRange[1],
             usage <= input$usageRange[2])
  })
  
  # Render Leaflet map
  output$drugMap <- renderLeaflet({
    leaflet(data = filteredData()) %>%
      addTiles() %>%
      addCircleMarkers(~longitude, ~latitude,
                       color = "blue", fillOpacity = 0.7,
                       popup = ~paste("Usage:", usage))
    
  })
  
  



  


  
  
  
  observe ({
    nameFilteredForEffect <- filter(DrugSubandSide, name == input$drugName)
    sideEffectForDrugs <- nameFilteredForEffect[1, 8:49]
    output$sideEffectsTable <- renderTable({sideEffectForDrugs})
    
  })

  observeEvent(input$learnMore, {
    showModal(modalDialog(
      title = "Symptoms",
      "Here you'll find detailed information on various types of drugs."
    ))
  })
  
  observeEvent(input$research, {
    showModal(modalDialog(
      title = "Alternates",
      "This section is dedicated to cutting-edge research on drug safety and efficacy."
    ))
  })
  
  observeEvent(input$contact, {
    showModal(modalDialog(
      title = "Contact Us",
      "Feel free to contact us at info@druginfohub.com."
    ))
  })
}


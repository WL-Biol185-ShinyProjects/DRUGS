library(shiny)
library(dplyr)

source("home.R")
source("medicalUses.R")
source("tab3.R")
source("tab4.R")
source("tab5.R")
source("tab6.R")
source("tab7.R")

#Loading in info from DrugSubandSide.RDS for medicalUses.R
symptom_list <- readRDS("DrugSubandSide.RDS")

function(input, output, session) {
  
  #Filtering for only illness names 
  illnessNameSubset <- unique(symptom_list[1:248000, 50])
  
  #Server side Selectization for drug illness for medicalUses.R    
  updateSelectizeInput(session,
                       "drugIllness",
                       choices = illnessNameSubset,
                       server = TRUE
  )
  
  #Creating filter to only select based on drug illness input for medicalUses.R 
  observe ({
    filterName <- filter(symptom_list, 
                         use0 == input$drugIllness | 
                           use1 == input$drugIllness |
                           use2 == input$drugIllness |
                           use3 == input$drugIllness |
                           use4 == input$drugIllness
    )
    #Creating filter for drug name for medicalUses.R
    drugNameFiltered <- filterName[1:248000, 2]
    updateSelectizeInput(session, 
                         "drugName", 
                         choices = unique(drugNameFiltered),
                         server = TRUE
    )
  })
  observe ({
    #Creating filter for drug selected in drugName search bar for medicalUses.R
    nameFilteredForEffect <- filter(symptom_list, name == input$drugName)
    
    #Creating tables to select for info needed for medicalUses.R
    sideEffectForDrugs <- nameFilteredForEffect[1, 8:12]
    sideEffectForDrugs1 <- nameFilteredForEffect[1, 13:17]
    checkSideEffect1 <- nameFilteredForEffect[1, 13]
    #sideEffectForDrugs2 <- nameFilteredForEffect[1, 18:22]
    #sideEffectForDrugs3 <- nameFilteredForEffect[1, 23:27]
    #sideEffectForDrugs4 <- nameFilteredForEffect[1, 28:32]
    #sideEffectForDrugs5 <- nameFilteredForEffect[1, 33:37]
    #sideEffectForDrugs6 <- nameFilteredForEffect[1, 38:42]
    #sideEffectForDrugs7 <- nameFilteredForEffect[1, 43:47]
    #sideEffectForDrugs8 <- nameFilteredForEffect[1, 48:49]
    alternativeDrugs <- nameFilteredForEffect[1, 3:7]
    therapeuticClass <- nameFilteredForEffect[1, 57]
    habitForming <- nameFilteredForEffect[1, 56]
    actionClass <- nameFilteredForEffect[1, 58]
    chemicalClass <- nameFilteredForEffect[1, 55]
    
    #Creating output for info tables for medicalUses.R
    output$sideEffectsTable <- renderDataTable({sideEffectForDrugs})
    output$sideEffectsTable1 <- renderUI({ if( checkSideEffect1 != " ") {
      renderTable(sideEffectForDrugs1)
    }
    })
    #output$sideEffectsTable2 <- renderTable({sideEffectForDrugs2})
    #output$sideEffectsTable3 <- renderTable({sideEffectForDrugs3})
    #output$sideEffectsTable4 <- renderTable({sideEffectForDrugs4})
    #output$sideEffectsTable5 <- renderTable({sideEffectForDrugs5})
    #output$sideEffectsTable6 <- renderTable({sideEffectForDrugs6})
    #output$sideEffectsTable7 <- renderTable({sideEffectForDrugs7})
    #output$sideEffectsTable8 <- renderTable({sideEffectForDrugs8})
    output$alternativeDrugsTable <- renderTable({alternativeDrugs})
    output$chemicalClassTable <- renderTable({chemicalClass})
    output$actionClassTable <- renderTable({actionClass})
    output$therapeuticClassTable <- renderTable({therapeuticClass})
    output$habitFormingTable <- renderTable({habitForming})
  })
  
  #Creating home page button responses for home.R
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




# Run the Shiny app
shinyApp(ui = ui, server = server)


#Sever Code to prdduce a heatmap 
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
  
  
  
  
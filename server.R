library(tidyverse)
library(shiny)
library(dplyr)
library(leaflet)

source("home.R")
source("medicalUses.R")
source("Cost_tab.R")
source("interaction_tab.R")
source("Clinical_Trails.R")
source("Maps.R")
source("Reviews.R")
source("Pharmacokinetics_Simulation1.R")

#Loading in info from DrugSubandSide.RDS for medicalUses.R
symptom_list <- readRDS("DrugSubandSide.RDS")

function(input, output, session) {
  #Ryan
  output$graph1 <- graph1(input)
  output$graph2 <- graph2(input)
  output$graph3 <- graph3(input)
  #Daniel
  output$Avg_Spend_Plot <- Avg_Spend_Plot(input)
  output$Tot_DrugSpend_Plot <- Tot_DrugSpend_Plot(input)
  output$Tot_Spend_Plot <- Tot_Spend_Plot(input)
  output$Tot_DrugClaims_Plot <- Tot_DrugClaims_Plot(input)
  
  output$Int_Plot <- Int_Plot(input)
  output$Int_Rev_Plot <- Int_Rev_Plot(input)
  
  #Filtering for only illness names 
  illnessNameSubset <- unique(symptom_list[1:248000, 50])
  
  # Cost Tab
  updateSelectizeInput(session,
                       "Brand_Name",
                       choices = Spread_Prices$Brnd_Name,
                       server = TRUE
  )
  
  #Interaction Tab
  updateSelectizeInput(session,
                       "Drug_Name",
                       choices = DDI_data$drug1_name,
                       server = TRUE
  )
  updateSelectizeInput(session,
                       "Drug_Name",
                       choices = reviews_clean$drug,
                       server = TRUE
  )
  

  
  
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
    #Creating filter for drug name for medicalUses.Rn
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
    
    nameFilteredForEffect[1, 8:49] <- trimws(nameFilteredForEffect[1, 8:49])
    
    #Creating tables to select for info needed for medicalUses.R
    sideEffectForDrugs <- nameFilteredForEffect[1, 8:12]
    sideEffectForDrugs1 <- nameFilteredForEffect[1, 13:17]
    checkSideEffect1 <- nameFilteredForEffect[1, 13]
    sideEffectForDrugs2 <- nameFilteredForEffect[1, 18:22]
    checkSideEffect2 <- nameFilteredForEffect[1, 18]
    sideEffectForDrugs3 <- nameFilteredForEffect[1, 23:27]
    checkSideEffect3 <- nameFilteredForEffect[1, 23]
    sideEffectForDrugs4 <- nameFilteredForEffect[1, 28:32]
    checkSideEffect4 <- nameFilteredForEffect[1, 28]
    sideEffectForDrugs5 <- nameFilteredForEffect[1, 33:37]
    checkSideEffect5 <- nameFilteredForEffect[1, 33]
    sideEffectForDrugs6 <- nameFilteredForEffect[1, 38:42]
    checkSideEffect6 <- nameFilteredForEffect[1, 38]
    sideEffectForDrugs7 <- nameFilteredForEffect[1, 43:47]
    checkSideEffect7 <- nameFilteredForEffect[1, 43]
    sideEffectForDrugs8 <- nameFilteredForEffect[1, 48:49]
    checkSideEffect8 <- nameFilteredForEffect[1, 48]
    alternativeDrugs <- nameFilteredForEffect[1, 3:7]
    therapeuticClass <- nameFilteredForEffect[1, 57]
    habitForming <- nameFilteredForEffect[1, 56]
    actionClass <- nameFilteredForEffect[1, 58]
    chemicalClass <- nameFilteredForEffect[1, 55]
    
    #Creating output for info tables for medicalUses.R
    output$sideEffectsTable <- renderTable({sideEffectForDrugs})
    #Creating conditional outputs for info tables for medicalUses.R
    output$sideEffectsTable1 <- renderUI({ if(checkSideEffect1 != "") {
      renderTable(sideEffectForDrugs1)
    }
    })
    output$sideEffectsTable2 <- renderUI({ if(checkSideEffect2 != "") {
      renderTable(sideEffectForDrugs2)
    }
    })
    output$sideEffectsTable3 <- renderUI({ if(checkSideEffect3 != "") {
      renderTable(sideEffectForDrugs3)
    }
    })
    output$sideEffectsTable4 <- renderUI({ if(checkSideEffect4 != "") {
      renderTable(sideEffectForDrugs4)
    }
    })
    output$sideEffectsTable5 <- renderUI({ if(checkSideEffect5 != "") {
      renderTable(sideEffectForDrugs5)
    }
    })
    output$sideEffectsTable6 <- renderUI({ if(checkSideEffect6 != "") {
      renderTable(sideEffectForDrugs6)
    }
    })
    output$sideEffectsTable7 <- renderUI({ if(checkSideEffect7 != "") {
      renderTable(sideEffectForDrugs7)
    }
    })
    output$sideEffectsTable8 <- renderUI({ if(checkSideEffect8 != "") {
      renderTable(sideEffectForDrugs8)
    }
    })
    #Creating table output for medicalUses.R
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










  























#HEATMAP

# Sample data (replace this with your actual data)
# drug_usage_data should include columns: state, usage_rate, longitude, latitude
drug_usage_data <- data.frame(
  state = state.name,
  usage_rate = runif(50, 0, 1),  # Random usage rate between 0 and 1
  longitude = state.center$x,
  latitude = state.center$y
)

library(ggplot2)
library(maps)
library(dplyr)

 
  
  output$heatmap <- renderPlot({
    # Filter data based on the selected state
    selected_data <- drug_usage_data %>%
      filter(state == input$state_select)
    
    # Load state map data
    state_map <- map_data("state")
    
    # Create heatmap using ggplot2
    ggplot() +
      geom_polygon(
        data = state_map %>% filter(region == tolower(input$state_select)),
        aes(x = long, y = lat, group = group),
        fill = "lightgray", color = "black"
      ) +
      geom_point(
        data = selected_data,
        aes(x = longitude, y = latitude, color = usage_rate),
        size = 5, alpha = 0.7
      ) +
      scale_color_gradient(low = "yellow", high = "red") +
      theme_minimal() +
      labs(
        title = paste("Drug Usage in", input$state_select),
        x = "Longitude",
        y = "Latitude",
        color = "Usage Rate"
      )
  })







#CLINICAL TRAILS
function(input, output, session) {
  # Populate the "Location" dropdown 
  observe({
    updateSelectInput(session, "Locations", 
                      choices = sort(unique(clinical_data$Locations)),
    server = TRUE)
  })
  
  # Populate the "Condition" dropdown 
  observe({
    updateSelectInput(session, "Conditions", 
                      choices = sort(unique(clinical_data$Conditions)),
    server = TRUE)
                      
  })
  
  # Populate the "Study Status" dropdown 
  observe({
    updateSelectInput(session, "Phases", 
                      choices = sort(unique(clinical_data$Phase)),
    server = TRUE)
  })
  
  #Creating filter for drug name for medicalUses.Rn
  ClinicalNameFiltered <- filterName[1:23409, 2]
  updateSelectizeInput(session, 
                       "drugName", 
                       choices = unique(drugNameFiltered),
                       server = TRUE
  )


  
    # Reactive filtering of the data
    filtered_data <- reactive({
      req(input$search) # Ensure the search button is clicked
      
      clinical_data[
        grepl(input$location, clinical_data$Location, ignore.case = TRUE) &
          grepl(input$condition, clinical_data$Condition, ignore.case = TRUE) &
          clinical_data$Phases == input$status, 
      ]
    })
    
    # Output filtered results as a table
    output$results <- renderTable({
      filtered_data()
    })
}
}


#Pharmacokinetics_Simulation
function(input, output) {
  
  # Function to simulate ADME (Absorption, Distribution, Metabolism, Elimination)
  simulate_adme <- function(age, weight, gender, health_condition, dose, half_life) {
    k_a <- 0.2  # Absorption rate constant (per hour)
    
    # Adjust the volume of distribution (Vd) based on weight
    Vd <- 0.7 * weight
    
    # Adjust clearance (Cl) based on age and weight
    Cl <- 0.05 * weight + 0.1 * age
    
    # Calculate the elimination rate constant (k_el) based on half-life
    k_el <- log(2) / half_life
    
    # Adjust elimination rate based on health condition
    if (health_condition == "Impaired Liver") {
      k_el <- k_el * 0.5  # Reduce elimination for liver impairment
    } else if (health_condition == "Impaired Kidney") {
      k_el <- k_el * 0.7  # Reduce elimination for kidney impairment
    }
    
    # Ensure that k_a and k_el are not equal to avoid division by zero
    if (abs(k_a - k_el) < 1e-6) {
      k_a <- k_el + 0.01  # Adjust k_a slightly to prevent division by zero
    }
    
    # Simulate concentration over time
    time <- seq(0, 48, by = 0.1)  # Time vector from 0 to 48 hours
    C_t <- (dose * k_a) / (Vd * (k_a - k_el)) * (exp(-k_el * time) - exp(-k_a * time))  # Concentration over time
    
    data.frame(time = time, concentration = C_t)
  }
  
  # Reactive expression to run the simulation
  drug_data <- eventReactive(input$simulate, {
    simulate_adme(input$age, input$weight, input$gender, input$health_condition, input$dose, input$half_life)
  })
  
  output$drug_concentration_plot <- renderPlot({
    data <- drug_data()
    
    ggplot(data, aes(x = time, y = concentration)) +
      geom_line(color = "blue", size = 1.2) +
      labs(title = "Drug Concentration Over Time",
           x = "Time (hours)", y = "Concentration (mg/L)") +
      theme_minimal()
  })
  
  output$summary_text <- renderText({
    data <- drug_data()
    peak_conc <- max(data$concentration)
    peak_time <- data$time[which.max(data$concentration)]
    paste("Peak concentration: ", round(peak_conc, 2), "mg/L at ", round(peak_time, 2), "hours after administration.")
  })
  
  output$half_life_text <- renderText({
    paste("Calculated elimination rate constant based on half-life: ", round(log(2) / input$half_life, 4))
  })
}



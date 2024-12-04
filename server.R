library(tidyverse)
library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(maps)
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
                       "Drug_Names",
                       choices = DDI_data$drug1_name,
                       server = TRUE
  )
  updateSelectizeInput(session,
                       "Drug_Namess",
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
  
    
    # Filtered data based on user input
    filtered_data <- reactive({
      drugs_data %>%
        filter(Year == input$year) %>%
        mutate(region = tolower(State))
    })
    
    # Render the static map
    output$mapPlot <- renderPlot({
      # Merge state map data with filtered dataset
      map_data <- states_map %>%
        left_join(filtered_data(), by = "region")
      
      # Plot the map using ggplot2
      ggplot(data = map_data, aes(x = long, y = lat, group = group, fill = !!sym(input$metric))) +
        geom_polygon(color = "white") +
        scale_fill_viridis_c(option = "D") +
        labs(
          title = paste("Drug Use Metric:", input$metric, "| Year:", input$year),
          fill = input$metric
        ) +
        theme_void() +
        theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5))
    })
    
    # Render the summary table
    output$summaryTable <- renderTable({
      filtered_data() %>%
        summarise(
          Metric = input$metric,
          Total = sum(.data[[input$metric]], na.rm = TRUE),
          Mean = mean(.data[[input$metric]], na.rm = TRUE),
          Median = median(.data[[input$metric]], na.rm = TRUE)
        )
    })
  
  
 



#CLINICAL TRAILS
  
clinical_trials <- read.csv("ClinicalST.csv")
  
    # Reactive dataset filtering
    filtered_data <- reactive({
      clinical_trials %>%
        filter(
          if (!is.null(input$Conditions) && length(input$Conditions) > 0) 
            Conditions %in% input$Conditions else TRUE,
          if (!is.null(input$Sex) && length(input$Sex) > 0) 
            Sex %in% input$Sex else TRUE,
          if (!is.null(input$Phases) && length(input$Phases) > 0) 
            grepl(paste(input$Phases, collapse = "|"), Phases, ignore.case = TRUE) else TRUE
        )
    })
    
    # Summary text
    output$summary <- renderText({
      data <- filtered_data()
      if (nrow(data) == 0) {
        return("No matching trials found.")
      }
      paste("Found", nrow(data), "matching trials based on your filters.")
    })
    
    # Render results table
    output$results <- DT::renderDataTable({
      data <- filtered_data()
      if (nrow(data) == 0) {
        return(data.frame(Message = "No matching trials found."))
      }
      data %>%
        select(Locations, Brief.Summary) %>%
        rename(
          Location = Locations,
          "Brief Summary" = Brief.Summary
        )
    }, options = list(pageLength = 5, autoWidth = TRUE))
    
    # Reset filters
    observeEvent(input$reset, {
<<<<<<< HEAD
      updateSelectizeInput(session, "condition", selected = clinical_trials$Conditions, server = TRUE)
      # updateSelectizeInput(session, "gender", selected = NULL, server = TRUE)
      # updateSelectizeInput(session, "phase", selected = NULL, server = TRUE)
=======
      updateSelectizeInput(session, "Conditions", selected = NULL)
      updateSelectizeInput(session, "Sex", selected = NULL)
      updateSelectizeInput(session, "Phases", selected = NULL)
>>>>>>> 9ccaea29ba05481bddd090d96e3a589697cfdc00
    })

  
#Pharmacokinetics_Simulation

    
    # Event Reactive to run the simulation when "simulate" button is clicked
    drug_data <- eventReactive(input$simulate, {
      req(input$age, input$weight, input$dose, input$half_life)  # Ensure inputs are provided
      
      # Simulate pharmacokinetics
      simulate_adme <- function(age, weight, gender, health_condition, dose, half_life) {
        # Example logic for ADME simulation
        time <- seq(0, 24, by = 0.5)  # Time in hours
        
        # Adjust elimination rate based on age
        # Younger (under 18) and older (over 65) individuals have slower clearance
        age_factor <- ifelse(age < 18, 0.8, ifelse(age > 65, 0.7, 1)) 
        
        elimination_rate <- (log(2) / half_life) * age_factor
        
        # Adjust dose based on weight and health condition
        adjusted_dose <- dose * (weight / 70) * ifelse(health_condition == "Healthy", 1, 0.8)
        
        # Simulate drug concentration
        concentration <- adjusted_dose * exp(-elimination_rate * time)  # Exponential decay formula
        
        data.frame(Time = time, Concentration = concentration)
      }
      
      # Call the function to simulate ADME
      simulate_adme(input$age, input$weight, input$gender, input$health_condition, input$dose, input$half_life)
    })
    
    # Plot the drug concentration over time
    output$drug_concentration_plot <- renderPlot({
      req(drug_data())  # Ensure data is available
      data <- drug_data()
      ggplot(data, aes(x = Time, y = Concentration)) +
        geom_line(color = "blue") +
        theme_minimal() +
        labs(title = "Drug Concentration vs Time", x = "Time (hours)", y = "Concentration (mg/L)")
    })
    
    # Display summary of the simulation
    output$drug_summary <- renderPrint({
      req(drug_data())  # Ensure data is available
      data <- drug_data()
      peak_concentration <- max(data$Concentration)
      peak_time <- data$Time[which.max(data$Concentration)]
      half_life_calculated <- input$half_life  # Display user-provided half-life
      
      cat("Peak Concentration:", round(peak_concentration, 2), "mg/L\n")
      cat("Peak Time:", round(peak_time, 2), "hours\n")
      cat("Input Half-Life:", round(half_life_calculated, 2), "hours\n")
      cat("Note: Elimination rate was adjusted based on age (Age Factor:", 
          ifelse(input$age < 18, 0.8, ifelse(input$age > 65, 0.7, 1)), ").\n")
    })
    
}
  
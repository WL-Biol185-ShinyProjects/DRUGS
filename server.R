library(tidyverse)
library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(jsonlite)
library(maps)
source("home.R")
source("medicalUses.R")
source("cost_tab.R")
source("interaction_tab.R")
source("clinical_Trials.R")
source("maps.R")
source("reviews.R")
source("pharmacokinetics_Simulation1.R")

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
  
  #Output costs tab graphs
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
  
  #Creating filter for drug selected in drugName search bar for medicalUses.R
  nameFilteredForEffect <- reactive ({ filter(
                                       symptom_list, 
                                       name == input$drugName
                                       )
  })
  nameFilteredForEffectAndSideEffect <- reactive ({ 
                                        nameFilteredForEffect() %>%
                                        select(sideEffect0 : sideEffect41) 
    })
  nameFilteredForEffectTrimmed <- reactive ({ trimws(nameFilteredForEffectAndSideEffect())})
  nameFilteredForEffectCheck1 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect5) 
                                          })
  nameFilteredForEffectTrimmedCheck1 <- reactive ({ trimws(nameFilteredForEffectCheck1())})
  nameFilteredForEffectCheck2 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect10) 
                                          })
  nameFilteredForEffectTrimmedCheck2 <- reactive ({ trimws(nameFilteredForEffectCheck2())})
  nameFilteredForEffectCheck3 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect15) 
                                          })
  nameFilteredForEffectTrimmedCheck3 <- reactive ({ trimws(nameFilteredForEffectCheck3())})
  nameFilteredForEffectCheck4 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect20) 
                                          })
  nameFilteredForEffectTrimmedCheck4 <- reactive ({ trimws(nameFilteredForEffectCheck4())})
  nameFilteredForEffectCheck5 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect25) 
                                          })
  nameFilteredForEffectTrimmedCheck5 <- reactive ({ trimws(nameFilteredForEffectCheck5())})
  nameFilteredForEffectCheck6 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect30) 
                                          })
  nameFilteredForEffectTrimmedCheck6 <- reactive ({ trimws(nameFilteredForEffectCheck6())})
  nameFilteredForEffectCheck7 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect35) 
                                          })
  nameFilteredForEffectTrimmedCheck7 <- reactive ({ trimws(nameFilteredForEffectCheck7())})
  nameFilteredForEffectCheck8 <- reactive ({ nameFilteredForEffect() %>%
                                             select(sideEffect40) 
                                          })
  nameFilteredForEffectTrimmedCheck8 <- reactive ({ trimws(nameFilteredForEffectCheck8())})
  
  #Creating outputs for drug classes
  alternativeDrugs <- reactive ({ nameFilteredForEffect() %>%
                                  select(substitute0:substitute4)
                               })
  actionClass <- reactive ({ nameFilteredForEffect() %>%
                             select(Action.Class)
                          }) 
  chemicalClass <- reactive ({ nameFilteredForEffect() %>%
                               select(Chemical.Class)
                            })
  therapeuticClass <- reactive ({ nameFilteredForEffect() %>%
                                  select(Therapeutic.Class)
                               })
  habitForming <- reactive ({ nameFilteredForEffect() %>%
                              select(Habit.Forming)
                           })
  
  #Creating output for info tables for medicalUses.R
  output$sideEffectsTable <- renderTable({nameFilteredForEffect() %>% 
                                          select(sideEffect0:sideEffect4)
                                        })
  #Creating conditional outputs for info tables for medicalUses.R
  output$sideEffectsTable1 <- renderUI({if(
    nameFilteredForEffectTrimmedCheck1() != ""
  ) 
    {
    renderTable(nameFilteredForEffect() %>% 
      select(sideEffect5:sideEffect9))
  }
  })
  output$sideEffectsTable2 <- renderUI({ if(
    nameFilteredForEffectTrimmedCheck2() != ""
  ) 
    {
    renderTable(nameFilteredForEffect() %>% 
      select(sideEffect10:sideEffect14))
  }
  })
  output$sideEffectsTable3 <- renderUI({ if(
    nameFilteredForEffectTrimmedCheck3() != ""
  ) 
    {
    renderTable(nameFilteredForEffect() %>% 
      select(sideEffect15:sideEffect19))
  }
  })
  output$sideEffectsTable4 <- renderUI({ if(
    nameFilteredForEffectTrimmedCheck4() != ""
  )
    {
    renderTable(nameFilteredForEffect() %>% 
      select(sideEffect20:sideEffect24))
  }
  })
  output$sideEffectsTable5 <- renderUI({ if(
    nameFilteredForEffectTrimmedCheck5() != ""
  ) 
    {
    renderTable(nameFilteredForEffect() %>% 
      select(sideEffect25:sideEffect29))
  }
  })
  output$sideEffectsTable6 <- renderUI({ if(
    nameFilteredForEffectTrimmedCheck6() != ""
  ) 
    {
    renderTable(nameFilteredForEffect() %>% 
      select(sideEffect30:sideEffect34))
  }
  })
  output$sideEffectsTable7 <- renderUI({ if(
    nameFilteredForEffectTrimmedCheck7() != ""
  )
    {
    renderTable(nameFilteredForEffect() %>% 
     select(sideEffect35:sideEffect39))
  }
  })
  output$sideEffectsTable8 <- renderUI({ if(
    nameFilteredForEffectTrimmedCheck8() != ""
  ) 
    {
    renderTable(nameFilteredForEffect() %>% 
     select(sideEffect40:sideEffect41))
  }
  })
  #Creating table output for medicalUses.R
  output$alternativeDrugsTable <- renderTable({alternativeDrugs()})
  output$chemicalClassTable <- renderTable({chemicalClass()})
  output$actionClassTable <- renderTable({actionClass()})
  output$therapeuticClassTable <- renderTable({therapeuticClass()})
  output$habitFormingTable <- renderTable({habitForming()})
  
  #Creating home page button responses for home.R
  observeEvent(input$drugInfoButton, {
    showModal(modalDialog(
      title = "Drug Information",
      "The drug information tab includes information about the side effects, alternatives, chemical class, action class, therapeutic class and potential for habit forming."
    ))
  })
  
  observeEvent(input$cost, {
    showModal(modalDialog(
      title = "Costs",
      "The costs tab includes information of a drug's average spending per drug claim, total spending per selected drug, total spending on all drugs, and total claims of your selected drug from 2018-2022"
    ))
  })
  
  observeEvent(input$interactions, {
    showModal(modalDialog(
      title = "Interactions",
      "The interaction tab allows you to select two drugs and see if there are any interactions between them and see how well reviewed a drug is"
    ))
  })
  observeEvent(input$clinicalTrial, {
    showModal(modalDialog(
      title = "Clinical Trial",
      "The clinical trial tab allows you to select a condition, clinical trial phase, targeted sex and see what clinical trials are currently being performed based on your criteria"
    ))
  })
  observeEvent(input$substanceUse, {
    showModal(modalDialog(
      title = "Substance Use in the USA",
      "The substance use in the USA tab allows you to select a substance and year to generate a heat map of the USA showing how much of the substance was used in each state and a summary table with total, mean and median use of the substance"
    ))
  })
  observeEvent(input$review, {
    showModal(modalDialog(
      title = "Reviews",
      "The reviews tab allows you to select a drug and see reviews on effectiveness, ease of use, and satisfaction ratings"
    ))
  })
  observeEvent(input$pharmacoKinetics, {
    showModal(modalDialog(
      title = "Pharmacokinetics Simulation (ADME)",
      "The pharmacokinetics simulation tab allows you to enter your information and a simulation will stimulate how long the drug will stay in your body at what concentration, gaining insight into what concentration of a drug you should take"
    ))
  })
  
  #HEATMAP
  drugs_data <- read.csv("drugs.csv")
  states_map <- map_data("state")

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
  
  #Server side selectize input
  updateSelectizeInput(session, 
                       "condition", 
                       choices = clinical_trials$Conditions, 
                       server = TRUE
                       )
  updateSelectizeInput(session, "gender", 
                       choices = clinical_trials$Sex, 
                       server = TRUE
                       )
  updateSelectizeInput(session, 
                       "phase", 
                       choices = clinical_trials$Phases, 
                       server = TRUE
                       )
  
  # Reactive dataset filtering
  filtered_data1 <- reactive({
    clinical_trials %>%
      filter(
        if (!is.null(input$condition) && length(input$condition) > 0) 
          Conditions %in% input$condition else TRUE,
        if (!is.null(input$gender) && length(input$gender) > 0) 
          Sex %in% input$gender else TRUE,
        if (!is.null(input$phase) && length(input$phase) > 0) 
          grepl(paste(input$phase, collapse = "|"), Phases, ignore.case = TRUE) else TRUE
      )
  })
  
  # Summary text
  output$summary <- renderText({
    data <- filtered_data1()
    if (nrow(data) == 0) {
      return("No matching trials found.")
    }
    paste("Found", nrow(data), "matching trials based on your filters.")
  })
  
  # Render results table
  output$results <- DT::renderDataTable({
    data <- filtered_data1()
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
    updateSelectizeInput(session, 
                         "condition", 
                         choices = NULL, 
                         server = TRUE)
    updateSelectizeInput(session, 
                         "condition", 
                         choices = clinical_trials$Conditions, 
                         server = TRUE
                         )
    updateSelectizeInput(session, 
                         "gender", 
                         choices = NULL, 
                         server = TRUE
                         )
    updateSelectizeInput(session, 
                         "gender",
                         choices = clinical_trials$Sex,
                         server = TRUE
                         )
    updateSelectizeInput(session, 
                         "phase", 
                         choices = NULL, 
                         server = TRUE
                         )
    updateSelectizeInput(session, 
                         "phase", 
                         choices = clinical_trials$Phases, 
                         server = TRUE
                         )
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
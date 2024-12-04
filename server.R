library(shiny)
library(dplyr)
library(leaflet)
library(ggplot2)
library(maps)
library(tidyverse)

source("home.R")
source("medicalUses.R")
source("tab3.R")
source("tab4.R")
source("Clinical_Trails.R")
source("Maps.R")
source("Reviews.R")

#Loading in info from DrugSubandSide.RDS for medicalUses.R
symptom_list <- readRDS("DrugSubandSide.RDS")
function(input, output, session) {
  
  output$graph1 <- graph1(input)
  output$graph2 <- graph2(input)
  output$graph3 <- graph3(input)
  
  #Filtering for only illness names 
  illnessNameSubset <- unique(symptom_list$use0)
  
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
    drugNameFiltered <- filterName$name
    updateSelectizeInput(session, 
                         "drugName", 
                         choices = unique(drugNameFiltered),
                         server = TRUE
    )
  })

    #Creating filter for drug selected in drugName search bar for medicalUses.R
  
   nameFilteredForEffect <- reactive ({ filter(symptom_list, name == input$drugName)
   })
   nameFilteredForEffectAndSideEffect <- reactive ({ nameFilteredForEffect() %>%
     select(sideEffect0 : sideEffect41) })
   nameFilteredForEffectTrimmed <- reactive ({ trimws(nameFilteredForEffectAndSideEffect())})
   nameFilteredForEffectCheck1 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect5) })
   nameFilteredForEffectTrimmedCheck1 <- reactive ({ trimws(nameFilteredForEffectCheck1())})
   nameFilteredForEffectCheck2 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect10) })
   nameFilteredForEffectTrimmedCheck2 <- reactive ({ trimws(nameFilteredForEffectCheck2())})
   nameFilteredForEffectCheck3 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect15) })
   nameFilteredForEffectTrimmedCheck3 <- reactive ({ trimws(nameFilteredForEffectCheck3())})
   nameFilteredForEffectCheck4 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect20) })
   nameFilteredForEffectTrimmedCheck4 <- reactive ({ trimws(nameFilteredForEffectCheck4())})
   nameFilteredForEffectCheck5 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect25) })
   nameFilteredForEffectTrimmedCheck5 <- reactive ({ trimws(nameFilteredForEffectCheck5())})
   nameFilteredForEffectCheck6 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect30) })
   nameFilteredForEffectTrimmedCheck6 <- reactive ({ trimws(nameFilteredForEffectCheck6())})
   nameFilteredForEffectCheck7 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect35) })
   nameFilteredForEffectTrimmedCheck7 <- reactive ({ trimws(nameFilteredForEffectCheck7())})
   nameFilteredForEffectCheck8 <- reactive ({ nameFilteredForEffect() %>%
       select(sideEffect40) })
   nameFilteredForEffectTrimmedCheck8 <- reactive ({ trimws(nameFilteredForEffectCheck8())})
  
    #Check Side Effect
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
        select(sideEffect0:sideEffect4)})
    #Creating conditional outputs for info tables for medicalUses.R
    output$sideEffectsTable1 <- renderUI({if(nameFilteredForEffectTrimmedCheck1() != ""
      ) {
      renderTable(nameFilteredForEffect() %>% 
                    select(sideEffect5:sideEffect9))
    }
    })
    output$sideEffectsTable2 <- renderUI({ if(nameFilteredForEffectTrimmedCheck2() != ""
    ) {
      renderTable(nameFilteredForEffect() %>% 
                    select(sideEffect10:sideEffect14))
    }
    })
    output$sideEffectsTable3 <- renderUI({ if(nameFilteredForEffectTrimmedCheck3() != ""
    ) {
      renderTable(nameFilteredForEffect() %>% 
                    select(sideEffect15:sideEffect19))
    }
    })
    output$sideEffectsTable4 <- renderUI({ if(nameFilteredForEffectTrimmedCheck4() != ""
    ) {
      renderTable(nameFilteredForEffect() %>% 
                    select(sideEffect20:sideEffect24))
    }
    })
    output$sideEffectsTable5 <- renderUI({ if(nameFilteredForEffectTrimmedCheck5() != ""
    ) {
      renderTable(nameFilteredForEffect() %>% 
                    select(sideEffect25:sideEffect29))
    }
    })
    output$sideEffectsTable6 <- renderUI({ if(nameFilteredForEffectTrimmedCheck6() != ""
    ) {
      renderTable(nameFilteredForEffect() %>% 
                    select(sideEffect30:sideEffect34))
    }
    })
    output$sideEffectsTable7 <- renderUI({ if(nameFilteredForEffectTrimmedCheck7() != ""
    ) {
      renderTable(nameFilteredForEffect() %>% 
                    select(sideEffect35:sideEffect39))
    }
    })
    output$sideEffectsTable8 <- renderUI({ if(nameFilteredForEffectTrimmedCheck8() != ""
    ) {
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
  observeEvent(input$learnMore, {
    showModal(modalDialog(
      title = "Symptoms",
      "Here you'll find detailed information on various types of drugs."
    ))
  })
  
  observeEvent(input$research, {
    showModal(modalDialog(
      title = "Medical Uses",
      "This section is dedicated to cutting-edge research on drug safety and efficacy."
    ))
  })
  
  observeEvent(input$contact, {
    showModal(modalDialog(
      title = "Contact Us",
      "Feel free to contact us at info@druginfohub.com."
    ))
  })
  observeEvent(input$contact_alt, {
    showModal(modalDialog(
      title = "Alternates",
      "This section is dedicated to providing alternatives for your prescription"
    ))
  })
  observeEvent(input$contact_efficacy, {
    showModal(modalDialog(
      title = "Efficacy",
      "This section is dedicated to providing the efficacy of the drug"
    ))
  })
  observeEvent(input$contact_prevalence, {
    showModal(modalDialog(
      title = "Prevalence",
      "This section is dedicated to prevalence"
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

# clinical_trials <- data.frame(
#   Trial_ID = 1:5,
#   Disease_Type = c("Cancer", "Diabetes", "Cancer", "Cardiovascular", "Diabetes"),
#   Treatment_Type = c("Chemotherapy", "Insulin", "Immunotherapy", "Statins", "Oral medication"),
#   Location = c("New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ"),
#   stringsAsFactors = FALSE
# )
# 
#   
  # observeEvent(input$search, {
  #   # Check if condition and treatment are selected
  #   if (input$condition == "Select Condition" | input$history == "Select Treatment") {
  #     output$results <- renderTable({
  #       data.frame(Message = "Please select both a condition and treatment.")
  #     })
  #     return()  # Stop further processing if inputs are invalid
  #   }
  #   
  #   # Filter trials based on user input
  #   filtered_trials <- clinical_trials %>%
  #     filter(grepl(input$condition, Disease_Type, ignore.case = TRUE)) %>%
  #     filter(grepl(input$history, Treatment_Type, ignore.case = TRUE)) %>%
  #     filter(grepl(input$location, Location, ignore.case = TRUE))
  #   
  #   # Output the filtered trials as a table
  #   output$results <- renderTable({
  #     if (nrow(filtered_trials) == 0) {
  #       return(data.frame(Message = "No matching trials found"))
  #     }
  #     return(filtered_trials)
  #   })
  # })
}
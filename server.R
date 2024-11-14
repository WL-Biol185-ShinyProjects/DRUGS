library(shiny)
library(dplyr)
library(leaflet)
library(plotly)
source("home.R")
source("medicalUses.R")
source("tab3.R")
source("tab4.R")
source("tab5.R")
source("Maps.R")
source("Reviews.R")

#Loading in info from DrugSubandSide.RDS for medicalUses.R
symptom_list <- readRDS("DrugSubandSide.RDS")

function(input, output, session) {
  
  output$graph1 <- graph1(input)
  output$graph2 <- graph2(input)
  output$graph3 <- graph3(input)
  
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
<<<<<<< HEAD
  
  #output$graph1 <- graph1(input)
  #output$graph2 <- graph2(input)
  #output$graph3 <- graph3(input)
  
  }
=======

}
>>>>>>> f26078acc348565e4d965d60c804431de59097f1
  


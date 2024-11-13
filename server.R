library(shiny)
library(dplyr)

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
  
  output$graph1 <- graph1(input)
  
}


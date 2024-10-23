library(shiny)
library(dplyr)
library(datasets)


symptom_list <- DrugSubandSide

function(input, output, session) {
  illnessNameSubset <- unique(DrugSubandSide[1:100, 50:54])
  
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
}
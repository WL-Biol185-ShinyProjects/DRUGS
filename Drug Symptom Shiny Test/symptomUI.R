library(shiny)
library(dplyr)


fluidPage(
  
  title = "Drug Side Effects",
  sidebarPanel(
    selectizeInput(
      "drugIllness",
      "What illness does your drug treat?",
      choices = NULL, 
    ),
    selectizeInput(
      "drugName",
      "What is you drug/s name?",
      choices = NULL,
    )
  ),
  mainPanel(
    tableOutput("sideEffectsTable")
  )
)
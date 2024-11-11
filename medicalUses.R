library(shiny)
library(dplyr)
medicalUses <- tabPanel(
  "Name1",
  tags$h2("What medical uses your medicine has"), 
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
    div(class = "header", 
        h2("Drug Information")
        ),
    div(class = "header",
        h2("Side Effects")
       ),
    
    tableOutput("sideEffectsTable")
  ) 
)
  



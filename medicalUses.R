library(shiny)
library(dplyr)
#Creating Tab Panel Name and Text
medicalUses <- tabPanel(
  "Drug Information",
  tags$h1("What medical uses your medicine has"), 
#Creating search bar for illness
   sidebarPanel(
    selectizeInput(
      "drugIllness",
      "What illness does your drug treat?",
      choices = NULL, 
    ),
#Creating search bar for drug name
    selectizeInput(
      "drugName",
      "What is you drug's name?",
      choices = NULL,
    )
  ),
#Generating info classifications and info from tables in dataset 
  mainPanel(
  h2("Side Effects of Drug"),
    dataTableOutput("sideEffectsTable"),
    tableOutput("sideEffectsTable1"),
    tableOutput("sideEffectsTable2"),
    tableOutput("sideEffectsTable3"),
    tableOutput("sideEffectsTable4"),
    tableOutput("sideEffectsTable5"),
    tableOutput("sideEffectsTable6"),
    tableOutput("sideEffectsTable7"),
    tableOutput("sideEffectsTable8"),
  h2("Alterantive Drugs for Illness"),
    tableOutput("alternativeDrugsTable"),
  h2("Chemical Class"),
    tableOutput("chemicalClassTable"),
  h2("Action Class"),
    tableOutput("actionClassTable"),
  h2("Therapeutic Class"),
    tableOutput("therapeuticClassTable"),
  h2("Potential for habit forming"),
    tableOutput("habitFormingTable")
  ) 
)
  



library(shiny)
library(dplyr)
#Creating Tab Panel Name and Text
medicalUses <- tabPanel(
  "Drug Information",
  tags$h1("What medical uses your medicine has"), 
sidebarLayout(
#Creating search bar for illness
   sidebarPanel(
   h1("Drug Search Tool"),
   p("Enter or select the illness that your drug treats and then enter or select your drug to find what side effects your drug has, what drugs can be used as alternatives to your drug, its chemical class, action class, therapuatic class and if it has the potential to be habit forming."),
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
    tableOutput("sideEffectsTable"),
    uiOutput("sideEffectsTable1"),
    uiOutput("sideEffectsTable2"),
    uiOutput("sideEffectsTable3"),
    uiOutput("sideEffectsTable4"),
    uiOutput("sideEffectsTable5"),
    uiOutput("sideEffectsTable6"),
    uiOutput("sideEffectsTable7"),
    uiOutput("sideEffectsTable8"),
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
)  



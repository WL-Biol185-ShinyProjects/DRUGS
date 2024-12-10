library(shiny)
library(dplyr)
symptom_list <- readRDS("DrugSubandSide.RDS")
#Creating Tab Panel Name and Text
medicalUses <- tabPanel(
  "Drug Information",
  tags$h2("Medical Properties of Your Selected Drug"),
  p("Here, you can find lots of information about different drugs. First, enter the condition that the wanted drug treats. Second, you can select which drug you would like information on, whether it's a drug you are taking now or a drug you would like to learn more about. The information includes side effects, alternative drugs for the selected illness, chemical class, action class, therapeutic class, and potential for habit-forming. This knowledge can help you see which drug is right for you!"),
  p("A drug's chemical class is information about its chemical structure, action class is information about the mechanism that it works through, therapeutic class is information about what its intended effect is and potential for habit forming is if it has a risk for addiction"),
sidebarLayout(
#Creating search bar for illness
   sidebarPanel(
     tags$h2("Drug Search"),
     p("Select or search for the illness that the drug treats and then for the drug you are interested in"),
    selectizeInput(
      "drugIllness",
      "What illness does your drug treat?",
      choices = unique(symptom_list$use0), 
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



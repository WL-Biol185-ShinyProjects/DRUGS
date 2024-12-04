library(shiny)
library(dplyr)
library(DT)

# Load dataset
clinical_trials <- read.csv("ClinicalST.csv")

Clinical_Trails <-   tabPanel ("Clinical Trial")
  sidebarLayout(
    sidebarPanel(
      selectizeInput("condition", "Select Condition(s):", 
                     choices = unique(clinical_trials$Conditions), 
                     options = list(maxOptions = 10),
                     multiple = TRUE),
      
      
      selectizeInput("gender", "Select Gender(s):", 
                     choices = unique(clinical_trials$Sex), 
                     multiple = TRUE),
      
      
      
      selectizeInput("phase", "Select Phase(s):", 
                     choices = unique(na.omit(clinical_trials$Phases)), 
                     multiple = TRUE),
      actionButton("search", "Search"),
      actionButton("reset", "Reset Filters")
    ),
    mainPanel(
      textOutput("summary"),
      DT::dataTableOutput("results")
    )
  )


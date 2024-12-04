library(shiny)
library(dplyr)
library(DT)

# Load dataset
<<<<<<< HEAD
=======
clinical_trials <- read.csv("ClinicalST.csv")
>>>>>>> f6e85dbb72df276ef798b0168acc364815e2cbc6

clinical_trials <- read.csv("ClinicalST.csv")

Clinical_Trials <-   tabPanel ("Clinical Trial")
  sidebarLayout(
    sidebarPanel(
      selectizeInput("condition", "Select Condition(s):", 
                     choices = NULL, 
                     options = list(maxOptions = 10),
                     multiple = TRUE),
      
      
      selectizeInput("gender", "Select Gender(s):", 
                     choices = NULL, 
                     multiple = TRUE),
      
      
      
      selectizeInput("phase", "Select Phase(s):", 
                     choices = NULL, 
                     multiple = TRUE),
      actionButton("search", "Search"),
      actionButton("reset", "Reset Filters")
    ),
    mainPanel(
      textOutput("summary"),
      DT::dataTableOutput("results")
    )
  )


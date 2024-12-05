library(shiny)
library(dplyr)
library(DT)

# Load dataset



Clinical_Trials <-   tabPanel ("Clinical Trial",
  #sidebarLayout(
    sidebarPanel(
      selectizeInput("condition", "Select Condition(s):", 
                     choices = NULL, 
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
  #)


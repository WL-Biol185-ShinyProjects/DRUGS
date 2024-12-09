library(shiny)
library(dplyr)
library(DT)

# Load dataset



Clinical_Trials <-   tabPanel ("Clinical Trial",
  #sidebarLayout(
    sidebarPanel(
      tags$p("Have you ever wondered what clinical trials are going on in the United States, either out curiosity of or looking for a friend, family member, or even yourself? On the clinical trial tab, you can select what condition you would like the clinical trial to treat for, your gender, and what phase of the clinical trial you would like to enter. After pressing search, information about both locations and a summary of clinical trials that fit into your search parameters. Widening your search parameters, including selecting one or multiple conditions and “all” genders will help find all the clinical trials you need."),
      
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


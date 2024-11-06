library(shiny)
library(dplyr)
source("home.R")
source("medicalUses.R")
source("tab3.R", local = TRUE)$value
source("tab4.R")
source("tab5.R")
source("tab6.R")
source("tab7.R")
fluidPage (
  includeCSS("www/homePage.css"),
  
  # Header
  div(class = "header",
      h1("Welcome to Drug Sqaud!!!!")
  ),
  navbarPage(
    "Home",
    home,
    medicalUses,
    tab3,
    tab4,
    tab5,
    tab6,
    tab7
  )
)

  

 function(input, ) {
  output$total_cost <- renderText({
    # Check if calculate button is pressed
    input$calculate
    
    # Retrieve inputs and calculate total cost
    isolate({
      dosage <- input$dosage
      frequency <- input$frequency
      cost_per_unit <- input$cost_per_unit
      duration <- input$duration
      
      # Calculation
      total_cost <- dosage * frequency * cost_per_unit * duration
      paste("The total cost for", input$drug, "is $", round(total_cost, 2))
    })
  })
}
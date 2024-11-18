library(shiny)
library(dplyr)

# Simulated clinical trial database
clinical_trials <- data.frame(
  Trial_ID = 1:5,
  Disease_Type = c("Cancer", "Diabetes", "Cancer", "Cardiovascular", "Diabetes"),
  Treatment_Type = c("Chemotherapy", "Insulin", "Immunotherapy", "Statins", "Oral medication"),
  Location = c("New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Phoenix, AZ"),
  stringsAsFactors = FALSE
)

# Shiny App
ui <- fluidPage(
  titlePanel("Clinical Trial Matching"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("name", "Patient Name:", value = ""),
      selectInput("condition", "Current Health Condition:",
                  choices = c("Select Condition", "Cancer", "Diabetes", "Cardiovascular", "Asthma", "Arthritis")),
      selectInput("history", "Treatment History:",
                  choices = c("Select Treatment", "Chemotherapy", "Insulin", "Immunotherapy", "Statins", "Oral medication")),
      textInput("location", "Location (City/State):", value = ""),
      actionButton("search", "Find Matching Trials")
    ),
    
    mainPanel(
      tableOutput("results")
    )
  )
)

server <- function(input, output, session) {
  
  observeEvent(input$search, {
    # Check if condition and treatment are selected
    if (input$condition == "Select Condition" | input$history == "Select Treatment") {
      output$results <- renderTable({
        data.frame(Message = "Please select both a condition and treatment.")
      })
      return()  # Stop further processing if inputs are invalid
    }
    
    # Filter trials based on user input
    filtered_trials <- clinical_trials %>%
      filter(grepl(input$condition, Disease_Type, ignore.case = TRUE)) %>%
      filter(grepl(input$history, Treatment_Type, ignore.case = TRUE)) %>%
      filter(grepl(input$location, Location, ignore.case = TRUE))
    
    # Output the filtered trials as a table
    output$results <- renderTable({
      if (nrow(filtered_trials) == 0) {
        return(data.frame(Message = "No matching trials found"))
      }
      return(filtered_trials)
    })
  })
}

# Run the app
shinyApp(ui = ui, server = server)

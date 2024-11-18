Clinical_Trails <-
  
  tabPanel("Clinical Trial Matching",



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


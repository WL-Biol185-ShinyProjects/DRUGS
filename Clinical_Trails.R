Clinical_Trails <-
  
<<<<<<< HEAD
  tabPanel("Clinical Trial Matching",

  
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("Locations", "Select Location:", choices = NULL), # Populated dynamically
                            selectInput("Conditions", "Select Condition:", choices = NULL), # Populated dynamically
                            selectInput("StudyStatus", "Select Study Status:", choices = NULL), # Populated dynamically
                            actionButton("search", "Search")
                          ),
                          mainPanel(
                            tableOutput("results")
                          )
                        )
               )
             
           
           
=======
  tabPanel("Clinical Trial Matching")






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


>>>>>>> e23ac17c742d02229554e902c66ba7f9166178ce

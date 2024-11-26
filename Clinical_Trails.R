Clinical_Trails <-
  
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
             
           
           
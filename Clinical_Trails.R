# Load the dataset
Clinical_Trai1 <- read.csv("ctg-studies.csv")



Clinical <- tabPanel("Clinical Trial Matching",
                            sidebarLayout(
                              sidebarPanel(
                                selectizeInput("Locations", "Select Location:", choices = NULL),
                                selectizeInput("Conditions", "Select Condition:", choices = NULL),
                                selectizeInput("StudyStatus", "Select Phase:", choices = NULL),
                                actionButton("search", "Search")
                              ),
                              mainPanel(
                                tableOutput("results")
                              )
                            )
)






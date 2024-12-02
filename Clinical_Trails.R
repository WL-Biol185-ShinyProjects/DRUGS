

Clinical_Traillls1 <- read.csv("ctg_studie_(4).csv")



Clinical_Trails <-
  

  tabPanel("Clinical Trial Matching",

  
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("Locations", "Select Location:", choices = ctg_studie_(4)), # Populated dynamically
                            selectInput("Conditions", "Select Condition:", choices = ctg_studie_(4)), # Populated dynamically
                            selectInput("StudyStatus", "Select Phase:", choices = ctg_studie_(4)), # Populated dynamically
                            actionButton("search", "Search")
                          ),
                          mainPanel(
                            tableOutput("results")
                          )
                        )
               )
             
           

#  tabPanel("Clinical Trial Matching")






#sidebarLayout(
 # sidebarPanel(
  #  textInput("name", "Patient Name:", value = ""),
   # selectInput("condition", "Current Health Condition:",
    #            choices = c("Select Condition", "Cancer", "Diabetes", "Cardiovascular", "Asthma", "Arthritis")),
#    selectInput("history", "Treatment History:",
 #               choices = c("Select Treatment", "Chemotherapy", "Insulin", "Immunotherapy", "Statins", "Oral medication")),
 #   textInput("location", "Location (City/State):", value = ""),
#    actionButton("search", "Find Matching Trials")
 # ),
  
  #mainPanel(
   # tableOutput("results")
  #)
#)




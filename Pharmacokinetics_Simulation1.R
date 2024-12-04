Pharmacokinetics_Simulation1 <- 



simulate_adme <-
  
  
  tabPanel("Pharmacokinetics Simulation (ADME)",

sidebarLayout(
  sidebarPanel(
    numericInput("age", "Age (years):", value = 30, min = 18, max = 100),
    numericInput("weight", "Weight (kg):", value = 70, min = 30, max = 200),
    selectInput("gender", "Gender:", choices = c("Male", "Female")),
    selectInput("health_condition", "Health Condition:", choices = c("Healthy", "Impaired Liver", "Impaired Kidney")),
    numericInput("dose", "Drug Dose (mg):", value = 500, min = 50, max = 1000),
    numericInput("half_life", "Drug Half-Life (hours):", value = 6, min = 1, max = 24),
    actionButton("simulate", "Run Simulation")
  ),
  
  mainPanel(
    plotOutput("drug_concentration_plot"),
    p("Note: The drug concentration model is based on simplified pharmacokinetics."),
    verbatimTextOutput("summary_text"),
    verbatimTextOutput("half_life_text")
  )
)

)


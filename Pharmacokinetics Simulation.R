library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Pharmacokinetics Simulation (ADME)"),
  
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

server <- function(input, output) {
  
  # Function to simulate ADME (Absorption, Distribution, Metabolism, Elimination)
  simulate_adme <- function(age, weight, gender, health_condition, dose, half_life) {
    k_a <- 0.2  # Absorption rate constant (per hour)
    
    # Adjust the volume of distribution (Vd) based on weight
    Vd <- 0.7 * weight
    
    # Adjust clearance (Cl) based on age and weight
    Cl <- 0.05 * weight + 0.1 * age
    
    # Calculate the elimination rate constant (k_el) based on half-life
    k_el <- log(2) / half_life
    
    # Adjust elimination rate based on health condition
    if (health_condition == "Impaired Liver") {
      k_el <- k_el * 0.5  # Reduce elimination for liver impairment
    } else if (health_condition == "Impaired Kidney") {
      k_el <- k_el * 0.7  # Reduce elimination for kidney impairment
    }
    
    # Ensure that k_a and k_el are not equal to avoid division by zero
    if (abs(k_a - k_el) < 1e-6) {
      k_a <- k_el + 0.01  # Adjust k_a slightly to prevent division by zero
    }
    
    # Simulate concentration over time
    time <- seq(0, 48, by = 0.1)  # Time vector from 0 to 48 hours
    C_t <- (dose * k_a) / (Vd * (k_a - k_el)) * (exp(-k_el * time) - exp(-k_a * time))  # Concentration over time
    
    data.frame(time = time, concentration = C_t)
  }
  
  # Reactive expression to run the simulation
  drug_data <- eventReactive(input$simulate, {
    simulate_adme(input$age, input$weight, input$gender, input$health_condition, input$dose, input$half_life)
  })
  
  output$drug_concentration_plot <- renderPlot({
    data <- drug_data()
    
    ggplot(data, aes(x = time, y = concentration)) +
      geom_line(color = "blue", size = 1.2) +
      labs(title = "Drug Concentration Over Time",
           x = "Time (hours)", y = "Concentration (mg/L)") +
      theme_minimal()
  })
  
  output$summary_text <- renderText({
    data <- drug_data()
    peak_conc <- max(data$concentration)
    peak_time <- data$time[which.max(data$concentration)]
    paste("Peak concentration: ", round(peak_conc, 2), "mg/L at ", round(peak_time, 2), "hours after administration.")
  })
  
  output$half_life_text <- renderText({
    paste("Calculated elimination rate constant based on half-life: ", round(log(2) / input$half_life, 4))
  })
}

shinyApp(ui = ui, server = server)

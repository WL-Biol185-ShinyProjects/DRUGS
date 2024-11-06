
library(shiny)

 fluidPage(
  titlePanel("Drug Cost Calculator"),
  sidebarLayout(
    sidebarPanel(
      textInput("drug", "Drug Name:", value = "Enter drug name"),
      numericInput("dosage", "Dosage (mg):", value = 0, min = 0),
      numericInput("frequency", "Frequency per Day:", value = 1, min = 1),
      numericInput("cost_per_unit", "Cost per Unit ($):", value = 0, min = 0),
      numericInput("duration", "Duration (Days):", value = 30, min = 1),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      textOutput("total_cost")
    )
  )
)
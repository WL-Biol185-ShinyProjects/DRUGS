# Load necessary libraries
library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(maps)

# Load the dataset
drugs_data <- read.csv("drugs.csv")

# Prepare state map data
states_map <- map_data("state")

# UI: Define the user interface
Maps <- 
  tabPanel(" Substance Use in the USA",
           tags$h2("The Frequency of Substance Use in the USA"),
           tags$p("Explore the patterns of alcohol, marijuana, illicit drugs, and tobacco usage across the United States with our interactive heat map spanning from 2002 to 2018. This visualization highlights the frequency of each substance within different states and regions, allowing you to easily identify trends, hotspots, and regional variations over time. Whether you're analyzing public health data, researching societal behaviors, or seeking insights for policy development, this heat map provides a clear and comprehensive view of substance use dynamics across the nation."),
           tags$h3("Select or search the metric and year you are interested about below"),
  
  sidebarLayout(
    selectInput(
      inputId = "metric",
      label = "Select Metric:",
      choices = colnames(drugs_data)[6:ncol(drugs_data)], # Dynamic column selection
      selected = "Totals.Alcohol.Use Disorder Past Year.12-17"
    ),
    sliderInput(
      inputId = "year",
      label = "Select Year:",
      min = min(drugs_data$Year),
      max = max(drugs_data$Year),
      value = min(drugs_data$Year),
      step = 1
    )
  ),

    mainPanel(
      tabsetPanel(
        tabPanel("Map", plotOutput("mapPlot")),
        tabPanel("Summary", tableOutput("summaryTable"))
      )
    )
   )


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
  tabPanel(" Drug Use in the USA",
  
  sidebarLayout(
    #sidebarPanel(
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


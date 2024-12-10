
library(tidyverse)
library(reshape2)
library(d3heatmap)
library(ggplot2)

Spread_Prices <- read.csv("Spread_Prices.csv")


Costs <- tabPanel(
  "Costs",
  tags$h2("Costs of drugs covered by Medicaid"),
  tags$p("Do you have questions about how the cost of a drug has changed over the years? Here, you can search for the drug you would like to know about, and gain information about the average spending per drug claim (figure 1), total spending per selected drug (figure 2), total spending on all drugs (figure 3), and total claims of your selected drug (figure 4) from 2018-2022."),
  
  sidebarPanel(
    tags$h3("Brand Name"),
    p("Select or search the brand name of a drug to see information about its cost"),
    selectizeInput(
      "Brand_Name",
      "What is the Brand Name of the drug you are inquiring about?",
      choices = NULL
    )
  ),
  
  mainPanel(
    
    plotOutput('Avg_Spend_Plot'),
    plotOutput('Tot_DrugSpend_Plot'),
    plotOutput('Tot_Spend_Plot'),
    plotOutput('Tot_DrugClaims_Plot'),
    
    
  )
)

library(tidyverse)
library(dplyr)
library(ggplot2)


Spread_Prices <- read.csv("Spread_Prices.csv")

# Graphs for cost tab UI

Avg_Spend_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name == input$Brand_Name ) %>%
      ggplot( aes(x = year, y = Avg_Spnd_Per_Clm)) + geom_line(stat = "identity") +
      labs(x = "Year", y = "Average Drug Cost per Claim")
  }
  )
}

Tot_DrugSpend_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name == input$Brand_Name) %>%
      ggplot( aes(x = year, y = Tot_Spndng)) + geom_line(stat = "identity") + 
      labs(x = "Year", y = "Total Spending of Selected Drug")
  }
  )
}

Tot_Spend_Plot <- function(input) {
  renderPlot({
    ggplot(Spread_Prices,
           aes(x = year, y = Tot_Spndng)) + geom_bar(stat = "identity") +
      labs(x = "Year", y = "Total Spending of All Drugs")
  }
  )
}


Tot_DrugClaims_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name == input$Brand_Name) %>%
      ggplot(aes(x = year, y = Tot_Clms)) + geom_line(stat = "Identity") +
      labs(x = "Year", y = "Total Drug Claims")
  }
  )
}
  












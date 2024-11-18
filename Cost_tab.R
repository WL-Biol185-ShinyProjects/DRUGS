library(tidyverse)
library(reshape2)
library(ggplot2)

Spread_Prices <- read.csv("Spread_Prices.csv")

Costs <- tabPanel(
  "Costs",
  tags$h2("Costs of drugs covered by Medicaid"),
  
  sidebarPanel(
    selectizeInput(
      "Brand_Name",
      "What is the Brand Name of the drug you are inquiring about?",
      choices = Spread_Prices$Brnd_Name
    )
  ),
  
  mainPanel(
    
    plotOutput('Avg_Spend_Plot'),
    plotOutput('Tot_DrugSpend_Plot'),
    plotOutput('Tot_Spend_Plot'),
    plotOutput('Tot_DrugClaims_Plot')
  )
)


# Comparing average spending per drug over time
Cost_Filtered_Drug <- filter(Spread_Prices, Brnd_Name == "Heather")

Avg_Spend_Plot <- ggplot(Cost_Filtered_Drug, 
                         aes(x = year, y = Avg_Spnd_Per_Clm)) + geom_line(stat = "identity") 

#UI info for Searching Drug

Avg_Spend_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name %in% input$Brand_Name ) %>%
      ggplot( aes(x = year, y = Avg_Spnd_Per_Clm )) + geom_line(stat = "identity") 
  }
  )
}

Tot_DrugSpend_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name %in% input$Brand_Name) %>%
      ggplot( aes(x = year, y = Tot_Spndng)) + geom_line(stat = "identity")
  }
  )
}

Tot_Spend_Plot <- function(input) {
  renderPlot({
    ggplot(Spread_Prices,
           aes(x = year, y = Tot_Spndng)) + geom_bar(stat = "identity")
  }
  )
}

Tot_DrugClaims_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name %in% input$Brand_Name) %>%
      ggplot(aes(x = year, y = Tot_Clms)) + geom_line(stat = "Identity")
  }
  )
}

# Comparing Total Spending over time Per Drug

ggplot(Cost_Filtered_Drug, 
       aes(x = year, y = Tot_Spndng)) + geom_line(stat = "identity")

# Comparing Total Spending over time of All Drugs
ggplot(Spread_Prices, 
       aes(x = year, y = Tot_Spndng)) + geom_bar(stat = "identity")

# Comparing total claims over time per drug 

ggplot(Cost_Filtered_Drug,
       aes(x = year, y = Tot_Clms)) + geom_line(stat = "identity")










library(tidyverse)
library(reshape2)
library(d3heatmap)


# Comparing average spending per drug over time
Cost_Filtered_Drug <- filter(Spread_Prices, Brnd_Name == "Heather")

Avg_Spend_Plot <- ggplot(Cost_Filtered_Drug, 
                         aes(x = year, y = Avg_Spnd_Per_Clm)) + geom_line(stat = "identity") 

Cost_tab <- tabPanel(
  
  
  
  #Server Info for Searching Drug
  
  function(input, output, session) { 
    Brand_Name_Subset <- unique(Cost_Data_filtered(1))
    
    observe({
      updateSelectizeInput(session,
                           "Brand_Name",
                           choices = Brand_Name_Subset, ) } )
    
    observe ({
      filterName <- filter(Cost_Data_filtered, 
                           Brnd_Name == input$Brand_Name ) } )
  }
)

#UI info for Searching Drug

Avg_Spend_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name == Input$Brnd_Name ) %>%
      ggplot( aes(x = year, y = Avg_Spnd_Per_Clm)) + geom_line(stat = "identity") 
  }
  )
}

Tot_DrugSpend_Plot <- function(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name == Input$Brnd_Name) %>%
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

Tot_DrugClaims_Plot <- functino(input) {
  renderPlot({
    filter(Spread_Prices, Brnd_Name == input$Brnd_Name) %>%
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










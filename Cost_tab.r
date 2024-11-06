library(tidyverse)
library(reshape2)

Cost_tab <- tabPanel(
  
# Code for comparing cost over time

Avg_Spend_filtered_Drug <- filter(Cost_Filtered_Drug, Brnd_Name == "Heather")

Avg_Spend_Plot <- ggplot(Avg_Spend_filtered_Drug, aes(x = year, y = Avg_Spnd_Per_Clm)) + geom_line(stat = "identity") 
              
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

  #UI info for Searching Drug

fluidPage( 
  
  title = "Drug Price",
    sidebarPanel(
      selectizeInpu(
        "Brand_Name",
        "What is the name of your Drug?",
        choices = NULL,
    )
    ),
  mainPanel(
    PlotOutput( "Avg_Spend_Plot")
  )
  )
)


# Comparing Total Spending over time


Cost_Filtered_Drug <- filter(Spread_Prices, Brnd_Name == "Heather")

Tot_Spend_Plot <- ggplot(Cost_Filtered_Drug, aes(x = year, y = Tot_Spndng)) + geom_line(stat = "identity")


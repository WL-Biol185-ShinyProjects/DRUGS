Interactions <- tabPanel(
  "Interactions",
  tags$h2("The drugs that your selected drug interacts with"),
  
  sidebarPanel(
    selectizeInput(
      "Drug_Name",
      "What is the name of the drug you are inquiring about?",
      choices = Spread_Prices$drug1_name
    )
  ),
  
  mainPanel(
    
    plotOutput('Int_Plot'),
    plotOutput('Int_Rev_Plot')
    
    
  )
)

library(tidyverse)
library(ggplot2)


DDI_data <- read.csv("DDI_data.csv")
reviews_clean <- read.csv("reviews_clean.csv")

# Comparing Drug Interactions 

Filtered_DDI_Data <- filter(DDI_data, 
                            drug1_name == "Apixaban" | drug1_name == "Bivalirudin") 

ggplot(Filtered_DDI_Data, 
       aes( x = drug1_name, y = drug2_name)) + geom_tile(aes(fill = interaction_type)) + theme(axis.text.y = element_blank())

#UI for Drug Interaction

Int_Plot <- function(input) {
  renderPlot({
    filter(DDI, drug1_name %in% input$Drug_Name | drug1_name %in% input$Drug_Name) %>%
    ggplot( aes(x = drug1_name, y = drug2_name)) + geom_tile(aes(fill = interaction_type)) + theme(axis.text.y = element_blank())
    }
  )
}
 
Joined_DDI_Details <-   left_join(filter(DDI_data, drug1_name %in% input$Drug_Name | drug1_name %in% input$Drug_Name),
                                  filter(reviews_clean, drug %in% input$Drug_Name | drug %in% input$Drug_Name),
                                  by = c("drug1_name" = "drug")) 

Int_Rev_Plot <- function(input) {
  renderPlot({

      
  })
}

# Comparing Drugs to Reviews based off number of interactions


Joined_DDI_Details$poor <- as.numeric(Joined_DDI_Details$poor)
Joined_DDI_Details$average <- as.numeric(Joined_DDI_Details$average)
Joined_DDI_Details$excellent <- as.numeric(Joined_DDI_Details$excellent)

Joined_DDI_Details <- left_join(filter(DDI_data, drug1_name == "Apixaban" | drug1_name == "Warfarin"),
                                filter(reviews_clean, drug == "Apixaban" | drug == "Warfarin"),
                                by =  c("drug1_name" = "drug"))

Joined_DDI_Details[!duplicated(Joined_DDI_Details$poor),] %>%
  group_by(drug1_name) %>%
  ggplot(aes(x = drug1_name, y = poor, fill = drug1_name)) + geom_bar(stat = "identity")


Joined_DDI_Details %>%
  select(drug1_name, excellent, average, poor) %>%
  pivot_longer( cols = c(excellent, average, poor), names_to = "Rev_Type", values_to = "Rev_Num") %>%
  ggplot(aes(x = Rev_Type, y = Rev_Num, fill = drug1_name)) + geom_bar(stat = "summary", position = "dodge")



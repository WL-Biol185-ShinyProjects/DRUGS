Interactions <- tabPanel(
  "Interactions",
  tags$h2("The drugs that your selected drug interacts with"),
  
  sidebarPanel(
    selectizeInput(
      "Drug_Name",
      "What is the name of the drug you are inquiring about?",
      choices = NULL
    )
  ),
  
  sidebarPanel(
    selectizeInput(
      "Drug_Names",
      "What is the name of the drug you are inquiring about?",
      choices = NULL
    )
  ),
  
  mainPanel(
    
    plotOutput('Int_Plot'),
    plotOutput('Int_Rev_Plot')

    
  )
)

library(tidyverse)
library(dplyr)
library(ggplot2)


DDI_data <- read.csv("DDI_data.csv")
reviews_clean <- read.csv("reviews_clean.csv")


#UI for Drug Interaction

Int_Plot <- function(input) {
  renderPlot({
    Filtered_DDI_Data <- filter(DDI_data, drug1_name == input$Drug_Name | drug1_name == input$Drug_Names)
    ggplot(Filtered_DDI_Data, aes(x = drug1_name, y = drug2_name)) + 
      geom_tile(aes(fill = interaction_type)) + 
      theme(axis.text.y = element_blank()) +
      labs(x = "Selected Drug", y = "Interacting Drugs")
    }
  )
}
 

Int_Rev_Plot <- function(input) {
  renderPlot({
    if (is.null(input$Drug_Name) || input$Drug_Name == "") {
      return(NULL) 
    }
    
    DDI_data <-  filter(DDI_data, drug1_name == input$Drug_Name)
    reviews_clean <- filter(reviews_clean, drug == input$Drug_Name)
    
    Joined_DDI_Details <- 
      left_join(DDI_data, reviews_clean, by = c("drug1_name" = "drug")
      )
   

    if (is.null(Joined_DDI_Details) || nrow(Joined_DDI_Details) == 0) {
      message("No data found for the selected drug.")
      return(NULL) 
    }
  
    long_data <- Joined_DDI_Details %>%
      select(drug1_name, excellent, average, poor) %>%
      pivot_longer(cols = c(excellent, average, poor), 
                   names_to = "Review_Type", 
                   values_to = "Review_Amount")
    
    long_data$Review_Amount <- as.numeric(long_data$Review_Amount)
    
    ggplot(long_data, aes(x = Review_Type, y = Review_Amount, fill = drug1_name)) + 
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Review Type", y = "Review Amount", title = paste("Reviews for", input$Drug_Name)) +
      guides(fill=guide_legend(title="Selected Drug")) +
      theme_minimal() 
  })
}







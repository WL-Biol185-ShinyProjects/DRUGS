
tab4 <- tabPanel(
  "Tab4",
  tags$h2("Select your medicine"),
  mainPanel(
    
  )
)

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
      "Drug_Name",
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


# Comparing Drug Interactions 

Filtered_DDI_Data <- filter(DDI_data, 
                            drug1_name == "Apixaban" | drug1_name == "Bivalirudin") 

ggplot(Filtered_DDI_Data, 
       aes( x = drug1_name, y = drug2_name)) + geom_tile(aes(fill = interaction_type)) + theme(axis.text.y = element_blank())


#UI for Drug Interaction

Int_Plot <- function(input) {
  renderPlot({

    Filtered_DDI_Data <- filter(DDI_data, drug1_name == input$Drug_Name | drug1_name == input$Drug_Name)
    
    ggplot(Filtered_DDI_Data, aes(x = drug1_name, y = drug2_name)) + 
      geom_tile(aes(fill = interaction_type)) + 
      theme(axis.text.y = element_blank())
    }
  )
}
 

Int_Rev_Plot <- function(input) {
  renderPlot({
    
    # Check if input$Drug_Name is valid and not empty
    if (is.null(input$Drug_Name) || input$Drug_Name == "") {
      return(NULL) # Return nothing if input is not valid
    }
    
    # Perform the left join operation
    Joined_DDI_Details <- tryCatch({
      left_join(
        filter(DDI_data, drug1_name == input$Drug_Name),
        filter(reviews_clean, drug == input$Drug_Name),
        by = c("drug1_name" = "drug")
      )
    }, error = function(e) {
      message("Error during join: ", e$message)
      return(NULL) # Return NULL if there's an error in the join
    })
    
    # Check if the join resulted in any data
    if (is.null(Joined_DDI_Details) || nrow(Joined_DDI_Details) == 0) {
      message("No data found for the selected drug.")
      return(NULL) # Return nothing if no matching rows found
    }
    
    # Print Joined_DDI_Details for debugging
    print(head(Joined_DDI_Details)) # Check the structure of the joined data
    
    # Pivot the data from wide to long format
    long_data <- Joined_DDI_Details %>%
      select(drug1_name, excellent, average, poor) %>%
      pivot_longer(cols = c(excellent, average, poor), 
                   names_to = "Review_Type", 
                   values_to = "Review_Amount")
    
    # Ensure Review_Amount is numeric (in case it's a factor or character)
    long_data$Review_Amount <- as.numeric(long_data$Review_Amount)
    
    # Create the bar plot
    ggplot(long_data, aes(x = Review_Type, y = Review_Amount, fill = drug1_name)) + 
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Review Type", y = "Review Amount", title = paste("Reviews for", input$Drug_Name)) +
      theme_minimal() # Optional theme for cleaner plot
  })
}



# Comparing Drugs to Reviews based off number of interactions




# Comparing Drugs to Reviews based off number of interactions


#Joined_DDI_Details$poor <- as.numeric(Joined_DDI_Details$poor)
#Joined_DDI_Details$average <- as.numeric(Joined_DDI_Details$average)
#Joined_DDI_Details$excellent <- as.numeric(Joined_DDI_Details$excellent)

#Joined_DDI_Details <- left_join(filter(DDI_data, drug1_name == "Apixaban" | drug1_name == "Warfarin"),
#                                filter(reviews_clean, drug == "Apixaban" | drug == "Warfarin"),
#                                by =  c("drug1_name" = "drug"))




Joined_DDI_Details %>%
  select(drug1_name, excellent, average, poor) %>%
  pivot_longer( cols = c(excellent, average, poor), names_to = "Rev_Type", values_to = "Rev_Num") %>%
  ggplot(aes(x = Rev_Type, y = Rev_Num, fill = drug1_name)) + geom_bar(stat = "summary", position = "dodge")

#Joined_DDI_Details %>%
#  select(drug1_name, excellent, average, poor) %>%
# pivot_longer(., cols = c(excellent, average, poor), names_to = "Review_Type", values_to = "Review_Amount") %>%
#  ggplot(aes(x = Review_Type, y = Review_Amount, fill = drug1_name)) + geom_bar(stat = "summary", position = "dodge")





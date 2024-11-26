tab4 <- tabPanel(
  "Tab4",
  tags$h2("Select your medicine"),
  mainPanel(
    
  )
)


# Comparing Drug Interactions 

Filtered_DDI_Data <- filter(DDI_data, 
                            drug1_name == "Apixaban" | drug1_name == "Bivalirudin") 

ggplot(Filtered_DDI_Data, 
       aes( x = drug1_name, y = drug2_name)) + geom_tile(aes(fill = interaction_type)) + theme(axis.text.y = element_blank())

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



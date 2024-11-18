library(ggplot2)




# Define UI for Tab 6
Maps <- tabPanel("Map",
                 h2("Drug Usage Map"),
                 
        
                 
                 
                 
                 # Sidebar layout with dropdown menu for state selection
                 
                 sidebarLayout(
                   sidebarPanel(
                     
                     # Dropdown menu to select a state
                     
                     selectInput("state_select", "Select a state:", choices = state.name, selected = "California")
                   ),
                   mainPanel(
                     plotOutput("heatmap")
                   )
                 ),
           
                
                 
                 
                 
                 
                 
                       
              
                 
)     
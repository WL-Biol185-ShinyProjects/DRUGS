library(shiny)
library(leaflet)



# Define UI for Tab 7
tab7 <- tabPanel("Map",
                 h2("Drug Usage Map"),
                 
                 
       
             
                 # Sidebar layout with dropdown menu for state selection
                 
                 sidebarLayout(
                   sidebarPanel(
                     
                     # Dropdown menu to select a state
                     
                     selectInput("state_select", "Select a state:", choices = state.name, selected = "California")
                   ),
                   mainPanel(
                     leafletOutput("us_map")
                   )
                 )
                 
                 
                 
                 
                 
                 
                 
                 
)
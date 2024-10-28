library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)
library(dplyr)

source("Home_page.R")
source("Symptoms_tab.R")
source("Medical_uses_tab.R")
source("Cost_tab.R")
source("Alternatives_tab.R")
source("Efficacy_tab.R")
source("Prevalence_tab.R")


fluidPage 

(css <- ",
body {
    font-family: 'Arial', sans-serif;
    background-color: #f9f9f8;
    margin: 0;
    padding: 0;
}
.header { 
    background-color: #007bff;
    padding: 20px;
    text-align: center;
    color: white;
}
.header h1 {
    margin: 0;
    font-size: 48px;
}
.navbar {
    background-color: #343a40;
    overflow: hidden;
}
.navbar a {
    float: left;
    display: block;
    color: #f2f2f2;
    text-align: center;
    padding: 14px 20px;
    text-decoration: none;
}
.navbar a:hover {
    background-color: #ddd;
    color: black;
}
.content {
    padding: 20px;
}
.card {
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
    transition: 0.3s;
    background-color: white;
    padding: 16px;
    margin: 10px;
    border-radius: 5px;
}
.card:hover {
    box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}
footer {
    text-align: center;
    padding: 10px;
    background-color: #007bff;
    color: white;
    position: fixed;
    left: 0;
    bottom: 0;
    width: 100%;
}
"
  tags$head(tags$style(HTML(css))),
  
  
  # Header
  div(class = "header",
      h1("Welcome to Drug Sqaud!!!!")
  ),
  
  # Navigation bar
  navbarPage(title = "Home",
             theme = shinythemes::shinytheme("sandstone"), 
             header = tags$style(HTML("
                                    .leaflet-container { 
                                    background: #BAECFF; 
                                    outline: 0; 
                                    }" 
             )), 
             
             tags$style(type = "text/css", ".navbar-brand {font-size: 36px;}"), 
             
             tabPanel("Symptoms",
                      tags$h2("Select what medicine treats first then select your medicine"), 
                      mainPanel(
                        
                      ) 
             ),
             
             tabPanel("Medical Uses",
                      tags$h2("What Medical Uses a Medicine Has"), 
                      mainPanel(
                        
                      ) 
             ),
             
             tabPanel("Cost",
                      tags$h2("Select a medicine to compare costs"), 
                      mainPanel(
                        
                      ) 
             ),
             
             tabPanel("Alternatives",
                      tags$h2("Select Medicine to see Alternatives"),
                      mainPanel(
                        
                      )
             ),
             
             tabPanel("Efficacy",
                      tags$h2("Select medicine to see efficacy"),
                      mainPanel(
                        
                      )
             ),
             
             tabPanel("Prevalence",
                      tags$h2("Select Medicine to see prevalence"),
                      mainPanel(
                        
                      )
             ),
             
             
  ),
  
  
  div(class = "content",
      h2("About Us"),
      p("We provide accurate, up-to-date information on a variety of drugs, 
        their uses, effects, and the latest research."),
      
      div(class = "card",
          h3("Symptoms"),
          p("Explore the various categories of drugs including prescription 
            medications, over-the-counter drugs, and recreational substances."),
          actionButton("learnMore", "Learn More", class = "btn btn-primary")
          
      ),
      
      div(class = "card",
          h3("Medical Uses"),
          p("Stay informed with the latest studies and findings on the safety 
            and efficacy of different drugs."),
          actionButton("research", "Read More", class = "btn btn-primary")
          
          
          
          
          
          
          
      ),
      
      div(class = "card",
          h3("Cost"),
          p("Have questions? Feel free to reach out to us for more information."),
          actionButton("contact", "Get in Touch", class = "btn btn-primary")
      )
  ),
  
  div(class="card",
      h3("Alternatives"),
      p("Have questions? Feel free to reach out to us for more information."),
      actionButton("contact", "Get in Touch", class = "btn btn-primary")
      
      
  ),
  
  div(class="card",
      h3("Efficancy"),
      p("Have questions? Feel free to reach out to us for more information."),
      actionButton("contact", "Get in Touch", class = "btn btn-primary")
      
  ),
  
  div(class="card",
      h3("Prevalence"),
      p("Have questions? Feel free to reach out to us for more information."),
      actionButton("contact", "Get in Touch", class = "btn btn-primary")
      
  ),
  
  
)
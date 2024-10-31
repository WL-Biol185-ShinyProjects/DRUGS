library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(bslib)
library(shinythemes)

#Source Pages
#source("Symptoms_tab.R")
#source("Medical_uses_tab.R")
#source("Cost_tab.R")
#source("Alternatives_tab.R")
#source("Efficacy_tab.R")
#source("Prevalence_tab.R")



ui <- navbarPage(
  title = "Home",
  theme = shinythemes::shinytheme("sandstone"),
  includeCSS("www/home_page.css"),
  
  # Add a title panel inside the navbar
  tabPanel("Home",
           div(class = "header",
               h1("Welcome to Drug Squad!!!!")
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
               ),
               
               div(class = "card",
                   h3("Alternatives"),
                   p("Have questions? Feel free to reach out to us for more information."),
                   actionButton("contact_alt", "Get in Touch", class = "btn btn-primary")
               ),
               
               div(class = "card",
                   h3("Reviews"),
                   p("Have questions? Feel free to reach out to us for more information."),
                   actionButton("contact_efficacy", "Get in Touch", class = "btn btn-primary")
               ),
               
               div(class = "card",
                   h3("Insert Here"),
                   p("Have questions? Feel free to reach out to us for more information."),
                   actionButton("contact_prevalence", "Get in Touch", class = "btn btn-primary")
               )
           )
  ),
  
  # Define additional tabs for Symptoms, Medical Uses, Cost, Alternatives, Efficacy, Prevalence
  tabPanel("Symptoms",
           tags$h2("Side effects correlation"),
           mainPanel()
  ),
  
  tabPanel("Medical Uses",
           tags$h2("Retrieve information about medical uses from wikipedia"),
           mainPanel()
  ),
  
  tabPanel("Cost",
           tags$h2("Select a medicine to compare costs, compare one drug over 5 years"),
           mainPanel()
  ),
  
  tabPanel("Alternatives",
           tags$h2("similar drugs that do the same thing"),
           mainPanel()
  ),
  
    tabPanel("Reviews",
           tags$h2("Compare customer sastifactions to reviews"),
           mainPanel()
  ),
  
  tabPanel("Insert Here",
           tags$h2("Select Medicine to see prevalence"),
           mainPanel()
  )
)




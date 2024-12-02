library(shiny)
library(dplyr)
library(leaflet)

source("home.R")
source("medicalUses.R")
source("Cost_tab.R")
source("interaction_tab.R")
source("Clinical_Trails.R")
source("Maps.R")
source("Reviews.R")
source("Pharmacokinetics_Simulation1.R")

fluidPage (
  includeCSS("www/homePage.css"),
  
  # Header
  div(class = "header",
      h1("Welcome to Drug Squad!!!")
  ),
  navbarPage(
    "Home",
    home,
    medicalUses,
    Costs,
    Interactions,
    Clinical_Trails,
    Maps,
    Reviews,
    Pharmacokinetics_Simulation
  )
  
  
  
  
  
)



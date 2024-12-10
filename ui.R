library(shiny)
library(dplyr)
library(leaflet)
source("home.R")
source("medicalUses.R")
source("cost_tab.R")
source("interaction_tab.R")
source("clinical_Trials.R")
source("maps.R")
source("reviews.R")
source("pharmacokinetics_Simulation1.R")


fluidPage (
  includeCSS("www/homePage.css"),
  
  # Header
  div(class = "header",
      h1("Welcome to Drug Squad!!!")
  ),
  
  navbarPage(
    "Tab Selection",
    home,
    medicalUses,
    Costs,
    Interactions,
    Clinical_Trials,
    Maps,
    Reviews,
    Pharmacokinetics_Simulation1
  )
)
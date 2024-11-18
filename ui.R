library(shiny)
library(dplyr)
library(leaflet)
library(plotly)

source("home.R")
source("medicalUses.R")
source("Cost_tab.R")
source("tab4.R")
source("tab5.R")
source("Maps.R")
source("Reviews.R")

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
    tab4,
    tab5,
    Maps,
    Reviews
  )
)



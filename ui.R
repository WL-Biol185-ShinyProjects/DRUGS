library(shiny)
library(dplyr)
source("home.R")
source("medicalUses.R")
source("tab3.R")
source("tab4.R")
source("tab5.R")
source("tab6.R")
source("tab7.R")

fluidPage (
  includeCSS("www/homePage.css"),
  
  # Header
  div(class = "header",
      h1("Welcome to Drug Sqaud!!!!")
  ),
  navbarPage(
    "Home",
    home,
    medicalUses,
    tab3,
    tab4,
    tab5,
    tab6,
    tab7
  )
)



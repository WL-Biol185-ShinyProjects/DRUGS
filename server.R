library(leaflet)
library(tidyverse)
library(shiny)
library(ggplot2)
library(dplyr)

source("Home_page.R")
source("Symptoms_tab.R")
source("Medical_uses_tab.R")
source("Cost_tab.R")
source("Alternatives_tab.R")
source("Efficacy_tab.R")
source("Prevalence_tab.R")

function(input, output) {
  observeEvent(input$learnMore, {
    showModal(modalDialog(
      title = "Symptoms",
      "Here you'll find detailed information on various types of drugs."
    ))
  })
  
  observeEvent(input$research, {
    showModal(modalDialog(
      title = "Alternates",
      "This section is dedicated to cutting-edge research on drug safety and efficacy."
    ))
  })
  
  observeEvent(input$contact, {
    showModal(modalDialog(
      title = "Contact Us",
      "Feel free to contact us at info@druginfohub.com."
    ))
  })
}
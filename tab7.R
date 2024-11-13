tab7 <- tabPanel(
  "Tab7",
  tags$h2("Select your medicine"),
  mainPanel(
    
    
    #selectizeInput( inputId  = "Condition_Choice"
    #                , label = ""
    #                , choices  = UnduplicatedDrug2$Condition
    #                , selected = "back pain"
    #                , options  = list( create = FALSE
    #                                   , placeholder = "Search..."
    #                                   , maxItems = "1"
    #                                   , onDropdownOpen = I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}")
    #                                   , onType = I("function (str) {if (str === \"\") {this.close();}}")
    #                )
    #),
    plotOutput('graph1')
  )
)

##bar graph comparing the drug to how effective it is in regards to the condition the drug treats

##bar graph comparign the drug to its ease of use in regards to the condiiton the drug treats
#Filtered_UnduplicatedDrug2 <- filter(UnduplicatedDrug2, Condition == 'Acute Bacterial Sinusitis'),
#ggplot( Filtered_UnduplicatedDrug2, aes(EaseOfUse, Reviews.1)) + geom_point(aes( colour = factor(Drug))),

##Satisfaction vs reviews filtered by drugs in a certain condition
#Filtered_UnduplicatedDrug2 <- filter(UnduplicatedDrug2, Condition == 'Acute Bacterial Sinusitis'),
#ggplot( Filtered_UnduplicatedDrug2, aes(Satisfaction, Reviews.1)) + geom_point(aes( colour = factor(Drug)))


graph1 <- function (input) {
  renderPlot(
    filter(UnduplicatedDrug2, Condition == input$Condition_Choice) %>%
      ggplot(aes(Effective, Reviews.1)) + geom_point(aes(colour = factor(Drug)))
  )
}
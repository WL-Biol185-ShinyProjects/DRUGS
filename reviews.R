UnduplicatedDrug2 <- read.csv("UnduplicatedDrug2.csv")

Reviews <- tabPanel(
  "Reviews",
  tags$h2("Reviews categorized by Effectiveness, Ease of Use, and Satisfaction of Drugs"),
  tags$p("In the Reviews tab, you can figure out which drug is liked the most based on effectiveness, ease of use, and satisfaction ratings. First, select which condition/illness you would like to learn more about. Then three graphs will come up, with all the drugs for a certain condition plotted. The farther to the right the drug is on the x-axis and the higher the drug is on the y-axis, the more effectiveness/ease of use/satisfaction ratings a drug has gotten and the more reviews it has, making the predictions a more reliable source."),
  
  sidebarPanel(
    tags$h3("Condition Selection"),
    p("Select or search the condition your drug treat to see how drugs treating it were reviewed"),
    selectizeInput(
      "Condition",
      "What Condition would you like to know information about",
      choices = UnduplicatedDrug2$Condition, 
    )
  ),
  
  mainPanel(
    
    
    plotOutput('graph1'),
    plotOutput('graph2'),
    plotOutput('graph3')
   )
  )


graph1 <- function(input) {
  renderPlot({
    filter(UnduplicatedDrug2, Condition == input$Condition) %>%
     ggplot(aes(Effective, Reviews.1)) +
       geom_point(aes
                   (colour = factor
                     (Drug)
                     )
                   )+
      xlab("Effectiveness")+
      ylab("Reviews")+
      ggtitle("Effectiveness of Drugs based on Reviews")
  })
}
graph2 <- function(input) {
  renderPlot({
    filter(UnduplicatedDrug2, Condition == input$Condition) %>%
      ggplot(aes(EaseOfUse, Reviews.1)) +  
        geom_point(aes
                    (colour = factor
                      (Drug)
                      )
                    )+
      ylab("Reviews")+
      ggtitle("Ease of Use of Drugs based on Reviews")
  })
}
    
graph3 <- function(input) {
  renderPlot({
    filter(UnduplicatedDrug2, Condition == input$Condition) %>%
      ggplot(aes(Satisfaction, Reviews.1)) +
        geom_point(aes
                    ( colour = factor
                      (Drug)
                      )
                    )+
      ylab("Reviews")+
      ggtitle("Satisfaction of Drugs based on Reviews")
                 })
}


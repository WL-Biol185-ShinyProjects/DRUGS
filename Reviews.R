UnduplicatedDrug2 <- read.csv("UnduplicatedDrug2.csv")

Reviews <- tabPanel(
  "Reviews",
  tags$h2("Reviews based on Effectivness, Ease of Use, and Satisfaction of Drugs"),
  
  sidebarPanel(
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
       ylab("Reviews")+
       ggtitle("Effectiveness of Drug based on Reviews")
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
        ggtitle("Ease of Use of Drug based on Reviews")
  })
}
    
graph3 <- function(input) {
  renderPlot({
    filter(UnduplicatedDrug2, Condition == input$Condition) %>%
      ggplot(aes(Satisfaction, Reviews.1)) +
        geom_point(aes
                   (colour = factor
                     (Drug)
                     )
                   )+
        ylab("Reviews")+
        ggtitle("Satisfaction of Drug based on Reviews")
                 })
}


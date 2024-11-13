tab7 <- tabPanel(
  "Reviews",
  tags$h2("Reviews based on Satisfaction, Ease of Use, and Effectiveness"),
  
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
                   )
    
graph2 <- function(input) {
  renderPlot({
    filter(UnduplicatedDrug2, Condition == input$Condition) %>%
      ggplot(aes(EaseOfUse, Reviews.1)) +  
        geom_point(aes
                    (colour = factor
                      (Drug)
                      )
                    )
    
graph3 <- function(input) {
  renderPlot({
    filter(UnduplicatedDrug2, Condition == input$Condition) %>%
      ggplot(aes(Satisfaction, Reviews.1)) +
        geom_point(aes
                    ( colour = factor
                      (Drug)
                      )
                    )
                 })
             }
          })
        }
   })

}

output$graph1 <- graph1(input)
output$graph2 <- graph2(input)
output$graph3 <- graph3(input)


library(shiny)

#Creating tabs for app

server <- function(input, output, session)
 {
  observeEvent(input$add, {
    appendTab(inputId = "tabs",
              tabPanel("Dynamic", 
                       "This a dynamically-added tab")
    )
  })
}
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

})

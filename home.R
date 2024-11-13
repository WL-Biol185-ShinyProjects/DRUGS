library(shiny)
library(dplyr)
home <- tabPanel(
  "Name2",
  tags$h2("Select your medicine"),
  div(class = "content",
      h2("About Us"),
      p("We provide accurate, up-to-date information on a variety of drugs, 
                 their uses, effects, and the latest research."),
      
      div(class = "card",
          h3("Symptoms"),
          p("Explore the various categories of drugs including prescription 
                     medications, over-the-counter drugs, and recreational substances."),
          actionButton("learnMore", "Learn More", class = "btn btn-primary")
      ),
      
      div(class = "card",
          h3("Medical Uses"),
          p("Stay informed with the latest studies and findings on the safety 
                     and efficacy of different drugs."),
          actionButton("research", "Read More", class = "btn btn-primary")
      ),
      
      div(class = "card",
          h3("Cost"),
          p("Have questions? Feel free to reach out to us for more information."),
          actionButton("contact", "Get in Touch", class = "btn btn-primary")
      ),
      
      div(class = "card",
          h3("Alternatives"),
          p("Have questions? Feel free to reach out to us for more information."),
          actionButton("contact_alt", "Get in Touch", class = "btn btn-primary")
      ),
      
      div(class = "card",
          h3("Reviews"),
          p("Have questions? Feel free to reach out to us for more information."),
          actionButton("contact_efficacy", "Get in Touch", class = "btn btn-primary")
      ),
      
      div(class = "card",
          h3("Insert Here"),
          p("Have questions? Feel free to reach out to us for more information."),
          actionButton("contact_prevalence", "Get in Touch", class = "btn btn-primary")
      )
  )
)


#Map Output 

fluidPage(
  titlePanel("Drug Usage Frequency by State"),
  
  # Sidebar layout with dropdown menu for state selection
  sidebarLayout(
    sidebarPanel(
      # Dropdown menu to select a state
      selectInput("state_select", "Select a state:", choices = state.name, selected = "California")
    ),
    mainPanel(
      plotOutput("heatmap")
    )
  )
)



  mainPanel(
            
  )

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
  
  
  server <- function(input, output) {
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
  
  
  
  

  
  
  
  
  
  
  

  
  
  
  


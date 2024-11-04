library(shiny)
library(shinythemes)

  ui <- navbarPage(
  title = "Home",
  theme = shinythemes::shinytheme("sandstone"),
  includeCSS("www/home_page.css"),
  
  # Add a title panel inside the navbar
  tabPanel("Home",
           div(class = "header",
               h1("Welcome to Drug Squad!!!!")
           ),
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
                   h3("Efficacy"),
                   p("Have questions? Feel free to reach out to us for more information."),
                   actionButton("contact_efficacy", "Get in Touch", class = "btn btn-primary")
               ),
               
               div(class = "card",
                   h3("Prevalence"),
                   p("Have questions? Feel free to reach out to us for more information."),
                   actionButton("contact_prevalence", "Get in Touch", class = "btn btn-primary")
               )
           )
  ),
  
  # Define additional tabs for Symptoms, Medical Uses, Cost, Alternatives, Efficacy, Prevalence
  tabPanel("Symptoms",
           tags$h2("Select what medicine treats first then select your medicine"),
           mainPanel()
  ),
  
  tabPanel("Medical Uses",
           tags$h2("What Medical Uses a Medicine Has"),
           mainPanel()
  ),
  
  tabPanel("Cost",
           tags$h2("Select a medicine to compare costs"),
           mainPanel()
  ),
  
  tabPanel("Alternatives",
           tags$h2("Select Medicine to see Alternatives"),
           mainPanel()
  ),
  
  tabPanel("Efficacy",
           tags$h2("Select medicine to see efficacy"),
           mainPanel()
  ),
  
  tabPanel("Prevalence",
           tags$h2("Select Medicine to see prevalence"),
           mainPanel()
  )
)


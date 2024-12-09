library(shiny)
library(dplyr)
home <- tabPanel(
  "Home",
  #creating text for website
  tags$h2("Welcome to Drug Squad!"),
  p(
    "This application offers an interactive platform to explore comprehensive information about pharmaceutical drugs. This app is for the normal everyday patients just like you!! Our interface is very user-friendly, so do not be afraid to head to the app tabs! If you want basic information on symptoms and side effects, we got it! If you want to compare the cost of two drugs, compare the reviews from multiple drugs that treat the same condition, or even compare how two drugs would interact with each other, we’ve got that too!! This app holds many advanced search functionalities in order for you to be able to get the information you need. Our data comes from very reliable sources, including the government database and DrugBank."),
  p(
    "While Drug Squad provides comprehensive and reliable drug information, it is important to remember that this app is designed for informational purposes only. Always consult your doctor or healthcare provider before making any decisions about your medications or treatment. Your doctor knows your medical history best and can provide personalized advice tailored to your needs."),
# Adding image to home
img(src="drugHomeImage.jpeg", height="100%", width="100%", align = "center"),
# creating about us text
  tags$h2("Select your medicine"),
)
  div(class = "content",
      h2("About Us"),
      p("We provide accurate, up-to-date information on a variety of drugs, 
                 their uses, effects, and the latest research."),
# creating info buttons
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
          h3("Prevalence"),
          p("Have questions? Feel free to reach out to us for more information."),
          actionButton("contact_prevalence", "Get in Touch", class = "btn btn-primary")
      )
  )
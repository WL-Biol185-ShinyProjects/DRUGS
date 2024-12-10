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

  tags$h2("Information about what services this website offers"),
  p("Click on the section that you are interested in learning to get information on what the tab will do."),
  
# creating info buttons
  div(class = "card",
          h3("Drug Information Tab"),
          p("The drug information tab allows you to select a drug and learn more about it"),
          actionButton("drugInfoButton", "Learn More", class = "btn btn-primary")
  ),
  div(class = "card",
          h3("Costs Tab"),
          p("The costs tab allows you to select drugs and see how costs have changed over time"),
          actionButton("cost", "Learn More", class = "btn btn-primary")
  ),
      
  div(class = "card",
          h3("Interactions Tab"),
          p("The interactions tab allows you to select multiple drugs and see if there are interactions between them"),
          actionButton("interactions", "Learn More", class = "btn btn-primary")
      ),
  div(class = "card",
          h3("Clinical Trials Tab"),
          p("The clinical trials tab allows you to select a condition and see what clinical trials are being performed for it"),
          actionButton("clinicalTrial", "Learn More", class = "btn btn-primary")
      ),
  div(class = "card",
          h3("Substance Use in the USA Tab"),
          p("The substance use in the USA tab allows you to select a year and substance and see how much it was used in the USA"),
          actionButton("substanceUse", "Learn More", class = "btn btn-primary")
      ),
      
  div(class = "card",
          h3("Reviews Tab"),
          p("The reviews tab allows you to select a drug and see how well reviewed the drug is"),
          actionButton("review", "Learn More", class = "btn btn-primary")
      ),

  div(class = "card",
    h3("Pharmacokinetics Simulation (ADME) Tab"),
    p("The pharmacokinetics simulation (ADME) tab allows you to select different factors about yourself and stimulate how long a drug will stay in your body"),
    actionButton("pharmacoKinetics", "Learn More", class = "btn btn-primary")
  )
  )
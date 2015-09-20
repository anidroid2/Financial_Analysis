library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Cash Query 02 - Available Cash Asset over time period"),
    
    # Sidebar with a slider input for the number of bins
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("Q2")
        )
    
))

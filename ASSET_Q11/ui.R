library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Asset Query 11 - Asset Allocation -Current"),
    
    # Sidebar with a slider input for the number of bins
            # Show a plot of the generated distribution
        mainPanel(
            plotOutput("Q1"),
            tableOutput("df_test")
        )
    )
)

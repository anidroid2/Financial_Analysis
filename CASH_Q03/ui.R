library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Cash Query 03 - Shopping expenses"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("year",
                        "Year:",
                        choices = list("2014" = 2014, "2015" = 2015,
                                       "2016" = 2016), selected = 2015)
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("Q1"),
            dataTableOutput("df_test")
        )
    )
))

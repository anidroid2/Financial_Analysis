library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should be automatically
  #     re-executed when inputs change
  #  2) Its output type is a plot

  
  output$Q2 <- renderPlot({
    
    (ggplot(Asset_C, aes(Asset_C$ValueDate, Asset_C$Total)) +geom_step(direction = "hv"))
  })
  
})

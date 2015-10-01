library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Expression that generates a histogram. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should be automatically
    #     re-executed when inputs change
    #  2) Its output type is a plot
    
    
    output$Q1 <- renderPlot({
        print(ggplot(shop_expense_month_wide[shop_expense_month_wide$Year == input$year,], aes(x=Month,y=shop_expense ,fill=SubID)) + geom_bar(stat="identity"))
    })
})

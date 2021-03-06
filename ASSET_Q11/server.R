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
        pie(pie_slices,pie_label,col=rainbow(length(pie_label))	,main="Asset Allocation -Current")
    })
    output$df_test <- renderTable({asset_df})
})

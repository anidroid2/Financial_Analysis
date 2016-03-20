## app.R ##
library(shinydashboard)

ui <- dashboardPage(
    
    dashboardHeader(title = "Financial Analysis", dropdownMenu(type = "tasks", badgeStatus = "success",
                                                               taskItem(value = 12, color = "green",
                                                                        "Documentation"
                                                               ),
                                                               taskItem(value = 17, color = "aqua",
                                                                        "Project X"
                                                               ),
                                                               taskItem(value = 75, color = "yellow",
                                                                        "Server deployment"
                                                               ),
                                                               taskItem(value = 80, color = "red",
                                                                        "Overall project"
                                                               )
                                                               )
                    ),
   
    ## Sidebar content
    dashboardSidebar(
        sidebarMenu(
            menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
            menuItem("InFlow", tabName = "flow1", icon = icon("bar-chart")),
            menuItem("OutFlow", tabName = "flow2", icon = icon("bar-chart"),
                     menuSubItem("Bills",tabName = "bill"),
                     menuSubItem("Shopping",tabName = "shop")
            ),
            menuItem("Stock",tabName = "sData", icon= icon("dollar"),
                     menuSubItem("Market Watch", tabName = "View1"),
                     menuSubItem("Historic Fund Flow", tabName = "View2")
            )
        )
    ),
    dashboardBody(
        tabItems(
            #DASHBOARD
            tabItem(tabName = "dashboard",
                    fluidRow(
                        infoBoxOutput("Box1", width = 3),
                        infoBoxOutput("Box2", width = 3),
                        infoBoxOutput("Box5", width = 3)
                        
                    ),
                    fluidRow(
                        infoBoxOutput("Box3", width = 3),
                        infoBoxOutput("Box4", width = 3)
                    ),
                    fluidRow(
                        box(plotOutput("plot_pie"))
                        
                    )
            ),
    
            tabItem(tabName = "flow1",
                    fluidRow(
                        box(plotOutput("plot_IN")),
                        box(
                            selectInput("year_IN","Year:", choices = unique(TTadv$year),selected = default_year
                            )
                        )
                    )
            ),
            
            # Second tab content
            tabItem(tabName = "bill",
                    fluidRow(
                        box( plotOutput("plot1")),
                        box(
                            selectInput("year1","Year:", choices = unique(TTadv$year),selected = default_year
                            )
                        )
                )
            ),
            
            tabItem(tabName = "shop",
                    fluidRow(
                        box( plotOutput("plot2")),
                        box(
                            selectInput("year2","Year:", choices = unique(TTadv$year),selected = default_year
                            )
                        )
                    )
            ),
            tabItem(tabName = "View1",
                    fluidRow(
                        box(selectInput("stockin1","Stock",choices = (Scode$Description), selected = "Nifty50"),
                            selectInput("sDur","Plot for: ",choices = Sduration$duration, selected = "2 year")
                        ),
                        plotOutput("sPlot1")
                    )
                    
            ),
            tabItem(tabName = "View2",
                    fluidRow(
                        box(title = "Equity Flow", plotOutput("Eqflow1"))
                    )
                    
            )
            
        )
    )
)

server <- function(input, output) {
    
    output$plot1 <- renderPlot({
        print(ggplot(BL_BYM[BL_BYM$Year == input$year1,], aes(x=Month,y=Bill ,fill=SubID)) + geom_bar(stat="identity", drop= FALSE)+scale_x_discrete(drop=FALSE))
    })
    output$plot2 <- renderPlot({
        print(ggplot(SH_BYM[SH_BYM$Year == input$year2,], aes(x=Month,y=shop_expense ,fill=SubID)) + geom_bar(stat="identity")+scale_x_discrete(drop=FALSE))
    })
    output$Box1 <- renderValueBox({
        valueBox(value = sprintf("%s ₹", KPI_CASH),
                 subtitle = sprintf("Holding Cash"),
                 icon = icon("money"),
                 color = "green"
                )
    })
    output$Box2 <- renderValueBox ({
        valueBox (value = sprintf("%s ₹", KPI_201),
                  subtitle = sprintf("Deposits"),
                  icon = icon("lock"),
                  color = "green"
        )
    })
    output$Box3 <- renderValueBox ({
        valueBox (value = sprintf("%s ₹", KPI_MF),
                  subtitle = sprintf("Mutual Fund Investments"),
                  icon = icon("line-chart"),
                  color = "blue"
        )
    })
    output$Box4 <- renderValueBox ({
        valueBox (value = sprintf("%s ₹", KPI_EQ),
                  subtitle = sprintf("Equity Holding"),
                  icon = icon("line-chart"),
                  color = "blue"
        )
    })
    output$Box5 <- renderValueBox ({
        valueBox (value = sprintf("%s ₹", KPI_CCdue),
                  subtitle = sprintf("Credit Cards Due"),
                  icon = icon("credit-card"),
                  color = "red"
                  )
    })
    
    output$plot_IN <- renderPlot({
        print(ggplot(IN_BYM[IN_BYM$Year == input$year_IN,], aes(x=Month,y=Income )) + geom_bar(stat="identity")+scale_x_discrete(drop=FALSE))
    })
    output$plot_pie <- renderPlot({
        pie(InvestPie,InvestPie_names,main="Asset Allocation -Current")  
    })
    
    output$sPlot1 <- renderPlot({
        chartSeries( list_symbols[[(txtToCode(input$stockin1) )]][paste0(input$sDur,'::')]  ) # , input$sDur) 
    })
    
    output$sPlot2 <- renderPlot({
        candleChart(LT.NS['2015::'],multi.col=TRUE,theme = "white")
    })
    
    output$Eqflow1 <- renderPlot({
        print(ggplot(InvestEQ, aes(x= qtryear, y= Net))+
                  geom_bar(stat="identity",position="identity",aes(fill = inout))+
                  scale_fill_manual(values=c("Out"="firebrick1","In"="steelblue")))
    })
}

shinyApp(ui, server)
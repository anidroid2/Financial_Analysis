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
                     menuSubItem("Shopping",tabName = "shop"),
                     menuSubItem("Event Expenses",tabName = "travel")
            ),
            menuItem("Stock",tabName = "sData", icon= icon("dollar"),
                     menuSubItem("Market Watch", tabName = "View1"),
                     menuSubItem("Historic Fund Flow", tabName = "View2"),
                     menuSubItem("Funds Distribution", tabName = "View3")
            ),
            menuItem("Base TT table", tabName = "bTData"),
            menuItem("Testing!!", tabName = "testMenu")
        )
    ),
    dashboardBody(
        tabItems(
            #TEST TAB
            tabItem(tabName = "testMenu",
              fluidRow(plotOutput("testplot"))  
                
            ),
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
            tabItem(tabName = "travel",
                    tableOutput("t1")
                    ),
            
            
            tabItem(tabName = "View1",
                    fluidRow(
                        box(selectInput("stockin1","Stock",choices = (as.list(select(filter(Scode,Type == "Stock" ),Description))), selected = "Nifty50"),
                            selectInput("sDur","Plot for: ",choices = Sduration$duration, selected = "2 year")
                        ),
                        box(
                            selectInput("cType","Type of Chart",choices = c("Candle Stick w/ ", "Line"), selected = "Line"),
                            checkboxInput("TA","Technical Analysis",FALSE)
                            
                        ),
                        plotOutput("sPlot1")
                    )
                    
            ),
            tabItem(tabName = "View2",
                    fluidRow(
                        box(title = "Stock Equity Flow", plotOutput("Eqflow1"))
                    )
                    
            ),
            tabItem(tabName = "View3",
                    fluidRow(
                        box(title = "Distribution of Equity Holidng across MCaps", plotOutput("Dist1")),
                        box(title = "Distribution of Equity Holidng across Sectors", plotOutput("Dist2"))
                    )
                    
            ),
            
            tabItem(tabName = "bTData",
                    fluidRow(
                        dataTableOutput("BTtable")     
                    )
                    )
            
        )
    )
)

server <- function(input, output) {
    
    output$plot1 <- renderPlot({
        print(ggplot(BL_BYM[BL_BYM$Year == input$year1,], aes(x=Month,y=Bill ,fill=SubID)) + geom_bar(stat="identity")+scale_x_discrete(drop=FALSE))
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
        if(input$cType != "Line" )
            chartSeries( list_symbols[[(txtToCode(input$stockin1) )]][paste0(input$sDur,'::')]  )
        if(input$TA == FALSE)
            chartSeries( list_symbols[[(txtToCode(input$stockin1) )]][paste0(input$sDur,'::'),6],theme = "white")
        else
            chartSeries( list_symbols[[(txtToCode(input$stockin1) )]][paste0(input$sDur,'::'),6],theme = "white" ,TA= "addVo();addRSI();addEMA(25);addEMA(200)")
    })
    
    
    output$Eqflow1 <- renderPlot({
        print(ggplot(InvestEQ, aes(x= qtryear, y= Net))+
                  geom_bar(stat="identity",position="identity",aes(fill = inout))+
                  scale_fill_manual(values=c("Out"="firebrick1","In"="steelblue")))
    })
    output$t1 <- renderTable(TR)
    
    output$BTtable <- renderDataTable(TT) 
    
    output$Dist1 <- renderPlot({MCapDist_byCapPie})
    output$Dist2 <- renderPlot({MCapDist_bySecPie})
    output$testplot <- renderPlot({MCapDist_byCapPie})
}

shinyApp(ui, server)
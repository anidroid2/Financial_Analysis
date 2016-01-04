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
            )
        )
    ),
    dashboardBody(
        tabItems(
            #DASHBOARD
            tabItem(tabName = "dashboard",
                    fluidRow(
                        infoBoxOutput("Box1"),
                        infoBoxOutput("Box2")
                        
                    ),
                    fluidRow(
                        infoBoxOutput("Box3"),
                        infoBoxOutput("Box4")
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
    output$Box1 <- renderInfoBox({
        infoBox("CASH",paste0(KPI_CASH, " Ru"))
    })
    output$Box2 <- renderInfoBox({
        infoBox("Deposits",paste0(KPI_201, " Ru"))
    })
    output$Box3 <- renderInfoBox({
        infoBox("MutualFund",paste0(KPI_MF, " Ru"))
    })
    output$Box4 <- renderInfoBox({
        infoBox("Equity",paste0(KPI_EQ, " Ru"))
    })
    output$plot_IN <- renderPlot({
        print(ggplot(IN_BYM[IN_BYM$Year == input$year_IN,], aes(x=Month,y=Income )) + geom_bar(stat="identity")+scale_x_discrete(drop=FALSE))
    })
    output$plot_pie <- renderPlot({
        pie(InvestPie,InvestPie_names,main="Asset Allocation -Current")  
    })
}

shinyApp(ui, server)
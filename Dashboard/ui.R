sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Widgets", icon = icon("th"), tabName = "widgets",
                 badgeLabel = "new", badgeColor = "green"),
        menuItem("W2", icon = icon("th"), tabName = "widgets",
                 badgeLabel = "new", badgeColor = "green")
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "Dashboard",
                h2("Dashboard tab content")
        ),
        
        tabItem(tabName = "Widgets",
                h2("Widgets tab content")
        ),
        tabItem(tabName = "W2",
                h2("Widgets tab content")
        )        
    )
)

# Put them together into a dashboardPage
dashboardPage(
    dashboardHeader(title = "Simple tabs"),
    sidebar,
    body
)

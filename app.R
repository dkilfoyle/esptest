## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "ESP Test"),
  dashboardSidebar(
    sidebarMenu(
      textInput("ip","IP","192.168.1.74"),
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("OLED", tabName = "oled", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
        fluidRow(
          infoBoxOutput("analogpin")
        )
      ),
      
      # Second tab content
      tabItem(tabName = "oled",
        h2("oled ui here")
      )
    )
  )
)

server <- function(input, output) {

  output$analogpin = renderInfoBox({
    infoBox("Analog Pin 1", 255)
  })
  
}

shinyApp(ui, server)
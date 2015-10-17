## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "ESP Test", dropdownMenuOutput("notificationMenu")),
  dashboardSidebar(
    sidebarMenu(
      sidebarSearchForm(textId = "ip", buttonId = "ipconnect", label = "IP"),
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("OLED", tabName = "oled", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
        fluidRow(
          infoBoxOutput("analogpin"),
          box(title="LED",
            radioButtons("ledradio", "Set", c("On","Off"), selected="Off", inline=T))
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
  
  ip = NULL
  values = reactiveValues(notifications = c())
  
  output$notificationMenu = renderMenu({
    xx = lapply(values$notifications, function(x) { notificationItem(x) })
    
    dropdownMenu(type="notifications", .list=xx)
  })
  
  observeEvent(input$ipconnect, {
    ip = input$ip
    values$notifications = c(values$notifications, paste0("Connected to ",input$ip))
    cat(values$notifications, "\n")

  })

  output$analogpin = renderInfoBox({
    infoBox("Analog Pin 1", 255)
  })
  
}

shinyApp(ui, server)
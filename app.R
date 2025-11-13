# VPS Calculator Shiny App
# This app calculates the cost and specifications for VPS configurations

library(shiny)
library(shinydashboard)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "VPS Calculator"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Calculator", tabName = "calculator", icon = icon("calculator")),
      menuItem("About", tabName = "about", icon = icon("info-circle"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Calculator tab
      tabItem(tabName = "calculator",
        fluidRow(
          box(
            title = "VPS Configuration",
            status = "primary",
            solidHeader = TRUE,
            width = 6,
            
            sliderInput("cpu_cores",
                       "CPU Cores:",
                       min = 1,
                       max = 32,
                       value = 2),
            
            sliderInput("ram_gb",
                       "RAM (GB):",
                       min = 1,
                       max = 128,
                       value = 4,
                       step = 1),
            
            sliderInput("storage_gb",
                       "Storage (GB):",
                       min = 10,
                       max = 1000,
                       value = 50,
                       step = 10),
            
            sliderInput("bandwidth_tb",
                       "Bandwidth (TB):",
                       min = 1,
                       max = 20,
                       value = 2,
                       step = 1),
            
            selectInput("region",
                       "Region:",
                       choices = c("US East", "US West", "Europe", "Asia Pacific"),
                       selected = "US East")
          ),
          
          box(
            title = "Cost Estimation",
            status = "success",
            solidHeader = TRUE,
            width = 6,
            
            h3(textOutput("monthly_cost")),
            h4(textOutput("yearly_cost")),
            
            hr(),
            
            h4("Configuration Summary:"),
            verbatimTextOutput("config_summary")
          )
        ),
        
        fluidRow(
          box(
            title = "Pricing Details",
            status = "info",
            width = 12,
            
            tableOutput("pricing_table")
          )
        )
      ),
      
      # About tab
      tabItem(tabName = "about",
        fluidRow(
          box(
            title = "About VPS Calculator",
            width = 12,
            
            h3("What is this?"),
            p("This VPS Calculator helps you estimate the cost of Virtual Private Server (VPS) configurations based on your resource requirements."),
            
            h3("How to use:"),
            tags$ol(
              tags$li("Adjust the sliders to configure your desired VPS specifications"),
              tags$li("Select your preferred region"),
              tags$li("View the estimated monthly and yearly costs"),
              tags$li("Review the detailed pricing breakdown")
            ),
            
            h3("Pricing Model:"),
            tags$ul(
              tags$li("CPU: $10 per core per month"),
              tags$li("RAM: $5 per GB per month"),
              tags$li("Storage: $0.10 per GB per month"),
              tags$li("Bandwidth: $2 per TB per month"),
              tags$li("Regional pricing multipliers apply")
            )
          )
        )
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Calculate base prices
  calculate_prices <- reactive({
    cpu_cost <- input$cpu_cores * 10
    ram_cost <- input$ram_gb * 5
    storage_cost <- input$storage_gb * 0.10
    bandwidth_cost <- input$bandwidth_tb * 2
    
    # Regional multipliers
    region_multiplier <- switch(input$region,
                               "US East" = 1.0,
                               "US West" = 1.1,
                               "Europe" = 1.15,
                               "Asia Pacific" = 1.2,
                               1.0)
    
    list(
      cpu = cpu_cost,
      ram = ram_cost,
      storage = storage_cost,
      bandwidth = bandwidth_cost,
      subtotal = cpu_cost + ram_cost + storage_cost + bandwidth_cost,
      multiplier = region_multiplier
    )
  })
  
  # Calculate total monthly cost
  monthly_total <- reactive({
    prices <- calculate_prices()
    prices$subtotal * prices$multiplier
  })
  
  # Output monthly cost
  output$monthly_cost <- renderText({
    paste0("Monthly Cost: $", format(round(monthly_total(), 2), nsmall = 2))
  })
  
  # Output yearly cost
  output$yearly_cost <- renderText({
    yearly <- monthly_total() * 12
    paste0("Yearly Cost: $", format(round(yearly, 2), nsmall = 2))
  })
  
  # Configuration summary
  output$config_summary <- renderText({
    paste0(
      "CPU Cores: ", input$cpu_cores, "\n",
      "RAM: ", input$ram_gb, " GB\n",
      "Storage: ", input$storage_gb, " GB\n",
      "Bandwidth: ", input$bandwidth_tb, " TB\n",
      "Region: ", input$region
    )
  })
  
  # Pricing table
  output$pricing_table <- renderTable({
    prices <- calculate_prices()
    
    data.frame(
      Component = c("CPU Cores", "RAM", "Storage", "Bandwidth", "Subtotal", "Regional Multiplier", "Total"),
      Quantity = c(
        paste(input$cpu_cores, "cores"),
        paste(input$ram_gb, "GB"),
        paste(input$storage_gb, "GB"),
        paste(input$bandwidth_tb, "TB"),
        "",
        paste0(prices$multiplier, "x (", input$region, ")"),
        ""
      ),
      Cost = c(
        paste0("$", format(prices$cpu, nsmall = 2)),
        paste0("$", format(prices$ram, nsmall = 2)),
        paste0("$", format(prices$storage, nsmall = 2)),
        paste0("$", format(prices$bandwidth, nsmall = 2)),
        paste0("$", format(prices$subtotal, nsmall = 2)),
        "",
        paste0("$", format(round(monthly_total(), 2), nsmall = 2))
      ),
      stringsAsFactors = FALSE
    )
  })
}

# Run the application
shinyApp(ui = ui, server = server)

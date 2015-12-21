library(shiny)
library(rCharts)

# Define UI 
shinyUI(fluidPage(
  
  titlePanel("Pipeline Incidents in the U.S., January 2010-Present"),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
      h5("Which commodity type would you like to examine?"),
      br(),
      radioButtons(inputId = "commType", 
                   label = "Choose a commodity:", 
                   choices = c("CO2 (CARBON DIOXIDE)",
                               "CRUDE OIL",
                               "HIGHLY VOLATILE LIQUID",
                               "REFINED/PETROLEUM PRODUCT (NON-HVL)",
                               "BIOFUELS"), 
                   selected = "CRUDE OIL"),
      br(),
      helpText("Please hover over the lines to get exact",
               "values. For each commodity you can examine",
               "the number of incidents, amount of product",
               "released in barrels, and the costs of property",
               "damage in dollars. For more infomation on how the",
               "data was collected and how the app works", 
               "please check the ", tags$a(href="http://rpubs.com/Data8021/136107", "project documentation."))
    ),
    
    # Show the plot 
    mainPanel(
      tabsetPanel(
        tabPanel("Number of Incidents", showOutput("plot1", "nvd3")),
        tabPanel("Total Barrels Released", showOutput("plot2", "nvd3")),
        tabPanel("Total Property Damage (USD)", showOutput("plot3", "nvd3"))
      )
    )
  )
))
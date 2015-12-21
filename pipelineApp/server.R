library(shiny)
library(dplyr)
library(lubridate)
library(rCharts)

data <- read.csv("incidentData.csv")
source("incidentData.R")

shinyServer(
  function(input, output) {
    
    # Generate chart2 for the selected commodity
    output$plot1 <- renderChart2({
      selected <- input$commType
      n1 <- nPlot(numIncidents ~ year,
                             data = data[data$commodity == selected,],
                             type = "lineChart")
      n1$chart(margin = list(left = 100), showLegend = FALSE)
      n1$yAxis(axisLabel = "Total Number of Incidents")
      n1$xAxis(axisLabel = "Year")
      n1
    })
    
    output$plot2 <- renderChart2({
      selected <- input$commType
      n2 <- nPlot(totalBarrels ~ year,
                            data = data[data$commodity == selected,],
                            type = "lineChart")
      n2$chart(margin = list(left = 100), showLegend = FALSE)
      n2$yAxis(axisLabel = "Total Barrels of Products Released")
      n2$xAxis(axisLabel = "Year")
      n2
    })
    
    output$plot3 <- renderChart2({
      selected <- input$commType
      n3 <- nPlot(totalPropertyDamage ~ year,
                         data = data[data$commodity == selected,],
                         type = "lineChart")
      n3$chart(margin = list(left = 100))
      n3$yAxis(axisLabel = "Total Property Damage (thousands USD)")
      n3$xAxis(axisLabel = "Year")
      n3
    })
  }
)
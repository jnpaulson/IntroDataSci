# a simple example with rCharts and Shiny
# https://github.com/ramnathv/rCharts
library(shiny)
library(rCharts)
library(gapminder)
library(dplyr)

shinyServer(function(input, output) {
  output$myChart <- renderChart({
    p1 <- gapminder %>%
      filter(year == input$year) %>%
      rPlot("gdpPercap", "lifeExp", data=., type="point")
    p1$addParams(dom = "myChart")
    return(p1)
  })
})

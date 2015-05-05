library(shiny)
library(rCharts)

shinyUI(pageWithSidebar(
  headerPanel("rCharts"),
  sidebarPanel(
    sliderInput(inputId="year",
                label = "Year",
                min = 1952, max = 2007,
                value = 1987, sep="", step=5)),
  mainPanel(
    showOutput("myChart", "polycharts")
  )
))

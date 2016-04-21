library(shiny)
library(UsingR)
library(dplyr)
library(ggplot2)

source("qsim.R")
source("runsim.R")
source("plotsim.R")
source("help.R")


shinyServer(
    function(input, output) {
        output$SimPlot <- renderPlot({
            runsim(input$arr.rate, input$n.serv, input$svc.mean, input$svc.sd)
        })
        output$gethelp <- renderText({gethelp()})
        
    }
)

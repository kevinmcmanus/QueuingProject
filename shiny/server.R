library(shiny)
library(UsingR)
data(galton)

shinyServer(
    function(input, output) {
        output$SimPlot <- renderPlot({
            runsim(input$arr.rate, input$n.serv, input$svc.mean, input$svc.sd)
        })
        
    }
)

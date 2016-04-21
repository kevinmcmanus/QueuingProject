library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("100 Customer Simulation"),
    sidebarPanel(
        sliderInput('arr.rate', 'Customer arrival rate per hour',value = 7, min = 4, max = 30, step = 1),
        sliderInput('n.serv', 'Number of servers',value = 2, min = 1, max = 10, step = 1),
        sliderInput('svc.mean', 'Mean Service Time in minutes',value = 5, min = 2, max = 40, step = 2),
        sliderInput('svc.sd', 'Service Time stddev in minutes',value = 2, min = 0.5, max = 7, step = 0.5)
        
    ),
#    mainPanel(
#        plotOutput('SimPlot')
        mainPanel(
            tabsetPanel(
                tabPanel("Simulator", plotOutput("SimPlot")), 
                tabPanel("Help", verbatimTextOutput("gethelp"))
            )
    )
))

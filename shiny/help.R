gethelp <- function(){
    paste("*** Help for Waiting Queue Simulator ***",
            "\n\n\n",
          "This application simulates the arrival of 100 customers at a service station. ",
          "It computes the average waiting time throughout the simulation and the average server utilization",
          "\n\n\n",
          "\nText in blue on upper left of plot shows input parameters",
          "\nText in red on upper right of plot shows summary output measures",
          "\n\n",
          "\nUsage:",
          "\n------",
          "\n\n",
          "\nUse the sliders in the left navigation pane to vary the four input parameters:",
          "\n\tCustomer Arrival Rate (customers per hour)",
          "\n\tNumber of servers",
          "\n\tMean Customer Service Time",
          "\n\tService Time Standard Deviation",
          "\n\n\n",
          "\nExample usage:",
          "\n------- ------",
          "\n\n\n",
          "\nIncrease the customer arrival rate and the mean customer service time.",
          "Observe the imapct on the average customer waiting time.",
          "\nNow increase the number of servers until the waiting time gets down to an acceptable value"
          

    )
}
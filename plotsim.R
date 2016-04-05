plotsim <- function(sim){
    ggplot(aes(x=t, y=q), data=sim$q)+
        geom_line(size=1, color = "black")+
        geom_vline(xintercept = sim$last.cust.arr,size=2, color="red")+
        labs(x="Time",y="Queue Length")
}
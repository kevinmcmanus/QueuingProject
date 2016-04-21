library(ggplot2)

plotsim <- function(sim){
    outstr=paste("Average Waiting Time: ", round(sim$avg.waiting.time*60,2), " minutes",
                 "\nAverage Server Utilization: ", round(sim$svr.busy.pct*100,2),"%",sep="")
    instr=paste("Customer Arrival Rate: ", sim$inputs$arr.rate," per hour",
                "\nNumber of Servers: ", sim$inputs$n.server,
                "\nMean Service Time: ", sim$inputs$svc.mean, " minutes",
                "\nService Time stddev: ", sim$inputs$svc.sd, " minutes", sep="")
    ggplot(aes(x=t, y=q), data=sim$q)+
        geom_line(size=1, color = "black")+
        geom_segment(aes(x=sim$last.cust.arr,xend=sim$last.cust.arr, y=0,yend=max(sim$q$q)*1.3),size=2,color="red")+
        scale_y_continuous(limits = c(0,max(sim$q$q)*2))+
        labs(x="Time (Hours)",y="Queue Length", title = "Queue Length at Time t")+
        annotate("text",x=sim$last.cust.arr,y=max(sim$q$q)*1.31, vjust=0,label="Last Arrival",color="red")+
        annotate("text", hjust=0, vjust=1, x=0, y=max(sim$q$q)*2,label=instr, color="blue")+
        annotate("text", hjust=1, vjust=1, x=max(sim$q$t), y=max(sim$q$q)*2,label=outstr, color="red")
}
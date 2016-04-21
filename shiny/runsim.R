runsim <- function(arr.rate, n.server, svc.mean, svc.sd){
    s=qsim(arr.rate, n.server, svc.mean, svc.sd)
    plotsim(s)
}
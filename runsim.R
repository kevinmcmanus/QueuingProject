runsim <- function(arr.rate, svc.mean, svc.sd){
    s=qsim(arr.rate, svc.mean, svc.sd)
    plotsim(s)
}
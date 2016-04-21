library(dplyr)

#poisson arrivals with mean lambda => interarrival time is exponential with rate = lambda
qsim = function(arr.rate=10, #arrival rate in customers per hour
                n.server=3,  #number of servers
                svc.mean=3,  #service time mean in minutes
                svc.sd=0.5){ #service time stddev in minutes
    

ncust = 100 #simulate for 100 customers
lambda = arr.rate # arrivals per hour

service.mean = svc.mean/60 # 3 minutes mean service time in hours
service.sd = svc.sd/60

df=data.frame(cust.id = 1:ncust,
    inter.arrival = rexp(ncust, rate = lambda)) #time in hours from when the previous customer arrived

df = mutate(df, arrival.time = cumsum(inter.arrival),
                service.time = max(0,rnorm(ncust, mean = service.mean, sd = service.sd)))

starttime = rep(NA, ncust) #when the i-th customer begins receiving service
finishtime = rep(NA, ncust) #when the i-th customer is finished being serviced
serv.avail = rep(0, n.server) #time when the j-th server finishes service and becomes available

for (i in 1:ncust){
    #find earliest available server
    which.serv = which(serv.avail == min(serv.avail))[1]
    
    #service for the i-th cusotmer starts at the later of when customer arrives and when server is available
    starttime[i] = max(df$arrival.time[i],serv.avail[which.serv])
    finishtime[i] = serv.avail[which.serv] = starttime[i]+df$service.time[i]
}

df = mutate(df,
            start.time = starttime,
            finish.time = finishtime,
            waiting.time = start.time - arrival.time,
            total.time = finish.time - arrival.time)

#compute the queue length at each arrival and each finish event
t=c(df$arrival.time,df$finish.time)
nevents = length(t)
qlength = rep(NA, nevents)

for (i in 1:nevents) {
    # number of customers who've arrived by this time
    n.arr = sum(df$arrival.time<=t[i])
    
    #number of customers who've finished by this time
    n.fin = sum(df$finish.time <= t[i])
    
    #queue length is number of customer who've arrived but not yet finished
    qlength[i] = n.arr-n.fin
}

inputs=list(arr.rate=arr.rate,
            n.server=n.server,
            svc.mean=svc.mean,
            svc.sd=svc.sd)

list(inputs = inputs,
     avg.waiting.time = mean(df$waiting.time),
     svr.busy.pct = sum(df$service.time)/(n.server*max(df$finish.time)),
     last.cust.arr = max(df$arrival.time),
     q=data.frame(t = t, q=qlength))
}
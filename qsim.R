library(dplyr)

#poisson arrivals with mean lambda => interarrival time is exponential with rate = lambda
qsim = function(arr.rate=10, #arrival rate in customers per hour
                svc.mean=3,  #service time mean in minutes
                svc.sd=0.5){ #service time stddev in minutes
    

ncust = 60
lambda = arr.rate # arrivals per hour

service.mean = svc.mean/60 # 3 minutes mean service time in hours
service.sd = svc.sd/60

df=data.frame(cust.id = 1:ncust,
    inter.arrival = rexp(ncust, rate = lambda)) #time in hours from when the last customer arrived

df = mutate(df, arrival.time = cumsum(inter.arrival),
                service.time = max(0,rnorm(ncust, mean = service.mean, sd = service.sd)))

starttime = rep(NA, ncust)
finishtime = rep(NA, ncust)

for (i in 1:ncust){
    starttime[i] = max(df$arrival.time[i],ifelse(i==1,0,finishtime[i-1]))
    finishtime[i] = starttime[i]+df$service.time[i]
}

df = mutate(df, start.time = starttime,
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

list(avg.waiting.time = mean(df$waiting.time),
     svr.busy.pct = sum(df$service.time)/max(df$finish.time),
     last.cust.arr = max(df$arrival.time),
     q=data.frame(t = t, q=qlength))
}
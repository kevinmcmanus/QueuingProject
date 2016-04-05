library(manipulate)

manipulate(runsim(arr.rate,svc.mean,svc.sd),
           arr.rate = slider(5,20,step=1),
           svc.mean = slider(2,8, step=0.5),
           svc.sd = slider(0.25,3, step=0.25))

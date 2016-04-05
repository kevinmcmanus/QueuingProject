library(manipulate)

manipulate(runsim(arr.rate,n.server,svc.mean,svc.sd),
           arr.rate = slider(5,20,step=1),
           n.server = slider(1,8, step =1),
           svc.mean = slider(2,30, step=2),
           svc.sd = slider(0.25,5.25, step=0.5))

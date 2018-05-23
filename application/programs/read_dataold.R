
data=read.csv(file="programs/bdata.csv")
n=length(unique(data$ID))
Mi=Ki=hh=ht=rep(0,n)
max_recurrent_times=4
nX=delta=matrix(NA,n,max_recurrent_times)
Z=matrix(NA,n,3)
W=matrix(NA,n,4)
attach(data)
t_index=0
z1id0=which(Trt==1)
z1id1=which(Trt==2)
data[z1id0,7]=0
data[z1id1,7]=1

for(i in 1:n){
   times_index=0
   censored_index=1
   cumsum_T=0
   Ki[i]=0
   Z[i,]=as.matrix(data[max(which(ID==i)),c(7,9,10)])
   W[i,]=c(1,as.matrix(data[max(which(ID==i)),c(7,9,10)]))
   for(j in min(which(ID==i)):max(which(ID==i))){
      times_index=times_index+1
      if(Status[j]==1){
         Ki[i]=Ki[i]+1
         nX[i,times_index]=data[j,2+times_index]-TStart[j]
         delta[i,times_index]=Status[j]
      }
      else{
         if(censored_index==1){
            censored_index=0
            Ki[i]=Ki[i]+1
            if(j==1){
               nX[i,times_index]=Time[j]-data[j,1+times_index]
               delta[i,times_index]=Status[j]   
            }
         }
      }
   }

}
#nX=nX/12
Ki[Ki==0]=1
Wij=array(NA,c(n,4,n))
for(i in 1:n){
   Wij[,,i]=W
}  
T_telta=nX
Order=order(T_telta)
tt1=T_telta[Order]
delta_tt=delta[Order]
tt=tt1[-which(1*is.na(tt1)==1)]
delta_tt=delta_tt[-which(1*is.na(tt1)==1)]  
nX=T_telta
odelta=delta
delta=delta_tt
L.fn=function(x) exp(x)/(1+exp(x))
L.bn=function(x) 1/(1+exp(x))
Lambda.fn=function(x) G.fn(exp(x))


   
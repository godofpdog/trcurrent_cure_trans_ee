 

##  mixure cured recurrent model (semi-transformation models) generate  ## 

   beta=sbeta
   gamma=sgamma
   #thetaC1=sthetaC1
   #thetaC2=sthetaC2
   thetaC=sthetaC
   z1=sample(1:4,n,TRUE,c(.25,.25,.25,.25))
   z2=rbinom(n,1,.5)
   z3=rbinom(n,1,.5)
   w1=rep(1,n)
   w2=sample(0:1,n,TRUE,c(0.5,0.5))
   w2=rnorm(n)
   #w2=runif(n,0,1)
   Z=matrix(c(z1,z2),n,2)
   W=matrix(c(w1,w2),n,2)
   bz=Z%*%beta
   Wij=array(NA,c(n,2,n))  
   Wij[,,1]=W
   Tij=T_telta=matrix(NA,n,n)   
   Mi=Ki=Ci=delta=NULL
   cure_recurrent_count=nocure_recurrent_count=NULL
   cure_re_times=nocure_re_times=0
   delta=matrix(NA,n,n)
   for(i in 2:n){
      ww=runif(n)/5
      w2=w2+ww
      W=matrix(c(w1,w2),n,2)
      Wij[,,i]=W
   }
   i=1
   id_regen=0   
   #for(i in 1:n){
   while(i<=n){
      j=0
      ttj=0
      ttt=NULL
      cure_ind=0
      cure_index=0
      cure_count=0
      #c=runif(1,thetaC1,thetaC2)
      c=rexp(1,1/thetaC)
      u_T_telta=runif(1)
      repeat{
         if(j>max_j){
            id_regen=1
            p=0.5
         }
         if(id_regen==1) break
         j=j+1
         ttj=ttj+1
         p=exp(Wij[i,,j]%*%gamma)/(1+exp(Wij[i,,j]%*%gamma))
         u=runif(1)
         if(u>=p){
            cure_re_times=cure_re_times+1
            T_telta[i,j]=99999
            cure_index=1
            cure_recurrent_count[cure_re_times]=j
         }
         else{
            t=R.in(G.in(-log(1-u_T_telta))/exp(bz[i])) 
            Tij[i,j]=T_telta[i,j]=t
            delta[i,j]=1*(t<=c)
            ttt[ttj]=t
            u=runif(1)
            cor_beta=cor_alpha/(1+cor_alpha)
            u_T_telta=((u_T_telta**(-cor_alpha))*(u**(-cor_beta))+1-u_T_telta**(-cor_alpha))**(-1/cor_alpha)
         } 
         cumsum_T=sum(T_telta[i,1:j])
         if(cumsum_T>=c){
            T_telta[i,j]=ifelse(j!=1,NA,c)
            delta[i,j]=ifelse(j!=1,NA,0)
            Tij[i,j]=NA
            ttt=ttt[-ttj]
            if(cure_index==0){
               nocure_re_times=nocure_re_times+1
               nocure_recurrent_count[nocure_re_times]=j 
            }
         }
         if(cumsum_T>=c) break
      } 
      Ki[i]=max(1,j-1)
      Ci[i]=c
      Mi[i]=j
      i=i+1
   }

   if(id_regen==0){

   cure_rate=cure_re_times/n
   nn=length(sort(T_telta))
   mean_re=mean(Ki)
   mean_re_cure=mean(cure_recurrent_count)
   mean_re_nocure=mean(nocure_recurrent_count)
   cat("the average number of recurrents is :",mean_re,"\n")
   cat("the cure rate is :",cure_rate,"\n")
   Order=order(T_telta)
   tt1=T_telta[Order]
   delta_tt=delta[Order]
   tt=tt1[-which(1*is.na(tt1)==1)]
   delta_tt=delta_tt[-which(1*is.na(tt1)==1)]  
   nX=T_telta
   L.fn=function(x) exp(x)/(1+exp(x))
   L.bn=function(x) 1/(1+exp(x))
   Lambda.fn=function(x) G.fn(exp(x))

   }
  
   if(id_regen==1){
      cat("re-generate the data because j is more over j_max","\n")
      source(file.path("programs/data_gen.r"))
   }




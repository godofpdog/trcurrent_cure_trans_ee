

## main program ##

source(file.path("programs/models.r"))
source(file.path("programs/space.r"))
source(file.path("programs/EE.r"))

R=1

while(R<=REP){
   cat("replication : ",R,"\n")
   iter_rep=data.frame(iter=R)
   write.table(iter_rep,file.path("output/replications.txt"),quote=F)
   source(file.path("programs/data_gen.r"))
   MRE[R]=mean_re
   MRE_cure[R]=mean_re_cure
   MRE_non_cure[R]=mean_re_nocure
   cure_rate_set[R]=mean(cure_rate)
   ht=NULL
   iter=0
   hh=log(R.fn(tt))
   repeat{
      iter=iter+1
      #dL=exp(hh)
      #dL=dL/sum(dL*exp(-cumsum(dL)))
      #hh=log(dL)
      ht[1]=nleqslv(x=hh[1],ee_ht1.fn)$x
      for(k in 2:length(tt)){
         if(delta_tt[k]==1){
            ht[k]=nleqslv(x=hh[k],ee_ht.fn)$x
         }
         else{
            ht[k]=ht[k-1]
         }
      }
      hh=ht
      tmp_beta=nleqslv(x=beta,ee_beta.fn)$x
      db=max(abs(tmp_beta-beta))
      beta=tmp_beta
      #cat("beta = ",beta,"\n")
      #if(db<=1e-2) break
      tmp_gamma=nleqslv(x=gamma,ee_gamma.fn)$x
      dg=max(abs(tmp_gamma-gamma))
      gamma=tmp_gamma
      #if(db<=1e-2&&dg<=1e-2) break
      if(db<=1e-2) break
      #cat("gamma = ",gamma,"\n\n")
   }
   cat("beta = ",beta,"\n")
   cat("gamma = ",gamma,"\n")
   B[R,]=beta
   G[R,]=gamma
   result_tmp=data.frame(beta1=B[,1],beta2=B[,2],gama1=G[,1],gamma2=G[,2])
   write.table(result_tmp,file.path("output/result_tmp.txt"),quote=F)
   R=R+1
}

if(R==(REP+1)) source(file.path("programs/result.r"))
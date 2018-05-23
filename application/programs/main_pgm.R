   source(file.path("programs/models.r"))
   source(file.path("programs/EE.r"))
   source(file.path("programs/read_data.r"))

   hh=log(R.fn(tt+0.01))
   beta=sbeta
   gamma=sgamma
   iter=0
   hh[hh<0]=min(hh[hh>0])
  
   repeat{
      iter=iter+1
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
      cat("beta = ",beta,"\n")
      tmp_gamma=nleqslv(x=gamma,ee_gamma.fn)$x
      dg=max(abs(tmp_gamma-gamma))
      gamma=tmp_gamma
      cat("gamma = ",gamma,"\n")
      cat(db,dg,"\n\n")
      if(db<=1e-3&&dg<=1e-3) break
      #if(db<=1e-2) break

   }
   detach(data)
   cat("beta = ",beta,"\n")
   cat("gamma = ",gamma,"\n")
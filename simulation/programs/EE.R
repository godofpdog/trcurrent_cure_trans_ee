

##  estimating equations for recurrent cure model ##

   ee_ht1.fn=function(x){
      bz=Z%*%beta
      tmpi1=tmpi2=tmpi3=NULL
      for(i in 1:n){
         tmpj1=tmpj2=tmpj3=rep(NA,Ki[i])
         for(j in 1:Ki[i]){
            Y=1*(nX[i,j]>=tt[1])
            tmpj1[j]=Y*log(L.fn(Lambda.fn(x+bz[i])-Wij[i,,j]%*%gamma))
            tmpj2[j]=1*(nX[i,j]==tt[1])*delta[i]
            tmpj3[j]=Y*log(L.fn(-Wij[i,,j]%*%gamma))
         }
         tmpi1[i]=sum(tmpj1)/Ki[i]
         tmpi2[i]=sum(tmpj2)/Ki[i]
         tmpi3[i]=sum(tmpj3)/Ki[i]
      }
      return(sum(tmpi1)-sum(tmpi2)-sum(tmpi3))   
   }

   ee_ht.fn=function(x){
      tmpi1=tmpi2=tmpi3=NULL
      bz=Z%*%beta
      for(i in 1:n){
         tmpj1=tmpj2=tmpj3=rep(NA,Ki[i])
         for(j in 1:Ki[i]){
            Y=1*(nX[i,j]>=tt[k])
            tmpj1[j]=Y*log(L.fn(Lambda.fn(x+bz[i])-Wij[i,,j]%*%gamma))
            tmpj2[j]=(1*(nX[i,j]==tt[k]))*delta[i]
            tmpj3[j]=Y*log(L.fn(Lambda.fn(ht[k-1]+bz[i])-Wij[i,,j]%*%gamma))
         }
         tmpi1[i]=sum(tmpj1)/Ki[i]
         tmpi2[i]=sum(tmpj2)/Ki[i]
         tmpi3[i]=sum(tmpj3)/Ki[i]
      }
      return(sum(tmpi1)-sum(tmpi2)-sum(tmpi3))   
   }

   ee_beta.fn=function(x){
      bz=Z%*%x
      length_beta=length(x)
      tmpi=matrix(NA,n,length_beta)
      for(i in 1:n){
         tmpj=matrix(NA,Ki[i],length_beta)         
         for(j in 1:Ki[i]){
            cnt=which(nX[i,j]==tt)
            tmpj[j,]=c(Z[i,])*c(delta[i]*1*(nX[i,j]<=tt[length(tt)])-log(L.fn(Lambda.fn(ht[cnt]+bz[i])-Wij[i,,j]%*%gamma))+log(L.fn(-Wij[i,,j]%*%gamma)))
         }
         tmpi[i,]=colSums(tmpj)/Ki[i]
      }
      return(colSums(tmpi))
   }

   ee_gamma.fn=function(x){
      bz=Z%*%beta
      length_gamma=length(x)
      tmpi=matrix(NA,n,length_gamma)
      for(i in 1:n){
         tmpj=matrix(NA,Ki[i],length_gamma)
         for(j in 1:Ki[i]){                     
            cnt=which(nX[i,j]==tt)
            tmpj[j,]=c(Wij[i,,j])*c(delta[i]+(1-delta[i])*L.bn(Lambda.fn(ht[cnt]+bz[i])-Wij[i,,j]%*%gamma)-(L.fn(Wij[i,,j]%*%x)))          
         }
         tmpi[i,]=colSums(tmpj)/Ki[i]
      }
      return(colSums(tmpi))
   }

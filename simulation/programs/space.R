

## space ##

length_beta=length(sbeta)
length_gamma=length(sgamma)
B=matrix(NA,REP,length_beta)    
G=matrix(NA,REP,length_gamma)
MRE=rep(NA,REP) #average recurrent times
MRE_cure=MRE_non_cure=rep(NA,REP)
cure_id_recurrent_number=matrix(NA,n,2)
cure_rate_set=rep(NA,REP)

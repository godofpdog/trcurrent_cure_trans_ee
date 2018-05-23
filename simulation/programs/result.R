





##  result  ##

mean_beta1=mean(B[,1])
mean_beta2=mean(B[,2])
bias_beta1=mean_beta1-sbeta[1]
bias_beta2=mean_beta2-sbeta[2]
sd_beta1=sd(B[,1])
sd_beta2=sd(B[,2])
rb1=(bias_beta1^2+sd_beta1^2)^0.5
rb2=(bias_beta2^2+sd_beta2^2)^0.5
mean_gamma1=mean(G[,1])
mean_gamma2=mean(G[,2])
bias_gamma1=mean_gamma1-sgamma[1]
bias_gamma2=mean_gamma2-sgamma[2]
sd_gamma1=sd(G[,1])
sd_gamma2=sd(G[,2])
rg1=(bias_gamma1^2+sd_gamma1^2)^0.5
rg2=(bias_gamma2^2+sd_gamma2^2)^0.5

b1=c(mean_beta1,bias_beta1,sd_beta1,rb1)
b2=c(mean_beta2,bias_beta2,sd_beta2,rb2)
g1=c(mean_gamma1,bias_gamma1,sd_gamma1,rg1)
g2=c(mean_gamma2,bias_gamma2,sd_gamma2,rg2)

cat("\n\n","## summary ##","\n\n")
cat("the marginal model of gap time is ",model,"\n")
cat("the sample size is : ",n,"\n")
cat("the average number of recurrents is : ",mean(MRE),"\n")
cat("the average recurrent times of the cure cases is :",mean(MRE_cure),"\n")
cat("the average recurrent times of the non-cure cases is :",mean(MRE_non_cure),"\n")
cat("the average cure rate is :",mean(cure_rate_set),"\n\n")
summary=matrix(c(b1,b2,g1,g2),4,4)
rownames(summary)=c("mean","bias","sd","rmse")
colnames(summary)=c("beta1","beta2","gamma1","gamm2")
print(summary)
write.table(summary,file.path("output/summary.txt"),quote=F)

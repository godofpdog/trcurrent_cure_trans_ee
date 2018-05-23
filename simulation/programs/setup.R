


source(file.path("programs/models.r"))
source(file.path("programs/space.r"))

for(R in 1:1000){

   source(file.path("programs/data_gen.r"))
   MRE[R]=mean_re
   MRE_cure[R]=mean_re_cure
   MRE_non_cure[R]=mean_re_nocure
   cure_rate_set[R]=mean(cure_rate)

}


cat("\n\n\n","the average number of recurrents is : ",mean(MRE),"\n")
cat("the average recurrent times of the cure cases is :",mean(MRE_cure),"\n")
cat("the average recurrent times of the non-cure cases is :",mean(MRE_non_cure),"\n")
cat("the average cure rate is :",mean(cure_rate_set))
   
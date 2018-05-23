rm(list = ls())
library(nleqslv)

setwd("/Users/liuyi/survival/recurrent_cure_application")


sbeta=c(0,0,0)
sgamma=c(0,0,0,0)

rho=1
md="log trans"
R.fn=function(x) x^.5


source(file.path("programs/main_pgm.r"))
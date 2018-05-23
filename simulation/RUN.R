##############################################
# Marginal Regression of Recurrent Gap Times #
#                 Base on                    #
# Semiparamatric transformation cure model   #
##############################################

rm(list = ls())
library(nleqslv)

## setting working directory

setwd("/Users/liuyi/survival/recurrent_cure_trans_ee")

## setting parameters

n=100
REP=3
sbeta=c(1,1)
sgamma=c(1,1)
sthetaC=0.2
cor_alpha=0.8
rho=0
max_j=n-1

## inverse of baseline hazard

R.in=function(x) x^2*10
R.fn=function(x) (x/10)^0.5

## model selection ("ph","prop odds","log trans","Box Cox")

md="ph"

## main pgm

options(digits=4)

source(file.path("programs/main_pgm.r"))




##############################################
# Marginal Regression of Recurrent Gap Times #
#                 Base on                    #
# Semiparamatric transformation cure model   #
##############################################

rm(list = ls())
#library(nleqslv)

## setting working directory

setwd("F:\\simulation_recurrent_cure\\test\\recurrent_cure_trans")

## setting parameters

n=100
REP=50
sbeta=c(1,1)
sgamma=c(1,1)
sthetaC=30
cor_alpha=0.8
rho=0
max_j=30

## inverse of baseline hazard

R.in=function(x) 50*x

## model selection ("ph","prop odds","log trans","Box Cox")

md="ph"

## main pgm

options(digits=4)

source(file.path("programs/setup.r"))
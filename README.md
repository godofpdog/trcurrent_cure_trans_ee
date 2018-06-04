# trcurrent_cure_trans_ee

## recurrent cure model
* consider events could occur several times, want to build model on each gap time to predict the probbability of event occur.
* when the event occur like heart attack, the patient will go to hospital and receive treatment. There is chance to be 'cure', which means the disease will not happend again.

## semiparametric transformation models
* Cox proportion hazard model is the most popular semiparametric model in survival area, but the proportion hazard assumption can be violated in some situations.
* We can treat the semiparametric transformation model as a generalized Cox ph model.
* In application, we just find a good transformation model to fit the data by some metrics just like tuning hyper-parameters in machine learning area.

## the API
* simulation 
* application

## simulation : 
Simulation is the way to find out the performance of entire algorithm on different situations. Generating data by a known parameters of model, we can get some metrics like 'rmse' of the estimation of weights in the model (see '/simulation/output/summary.txt'). That is, we controll the situations by setting parameters then evaluate the algorithm's performane and decide whether to use this method.

*RUN.r* : run the algorithm by setup some params.
* n : sample size of the simulation
* REP : replication of whole simulation.
* sbeta : initial values of beta related to the gap time distribution.
* sgamma : initial values of gamma related to the cure rate.
* sthetaC : parameter to control censored rate.
* cor_alpha : parmeter to control the correlationship level of each gap time of one individual.
* rho : the parameter of transformation model. (log trans, BoxCox trans)
* max_j : set the max limit number of recurrent times for each individual.
* R.fn : baseline hazerd related to the gap time distribution.
* R.in : inverse function of baseline hazerd.
* md : model of the gap time.
*continue.R* : continue the programs if it shutdown.
*setup* help us to find the params to generate the data of wanted situation.

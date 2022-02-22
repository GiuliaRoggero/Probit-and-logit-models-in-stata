clear all 
set more off


global datadir "C:\Users\giuli\OneDrive\Desktop\Stata_exercises_applied_microeconometrics\Stataeconometrics\Probit and Logit models in stata"

*data of working women
use "$datadir/MROZ.dta", clear

describe inlf nwifeinc educ exper age kidslt6
summarize inlf nwifeinc educ exper age kidslt6
list inlf nwifeinc educ exper age kidslt6 in 1/10

*inlf= 1 if it's in the labour force, 0 if it's not
tabulate inlf

*linear probability model 
reg inlf nwifeinc educ exper age kidslt6


*probit model
probit inlf nwifeinc educ exper age kidslt6
*interpretation more educated people will be more likely to be in the labour force and older people are going to be less likely in the labour force. people that have more children less likely to be in the labour force. WE USE THE WORDS LESS LIKELY OR MORE LIKELY. we do not interpret the magnitude of the coefficients we only use more likely or less likely 

*logit regression or the logistic regression 
logit inlf nwifeinc educ exper age kidslt6
*the logit coefficients are always 1.6 times higher than the probit model
*interpretation: if women have higher education they are more likely to be in the labour force and if they have more years of experience they are more likely to be in the labour force. we cannot interpret the magnitude of the coeddificent


*PREDICTED PROBABILITIES
*predicted probabilities for LPM
quietly reg inlf nwifeinc educ exper age kidslt6
predict inlf_hat_lpm,xb

*predicted probabilities for probit models
quietly probit inlf nwifeinc educ exper age kidslt6
predict inlf_hat_probit, pr

*predicted probabilities for logit model
quietly logit inlf nwifeinc educ exper age kidslt6
predict inlf_hat_logit, pr

summarize inlf inlf_hat_lpm inlf_hat_logit inlf_hat_probit



*marginal effects;because the coefficients cannot be interpreted in magnitude we want to calculate the marginal effects

reg inlf nwifeinc educ exper age kidslt6
*coefficients are marginal effects in a linear model

*probit models

probit inlf nwifeinc educ exper age kidslt6

*marginal effect at the mean.
margins, dydx(*) atmeans
*we can interpret the magnitude, example foreach additional year of education women are 5.01 more likely to be in the labour force.
*one drawback of the marginal effect at the mean is that they are calculated at the mean value of each of the dependent variable.


*average marginal effects: calcualte marginal effect for each observation and then calculate the average
margins, dydx(*) 
*this makes more sense: the interpretation is the same! 


*logit model
logit inlf nwifeinc educ exper age kidslt6

margins, dydx(*) atmeans


margins, dydx(*)


*pseudo R-squared

*probit model - unrestricted model with all variables
probit inlf nwifeinc educ exper age kidslt6

*display R-squared
display e(r2_p)

display e(ll)
gen LLur=e(ll)


*probit model with only constants
probit inlf

display e(ll)
gen LL0=e(ll)

*calculate Rsquared pseudo

gen pseudo_r2=1-LLur/LL0
display pseudo_r2
*it's the same!
*higher pseudo rsquared is better,obviously.
*it's the gooness of fit.

*percent correctly predicted

*percent correclty predicted for probit model 

quietly probit inlf nwifeinc educ exper age kidslt6
estat classification

*percent correclty predicted for logit models
quietly logit inlf nwifeinc educ exper age kidslt6
estat classification





























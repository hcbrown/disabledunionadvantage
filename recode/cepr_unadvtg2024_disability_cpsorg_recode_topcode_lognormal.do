set more 1

/*
File:	cepr_unadvtg2024_disability_cpsorg_recode_topcode_lognormal.do
Date:	July 2024
Desc:	Estimates mean above the topcode for weekly earnings
        using the lognormal distribution - adjusted to use EPI variables
*/

/* topcode by year & minsamp */

if 2016<=year & year<=2022 {
global topcode=2884 /* topcode is $2,884.61 per week for 2016–2022 */
}
if year==2023 & minsamp==8 {
global topcode=2884 /* topcode is $2,884.61 per week for 2023 minsamp==8 */
}
if year==2023 & minsamp==4 & month==4 {
global topcode=9646 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==5 {
global topcode=10792 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==6 {
global topcode=6891 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==7 {
global topcode=9088 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==8 {
global topcode=9189 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==9 {
global topcode=9356 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==10 {
global topcode=7717 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==11 {
global topcode=8390 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}
if year==2023 & minsamp==4 & month==12 {
global topcode=8608 /* max topcode is $10,792.40 per week for 2023 minsamp==4... 
...but it actually varies dynamically by month from April 2023 onward */
}


global T=ln($topcode) /* to simplify calculation below */
/* mark observations with topcoded weekly earnings */

gen byte tc=0 if lfstat==1 & selfemp==0 & weekpay_noadj~=9999.99 & paidhre==0
replace tc=1 if lfstat==1 & selfemp==0  & paidhre==0 /*
*/ & $topcode<=weekpay_noadj & weekpay_noadj~=. & weekpay_noadj~=9999.99
replace tc=1 if weekpay_noadj_tcid==1
lab var tc "Weekly earnings topcoded"
notes tc: Weekly earnings topcode is $2884.61, except 2023 minsamp 4, when it varies by month
notes tc: see coding for weekpay_noadj_tcid for monthly topcodes for minsamp 4 from April 2023 onward
 /*
*/ 
 /*
*/ 

/* Description of procedure for estimating mean above topcode 

   Step 1: estimate mean, s.d. of uncensored distribution 
 
If
1. y*~N[mu,sigma^2] (uncensored distribution)
2. y=a if a<=y* 
3. y=y* if y*<a
then 
1. E[y]=(1-PHI)*a + PHI*(mu + sigma*lamda)
2. Var[y]=sigma^2 * (1-PHI) * [(1-delta)+(alpha-lamda)^2*PHI]
where
1. PHI (uppercase) is standard normal cumulative density function
2. PHI=PHI[(a-mu)/sigma]=PHI(alpha)=Prob(y*>a)
3. lamda= -phi(alpha)/PHI(alpha)
4. phi (lowercase) is standard normal probability density function
5. delta=lamda^2 - lamda*alpha
therefore

See William H. Greene, Econometric Analysis, 5th Edition, pp. 763-64.

   Step 2: use mean, s.d. of uncensored distribution to estimate mean
   of the uncensored distribution above the topcode
 
E[y*|y>a]=mu + [(sigma*phi(alpha))/(1 - PHI(alpha)]
where
alpha=(a - mu)/sigma

See Greene, pp. 759-60.


*/

capture program drop tcln
program define tcln
version 9.0
while "`1'"~="" {
*
* a. calculate share of weekly earnings at or above the topcode (PHI)
* universe is all those not paid by hour and reporting weekly earnings
* not paid by hour is paidhre==2 in NBER data, ==0 in modified data
*
sum tc [aw=weekpay_noadj] if `1'
local PHI=1-r(mean)
*
* b. calculate other needed values
* top-coding implies right-censoring
*
* take natural log of weekly earnings since procedure
* assumes weekly earnings are log-normally distributed
*
tempvar lnwke
gen `lnwke'=ln(weekpay_noadj) if lfstat==1 & selfemp==0 & `1'
sum `lnwke' [aw=orgwgt] if tc~=. & `1' /* only reporting weekly earnings */

local X=r(mean) /* mean, calculated using topcode (E[y] above) */
local SD=r(sd) /* standard deviation calculated using topcode */
local alpha=invnorm(`PHI')
local lamda=-normden(`alpha')/norm(`alpha')
*
* d. calculate estimates of true mean and standard deviation
local lsigma=($T-`X')/(`PHI'*(`alpha'-`lamda'))
local lmu   =$T - `alpha'*`lsigma'
*
* e. convert from natural logs back to dollars per week
local mX=exp(`X')
local mu=exp(`lmu')
local mT=exp($T)
local sigma=exp(`lsigma')
* sigma=exp(`lsigma')
*
*
* Step 2
*
* a. calculate mean above topcode
* calculating mean above topcode implies left-truncation
*
local halpha=($T-`lmu')/`lsigma'
local hlamda=normden(`halpha')/(1 - norm(`halpha'))
local mtc=`lmu' + `lsigma'*`hlamda'
*
* b. convert from natural logs back to dollars per week
global matcln`2' : display %6.0f exp(`mtc')
*
mac shift 2
}
end

tcln "female~=." a "female==0" m "female==1" f


clear

/*
File:	cepr_unadvtg2024_disability_cpsorg_desc_wages.do
Date:	July 2024
Desc:	Mean union and non-union wages for disability union advantage report

*/

cd "$log"
log using cepr_unadvtg2024_disability_cpsorg_desc_wages_rounded.log, replace

cd "$working"
use "cepr_cpsorg_2016–2023_recode.dta"

		/* Rounded Wages */
		
/* all disabled - rounded wages */
table union [fw=rndwgt] if disability==1, c(mean crw_ot2) format(%6.2f)

/* all not disabled - rounded wages */
table union [fw=rndwgt] if disability==0, c(mean crw_ot2) format(%6.2f)

/* hearing difficulty - rounded wages */
table union [fw=rndwgt] if disear==1, c(mean crw_ot2) format(%6.2f)

/* vision difficulty - rounded wages */
table union [fw=rndwgt] if diseye==1, c(mean crw_ot2) format(%6.2f)

/* cognitive difficulty - rounded wages */
table union [fw=rndwgt] if discog==1, c(mean crw_ot2) format(%6.2f)

/* ambulatory difficulty - rounded wages */
table union [fw=rndwgt] if disamb==1, c(mean crw_ot2) format(%6.2f)

/* personal care difficulty - rounded wages */
table union [fw=rndwgt] if discare==1, c(mean crw_ot2) format(%6.2f)

/* independent living difficulty - rounded wages */
table union [fw=rndwgt] if disind==1, c(mean crw_ot2) format(%6.2f)

/* prime age, disabled - rounded wages */
table union [fw=rndwgt] if disability==1 & prmage==1, c(mean crw_ot2) format(%6.2f)

/* prime age, not disabled - rounded wages */
table union [fw=rndwgt] if disability==0 & prmage==1, c(mean crw_ot2) format(%6.2f)

/* women, disabled - rounded wages */
table union [fw=rndwgt] if disability==1 & female==1, c(mean crw_ot2) format(%6.2f)

/* women, not disabled - rounded wages */
table union [fw=rndwgt] if disability==0 & female==1, c(mean crw_ot2) format(%6.2f)

/* men, disabled - rounded wages */
table union [fw=rndwgt] if disability==1 & female==0, c(mean crw_ot2) format(%6.2f)

/* men, not disabled - rounded wages */
table union [fw=rndwgt] if disability==0 & female==0, c(mean crw_ot2) format(%6.2f)

/* white, disabled - rounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==1, c(mean crw_ot2) format(%6.2f)

/* white, not disabled - rounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==1, c(mean crw_ot2) format(%6.2f)

/* Black, disabled - rounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==2, c(mean crw_ot2) format(%6.2f)

/* Black, not disabled - rounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==2, c(mean crw_ot2) format(%6.2f)

/* Hispanic, disabled - rounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==3, c(mean crw_ot2) format(%6.2f)

/* Hispanic, not disabled - rounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==3, c(mean crw_ot2) format(%6.2f)

/* AAPI, disabled - rounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==4, c(mean crw_ot2) format(%6.2f)

/* AAPI, not disabled - rounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==4, c(mean crw_ot2) format(%6.2f)

log close

cd "$log"
log using cepr_unadvtg2024_disability_cpsorg_desc_wages_unrounded.log, replace
		
		/* Unrounded Wages */
		
/* all disabled - unrounded wages */
table union [fw=rndwgt] if disability==1, c(mean crw_ot) format(%6.2f)

/* all not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0, c(mean crw_ot) format(%6.2f)

/* hearing difficulty - unrounded wages */
table union [fw=rndwgt] if disear==1, c(mean crw_ot) format(%6.2f)

/* vision difficulty - unrounded wages */
table union [fw=rndwgt] if diseye==1, c(mean crw_ot) format(%6.2f)

/* cognitive difficulty - unrounded wages */
table union [fw=rndwgt] if discog==1, c(mean crw_ot) format(%6.2f)

/* ambulatory difficulty - unrounded wages */
table union [fw=rndwgt] if disamb==1, c(mean crw_ot) format(%6.2f)

/* personal care difficulty - unrounded wages */
table union [fw=rndwgt] if discare==1, c(mean crw_ot) format(%6.2f)

/* independent living difficulty - unrounded wages */
table union [fw=rndwgt] if disind==1, c(mean crw_ot) format(%6.2f)

/* prime age, disabled - unrounded wages */
table union [fw=rndwgt] if disability==1 & prmage==1, c(mean crw_ot) format(%6.2f)

/* prime age, not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0 & prmage==1, c(mean crw_ot) format(%6.2f)

/* women, disabled - unrounded wages */
table union [fw=rndwgt] if disability==1 & female==1, c(mean crw_ot) format(%6.2f)

/* women, not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0 & female==1, c(mean crw_ot) format(%6.2f)

/* men, disabled - unrounded wages */
table union [fw=rndwgt] if disability==1 & female==0, c(mean crw_ot) format(%6.2f)

/* men, not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0 & female==0, c(mean crw_ot) format(%6.2f)

/* white, disabled - unrounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==1, c(mean crw_ot) format(%6.2f)

/* white, not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==1, c(mean crw_ot) format(%6.2f)

/* Black, disabled - unrounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==2, c(mean crw_ot) format(%6.2f)

/* Black, not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==2, c(mean crw_ot) format(%6.2f)

/* Hispanic, disabled - unrounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==3, c(mean crw_ot) format(%6.2f)

/* Hispanic, not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==3, c(mean crw_ot) format(%6.2f)

/* AAPI, disabled - unrounded wages */
table union [fw=rndwgt] if disability==1 & wbhao==4, c(mean crw_ot) format(%6.2f)

/* AAPI, not disabled - unrounded wages */
table union [fw=rndwgt] if disability==0 & wbhao==4, c(mean crw_ot) format(%6.2f)

log close


clear

/*
File:	cepr_unadvtg2024_disability_cpsasec_regressions_benefits.do
Date:	July 2024
Desc:	Union and non-union benefit access for disability union advantage report

*/

cd "$working"
use "cepr_cpsasec_2016-2023_recode.dta"

cd "$log"
log using cepr_unadvtg2024_disability_cpsasec_desc_health.log, replace

		/* Health Insurance */
		
/* all disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1, col nofreq

/* all not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0, col nofreq

/* hearing difficulty*/
tab health union [aw=rndwgt] if lfstat==1 & disear==1, col nofreq

/* vision difficulty */
tab health union [aw=rndwgt] if lfstat==1 & diseye==1, col nofreq

/* cognitive difficulty */
tab health union [aw=rndwgt] if lfstat==1 & discog==1, col nofreq

/* ambulatory difficulty */
tab health union [aw=rndwgt] if lfstat==1 & disamb==1, col nofreq

/* personal care difficulty */
tab health union [aw=rndwgt] if lfstat==1 & discare==1, col nofreq

/* independent living difficulty */
tab health union [aw=rndwgt] if lfstat==1 & disind==1, col nofreq

/* prime age, disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1 & prmage==1, col nofreq

/* prime age, not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0 & prmage==1, col nofreq

/* women, disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1 & female==1, col nofreq

/* women, not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0 & female==1, col nofreq

/* men, disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1 & female==0, col nofreq

/* men, not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0 & female==0, col nofreq

/* white, disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==1, col nofreq

/* white, not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==1, col nofreq

/* Black, disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==2, col nofreq

/* Black, not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==2, col nofreq

/* Hispanic, disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==3, col nofreq

/* Hispanic, not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==3, col nofreq

/* AAPI, disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==4, col nofreq

/* AAPI, not disabled */
tab health union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==4, col nofreq

log close
	  
***********************************************************************

cd "$log"
log using cepr_unadvtg2024_disability_cpsasec_desc_pension.log, replace

/* all disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1, col nofreq

/* all not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0, col nofreq

/* hearing difficulty*/
tab pension union [aw=rndwgt] if lfstat==1 & disear==1, col nofreq

/* vision difficulty */
tab pension union [aw=rndwgt] if lfstat==1 & diseye==1, col nofreq

/* cognitive difficulty */
tab pension union [aw=rndwgt] if lfstat==1 & discog==1, col nofreq

/* ambulatory difficulty */
tab pension union [aw=rndwgt] if lfstat==1 & disamb==1, col nofreq

/* personal care difficulty */
tab pension union [aw=rndwgt] if lfstat==1 & discare==1, col nofreq

/* independent living difficulty */
tab pension union [aw=rndwgt] if lfstat==1 & disind==1, col nofreq

/* prime age, disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1 & prmage==1, col nofreq

/* prime age, not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0 & prmage==1, col nofreq

/* women, disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1 & female==1, col nofreq

/* women, not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0 & female==1, col nofreq

/* men, disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1 & female==0, col nofreq

/* men, not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0 & female==0, col nofreq

/* white, disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==1, col nofreq

/* white, not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==1, col nofreq

/* Black, disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==2, col nofreq

/* Black, not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==2, col nofreq

/* Hispanic, disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==3, col nofreq

/* Hispanic, not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==3, col nofreq

/* AAPI, disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==1 & wbhao==4, col nofreq

/* AAPI, not disabled */
tab pension union [aw=rndwgt] if lfstat==1 & disability==0 & wbhao==4, col nofreq

log close


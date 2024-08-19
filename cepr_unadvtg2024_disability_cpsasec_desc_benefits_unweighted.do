clear

/*
File:	cepr_unadvtg2024_disability_cpsasec_desc_benefits_unweighted.do
Date:	July 2024
Desc:	Union and non-union benefit access for disability union advantage report

*/

cd "$working"
use "cepr_cpsasec_2016-2023_recode.dta"

cd "$log"
log using cepr_unadvtg2024_disability_cpsasec_desc_health_unweighted.log, replace

		/* Health Insurance */
		
/* all disabled */
tab health union if lfstat==1 & disability==1 

/* all not disabled */
tab health union if lfstat==1 & disability==0 

/* hearing difficulty*/
tab health union if lfstat==1 & disear==1 

/* vision difficulty */
tab health union if lfstat==1 & diseye==1 

/* cognitive difficulty */
tab health union if lfstat==1 & discog==1 

/* ambulatory difficulty */
tab health union if lfstat==1 & disamb==1 

/* personal care difficulty */
tab health union if lfstat==1 & discare==1 

/* independent living difficulty */
tab health union if lfstat==1 & disind==1 

/* prime age, disabled */
tab health union if lfstat==1 & disability==1 & prmage==1 

/* prime age, not disabled */
tab health union if lfstat==1 & disability==0 & prmage==1 

/* women, disabled */
tab health union if lfstat==1 & disability==1 & female==1 

/* women, not disabled */
tab health union if lfstat==1 & disability==0 & female==1 

/* men, disabled */
tab health union if lfstat==1 & disability==1 & female==0 

/* men, not disabled */
tab health union if lfstat==1 & disability==0 & female==0 

/* white, disabled */
tab health union if lfstat==1 & disability==1 & wbhao==1 

/* white, not disabled */
tab health union if lfstat==1 & disability==0 & wbhao==1 

/* Black, disabled */
tab health union if lfstat==1 & disability==1 & wbhao==2 

/* Black, not disabled */
tab health union if lfstat==1 & disability==0 & wbhao==2 

/* Hispanic, disabled */
tab health union if lfstat==1 & disability==1 & wbhao==3 

/* Hispanic, not disabled */
tab health union if lfstat==1 & disability==0 & wbhao==3 

/* AAPI, disabled */
tab health union if lfstat==1 & disability==1 & wbhao==4 

/* AAPI, not disabled */
tab health union if lfstat==1 & disability==0 & wbhao==4 

log close
	  
***********************************************************************

cd "$log"
log using cepr_unadvtg2024_disability_cpsasec_desc_pension_unweighted.log, replace

/* all disabled */
tab pension union if lfstat==1 & disability==1 

/* all not disabled */
tab pension union if lfstat==1 & disability==0 

/* hearing difficulty*/
tab pension union if lfstat==1 & disear==1 

/* vision difficulty */
tab pension union if lfstat==1 & diseye==1 

/* cognitive difficulty */
tab pension union if lfstat==1 & discog==1 

/* ambulatory difficulty */
tab pension union if lfstat==1 & disamb==1 

/* personal care difficulty */
tab pension union if lfstat==1 & discare==1 

/* independent living difficulty */
tab pension union if lfstat==1 & disind==1 

/* prime age, disabled */
tab pension union if lfstat==1 & disability==1 & prmage==1 

/* prime age, not disabled */
tab pension union if lfstat==1 & disability==0 & prmage==1 

/* women, disabled */
tab pension union if lfstat==1 & disability==1 & female==1 

/* women, not disabled */
tab pension union if lfstat==1 & disability==0 & female==1 

/* men, disabled */
tab pension union if lfstat==1 & disability==1 & female==0 

/* men, not disabled */
tab pension union if lfstat==1 & disability==0 & female==0 

/* white, disabled */
tab pension union if lfstat==1 & disability==1 & wbhao==1 

/* white, not disabled */
tab pension union if lfstat==1 & disability==0 & wbhao==1 

/* Black, disabled */
tab pension union if lfstat==1 & disability==1 & wbhao==2 

/* Black, not disabled */
tab pension union if lfstat==1 & disability==0 & wbhao==2 

/* Hispanic, disabled */
tab pension union if lfstat==1 & disability==1 & wbhao==3 

/* Hispanic, not disabled */
tab pension union if lfstat==1 & disability==0 & wbhao==3 

/* AAPI, disabled */
tab pension union if lfstat==1 & disability==1 & wbhao==4 

/* AAPI, not disabled */
tab pension union if lfstat==1 & disability==0 & wbhao==4 

log close


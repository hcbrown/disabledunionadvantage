clear

/*
File:	cepr_unadvtg2024_disability_cpsasec_regressions_benefits.do
Date:	July 2024
Desc:	Regression-adjusted union benefit premiums for disability union advantage report

*/

cd "$working"
use "cepr_cpsasec_2016-2023_recode.dta"

cd "$log"
cd "benefit regression logs"
log using cepr_unadvtg2024_disability_cpsasec_regressions_health.log, replace


		/* Employer-sponsored health insurance, regression adjusted */
		
/* all disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1, robust
	estat ic
	  
/* all not disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0, robust
	estat ic
	
/* hearing difficulty */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & disear==1, robust
	estat ic
	
/* vision difficulty */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & diseye==1, robust
	estat ic
	
/* cognitive difficulty */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & discog==1, robust
	estat ic
	
/* ambulatory difficulty */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & disamb==1, robust
	estat ic
/*
*note: sample size too small to calculate for personal care difficulty
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid black hisp /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & discare==1, robust
*/

/* independent living difficulty */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & disind==1, robust
	estat ic
	
/* prime age, disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & prmage==1, robust
	estat ic
	
/* prime age, not disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & prmage==1, robust
	estat ic
	
/* women, disabled */
	dprobit health union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & female==1, robust
	estat ic
	
/* women, not disabled */
	dprobit health union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==1, robust
	estat ic
	
/* men, disabled */
	dprobit health union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & female==0, robust
	estat ic
	
/* men, not disabled */
	dprobit health union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==0, robust
	estat ic
	
/* white, disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & white==1, robust
	estat ic
	
/* white, not disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & white==1, robust
	estat ic
	
/* Black, disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & black==1, robust
	estat ic
	
/* Black, not disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & black==1, robust
	estat ic
	
/* Hispanic, disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & hisp==1, robust
	estat ic
	
/* Hispanic, not disabled */
	dprobit health union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & hisp==1, robust
	estat ic

log close
	  
***********************************************************************

cd "$log"
log using cepr_unadvtg2024_disability_cpsasec_regressions_pension.log, replace

		/* Employer-sponsored retirement plan, regression adjusted */

/* all disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1, robust
	estat ic
	
/* all not disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0, robust
	estat ic
	
/* hearing difficulty */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
            */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & disear==1, robust
	estat ic
	
/* vision difficulty */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
            */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & diseye==1, robust
	estat ic
	
/* cognitive difficulty */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
           */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & discog==1, robust
	estat ic
	
/* ambulatory difficulty */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & disamb==1, robust
	estat ic
	
/* personal care difficulty */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & discare==1, robust
	estat ic
	
/* independent living difficulty */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt dismult /*
      */ if (2016<=year & year<=2023) & disind==1, robust
	estat ic
	
/* prime age, disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*	  
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & prmage==1, robust
	estat ic
	
/* prime age, not disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid /*
	  */ black hisp aapi citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & prmage==1, robust
	estat ic
	
/* women, disabled */
	dprobit pension union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & female==1, robust
	estat ic
	
/* women, not disabled */
	dprobit pension union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==1, robust
	estat ic
	
/* men, disabled */
	dprobit pension union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & female==0, robust
	estat ic
	
/* men, not disabled */
	dprobit pension union /*
      */ ed2-ed5 age agesq year2-year6 covid /*
      */ black hisp aapi citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==0, robust
	estat ic
	
/* white, disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
	  */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & white==1, robust
	estat ic
	
/* white, not disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & white==1, robust
	estat ic
	
/* Black, disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & black==1, robust
	estat ic
	
/* Black, not disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & black==1, robust
	estat ic

/* Hispanic, disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
	  */ disear diseye discog disamb discare disind dismult /*
      */ if (2016<=year & year<=2023) & disability==1 & hisp==1, robust
	estat ic
	
/* Hispanic, not disabled */
	dprobit pension union /*
      */ ed2-ed5 female age agesq year2-year6 covid citizen /*
      */ state2-state51 doccly2-doccly53 dindly2-dindly23 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & hisp==1, robust
	estat ic
	
log close

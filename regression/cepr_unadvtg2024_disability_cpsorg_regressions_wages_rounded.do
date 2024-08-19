clear

/*
File:	cepr_unadvtg2024_disability_cpsorg_regressions_wages_rounded.do
Date:	July 2024
Desc:	Regression-adjusted union wage premiums for disability union advantage report,
		controlling for detailed occupation & applying 2023 rounding rules to all years

*/

cd "$log"
log using cepr_unadvtg2024_disability_cpsorg_regressions_wages_rounded.log, replace

cd "$working"
use "cepr_cpsorg_2016–2023_recode.dta"

/* Note: wage variable excludes all imputed wages
see Hirsch and Macpherson (2006) https://www.jstor.org/stable/10.1086/504276 */

		/* Union wage premium, regression adjusted */
		
/* all disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1, robust
estat ic
gen unprem_disab2=100*(exp(_b[union])-1)
tab unprem_disab2

/* all not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0, robust  
estat ic
gen unprem_notdisab2=100*(exp(_b[union])-1)
tab unprem_notdisab2

/* hearing difficulty - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & disear==1, robust
estat ic
gen unprem_disear2=100*(exp(_b[union])-1)
tab unprem_disear2

/* vision difficulty - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & diseye==1, robust
estat ic
gen unprem_diseye2=100*(exp(_b[union])-1)
tab unprem_diseye2

/* cognitive difficulty - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & discog==1, robust
estat ic
gen unprem_discog2=100*(exp(_b[union])-1)
tab unprem_discog2

/* ambulatory difficulty - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & disamb==1, robust
estat ic
gen unprem_disamb2=100*(exp(_b[union])-1)
tab unprem_disamb2

/* personal care difficulty - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & discare==1, robust
estat ic
gen unprem_discare2=100*(exp(_b[union])-1)
tab unprem_discare2

/* independent living difficulty - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & disind==1, robust
estat ic
gen unprem_disind2=100*(exp(_b[union])-1)
tab unprem_disind2

/* prime age, disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & prmage==1, robust
estat ic
gen unprem_disab_prmage2=100*(exp(_b[union])-1)
tab unprem_disab_prmage2

/* prime age, not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
	  */ if (2016<=year & year<=2023) & disability==0 & prmage==1, robust
estat ic
gen unprem_notdisab_prmage2=100*(exp(_b[union])-1)
tab unprem_notdisab_prmage2

/* women, disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & female==1, robust
estat ic
gen unprem_disab_f2=100*(exp(_b[union])-1)
tab unprem_disab_f2

/* women, not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==1, robust  
estat ic
gen unprem_notdisab_f2=100*(exp(_b[union])-1)
tab unprem_notdisab_f2

/* men, disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & female==0, robust
estat ic
gen unprem_disab_m2=100*(exp(_b[union])-1)
tab unprem_disab_m2

/* men, not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==0, robust  
estat ic
gen unprem_notdisab_m2=100*(exp(_b[union])-1)
tab unprem_notdisab_m2

/* white, disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==1, robust
estat ic
gen unprem_disab_w2=100*(exp(_b[union])-1)
tab unprem_disab_w2

/* white, not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==1, robust  
estat ic
gen unprem_notdisab_w2=100*(exp(_b[union])-1)
tab unprem_notdisab_w2

/* Black, disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==2, robust
estat ic
gen unprem_disab_b2=100*(exp(_b[union])-1)
tab unprem_disab_b2

/* Black, not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==2, robust  
estat ic
gen unprem_notdisab_b2=100*(exp(_b[union])-1)
tab unprem_notdisab_b2

/* Hispanic, disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==3, robust
estat ic
gen unprem_disab_h2=100*(exp(_b[union])-1)
tab unprem_disab_h2

/* Hispanic, not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==3, robust  
estat ic
gen unprem_notdisab_h2=100*(exp(_b[union])-1)
tab unprem_notdisab_h2

/* AAPI, disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==4, robust
estat ic
gen unprem_disab_a2=100*(exp(_b[union])-1)
tab unprem_disab_a2

/* AAPI, not disabled - rounded wages */
	reg lncrw_ot2 union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==4, robust  
estat ic
gen unprem_notdisab_a2=100*(exp(_b[union])-1)
tab unprem_notdisab_a2


log close

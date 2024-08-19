clear

/*
File:	cepr_unadvtg2024_disability_cpsorg_regressions_wages_unrounded.do
Date:	July 2024
Desc:	Regression-adjusted union wage premiums for disability union advantage report,
		controlling for detailed occupation & applying 2023 rounding rules to all years

*/

cd "$log"
log using cepr_unadvtg2024_disability_cpsorg_regressions_wages_unrounded.log, replace

cd "$working"
use "cepr_cpsorg_2016–2023_recode.dta"

/* Note: wage variable excludes all imputed wages
see Hirsch and Macpherson (2006) https://www.jstor.org/stable/10.1086/504276 */

		/* Union wage premium, regression adjusted */
		
/* all disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1, robust
estat ic
gen unprem_disab=100*(exp(_b[union])-1)
tab unprem_disab

/* all not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0, robust  
estat ic
gen unprem_notdisab=100*(exp(_b[union])-1)
tab unprem_notdisab

/* hearing difficulty - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & disear==1, robust
estat ic
gen unprem_disear=100*(exp(_b[union])-1)
tab unprem_disear

/* vision difficulty - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & diseye==1, robust
estat ic
gen unprem_diseye=100*(exp(_b[union])-1)
tab unprem_diseye

/* cognitive difficulty - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & discog==1, robust
estat ic
gen unprem_discog=100*(exp(_b[union])-1)
tab unprem_discog

/* ambulatory difficulty - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & disamb==1, robust
estat ic
gen unprem_disamb=100*(exp(_b[union])-1)
tab unprem_disamb

/* personal care difficulty - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & discare==1, robust
estat ic
gen unprem_discare=100*(exp(_b[union])-1)
tab unprem_discare

/* independent living difficulty - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen pubsec pt dismult /*
      */ i.statefips i.dind03 i.docc03 /*
	  */ if (2016<=year & year<=2023) & disind==1, robust
estat ic
gen unprem_disind=100*(exp(_b[union])-1)
tab unprem_disind

/* prime age, disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & prmage==1, robust
estat ic
gen unprem_disab_prmage=100*(exp(_b[union])-1)
tab unprem_disab_prmage

/* prime age, not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
	  */ if (2016<=year & year<=2023) & disability==0 & prmage==1, robust
estat ic
gen unprem_notdisab_prmage=100*(exp(_b[union])-1)
tab unprem_notdisab_prmage

/* women, disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & female==1, robust
estat ic
gen unprem_disab_f=100*(exp(_b[union])-1)
tab unprem_disab_f

/* women, not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==1, robust  
estat ic
gen unprem_notdisab_f=100*(exp(_b[union])-1)
tab unprem_notdisab_f

/* men, disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & female==0, robust
estat ic
gen unprem_disab_m=100*(exp(_b[union])-1)
tab unprem_disab_m

/* men, not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ age agesq /*
	  */ i.year covid i.wbhao citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & female==0, robust  
estat ic
gen unprem_notdisab_m=100*(exp(_b[union])-1)
tab unprem_notdisab_m

/* white, disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==1, robust
estat ic
gen unprem_disab_w=100*(exp(_b[union])-1)
tab unprem_disab_w

/* white, not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==1, robust  
estat ic
gen unprem_notdisab_w=100*(exp(_b[union])-1)
tab unprem_notdisab_w

/* Black, disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==2, robust
estat ic
gen unprem_disab_b=100*(exp(_b[union])-1)
tab unprem_disab_b

/* Black, not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==2, robust  
estat ic
gen unprem_notdisab_b=100*(exp(_b[union])-1)
tab unprem_notdisab_b

/* Hispanic, disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==3, robust
estat ic
gen unprem_disab_h=100*(exp(_b[union])-1)
tab unprem_disab_h

/* Hispanic, not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==3, robust  
estat ic
gen unprem_notdisab_h=100*(exp(_b[union])-1)
tab unprem_notdisab_h

/* AAPI, disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ disear diseye discog disamb /*	  
	  */ discare disind dismult /*	
	  */ if (2016<=year & year<=2023) & disability==1 & wbhao==4, robust
estat ic
gen unprem_disab_a=100*(exp(_b[union])-1)
tab unprem_disab_a

/* AAPI, not disabled - unrounded wages */
	reg lncrw_ot union /*
      */ i.educ female age agesq /*
	  */ i.year covid citizen i.statefips /*
      */ i.dind03 i.docc03 pubsec pt /*
      */ if (2016<=year & year<=2023) & disability==0 & wbhao==4, robust  
estat ic
gen unprem_notdisab_a=100*(exp(_b[union])-1)
tab unprem_notdisab_a


log close

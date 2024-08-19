clear

/*
File:	cepr_unadvtg2024_disability_cpsasec_recode_2016-2023.do
Date:	July 2024
Desc:	Recoding IPUMS variables for disabled workers union advantage report (ASEC portion)

*/

cd "$ipums"
use ipums_cpsasec_2016–2023.dta

/* general label for dummy variables */
lab def noyes 0 No 1 Yes

/* drop irrelevancies */
drop if empstat==1 /* drop armed forces */
drop if age<18 /* drop those under 18 yo */

/* Round Weights */
gen rndwgt=round(asecwt,1)
gen rndwgtorg=round(earnwt/12,1)

		/* union membership + coverage */
gen unmem=0 if inlist(union, 1, 2, 3)
replace unmem=1 if union==2
lab var unmem "Union membership"
lab def unmem 0 "Not union member" 1 "Union member"
lab val unmem unmem

rename union union_det

gen union=0 if inlist(union_det, 1, 2, 3)
replace union=1 if union_det==2 | union_det==3
lab var union "Union coverage"
lab def union 0 "No union coverage" 1 "Union coverage"
lab val union union

/* state */
tab statefip, gen(state)

/* Year */
tab year if (2016<=year & year<=2023), gen(year)

		/* COVID pandemic (before and since) */
gen covid=0
replace covid=1 if year>2021 /* ASEC reference period is previous full-calendar year */
lab var covid "During the COVID-19 pandemic"
lab val covid noyes

		/* sex */
gen female=0 if sex~=.
replace female=1 if sex==2
replace female=0 if sex==1
lab var female "female"
lab def female 0 "men" 1 "women"
lab val female female

		/* age */
gen agegrp=0 if (18<=age & age~=.)
replace agegrp=1 if (18<=age & age<=24)
replace agegrp=2 if (25<=age & age<=34)
replace agegrp=3 if (35<=age & age<=44)
replace agegrp=4 if (45<=age & age<=54)
replace agegrp=5 if (55<=age & age<=64)
replace agegrp=6 if (65<=age & age~=.)
lab var agegrp "Age group"
lab def agegrp 1 "18-24" 2 "25-34" 3 "35-44" 4 "45-54" 5 "55-64" 6 "65+"
lab val agegrp agegrp

gen prmage=0 if age~=.
replace prmage=1 if (25<=age & age<=54)
lab var prmage "Prime Age (25-54)"
lab val prmage noyes

gen agesq=age*age
lab var "Age squared"

		/* *** Race/ ethnicity *** */
/* wbhao - mutually exclusive, includes Asian/PI */
gen byte wbhao=. if race~=.
replace wbhao=1 if race==100 /* white only */
replace wbhao=2 if race==200 /* black only */
replace wbhao=2 if race==801 /* black-white */ | race==805 /*
*/ /* black-AI */ | race==806 /* black-asian */ | race==807 /*
*/ /* black-HP */ | race==810 /* W-B-AI */ | race==811 /* W-B-A */ /*
*/ | race==814 /* W-B-AI-A */ | race==816 /* W-B-HP */ /*
*/ | race==818 /* B-AI-A */
replace wbhao=4 if race==651 | race==652 /* asian & hawaiian/pacific islander */ /*
*/ | race==803 /* white-asian */ | race==804 /* white-HP */ | race==808 /*
*/ /* AI-Asian */ | race==809 /* asian-HP */ | race==812 /* W-AI-A */ /*
*/ | race==813 /* W-A-HP */ | race==815 /*AI-HP */ /*
*/ | race==817 /* W-AI-HP */ | race==819 /* W-AI-A-HP */
replace wbhao=5 if race==300 /* AI only */ | race==802 /* white-AI */ /*
*/ | race==820 /* 2-3 races, u.s. */ | race==830 /* 4-5 races, u.s. */
replace wbhao=3 if (100<=hispan & hispan<=612) /* hispanic */
lab var wbhao "Race/ethnicity, incl. AAPI"
#delimit ;
lab def wbhao
1 "White"
2 "Black"
3 "Hispanic"
4 "AAPI"
5 "Other"
;
#delimit cr
lab val wbhao wbhao

/* wbho - mutually exclusive, no separate asian/PI category */
gen byte wbho=. if race~=.
replace wbho=1 if race==100 /* white only */
replace wbho=2 if race==200 /* black only */
replace wbho=2 if race==801 /* black-white */ | race==805 /*
*/ /* black-AI */ | race==806 /* black-asian */ | race==807 /*
*/ /* black-HP */ | race==810 /* W-B-AI */ | race==811 /* W-B-A */ /*
*/ | race==814 /* W-B-AI-A */ | race==816 /* W-B-HP */ /*
*/ | race==818 /* B-AI-A */
replace wbho=4 if race==651 | race==652 /* asian & hawaiian/pacific islander */ /*
*/ | race==803 /* white-asian */ | race==804 /* white-HP */ | race==808 /*
*/ /* AI-Asian */ | race==809 /* asian-HP */ | race==812 /* W-AI-A */ /*
*/ | race==813 /* W-A-HP */ | race==815 /*AI-HP */ | race==817 /* W-AI-HP */ /*
*/ | race==819 /* W-AI-A-HP */| race==300 /* AI only */ | race==802 /* white-AI */ /*
*/ | race==820 /* 2-3 races, u.s. */ | race==830 /* 4-5 races, u.s. */
replace wbho=3 if (100<=hispan & hispan<=612) /* hispanic */
lab var wbho "Race/ethnicity, incl. AAPI"
#delimit ;
lab def wbho
1 "White"
2 "Black"
3 "Hispanic"
4 "Other"
;
#delimit cr
lab val wbho wbho

/* Hispanic dummy variable - wbhao version */
gen hisp=0
replace hisp=1 if wbhao==3
lab var hisp "Hispanic (wbhao & wbho)"
lab val hisp noyes

/* Black dummy variable (wbho, wbhao) */
gen black=0
replace black=1 if wbhao==2
lab var black "Black (wbho)"
lab val black noyes

/* white dummy variable (wwbho, bhao) */
gen white=0
replace white=1 if wbhao==1
lab var white "White (wbhao)"
lab val white noyes

/* AAPI dummy variable (wbhao) */
gen aapi=0
replace aapi=1 if wbhao==4
lab var aapi "AAPI (wbhao)"
lab val aapi noyes

/* Other dummy variable (wbho) */
gen oth=0
replace oth=1 if wbho==4
lab var oth "Other (wbho)"
lab val oth noyes

/* Other dummy variable (wbhao) */
gen otha=0
replace otha=1 if wbhao==5
lab var otha "Other (wbhao)"
lab val otha noyes

		/* nativity */
gen byte forborn=0 if citizen~=.
replace forborn=1 if citizen==4 | citizen==5
lab var forborn "Foreign born"
lab def forborn 0 "Native" 1 "Foreign"
lab val forborn forborn

rename citizen citizenship
gen byte citizen=0 if citizenship~=.
replace citizen=1 if citizenship==5
lab var citizen "Foreign born"
lab def citizen 0 "Not a US citizen" 1 "US citizen"
lab val citizen citizen

		/* education */
rename educ educat
gen educ=. if educat>1
replace educ=1 if (2<=educat & educat<=72)
replace educ=2 if educat==73
replace educ=3 if (80<=educat & educat<=100)
replace educ=4 if educat==111
replace educ=5 if (123<=educat & educat<=125)
lab var educ "Educational attainment"
#delimit ;
lab def educ
1 "LTHS"
2 "HS"
3 "Some college"
4 "Bachelor's"
5 "Advanced"
;
#delimit cr
lab val educ educ

/* union/education interaction variables */
tab educ, gen(ed)

		/* WORK */
		
/* industry */

*major industry last year
rename uh_indmly_a5 mind03ly
tab mind03ly, gen(mindly)

*2-digit occupation last year
rename uh_indly2_a4 dind03ly
tab dind03ly, gen(dindly)

/* occupation */
*major occupation last year
rename uh_occmly_a5 mocc03ly
tab mocc03ly, gen(moccly)

*2-digit occupation last year
rename uh_occly2_a4 docc03ly
tab docc03ly, gen(doccly)

/* labor force status - consolidated categories */
gen lfstat=. if empstat~=.
	replace lfstat=1 if inlist(empstat, 10, 12)
	replace lfstat=2 if inlist(empstat, 21, 22)
	replace lfstat=3 if inlist(empstat, 32, 34, 36)
lab var lfstat "Labor-force status"
#delimit ;
	lab def lfstat
	1 "Employed"
	2 "Unemployed"
	3 "NILF"
	;
#delimit cr
lab val lfstat lfstat

/* self-employed (unincorporated) */
gen byte selfemp=0 if classwkr~=. & classwkr~=0 & classwkr~=99 
replace selfemp=1 if classwkr==13
lab var selfemp "Self-employed, unincorporated"
lab val selfemp noyes
notes selfemp: Unincorporated self-employed only
notes selfemp: CPS: derived from a_clswkr, peio1cow
notes selfemp: For use with wages lognormal topcoding pr0gram

gen pubsec=0 if classwkr>0
replace pubsec=1 if inrange(classwkr, 24, 28)
lab var pubsec "Public sector"
lab val pubsec noyes

/* "hours vary" */
gen byte hrsvary=0 if uhrswork1<999
replace hrsvary=1 if uhrswork1==997
lab var hrsvary "Hours vary, main job"
lab val hrsvary noyes
notes hrsvary: Available 1994- only
notes hrsvary: CPS: pehrusl1==-4

/* full-time */
gen byte fulltime=0 if fullpart~=0 & selfemp==0 & lfstat==1
replace fulltime=1 if fullpart==1 & selfemp==0 & lfstat==1
lab var fulltime "Full-time"
lab def fulltime 0 "Part-time" 1 "Full-time"
lab val fulltime fulltime

/* pension plan, employee participates */
rename pension pens
gen pension=0 if pens>0
replace pension=1 if pens==3
lab var pension "Included in pension plan at work"
lab val pension noyes

/* employment-based health insurance */
rename health healthstatus
gen health=0 if grpcoutly~=2 
replace health=1 if grpownly==2
lab var health "Policyholder for employment-based health insurance"
lab val health noyes
notes health: Excludes those covered by employment-based health insurance through someone outside their household

			/* DISABILITY */
			
		/* recoded disability dummy variables */
		
/* any disability */
recode diffany (1=0 "no") (2=1 "yes"), gen(disability)
lab var disability "Any difficulty"
		
/* hearing */
recode diffhear (1=0 "no") (2=1 "yes"), gen(disear)
lab var disear "Hearing difficulty"

/* vision */
recode diffeye (1=0 "no") (2=1 "yes"), gen(diseye)
lab var diseye "Vision difficulty"

/* cognitive */
recode diffrem (1=0 "no") (2=1 "yes"), gen(discog)
lab var discog "Cognitive difficulty"

/* ambulatory */
recode diffphys (1=0 "no") (2=1 "yes"), gen(disamb)
lab var disamb "Ambulatory difficulty"

/* personal care */
recode diffcare (1=0 "no") (2=1 "yes"), gen(discare)
lab var discare "Personal care difficulty"

/* independent living */
recode diffmob (1=0 "no") (2=1 "yes"), gen(disind)
lab var disind "Independent living difficulty"

			
/* disability type single disabilities only */
gen byte distyp=7 if diffany==2
replace distyp=1 if diffhear==2 & diffeye==1 & diffrem==1 & diffphys==1 & diffmob==1 & diffcare==1
replace distyp=2 if diffeye==2 & diffhear==1 & diffrem==1 & diffphys==1 & diffmob==1 & diffcare==1
replace distyp=3 if diffrem==2 & diffeye==1 & diffhear==1 & diffphys==1 & diffmob==1 & diffcare==1
replace distyp=4 if diffphys==2 & diffeye==1 & diffhear==1 & diffrem==1 & diffmob==1 & diffcare==1
replace distyp=5 if diffmob==2 & diffeye==1 & diffhear==1 & diffrem==1 & diffphys==1 & diffcare==1
replace distyp=6 if diffcare==2 & diffeye==1 & diffhear==1 & diffrem==1 & diffphys==1 & diffmob==1
lab var distyp "Type of disability"
#delimit ;
lab def distyp
1 "Hearing only"
2 "Vision only"
3 "Cognitive only"
4 "Ambulatory only"
5 "Independent living only"
6 "Personal care only"
7 "Multiple disabilities"
;
#delimit cr
lab val distyp distyp


/* multiple disabilities */
gen byte dismult=0
replace dismult=1 if distyp==7
lab var dismult "Multiple types of difficulty"
lab val dismult noyes

/* union disability interaction */
gen undisab=union*disability
lab var undisab "union disability interaction"

cd "$working"
saveold "cepr_cpsasec_2016-2023_recode.dta", replace


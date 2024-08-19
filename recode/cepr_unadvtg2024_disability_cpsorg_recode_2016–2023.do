clear

/*
File:	do cepr_unadvtg2024_disability_cpsorg_recode_2016–2023.do
Date:	July 2024
Desc:	Recoding EPI variables for disability union advantage report 
		(wage premium portion)

*/

cd "$working"
use "epicepr_cpsorg_2016–2023.dta"

/* general label for dummy variables */
*lab def noyes 0 No 1 Yes

/* drop irrelevancies */
*drop if age<16 /* drop those under 16 yo */
drop if age<18 /* drop those under 18 yo */
drop if mind03==14 /* drop armed forces */

/* Round Weights */
gen rndwgt=round(orgwgt/12,1)

/* COVID pandemic (before and during) */
gen covid=0
replace covid=1 if year==2020 & inrange(month, 3 ,12)
replace covid=1 if year>2020
lab var covid "Before or during the COVID-19 pandemic"
lab def covid 0 "Before COVID" 1 "During COVID"
lab val covid covid

/* wage variable change (before and since) */
gen wagernd=0
replace wagernd=1 if year==2023 & inrange(month, 4 ,12)
lab var wagernd "Before or since rounding changes to wage variables"
lab def wagernd 0 "No rounding" 1 "DRounding"
lab val wagernd wagernd

/* union disability interaction */
gen undisab=union*disability
lab var undisab "union disability interaction"

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

/* Age squared */
gen agesq=age*age
lab var agesq "Age squared"

* region (US Bureau of Economic Analysis) */
gen byte regionbea=0 if statecensus~=.
replace regionbea=1 if 11<=statecensus & statecensus<=16 /* ME, NH, VT, MA, RI, CT */
replace regionbea=2 if 21<=statecensus & statecensus<=23 | 51<=statecensus & statecensus<=53 /* NY, NJ, PA, DE, MD, DC  */
replace regionbea=3 if 31<=statecensus & statecensus<=35 /* OH, IN, IL, MI, WI */
replace regionbea=4 if 41<=statecensus & statecensus<=47 /* MN, IA, MO, ND, SD, NE, KS */
replace regionbea=5 if 54<=statecensus & statecensus<=72 /* VA, WV, NC, SC, GA, FL, KY, TN, AL, MS, AR, LA */
replace regionbea=6 if 73<=statecensus & statecensus<=74 | 85<=statecensus & statecensus<=86 /* OK, TX, NM, AZ */
replace regionbea=7 if 81<=statecensus & statecensus<=84 | statecensus==87 /* MT, ID, WY, CO, UT */
replace regionbea=8 if 88<=statecensus & statecensus<=95 /* NV, WA, OR, CA, AK, HI */
#delimit ;
lab def regionbea
1 "New England"
2 "Mideast"
3 "Great Lakes"
4 "Plains"
5 "Southeast"
6 "Southwest"
7 "Rocky Mountain"
8 "Far West"
;
#delimit cr
lab var regionbea "Region (US Bureau of Economic Analysis)"
lab val regionbea regionbea
notes regionbea: Uses statecensus

		/* foreign born */
gen byte forborn=0 if citizen~=.
replace forborn=1 if citizen==4 | citizen==5
lab var forborn "Foreign born"
lab def forborn 0 "Native" 1 "Foreign"
lab val forborn forborn

		/* education */
#delimit ;
lab def edu
1 "LTHS"
2 "HS"
3 "Some college"
4 "Bachelor's"
5 "Advanced"
;
#delimit cr
lab val educ edu

/* Bachelor's degree or higher */
gen byte bach=.
replace bach=0 if inrange(educ, 1, 5)
replace bach=1 if educ==4 | educ==5
lab var bach "Bachelor's degree or higher"
lab val bach noyes

/*
/* union/education interaction variables */
tab educ, gen(ed)
gen unioned1=uncov*ed1
gen unioned2=uncov*ed2
gen unioned3=uncov*ed3
gen unioned4=uncov*ed4
gen unioned5=uncov*ed5
*/


		/* WORK */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_recode_occ.do

/* self-employed (unincorporated) */
notes selfemp: Unincorporated self-employed only
notes selfemp: CPS: derived from a-clswkr, peio1cow
notes selfemp: For use with wages lognormal topcoding program

/* "hours vary" */
gen byte hrsvary=hoursvary
lab val hrsvary noyes
notes hrsvary: Available 1994- only
notes hrsvary: CPS: pehrusl1==-4

/* part-time */
gen pt=0 if hoursu1i~=.
replace pt=1 if (1<=hoursu1i & hoursu1i<35)
lab var pt "Part time usual hours"
lab val pt noyes

/* non-public sector, non-manufacturing */
gen byte privnonmanuf=0 if pubsec~=. & manuf~=.
replace privnonmanuf=1 if pubsec==0 & manuf==0
lab var privnonmanuf "Neither public sector nor manufacturing"
lab val privnonmanuf noyes

	/* Hourly wage (rounded) */

*identify top-coded wages for rounded variables w dynamic topcoding
gen earnhour_tcid=0 if earnhour~=.
replace earnhour_tcid=1 if year==2023 & month==4 & minsamp==4 & earnhour==float(65.24)
replace earnhour_tcid=1 if year==2023 & month==5 & minsamp==4 & earnhour==float(66.73)
replace earnhour_tcid=1 if year==2023 & month==6 & minsamp==4 & earnhour==float(60.51)
replace earnhour_tcid=1 if year==2023 & month==7 & minsamp==4 & earnhour==float(65.8)
replace earnhour_tcid=1 if year==2023 & month==8 & minsamp==4 & earnhour==float(65.89)
replace earnhour_tcid=1 if year==2023 & month==9 & minsamp==4 & earnhour==float(66.05)
replace earnhour_tcid=1 if year==2023 & month==10 & minsamp==4 & earnhour==float(69.44)
replace earnhour_tcid=1 if year==2023 & month==11 & minsamp==4 & earnhour==float(69.84)
replace earnhour_tcid=1 if year==2023 & month==12 & minsamp==4 & earnhour==float(68.39)
lab var earnhour_tcid "Top code indicator for earnhour (April 2023 onward)"
lab def earnhour_tcid  0 "Not topcoded" 1 "Topcoded"
lab val earnhour_tcid earnhour_tcid

* apply rounding rules to wages across years, months, and months in sample
gen earnhour2=earnhour
replace earnhour2=0.05 if (0.01<=earnhour & earnhour<=0.07) & earnhour_tcid==0
replace earnhour2=round(earnhour, 0.05) if (0.08<=earnhour & earnhour<=29.99) & earnhour_tcid==0
replace earnhour2=round(earnhour, 0.25) if (30<=earnhour & earnhour<=49.99) & earnhour_tcid==0
replace earnhour2=round(earnhour, 0.50) if (50<=earnhour) & earnhour_tcid==0
lab var earnhour2 "Hourly wage (rounded)"
notes earnhour2: https://cps.ipums.org/cps-action/variables/HOURWAGE2#description_section


	/* Weekly pay (rounded) */

*identify top-coded wages for rounded variables w dynamic topcoding
gen weekpay_noadj_tcid=0 if weekpay_noadj~=.
replace weekpay_noadj_tcid=1 if year==2023 & month==4 & minsamp==4 & weekpay_noadj==float(9646.46)
replace weekpay_noadj_tcid=1 if year==2023 & month==5 & minsamp==4 & weekpay_noadj==float(10792.4)
replace weekpay_noadj_tcid=1 if year==2023 & month==6 & minsamp==4 & weekpay_noadj==float(6891.89)
replace weekpay_noadj_tcid=1 if year==2023 & month==7 & minsamp==4 & weekpay_noadj==float(9088.55)
replace weekpay_noadj_tcid=1 if year==2023 & month==8 & minsamp==4 & weekpay_noadj==float(9189.07)
replace weekpay_noadj_tcid=1 if year==2023 & month==9 & minsamp==4 & weekpay_noadj==float(9356.71)
replace weekpay_noadj_tcid=1 if year==2023 & month==10 & minsamp==4 & weekpay_noadj==float(7717.69)
replace weekpay_noadj_tcid=1 if year==2023 & month==11 & minsamp==4 & weekpay_noadj==float(8390.67)
replace weekpay_noadj_tcid=1 if year==2023 & month==12 & minsamp==4 & weekpay_noadj==float(8608.64)
lab var weekpay_noadj_tcid "Top code indicator for weekpay_noadj (April 2023 onward)"
lab def weekpay_noadj_tcid  0 "Not topcoded" 1 "Topcoded"
lab val weekpay_noadj_tcid weekpay_noadj_tcid
	
* apply rounding rules to wages across years, months, and months in sample
gen weekpay_noadj2=weekpay_noadj
replace weekpay_noadj2=4.00 if (0.01<=weekpay_noadj & weekpay_noadj<=7.00) & weekpay_noadj_tcid==0
replace weekpay_noadj2=round(weekpay_noadj, 2.00) if (7.01<=weekpay_noadj & weekpay_noadj<=1199.00) & weekpay_noadj_tcid==0
replace weekpay_noadj2=round(weekpay_noadj, 10.00) if (1199.01<=weekpay_noadj & weekpay_noadj<=1999.00) & weekpay_noadj_tcid==0
replace weekpay_noadj2=round(weekpay_noadj, 20.00) if (2000.00<=weekpay_noadj) & weekpay_noadj_tcid==0
lab var weekpay_noadj2 "Weekly pay (rounded)"
notes weekpay_noadj2: Applies 2023 rounding rules to all years and months in sample
notes weekpay_noadj2: https://www.census.gov/programs-surveys/cps/technical-documentation/user-notes/cps_2023_01.html


	/* Weekly earnings overtime, tips, commissions (rounded) */
	
*identify top-coded wages for rounded variables w dynamic topcoding
gen otcamt_tcid=0 if otcamt~=.
replace otcamt_tcid=1 if year==2023 & month==4 & minsamp==4 & otcamt==float(1995.7)
replace otcamt_tcid=1 if year==2023 & month==5 & minsamp==4 & otcamt==float(1729.82)
replace otcamt_tcid=1 if year==2023 & month==6 & minsamp==4 & otcamt==float(2471.35)
replace otcamt_tcid=1 if year==2023 & month==7 & minsamp==4 & otcamt==float(2062.62)
replace otcamt_tcid=1 if year==2023 & month==8 & minsamp==4 & otcamt==float(1668.46)
replace otcamt_tcid=1 if year==2023 & month==9 & minsamp==4 & otcamt==float(2051.25)
replace otcamt_tcid=1 if year==2023 & month==10 & minsamp==4 & otcamt==float(1906.39)
replace otcamt_tcid=1 if year==2023 & month==11 & minsamp==4 & otcamt==float(1761.08)
replace otcamt_tcid=1 if year==2023 & month==12 & minsamp==4 & otcamt==float(1607.7)
lab var otcamt_tcid "Top code indicator for otcamt (April 2023 onward, minsamp 4)"
lab def otcamt_tcid  0 "Not topcoded" 1 "Topcoded"
lab val otcamt_tcid otcamt_tcid 

* apply rounding rules to wages across years, months, and months in sample
gen otcamt2=otcamt
replace otcamt2=4.00 if (0.01<=otcamt & otcamt<=7.00) & otcamt_tcid==0
replace otcamt2=round(otcamt, 2.00) if (7.01<=otcamt & otcamt<=1199.00) & otcamt_tcid==0
replace otcamt2=round(otcamt, 10.00) if (1199.01<=otcamt & otcamt<=1999.00) & otcamt_tcid==0
replace otcamt2=round(otcamt, 20.00) if (2000.00<=otcamt) & otcamt_tcid==0
notes otcamt2: Applies 2023 rounding rules to all years and months in sample
notes otcamt2: See https://www.census.gov/programs-surveys/cps/technical-documentation/user-notes/cps_2023_01.html


	/* Hourly wage for non-hourly workers (rounded) */
gen wage2=.
replace wage2=weekpay_noadj2/hoursu1 if paidhre==0
replace wage2=. if wage2<0
lab var wage2 "Hourly wage for nonhourly workers (rounded)"
notes wage2: Dollars per hour
notes wage2: For nonhourly workers only
notes wage2: Includes overtime, tips, commissions
notes wage2: Usual weekly earnings / usual weekly hours
notes wage2: weekpay_noadj2/hoursu1
notes wage2: Applies 2023 rounding rules to all years and months in sample

gen wage_noadj2=earnhour2 if paidhre==1
replace wage_noadj2=wage2 if paidhre==0
lab var wage_noadj2 "Hourly wage for hourly and non-hourly workers (rounded)"
notes wage_noadj2: Dollars per hour, for hourly & nonhourly workers
notes wage_noadj2: Approximates NBER's recommended wage variable
notes wage_noadj2: Includes overtime, tips, commissions for nonhourly
notes wage_noadj2: Excludes overtime, tips, commissions for hourly
notes wage_noadj2: No adjustments for top-coding, no trimming of outliers
notes wage_noadj2: Excludes nonhourly workers whose usual hours vary
notes wage_noadj2: Applies 2023 rounding rules to all years and months in sample


gen wageotc_noadj2=.
* for hourly workers
replace wageotc_noadj2=earnhour2 if paidhre==1
replace wageotc_noadj2=(weekpay_noadj2/hoursu1) if paidhre==1 & /*  
*/ (earnhour2<(weekpay_noadj2/hoursu1) & (weekpay/hoursu1)~=.)
replace wageotc_noadj2=earnhour2+(otcamt2/hoursuorg) if paidhre==1 & otcrec==1 & /*
*/ (0<otcamt2 & otcamt2~=.) & (0<peernhro & peernhro<=99)
* for nonhourly workers
replace wageotc_noadj2=wage_noadj2 if paidhre==0
replace wageotc_noadj2=. if wageotc_noadj2<0
lab var wageotc_noadj2 "Hourly wage - OTC consistent (rounded)"
notes wageotc_noadj2: Dollars per hour, for hourly and nonhourly workers
notes wageotc_noadj2: Includes overtime, tips, commissions for nonhourly and hourly
notes wageotc_noadj2: Covers only hourly workers who report hourly rate of pay
notes wageotc_noadj2: No adjustments for top-coding, no trimming of outliers
notes wageotc_noadj2: Excludes nonhourly workers whose usual hours vary
notes wageotc_noadj2: CPS: derived from wage_noadj2, weekpay_noadj2, hoursu1, otcamt2, otrec, peernhro
notes wageotc_noadj2: Applies 2023 rounding rules to all years and months in sample

/* CEPR's wage3 is wage_noadj */
/* CEPR's wage4 is wageotc_noadj */
do cepr_unadvtg2024_disability_cpsorg_recode_topcode_lognormal.do

/* load real wage program */
do cepr_unadvtg2024_disability_cpsorg_recode_realwage.do

/* calculate real wages (unrounded) */
gen w_ln_no=wage_noadj
replace w_ln_no=weekpay_noadj/hoursu1i if paidhre==0
replace w_ln_no=. if w_ln_no<0
  /* top-coding */
replace w_ln_no=$matclnm/hoursu1i if paidhre==0 & tc==1 & female==0
replace w_ln_no=$matclnf/hoursu1i if paidhre==0 & tc==1 & female==1
  /* real 2023 $, trimmed */
realw w_ln_no
gen rw=tw_ln_no
replace rw=. if tw_ln_no<$dol_b
replace rw=. if $dol_t<tw_ln_no
drop tw_ln_no
lab var rw "Real wage, 2023$"

/* calculate real wages (rounded) */
gen w_ln_no2=wage_noadj2
replace w_ln_no2=weekpay_noadj2/hoursu1i if paidhre==0
replace w_ln_no2=. if w_ln_no2<0
  /* top-coding */
replace w_ln_no2=$matclnm/hoursu1i if paidhre==0 & tc==1 & female==0
replace w_ln_no2=$matclnf/hoursu1i if paidhre==0 & tc==1 & female==1
  /* real 2023 $, trimmed */
realw w_ln_no2
gen rw2=tw_ln_no2
replace rw2=. if tw_ln_no2<$dol_b
replace rw2=. if $dol_t<tw_ln_no2
drop tw_ln_no2
lab var rw2 "Real wage, 2023$ (rounded)"


/* calculate real wages with overtime, tips, & commissions (unrounded) */
gen w_ot=wageotc_noadj 
replace w_ot=weekpay_noadj/hoursu1i if paidhre==0
replace w_ot=(weekpay_noadj/hoursu1i) if hrsvary==1 & paidhre==1 & /*
*/ (weekpay_noadj/hoursu1i)~=.

/* /* For hourly workers with information on peernhro, we use that
information to calculate wages with overtime, tips, and commissions. */
replace wageotc_noadj =wage1+(otcamt/peernhro) if paidhre==1 & /*
*/ otcrec==1 & (0<otcamt & otcamt~=.) & (0<peernhro & peernhro<=99)
} */
replace w_ot=. if w_ot<0
  /* top-coding */
replace w_ot=$matclnm/hoursu1i if paidhre==0 & tc==1 & female==0
replace w_ot=$matclnf/hoursu1i if paidhre==0 & tc==1 & female==1

  /* real 2023 $, trimmed */
realw w_ot
gen rw_ot=tw_ot
replace rw_ot=. if tw_ot<$dol_b
replace rw_ot=. if $dol_t<tw_ot
drop tw_ot
lab var rw_ot "Real wage, 2023$"

/* calculate real wages with overtime, tips, & commissions 
	applying 2023 rounding rules to all years */
gen w_ot2=wageotc_noadj2 
replace w_ot2=weekpay_noadj2/hoursu1i if paidhre==0
replace w_ot2 =(weekpay_noadj2/hoursu1i) if hrsvary==1 & paidhre==1 & /*
*/ (weekpay_noadj2/hoursu1i)~=. /*FLAG: should this be replace w_ot2? */

/* /* For hourly workers with information on peernhro, we use that
information to calculate wages with overtime, tips, and commissions. */
replace wageotc_noadj =wage1+(otcamt2/peernhro) if paidhre==1 & /*
*/ otcrec==1 & (0<otcamt2 & otcamt2~=.) & (0<peernhro & peernhro<=99)
} */
replace w_ot2=. if w_ot2<0
  /* top-coding */
replace w_ot2=$matclnm/hoursu1i if paidhre==0 & tc==1 & female==0
replace w_ot2=$matclnf/hoursu1i if paidhre==0 & tc==1 & female==1

  /* real 2023 $, trimmed */
realw w_ot2
gen rw_ot2=tw_ot2
replace rw_ot2=. if tw_ot<$dol_b
replace rw_ot2=. if $dol_t<tw_ot
drop tw_ot2
lab var rw_ot2 "Real wage, 2023$ (rounded)"

/* for wage analysis only, excludes imputed wages */
gen crw_ot=rw_ot
replace crw_ot=. if a_weekpay==1
replace crw_ot=. if a_earnhour==1
gen lncrw_ot=ln(crw_ot)

/* for wage analysis only, excludes imputed wages, 
	applies 2023 rounding rules to all years */
gen crw_ot2=rw_ot2
replace crw_ot2=. if a_weekpay==1
replace crw_ot2=. if a_earnhour==1
gen lncrw_ot2=ln(crw_ot2)

cd "$working"
saveold "cepr_cpsorg_2016–2023_recode.dta", replace

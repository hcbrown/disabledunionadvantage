clear
capture log close
set more off

/*
File:	cepr_unadvtg2024_disability_cpsorg_recode_merge.do
Date:	July 2024
Desc:	Recoding variables from the raw CPS to merge with EPI extracts for 
		Union Advantage for People with Disabilities project
*/

cd "$working"
cd "raw_CPS"
use cps_basic_2016–2023.dta

/* general label for dummy variables */
lab def noyes 0 No 1 Yes 

/* drop non-ORG observations */
drop if pworwgt<=0 | pworwgt==. /* drop if observation has missing ORG weight */

		/* Household and person identification */

/* Household identification number: hhid */
lab var hrhhid "Household ID"
notes hrhhid: Unique to address, not household 
notes hrhhid: From May 2004-, concatenate hhid2 with hhid to uniquely identify HH
notes hrhhid: CPS: hrhhid

/* Household identifier 2: hhid 2 */
lab var hrhhid2 "Household ID Part 2"
notes hrhhid2: Unique to address, not household
notes hrhhid2: From May 2004-, concatenate hhid2 with hhid to uniquely identify HH
notes hrhhid2: CPS: hrhhid2

/* Person number (unique within household): personid */
replace pulineno=. if pulineno<0
lab var pulineno "Person line number within household"
notes pulineno: CPS: pulineno

		/* Time variables */
		
/* Year */
rename year readyear
gen byte year=.
replace year=hryear4
lab var year "Year"
notes year: CPS: hryear4

/* Month of interview */
gen byte month=.
replace month=hrmonth
lab var month "Month"
notes month: CPS: hrmonth

/* Month in sample */
gen byte minsamp=.
replace minsamp=hrmis
assert minsamp>=1 & minsamp<=8
lab var minsamp "Month in sample"
notes minsamp: CPS: hrmis

/* State (FIPS codes) */
gen byte statefips=.
replace statefips=gestfips
lab var statefips "State - FIPS code"
#delimit ;
lab def statefips
1 "Alabama"
2 "Alaska"
4 "Arizona"
5 "Arkansas"
6 "California"
8 "Colorado"
9 "Connecticut"
10 "Delaware"
11 "District of Columbia"
12 "Florida"
13 "Georgia"
15 "Hawaii"
16 "Idaho"
17 "Illinois"
18 "Indiana"
19 "Iowa"
20 "Kansas"
21 "Kentucky"
22 "Louisiana"
23 "Maine"
24 "Maryland"
25 "Massachusetts"
26 "Michigan"
27 "Minnesota"
28 "Mississippi"
29 "Missouri"
30 "Montana"
31 "Nebraska"
32 "Nevada"
33 "New Hampshire"
34 "New Jersey"
35 "New Mexico"
36 "New York"
37 "North Carolina"
38 "North Dakota"
39 "Ohio"
40 "Oklahoma"
41 "Oregon"
42 "Pennsylvania"
44 "Rhode Island"
45 "South Carolina"
46 "South Dakota"
47 "Tennessee"
48 "Texas"
49 "Utah"
50 "Vermont"
51 "Virginia"
53 "Washington"
54 "West Virginia"
55 "Wisconsin"
56 "Wyoming"
;
#delimit cr
lab val statefips statefips
notes statefips: 1994-present, CPS: gestfips

		/* Detailed industry and occupation */
rename peio1icd dind16
rename peio1ocd docc16
rename ptio1ocd docc21

* peio1icd is used in 2016 through 2020
* ptio1ocd is used in 2021 through 2023

		/* Disability */
		
/* Difficulty hearing */
gen byte disear=.
replace disear=0 if pedisear==2
replace disear=1 if pedisear==1
lab var disear "Difficulty hearing"
lab val disear noyes
notes disear: Deaf or serious difficulty hearing
notes disear: CPS: pedisear

/* Difficulty seeing */
gen byte diseye=.
replace diseye=0 if pediseye==2
replace diseye=1 if pediseye==1
lab var diseye "Difficulty seeing"
lab val diseye noyes
notes diseye: Blind or serious difficulty seeing, even when wearing glasses
notes diseye: CPS: pediseye

/* Cognitive difficulty */
gen byte discog=.
replace discog=0 if pedisrem==2
replace discog=1 if pedisrem==1
lab var discog "Cognitive difficulty"
lab val discog noyes
notes discog: Serious difficulty concentrating, remembering, or making decisions
notes discog: CPS: pedisrem

/* Ambulatory difficulty */
gen byte disamb=. 
replace disamb=0 if pedisphy==2
replace disamb=1 if pedisphy==1
lab var disamb "Ambulatory difficulty"
lab val disamb noyes
notes disamb: Serious difficulty walking or climbing stairs
notes disamb: CPS: pedisphy

/* Personal care difficulty */
gen byte discare=.
replace discare=0 if pedisdrs==2
replace discare=1 if pedisdrs==1
lab var discare "Personal care difficulty"
lab val discare noyes
notes discare: Serious difficulty dressing or bathing
notes discare: CPS: pedisdrs

/* Independent living (running errands alone) difficulty */
gen byte disind=.
replace disind=0 if pedisout==2
replace disind=1 if pedisout==1
lab var disind "Difficulty running errands alone"
lab val disind noyes
notes disind: Serious difficulty running errands alone, e.g. visiting doctor or shopping
notes disind: CPS: pedisout

/* Any difficulty */
gen byte disability=.
replace disability=0 if prdisflg==2
replace disability=1 if prdisflg==1
lab var disability "Any difficulty"
lab val disability noyes
notes: CPS: prdisflg

/* disability type single disabilities only */
gen byte distyp=7 if disability==1
replace distyp=1 if disear==1 & diseye==0 & discog==0 & disamb==0 & disind==0 & discare==0
replace distyp=2 if diseye==1 & disear==0 & discog==0 & disamb==0 & disind==0 & discare==0
replace distyp=3 if discog==1 & diseye==0 & disear==0 & disamb==0 & disind==0 & discare==0
replace distyp=4 if disamb==1 & diseye==0 & disear==0 & discog==0 & disind==0 & discare==0
replace distyp=5 if disind==1 & diseye==0 & disear==0 & discog==0 & disamb==0 & discare==0
replace distyp=6 if discare==1 & diseye==0 & disear==0 & discog==0 & disamb==0 & disind==0
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

keep year month hrhhid hrhhid2 pulineno statefips minsamp peernhro dind16 docc16 docc21 /*
disability*/ disear diseye discog disamb discare disind disability distyp dismult

cd "$working"
save "cepr_cpsorg_2016–2023.dta", replace

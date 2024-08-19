clear

/*
File:	cepr_unadvtg2024_disability_cpsorg_merge.do
Date:	July 2024
Desc:	Merges EPI extracts with raw files to add disability variables
	
*/


/* test to see merge results */

cd "$working"
use "epi_cpsorg_2016–2023.dta", clear
merge 1:1 year month statefips hrhhid hrhhid2 pulineno using "cepr_cpsorg_2016–2023.dta"
clear

/* create clean file */
cd "$working"
use "epi_cpsorg_2016–2023.dta", clear
merge 1:1 year month statefips hrhhid hrhhid2 pulineno using "cepr_cpsorg_2016–2023.dta", keep(match) nogenerate
save "epicepr_cpsorg_2016–2023.dta", replace
clear 

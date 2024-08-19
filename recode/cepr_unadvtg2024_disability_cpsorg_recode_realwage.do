set more 1

/*
File:	cepr_unadvtg2024_disability_cpsorg_recode_realwage.do
Date:	July 2024
Desc:	Converts nominal to real wages using the R-CPI-U-RS
*/

capture program drop realw
program define realw
version 7.0
* create real wage variable for analysis
* convert to $2023 using R-CPI-U-RS
* (see BLS R-CPI-U-RS table at https://www.bls.gov/cpi/research-series/r-cpi-u-rs-home.htm)
* accessed May 2024

local basecpi=449.3  /* 2023 CPI-U-RS */

local wage "`1'"
gen t`wage'=.
replace t`wage'=`wage'/(352.8/`basecpi') if year==2016
replace t`wage'=`wage'/(360.3/`basecpi') if year==2017
replace t`wage'=`wage'/(369.1/`basecpi') if year==2018
replace t`wage'=`wage'/(375.8/`basecpi') if year==2019
replace t`wage'=`wage'/(380.8/`basecpi') if year==2020
replace t`wage'=`wage'/(399.2/`basecpi') if year==2021
replace t`wage'=`wage'/(431.5/`basecpi') if year==2022
replace t`wage'=`wage'/(449.3/`basecpi') if year==2023


*
* CEPR CPS ORG preferred wage variable "trims" wage observations
* below $0.50 and above $200 in 1989 constant dollars
*
global dol_b=0.50/(188.6/`basecpi')
global dol_t=200/(188.6/`basecpi')
*
end

clear
capture log close
set more off

/*
File:	cepr_unadvtg2024_disability_master.do
Date:	July 2024
Desc:	Master File for Union Advantage for People with Disabilities paper
*/

/* set directories */

global do "/Users/glooper/CEPR Dropbox/Data/homestata/projects/unions/union_advantage_2024/union_2024_disability/do" /* do files */
global census "/Users/glooper/CEPR Dropbox/Data/homestata/projects/unions/union_advantage_2024/union_2024_disability/data/census" /* raw Census CPS */
global ipums "/Users/glooper/CEPR Dropbox/Data/homestata/projects/unions/union_advantage_2024/union_2024_disability/data/ipums" /* ipums */
global working "/Users/glooper/CEPR Dropbox/Data/homestata/projects/unions/union_advantage_2024/union_2024_disability/data/working" /* working data files */
global log "/Users/glooper/CEPR Dropbox/Data/homestata/projects/unions/union_advantage_2024/union_2024_disability/log" /* log files */

/* executables */
global gzip "/usr/bin/gzip"
global unzip "/usr/bin/unzip"
global copy "/bin/cp"
global erase "/bin/rm"

					/* for CPS ORG */

/* read raw data */
cd "$do"
cd "read"
do cepr_unadvtg2024_disability_cpsorg_read_2021–2023.do /* use CEPRdata raw files for other years */

/* combine all years into one file */
cd "$do"
cd "read"
do cepr_unadvtg2024_disability_cpsorg_combine_2016–2023.do

/* recode raw data */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_recode_merge.do

/* merge data */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_disability_merge.do

/* recode merged extract */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_recode_2016–2023.do

/* unweighted union density descriptive stats (for sample size evaluations) */
cd "$do"
do cepr_unadvtg2024_disability_desc_density_unweighted.do

/* union density descriptive stats */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_desc_density.do

/* descriptive stats for wages */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_desc_wages.do

/* run wage regressions */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_regressions_wages_rounded.do
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_regressions_wages_unrounded.do

/* recode ipums ORG extract for 2009–2023 */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_recode_2009-2023.do

/* union density descriptive stats by year, 2009–2023 */
cd "$do"
do cepr_unadvtg2024_disability_cpsorg_desc_density_2009–2023.do


					/* for CPS ASEC */
					
/* recode IPUMS extract */
cd "$do"
do cepr_unadvtg2024_disability_cpsasec_recode_2016-2023.do

/* descriptive stats for benefits */
cd "$do"
do cepr_unadvtg2024_disability_cpsasec_desc_benefits.do

/* unweighted descriptive stats for benefits (for sample size evaluations) */
cd "$do"
do cepr_unadvtg2024_disability_cpsasec_desc_benefits_unweighted.do

/* run benefit regressions */
cd "$do"
do cepr_unadvtg2024_disability_cpsasec_regressions_benefits.do


# The Union Advantage for Workers with Disabilities: Higher Pay, More Benefits
This repository contains replication files for "The Union Advantage for Workers with Disabilities: Higher Pay, More Benefits". It contains a series of Stata do files that recode and analyze data from the Current Population Survey Outgoing Rotation Group (CPS ORG) and the Current Populatioh Survey Annual Social and Economic Supplement (CPS ASEC). To reproduce the results, (1) download the data, (2) adjust your directories, and (3) use the [master file](/cepr_unadvtg2024_disability_master.do) to run the code in order.

## The data
The wage analysis relies on recoded CPS ORG [microdata extracts from the Economic Policy Institute](https://microdata.epi.org/) merged with recoded [public-use CPS ORG microdata from the Census](https://www.census.gov/data/datasets/time-series/demo/cps/cps-basic.html). My analysis adapts a set of adjustments developed by John Schmitt to create a consistent hourly wage series so that the adjustments reflect both the new top-coding rules and the [2023 CPS rounding rules](https://www.census.gov/programs-surveys/cps/technical-documentation/user-notes/2023-cps-puf-changes.html), which are applied to all years for consistency. The code for this can be found in [cepr_unadvtg2024_disability_cpsorg_recode_2016–2023.do](recode/cepr_unadvtg2024_disability_cpsorg_recode_2016–2023.do)

The benefits analysis relies on recoded [CPS ASEC data from IPUMS](https://cps.ipums.org/cps). 

The code used to read the raw Census data, including data dictionaries, can be found in the ["read" folder](/read). The code used to merge and recode the data to prepare it for analysis can be found in the ["recode" folder](/recode).

## The analysis
The code used to generate descriptive statistics, including the mean hourly wages of non-union workers and the share of non-union workers with employer-sponsored health insurance and retirement coverage, can be found in the ["desc" folder](/desc).

The code for the regressions can be found in the ["regression" folder](/regression). All regressions include adjustments for age, age squared, education (less than high school, high school, some college, bachelor's degree, and advanced), gender (when men and women appear in the same regression), race/ethnicity (when those of different races/ ethnicities appear the same regression), year, state, COVID-19 pandemic status, US citizenship, type of disability (when those with different types of difficulty appear in the same regression), presence of multiple types of disability (when disabled people are included in a regression), part-time hours, public sector, and two-digit occupation and industry. 

The wage regressions used to generate the results in the report can be founding in [cepr_unadvtg2024_disability_cpsorg_regressions_wages_rounded.do](regression/cepr_unadvtg2024_disability_cpsorg_regressions_wages_rounded.do). Regression-adjusted union wage premiums are calculated using ordinary least squares - see. Union wage premiums in percent are converted from log points by taking the antilog of regression coefficients and subtracting one. Union wage premiums in dollars are calculated relative to mean non-union wages for a given group. The final report reflects the application of the 2023 CPS rounding rules to all years. However, I also ran [the regressions without the rounding rules](regression/cepr_unadvtg2024_disability_cpsorg_regressions_wages_unrounded.do) and confirmed that the rounding had a negligible impact on my results in this case.

The benefit regressions used to generate the results in the report can be founding in[cepr_unadvtg2024_disability_cpsasec_regressions_benefits.do](regression/cepr_unadvtg2024_disability_cpsasec_regressions_benefits.do). Employer-sponsored benefit coverage regressions are probits. Union health insurance and retirement coverage increases in percent terms are relative to the current coverage rates for non-union workers.


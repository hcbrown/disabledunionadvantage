clear
capture log close
set more off

/*
File:	cepr_unadvtg2024_disability_cpsorg_combine_2016–2023.do
Date:	July 2024
Desc:	Combine months and years

*/

		/* append monthly files into annual files */

/* 2016 */
cd "$census"
cd "2016"
use "cps_basic_2016–01.dta"
append using "cps_basic_2016–02.dta"
append using "cps_basic_2016–03.dta"
append using "cps_basic_2016–04.dta"
append using "cps_basic_2016–05.dta"
append using "cps_basic_2016–06.dta"
append using "cps_basic_2016–07.dta"
append using "cps_basic_2016–08.dta"
append using "cps_basic_2016–09.dta"
append using "cps_basic_2016–10.dta"
append using "cps_basic_2016–11.dta"
append using "cps_basic_2016–12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2016_01–12.dta", replace

/* 2017 */
cd "$census"
cd "2017"
use "cps_basic_2017–01.dta"
append using "cps_basic_2017–02.dta"
append using "cps_basic_2017–03.dta"
append using "cps_basic_2017–04.dta"
append using "cps_basic_2017–05.dta"
append using "cps_basic_2017–06.dta"
append using "cps_basic_2017–07.dta"
append using "cps_basic_2017–08.dta"
append using "cps_basic_2017–09.dta"
append using "cps_basic_2017–10.dta"
append using "cps_basic_2017–11.dta"
append using "cps_basic_2017–12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2017_01–12.dta", replace

/* 2018 */
cd "$census"
cd "2018"
use "cps_basic_raw_2018_1.dta"
append using "cps_basic_raw_2018_2.dta"
append using "cps_basic_raw_2018_3.dta"
append using "cps_basic_raw_2018_4.dta"
append using "cps_basic_raw_2018_5.dta"
append using "cps_basic_raw_2018_6.dta"
append using "cps_basic_raw_2018_7.dta"
append using "cps_basic_raw_2018_8.dta"
append using "cps_basic_raw_2018_9.dta"
append using "cps_basic_raw_2018_10.dta"
append using "cps_basic_raw_2018_11.dta"
append using "cps_basic_raw_2018_12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2018_01–12.dta", replace

/* 2019 */
cd "$census"
cd "2019"
use "cps_basic_raw_2019_1.dta"
append using "cps_basic_raw_2019_2.dta"
append using "cps_basic_raw_2019_3.dta"
append using "cps_basic_raw_2019_4.dta"
append using "cps_basic_raw_2019_5.dta"
append using "cps_basic_raw_2019_6.dta"
append using "cps_basic_raw_2019_7.dta"
append using "cps_basic_raw_2019_8.dta"
append using "cps_basic_raw_2019_9.dta"
append using "cps_basic_raw_2019_10.dta"
append using "cps_basic_raw_2019_11.dta"
append using "cps_basic_raw_2019_12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2019_01–12.dta", replace

/* 2020 */
cd "$census"
cd "2020"
use "cps_basic_raw_2020_1.dta"
append using "cps_basic_raw_2020_2.dta"
append using "cps_basic_raw_2020_3.dta"
append using "cps_basic_raw_2020_4.dta"
append using "cps_basic_raw_2020_5.dta"
append using "cps_basic_raw_2020_6.dta"
append using "cps_basic_raw_2020_7.dta"
append using "cps_basic_raw_2020_8.dta"
append using "cps_basic_raw_2020_9.dta"
append using "cps_basic_raw_2020_10.dta"
append using "cps_basic_raw_2020_11.dta"
append using "cps_basic_raw_2020_12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2020_01–12.dta", replace

/* 2021 */
cd "$census"
cd "2021"
use "cps_basic_raw_2021_1.dta"
append using "cps_basic_raw_2021_2.dta"
append using "cps_basic_raw_2021_3.dta"
append using "cps_basic_raw_2021_4.dta"
append using "cps_basic_raw_2021_5.dta"
append using "cps_basic_raw_2021_6.dta"
append using "cps_basic_raw_2021_7.dta"
append using "cps_basic_raw_2021_8.dta"
append using "cps_basic_raw_2021_9.dta"
append using "cps_basic_raw_2021_10.dta"
append using "cps_basic_raw_2021_11.dta"
append using "cps_basic_raw_2021_12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2021_01–12.dta", replace

/* 2022 */
cd "$census"
cd "2022"
use "cps_basic_raw_2022_1.dta"
append using "cps_basic_raw_2022_2.dta"
append using "cps_basic_raw_2022_3.dta"
append using "cps_basic_raw_2022_4.dta"
append using "cps_basic_raw_2022_5.dta"
append using "cps_basic_raw_2022_6.dta"
append using "cps_basic_raw_2022_7.dta"
append using "cps_basic_raw_2022_8.dta"
append using "cps_basic_raw_2022_9.dta"
append using "cps_basic_raw_2022_10.dta"
append using "cps_basic_raw_2022_11.dta"
append using "cps_basic_raw_2022_12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2022_01–12.dta", replace

/* 2023 */
cd "$census"
cd "2023"
use "cps_basic_raw_2023_1.dta"
append using "cps_basic_raw_2023_2.dta"
append using "cps_basic_raw_2023_3.dta"
append using "cps_basic_raw_2023_4.dta"
append using "cps_basic_raw_2023_5.dta"
append using "cps_basic_raw_2023_6.dta"
append using "cps_basic_raw_2023_7.dta"
append using "cps_basic_raw_2023_8.dta"
append using "cps_basic_raw_2023_9.dta"
append using "cps_basic_raw_2023_10.dta"
append using "cps_basic_raw_2023_11.dta"
append using "cps_basic_raw_2023_12.dta"

cd "$working"
cd "raw_CPS"
save "cps_basic_2023_01–12.dta", replace

/* combine annual files into one file (raw data) */
cd "$working"
cd "raw_CPS"
use "cps_basic_2016_01–12.dta"
append using "cps_basic_2017_01–12.dta"
append using "cps_basic_2018_01–12.dta"
append using "cps_basic_2019_01–12.dta"
append using "cps_basic_2020_01–12.dta"
append using "cps_basic_2021_01–12.dta"
append using "cps_basic_2022_01–12.dta"
append using "cps_basic_2023_01–12.dta"
save "cps_basic_2016–2023.dta", replace

/* combine annual files into one file (epi extracts) */
cd "$epi"
use "epi_cpsorg_2016.dta"
append using "epi_cpsorg_2017.dta"
append using "epi_cpsorg_2018.dta"
append using "epi_cpsorg_2019.dta"
append using "epi_cpsorg_2020.dta"
append using "epi_cpsorg_2021.dta"
append using "epi_cpsorg_2022.dta"
append using "epi_cpsorg_2023.dta"
cd "$working"
save "epi_cpsorg_2016–2023.dta", replace


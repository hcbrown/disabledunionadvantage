/*
File:	cepr_unadvtg2024_disability_cpsorg_read_2021–2023.do
Date:	July 2024
Desc:	Read raw files for CPS Basic 2021–2023
*/

/* 2021 */
capture program drop b2021
program define b2021
local i=1
while `i'<=12 {
 /* Jan–Feb 2021 */
 	if 1<=`i' & `i'<=2 {
		cd "$census"
		cd "2021"
		!gzip -d cpsb_2021_`i'.txt.gz 
		/*orginal file name "month"21pub.dat.Z */
		!$copy cpsb_2021_`i'.txt "$census/2021/cpsb2021_01-02.txt"
		local dat_name "$census/2021/cpsb2021_01-02.txt"
		local dct_name "$do/read/dictionary_cpsorg_read_2020_01.dct" /* uses Jan 2020 coding */
		qui infile using "`dct_name'", using("`dat_name'") clear
		gen int year=2021
		compress
		cd "$census"
		cd "2021"
		saveold cps_basic_raw_2021_`i'.dta, replace
		!gzip -vN cpsb_2021_`i'.txt /* recompress */
		!$erase cpsb2021_01-02.txt
		}
 /* Mar–Dec 2021 */
	if 3<=`i' & `i'<=12 {
		cd "$census"
		cd "2021"
		!gzip -d cpsb_2021_`i'.txt.gz 
		/*orginal file name "month"21pub.dat.Z */
		!$copy cpsb_2021_`i'.txt "$census/2021/cpsb2021_03-12.txt"
		local dat_name "$census/2021/cpsb2021_03-12.txt"
		local dct_name "$do/read/dictionary_cpsorg_read_2021_03.dct" /* uses Mar 2021 coding */
		qui infile using "`dct_name'", using("`dat_name'") clear
		gen int year=2021
		compress
		cd "$census"
		cd "2021"
		saveold cps_basic_raw_2021_`i'.dta, replace
		!gzip -vN cpsb_2021_`i'.txt /* recompress */
		!$erase cpsb2021_03-12.txt
		}
local i=`i'+1
} /* loop through months */
end

/* 2022 */
capture program drop b2022
program define b2022
local i=1
while `i'<=12 {
 /* Jan–Dec 2022 */
	if 1<=`i' & `i'<=12 {
		cd "$census"
		cd "2022"
		!gzip -d cpsb_2022_`i'.txt.gz 
		/*orginal file name "month"22pub.dat.gz */
		!$copy cpsb_2022_`i'.txt "$census/2022/cpsb2022_01-12.txt"
		local dat_name "$census/2022/cpsb2022_01-12.txt"
		local dct_name "$do/read/dictionary_cpsorg_read_2021_03.dct"  /* uses Mar 2021 coding */
		qui infile using "`dct_name'", using("`dat_name'") clear
		gen int year=2022
		compress
		cd "$census"
		cd "2022"
		saveold cps_basic_raw_2022_`i'.dta, replace
		!gzip -vN cpsb_2022_`i'.txt /* recompress */
		!$erase cpsb2022_01-12.txt
		}
local i=`i'+1
} /* loop through months */
end

/* 2023 */
capture program drop b2023
program define b2023
local i=1
while `i'<=12 {
 /* Jan–Dec 2023 */
	if 1<=`i' & `i'<=12 {
		cd "$census"
		cd "2023"
		!gzip -d cpsb_2023_`i'.txt.gz 
		/*orginal file name "month"23pub.dat.gz */
		!$copy cpsb_2023_`i'.txt "$census/2023/cpsb2023_01-12.txt"
		local dat_name "$census/2023/cpsb2023_01-12.txt"
		local dct_name "$do/read/dictionary_cpsorg_read_2023_01.dct"  /* uses Jan 2023 coding */
		qui infile using "`dct_name'", using("`dat_name'") clear
		gen int year=2023
		compress
		cd "$census"
		cd "2023"
		saveold cps_basic_raw_2023_`i'.dta, replace
		!gzip -vN cpsb_2023_`i'.txt /* recompress */
		!$erase cpsb2023_01-12.txt
		}
local i=`i'+1
} /* loop through months */
end


b2021 /* read 2021 data months 1-12 */
b2022 /* read 2022 data months 1-12 */
b2023 /* read 2023 data months 1-12 */

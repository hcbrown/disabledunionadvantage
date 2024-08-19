clear

/*
File:	cepr_unadvtg2024_disability_cpsorg_desc_density.do
Date:	July 2024
Desc:	Union density by disability for union advantage report

*/

/* set directories */

cd "$log"
log using cepr_unadvtg2024_disability_cpsorg_desc_density.log, replace

cd "$working"
use "cepr_cpsorg_2016–2023_recode.dta"

*******************************************************************************
		************ Union representation density ************ 
*******************************************************************************

				*********** SHARES ***************	
* all disability
tab union disability [aw=rndwgt] if lfstat==1, col nofreq

			/* type of disability */
* hearing difficulty
tab union disear [aw=rndwgt] if lfstat==1, col nofreq

* vision difficulty
tab union diseye [aw=rndwgt] if lfstat==1, col nofreq

* cognitive difficulty
tab union discog [aw=rndwgt] if lfstat==1, col nofreq

* ambulatory difficulty
tab union disamb [aw=rndwgt] if lfstat==1, col nofreq

* self-care difficulty
tab union discare [aw=rndwgt] if lfstat==1, col nofreq

* difficulty running errands
tab union disind [aw=rndwgt] if lfstat==1, col nofreq

* only one vs multiple disabilities
tab union distyp [aw=rndwgt] if lfstat==1, col nofreq

			/* prime age */
tab union disability [aw=rndwgt] if lfstat==1 & prmage==1, col nofreq
			
			/* gender */
* women
tab union disability [aw=rndwgt] if lfstat==1 & female==1, col nofreq			

* men
tab union disability [aw=rndwgt] if lfstat==1 & female==0, col nofreq

			/* race/ethnicity */
* white
tab union disability [aw=rndwgt] if lfstat==1 & wbhao==1, col nofreq

* Black
tab union disability [aw=rndwgt] if lfstat==1 & wbhao==2, col nofreq

* Hispanic
tab union disability [aw=rndwgt] if lfstat==1 & wbhao==3, col nofreq

* AAPI
tab union disability [aw=rndwgt] if lfstat==1 & wbhao==4, col nofreq

			/* Union representation density by year */
* all disability
bysort year: tab union disability [aw=rndwgt] if lfstat==1, col nofreq


				*********** FREQUENCIES ***************

* all disability
tab union disability [fw=rndwgt] if lfstat==1

			/* type of disability */

* hearing difficulty
tab union disear [fw=rndwgt] if lfstat==1

* vision difficulty
tab union diseye [fw=rndwgt] if lfstat==1

* cognitive difficulty
tab union discog [fw=rndwgt] if lfstat==1

* ambulatory difficulty
tab union disamb [fw=rndwgt] if lfstat==1

* self-care difficulty
tab union discare [fw=rndwgt] if lfstat==1

* difficulty running errands
tab union disind [fw=rndwgt] if lfstat==1

* only one vs multiple disabilities
tab union distyp [fw=rndwgt] if lfstat==1

			/* prime age */
tab union disability [fw=rndwgt] if lfstat==1 & prmage==1 
			
			/* gender */
* women
tab union disability [fw=rndwgt] if lfstat==1 & female==1 

* men
tab union disability [fw=rndwgt] if lfstat==1 & female==0 

			/* race/ethnicity */
* white
tab union disability [fw=rndwgt] if lfstat==1 & wbhao==1 

* Black
tab union disability [fw=rndwgt] if lfstat==1 & wbhao==2 

* Hispanic
tab union disability [fw=rndwgt] if lfstat==1 & wbhao==3 

* AAPI
tab union disability [fw=rndwgt] if lfstat==1 & wbhao==4 

			/* Union representation density by year */
* all disability
bysort year: tab union disability [fw=rndwgt] if lfstat==1
		
		
log close

clear

/*
File:	cepr_unadvtg2024_disability_cpsorg_desc_density_2009–2023.do
Date:	July 2024
Desc:	Union density by disability for union advantage report

*/

/* set directories */

cd "$log"
log using cepr_unadvtg2024_disability_cpsorg_desc_density_2009–2023.log, replace

cd "$working"
use "cepr_cpsorg_2009–2023_recode.dta"

		/* Union representation density by year */
/* all disability */
bysort year: tab union disability [fw=rndwgt] if lfstat==1
bysort year: tab union disability [aw=rndwgt] if lfstat==1, col nofreq

/* hearing difficulty */
bysort year: tab union disear [fw=rndwgt] if lfstat==1
bysort year: tab union disear [aw=rndwgt] if lfstat==1, col nofreq

/* vision difficulty */
bysort year: tab union diseye [fw=rndwgt] if lfstat==1
bysort year: tab union diseye [aw=rndwgt] if lfstat==1, col nofreq

/* cognitive difficulty */
bysort year: tab union discog [fw=rndwgt] if lfstat==1
bysort year: tab union discog [aw=rndwgt] if lfstat==1, col nofreq

/* ambulatory difficulty */
bysort year: tab union disamb [fw=rndwgt] if lfstat==1
bysort year: tab union disamb [aw=rndwgt] if lfstat==1, col nofreq

/* self-care difficulty */
bysort year: tab union discare [fw=rndwgt] if lfstat==1
bysort year: tab union discare [aw=rndwgt] if lfstat==1, col nofreq

/* difficulty running errands */
bysort year: tab union disind [fw=rndwgt] if lfstat==1
bysort year: tab union disind [aw=rndwgt] if lfstat==1, col nofreq

/* only one vs multiple disabilities */
bysort year: tab union distyp [fw=rndwgt] if lfstat==1
bysort year: tab union distyp [aw=rndwgt] if lfstat==1, col nofreq
		
		
log close

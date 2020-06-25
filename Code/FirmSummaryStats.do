* Firm Output and innovation using citation-weighted patents (Panel b of Table 5 in the paper) 

clear all

cd "E:\Dropbox\Datasets\Patents\codeReplication2\Data"

use "firm_data.dta", clear

tsset permno year

 
* rescale measure by 1-prob of acceptance
replace  Af=Af/(1-0.56) * 100

replace  Acw=Acw * 100

 

gen F0logX=(logX-L.logX)  * 100
gen ninv1=(logK-L.logK)  * 100
gen demp1=(logH-L.logH)  * 100
gen F0logP=(logP-L.logP)  * 100
gen F0logY=(logY-L.logY)  * 100
replace logX=logX  * 100

drop if missing(LlogK)
drop if missing(LlogH)
drop if missing(AfI)     
drop if missing(Af)
drop if missing(indcd)
drop if missing(AcwI)
drop if missing(Acw)
drop if missing(Lvol_iret)
drop if missing(year)

label var Af "Innovation Output, SM-weighted"
label var Acw "Innovation Output, C-weighted"
label var F0logP "Profits, growth rate"
label var F0logY "Output, growth rate"
label var ninv1 "Capital stock, growth rate"
label var demp1 "Employment, growth rate"
label var logX "TFPR, log"



tabstat Af Acw  F0logP F0logY ninv1 demp1 logX,  stats(mean sd p10 p25 p50 p75 p90)  format(%9.1f) column(stat)   
 
 
 
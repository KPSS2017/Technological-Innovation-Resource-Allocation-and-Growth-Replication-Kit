
/* This script replicates the aggregate measures of innovation(Figure 4 of the paper) */
 
/* Create Aggregate index*/ 
clear
clear matrix
cd "E:\Dropbox\Patents\codeReplication2\Data"

set mem 1g
use  mkcap, clear
 
sort permno year

merge 1:1 permno year using firm_Af.dta
drop _merge
sort permno year

drop if sicc >= 6000 &  sicc <= 6799 
drop if sicc >= 4900 &  sicc <= 4949

drop if missing(mkcap)
 
replace Af=0 if missing(Af)

collapse (sum) mkcap  Af  AfNpats, by(year)
 
sort year
tsset year
 
/* Merge with Output and Population Data*/ 
merge 1:1 year using "AggData.dta"
drop if _merge==2
drop _merge

/* Merge Inflation Data*/ 
merge   1:1 year using "cpi.dta"
drop if _merge==2
drop _merge

* Merge with raw patent counts (all patents, not just to public firms)
merge 1:1 year using "patcount.dta"
drop if _merge==2
drop _merge

 
* Merge with Alexopoulos Measure
merge 1:1 year using "books.dta"
drop if _merge==2
drop _merge

* Merge with RD Data
merge 1:1 year using "RDdata.dta"
drop if _merge==2
drop _merge


gen ValuePerPatent=Af/(1-0.55)/AfNpats/cpi

gen logValuePerPatent=log(ValuePerPatent)


* Total Number of Patents per capita
gen A4=log(patnum/pop_y3)

* Books
gen A0tech=log(tech/pop_y3)
gen A0tech2=log(tech2/pop_y3)

* RD spendix
gen rdI=log(RDinvALLreal/pop_y3)
gen rdIK=(RDinvALLreal/RDstockALLreal)

 
 * RD per patent (all)
gen rdIN=log(RDinvALLreal/patnum)
gen RDdef= RDinvALLreal/ RDinvALL

gen costs2benefits=log(RDinvALLreal/patnum) - logValuePerPatent
gen benefits2costs=logValuePerPatent-log(RDinvALLreal/patnum)

 
* Create innovation indices 
gen AA1=log(Af/gdp/1000)
gen AA2=log(Af/mkcap*1000)


* Figure 4 (A)
label var AA1 "Innovation Index (scaled by GDP)" 
tsline AA1
graph export "../measures1.eps", replace

* Figure 4 (B)
label var AA2 "Innovation Index (scaled by Stock Market Cap)" 
tsline  AA2
graph export "../measures2.eps", replace

* Figure 4 (C)
label var A4 "Patents per capita" 
tsline A4
graph export "../npatents.eps", replace

* Figure 4 (D)
label var  logValuePerPatent "Value per patent, log" 
tsline logValuePerPatent
graph export "../Vperpatent.eps", replace

* Figure 4 (E)
label var  rdIN "RD per patent, log" 
tsline rdIN
graph export "../RDperpatent.eps", replace

* Figure 4 (F)
label var costs2benefits "Costs vs benefits of RD, log" 
tsline costs2benefits
graph export "../costsVSbenefits.eps", replace


label var  A0tech2  "New technology books, log" 
tsline A0tech2 
graph export "../books.eps", replace

label var  rdIK  "RD investment rate " 
tsline rdIK
graph export "../rdIK.eps", replace

 


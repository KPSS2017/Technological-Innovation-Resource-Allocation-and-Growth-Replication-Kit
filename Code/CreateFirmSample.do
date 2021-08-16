* This file merges the innovation measure with Compustat data and creates the needed variables to run the firm-level regressions*

clear all

cd "E:\Dropbox\Patents\codeReplication2\Data"

use  CompustatData, clear

sort permno year
tsset permno year

merge 1:1 permno year using firm_Af.dta
drop _merge
sort permno year

merge   m:1 year using cpi
drop _merge
sort permno year

replace invt=0 if missing(invt)

replace ppegt=. if ppegt<0

gen Dinvt=D.invt

replace invt=0 if missing(invt)

gen demp=D.emp/(L.emp)

drop if sicc >= 6000 &  sicc <= 6799 
drop if sicc >= 4900 &  sicc <= 4949

gen indcd=floor(sicc/10)

gen profits=sale-cogs

gen logY=log((sale+Dinvt)/cpi*100)
gen logP=log(profits/cpi*100)

gen logvol=log(firmvol)
gen Lvol_iret=L.logvol


replace Acw=0 if missing(Acw)
replace Af=0 if missing(Af)
 
 
* Create Innovation by Competitors  

drop if missing(indcd)
drop if missing(at) 
gen rawAf=Af
gen rawAcw=Acw 

egen mAf=mean(Af), by(indcd)
drop if mAf==0
egen iat = sum(at), by(year indcd)
egen iSALE = sum(sale), by(year indcd)


replace xrd=0 if missing(xrd)
replace xrd=. if year<1970

gen ARD=xrd/sale

egen xrdI = sum(xrd), by(year indcd)
gen ARDI=(xrdI-xrd)/(iSALE-sale)
 
egen AfI = sum(Af), by(year indcd)
replace AfI=(AfI-Af)/(iat-at)

egen  AcwI= sum(Acw), by(year indcd)
replace AcwI=(AcwI-Acw)/(iat-at)

replace Af=Af/at
replace Acw=Acw/at
 
gen logH=log(emp)
gen logK=log(ppegt/price_k)
gen logX=tfp

gen LlogK=L.logK 
gen LlogH=L.logH 
 
 
drop if AfI<0
drop if AcwI<0
drop if year<1950
drop if year>2010

*winsorize the variables using annual breakpoints
winsorizeJ LlogK LlogH logY logP logK logH logX   , by(year) cuts(1 99)
replace LlogK=LlogKW
replace LlogH=LlogHW

 
replace logY=logYW
replace logP=logPW
replace logK=logKW
replace logH=logHW
replace logX=logXW

winsorizeJ Lvol_iret, by(year) cuts(1 99)
replace Lvol_iret=Lvol_iretW


winsorizeJ  Af AfI  Acw AcwI ARD ARDI, by(year) cuts(1 99)
replace AfI=AfIW
replace Af=AfW
replace AcwI=AcwIW
replace Acw=AcwW
replace ARD=ARDW
replace ARDI=ARDIW
  

save "firm_data.dta", replace

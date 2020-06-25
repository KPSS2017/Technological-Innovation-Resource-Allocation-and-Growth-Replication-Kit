
/* This script replicates the aggregate results*/
 
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


collapse (sum) mkcap  Af, by(year)
 
sort year
tsset year

 
/* Merge Inflation Data*/ 
merge 1:1 year using "AggData.dta"
drop _merge

/* Merge Inflation Data*/ 
merge   1:1 year using "cpi.dta"
drop _merge

sort year
tsset year

gen AA1=log(Af/gdp/1000)
gen AA2=log(Af/mkcap*1000)

gen logY=log(gdp/pop_y3/cpi)
gen logX2=log(TFP_BFK_util)

drop if year<1926
drop if year>2010

egen A1=std(AA1)
egen A2=std(AA2)
 

gen F1logY=logY 
gen F2logY=F.logY 
gen F3logY=F2.logY 
gen F4logY=F3.logY 
gen F5logY=F4.logY 
gen F6logY=F5.logY 
gen F7logY=F6.logY 
gen F8logY=F7.logY 


gen F1logX=   logX2 
gen F2logX= F.logX2 
gen F3logX=F2.logX2 
gen F4logX=F3.logX2 
gen F5logX=F4.logX2 
gen F6logX=F5.logX2 
gen F7logX=F6.logX2
gen F8logX=F7.logX2
 
/* run predictive regressions*/ 
qui: eststo r1: ivreg2 F1logY L.A1 L.logY  L2.logY      , bw(5) robust
qui: eststo r2: ivreg2 F2logY L.A1 L.logY  L2.logY   L3.logY  , bw(6) robust
qui: eststo r3: ivreg2 F3logY L.A1 L.logY  L2.logY  L3.logY   , bw(7) robust
qui: eststo r4: ivreg2 F4logY L.A1 L.logY  L2.logY  L3.logY     , bw(8) robust
qui: eststo r5: ivreg2 F5logY L.A1 L.logY  L2.logY  L3.logY  , bw(9) robust
esttab r1 r2 r3 r4 r5, keep(L.A1) nostar t noparentheses 
esttab r1 r2 r3 r4 r5 using "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\Y_A1.csv", keep(L.A1) nostar se noparentheses replace csv plain

qui: eststo r1: ivreg2 F1logX L.A1 L.logX     , bw(5) robust
qui: eststo r2: ivreg2 F2logX L.A1 L.logX    , bw(6) robust
qui: eststo r3: ivreg2 F3logX L.A1 L.logX     , bw(7) robust
qui: eststo r4: ivreg2 F4logX L.A1 L.logX        , bw(8) robust
qui: eststo r5: ivreg2 F5logX L.A1 L.logX    , bw(9) robust
esttab r1 r2 r3 r4 r5, keep(L.A1) nostar t noparentheses 
esttab r1 r2 r3 r4 r5 using "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\X_A1.csv", keep(L.A1) nostar se noparentheses replace csv plain

qui: eststo r1: ivreg2 F1logY L.A2 L.logY  L2.logY       , bw(5) robust
qui: eststo r2: ivreg2 F2logY L.A2 L.logY  L2.logY   L3.logY  , bw(6) robust
qui: eststo r3: ivreg2 F3logY L.A2 L.logY  L2.logY  L3.logY   , bw(7) robust
qui: eststo r4: ivreg2 F4logY L.A2 L.logY  L2.logY  L3.logY     , bw(8) robust
qui: eststo r5: ivreg2 F5logY L.A2 L.logY  L2.logY  L3.logY  , bw(9) robust

esttab r1 r2 r3 r4 r5, keep(L.A2) nostar t noparentheses
esttab r1 r2 r3 r4 r5 using "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\Y_A2.csv", keep(L.A2) nostar se noparentheses replace csv plain

qui: eststo r1: ivreg2 F1logX L.A2 L.logX     , bw(5) robust
qui: eststo r2: ivreg2 F2logX L.A2 L.logX    , bw(6) robust
qui: eststo r3: ivreg2 F3logX L.A2 L.logX     , bw(7) robust
qui: eststo r4: ivreg2 F4logX L.A2 L.logX        , bw(8) robust
qui: eststo r5: ivreg2 F5logX L.A2 L.logX    , bw(9) robust
 
esttab r1 r2 r3 r4 r5, keep(L.A2) nostar t noparentheses 
esttab r1 r2 r3 r4 r5 using "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\X_A2.csv", keep(L.A2) nostar se noparentheses replace csv plain


/* Run VARs*/

irf set "C:\Users\dpap\ddd"

varsoc   logY    A1
qui: var  logY    A1, lags(1/4  )  
irf create RY_A1L, replace step(5)    bs rep(500) 
irf table oirf, irf(RY_A1L) impulse( A1) response(logY) level(90)
irf graph oirf, irf(RY_A1L) impulse(A1) response(logY) level(90) byopts( note(" ") legend(off)) subtitle ("" ) xtitle(Years, size(large))   xlabel(1 2 3 4 5,labsize(huge))  ylabel(,labsize(huge)) xticks(1 2 3 4 5)
graph export "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\Y_A1.eps", replace
irf table fevd, irf(RY_A1L) impulse(A1) response(logY) level(90)

 
varsoc   logX2    A1
qui: var  logX2    A1, lags(1/1)  
irf create RX2_A1L, replace step(5)    bs rep(500) 
irf table oirf, irf(RX2_A1L) impulse( A1) response(logX2) level(90)
irf graph oirf, irf(RX2_A1L) impulse(A1) response(logX2) level(90) byopts( note(" ") legend(off)) subtitle ("" ) xtitle(Years, size(large))   xlabel(1 2 3 4 5,labsize(huge))  ylabel(,labsize(huge)) xticks(1 2 3 4 5)
graph export "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\TFP_A1.eps", replace
irf table fevd, irf(RX2_A1L) impulse(A1) response(logX2) level(90)

varsoc   logY    A2
qui: var  logY    A2, lags(1/2)  
irf create RY_A2L, replace step(5)    bs rep(500) 
irf table oirf, irf(RY_A2L) impulse( A2) response(logY) level(90)
irf graph oirf, irf(RY_A2L) impulse(A2) response(logY) level(90) byopts( note(" ") legend(off)) subtitle ("" ) xtitle(Years, size(large))   xlabel(1 2 3 4 5,labsize(huge))  ylabel(,labsize(huge)) xticks(1 2 3 4 5)
graph export "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\Y_A2.eps", replace
irf table fevd, irf(RY_A2L) impulse(A2) response(logY) level(90)

 
varsoc   logX2    A2
qui: var  logX2    A2, lags(1/1)  
irf create RX2_A2L, replace step(5)    bs rep(500) 
irf table oirf, irf(RX2_A2L) impulse( A2) response(logX2) level(90)
irf graph oirf, irf(RX2_A2L) impulse(A2) response(logX2) level(90) byopts( note(" ") legend(off)) subtitle ("" ) xtitle(Years, size(large))   xlabel(1 2 3 4 5,labsize(huge))  ylabel(,labsize(huge)) xticks(1 2 3 4 5)
graph export "E:\Dropbox\Datasets\Patents\codeReplication2\Figs\TFP_A2.eps", replace
irf table fevd, irf(RX2_A2L) impulse(A2) response(logX2) level(90)



 
 

* Firm TFP and innovation (Panel e of Table 4 in the paper)

clear all

cd "E:\Dropbox\Patents\codeReplication\Data"

use "firm_data.dta", clear

*duplicates drop  gvkey year, force

gen F0logX=(logX)-L.logX
gen F1logX=(F1.logX)-L.logX
gen F2logX=(F2.logX)-L.logX
gen F3logX=(F3.logX)-L.logX
gen F4logX=(F4.logX)-L.logX
gen F5logX=(F5.logX)-L.logX
gen F6logX=(F6.logX)-L.logX
gen F7logX=(F7.logX)-L.logX
 
gen LlogX=L.logX

* Innovation by competing firms
gen LSA2i=L.AfI

* Innovation by the firm
gen LSA2f=L.Af

* This matrix holds the standardized coefficients (Innovation scaled to unit standard deviation)
matrix stoSTD = J(2,8,.) 

eststo prod_C0: qui xi: cluster2  F0logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   ,  fcluster(permno) tcluster(year)  
qui xi:  reg F0logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   
qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,1]=r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,1]=r(sd) * _b[LSA2i]

predict F0logXp, xb
gen F0logXnC=F0logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C1: qui xi: cluster2  F1logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)   
qui xi:  reg F1logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,2]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,2]=r(sd) * _b[LSA2i]

predict F1logXp, xb
gen F1logXnC=F1logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C2: qui xi: cluster2  F2logX    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)   
qui xi:  reg F2logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,3]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,3]=r(sd) * _b[LSA2i]

predict F2logXp, xb
gen F2logXnC=F2logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C3: qui xi: cluster2  F3logX    LlogK LlogH     i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)  
qui xi:  reg F3logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,4]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,4]=r(sd) * _b[LSA2i]

predict F3logXp, xb
gen F3logXnC=F3logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C4: qui xi: cluster2  F4logX   LlogK  LlogH     i.year i.indcd LSA2i   LSA2f  Lvol_iret   LlogX ,  fcluster(permno) tcluster(year)   
qui xi:  reg F4logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,5]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,5]=r(sd) * _b[LSA2i]

predict F4logXp, xb
gen F4logXnC=F4logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f


eststo prod_C5: qui xi: cluster2  F5logX    LlogK   LlogH   i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX ,  fcluster(permno) tcluster(year) 
qui xi:  reg F5logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,6]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,6]=r(sd) * _b[LSA2i]

predict F5logXp, xb
gen F5logXnC=F5logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C6: qui xi: cluster2  F6logX    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)   
qui xi:  reg F6logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,7]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,7]=r(sd) * _b[LSA2i]

predict F6logXp, xb
gen F6logXnC=F6logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C7: qui xi: cluster2  F7logX    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)  
qui xi:  reg F7logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogX   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,8]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,8]=r(sd) * _b[LSA2i]

predict F7logXp, xb
gen F7logXnC=F7logXp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

esttab prod_C*, keep(LSA2i   LSA2f) nostar t(2) b(3) brackets

* The standardized coefficients of Panel e of Table 4
mat list stoSTD
 

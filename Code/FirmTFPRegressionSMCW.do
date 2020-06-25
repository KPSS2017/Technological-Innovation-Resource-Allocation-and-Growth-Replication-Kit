* Firm TFP and innovation using both our measure and citation-weighted patents (Panel e of Table 6 in the paper) 
 
clear all

cd "E:\Dropbox\Patents\codeReplication\Data"

use "firm_data.dta", clear
 
gen F0logX=(logX)-L.logX

gen F1logX=(F1.logX)-L.logX
gen F2logX=(F2.logX)-L.logX
gen F3logX=(F3.logX)-L.logX
gen F4logX=(F4.logX)-L.logX
gen F5logX=(F5.logX)-L.logX
gen F6logX=(F6.logX)-L.logX
gen F7logX=(F7.logX)-L.logX

gen LlogX=L.logX

* Innovation by competing firms, SM-based measure
gen LSA2i=L.AfI

* Innovation by the firm, SM-based measure
gen LSA2f=L.Af

* Innovation by competing firms, CW-based measure
gen LSA1i=L.AcwI

* Innovation by the firm, CW-based measure
gen LSA1f=L.Acw

* This matrix holds the standardized coefficients for the CW-based measure (Innovation scaled to unit standard deviation)
matrix sto1se  = J(2,8,.)
 
* This matrix holds the standardized coefficients for the SM-based measure (Innovation scaled to unit standard deviation)
matrix sto2se  = J(2,8,.) 


eststo prod_C0: qui xi: cluster2  F0logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)
qui xi: reg  F0logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f Lvol_iret  L.logX  
  
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,1]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,1]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,1]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,1]=( r(sd) ) * _b[LSA1i]

predict F0logXp, xb
gen F0logXnC=F0logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C1: qui xi: cluster2  F1logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)
qui xi: reg  F1logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logX 
  
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,2]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,2]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,2]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,2]=( r(sd) ) * _b[LSA1i]

predict F1logXp, xb
gen F1logXnC=F1logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C2: qui xi: cluster2  F2logX    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)
qui xi: reg  F2logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logX 

qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,3]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,3]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,3]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,3]=( r(sd) ) * _b[LSA1i]

predict F2logXp, xb
gen F2logXnC=F2logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C3: qui xi: cluster2 F3logX    LlogK LlogH     i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)
qui xi: reg  F3logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logX 

qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,4]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,4]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,4]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,4]=( r(sd) ) * _b[LSA1i]

predict F3logXp, xb
gen F3logXnC=F3logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C4: qui xi: cluster2  F4logX   LlogK  LlogH     i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret   LlogX ,  fcluster(permno) tcluster(year)
qui xi: reg  F4logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logX 
  
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,5]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,5]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,5]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,5]=( r(sd) ) * _b[LSA1i]

predict F4logXp, xb
gen F4logXnC=F4logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C5: qui xi: cluster2 F5logX    LlogK   LlogH   i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogX , fcluster(permno) tcluster(year)
qui xi: reg  F5logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logX 

qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,6]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,6]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,6]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,6]=( r(sd) ) * _b[LSA1i]

predict F5logXp, xb
gen F5logXnC=F5logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C6: qui xi: cluster2  F6logX    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogX ,  fcluster(permno) tcluster(year)
qui xi: reg  F6logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logX 
   
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,7]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,7]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,7]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,7]=( r(sd) ) * _b[LSA1i]

predict F6logXp, xb
gen F6logXnC=F6logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C7: qui xi: cluster2 F7logX    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret   LSA1i LSA1f LlogX ,  fcluster(permno) tcluster(year)
qui xi: reg  F7logX     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logX 
 
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,8]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,8]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,8]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,8]=( r(sd) ) * _b[LSA1i]

predict F7logXp, xb
gen F7logXnC=F7logXp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

esttab prod_C*, keep(LSA2i   LSA2f   LSA1i LSA1f) nostar t(2) b(3) brackets

* Standardized coefficients for SM-based measure
mat list sto2se
 
* Standardized coefficients for CW-based measure
mat list sto1se 
 
 
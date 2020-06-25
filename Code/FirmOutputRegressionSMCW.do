* Firm Output and innovation using both our measure and citation-weighted patents (Panel b of Table 6 in the paper) 
 
clear all

cd "E:\Dropbox\Patents\codeReplication\Data"

use "firm_data.dta", clear

gen F0logY=(logY)-L.logY

gen F1logY=(F1.logY)-L.logY
gen F2logY=(F2.logY)-L.logY
gen F3logY=(F3.logY)-L.logY
gen F4logY=(F4.logY)-L.logY
gen F5logY=(F5.logY)-L.logY
gen F6logY=(F6.logY)-L.logY
gen F7logY=(F7.logY)-L.logY
gen LlogY=L.logY

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


eststo prod_C0: qui xi: cluster2  F0logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f Lvol_iret  LlogY ,  fcluster(permno) tcluster(year)
qui xi: reg  F0logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f Lvol_iret  L.logY  
  
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,1]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,1]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,1]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,1]=( r(sd) ) * _b[LSA1i]

predict F0logYp, xb
gen F0logYnC=F0logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C1: qui xi: cluster2  F1logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  LlogY ,  fcluster(permno) tcluster(year)
qui xi: reg  F1logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logY 
  
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,2]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,2]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,2]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,2]=( r(sd) ) * _b[LSA1i]

predict F1logYp, xb
gen F1logYnC=F1logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C2: qui xi: cluster2  F2logY    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogY ,  fcluster(permno) tcluster(year)
qui xi: reg  F2logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logY 

qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,3]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,3]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,3]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,3]=( r(sd) ) * _b[LSA1i]

predict F2logYp, xb
gen F2logYnC=F2logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C3: qui xi: cluster2 F3logY    LlogK LlogH     i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogY ,  fcluster(permno) tcluster(year)
qui xi: reg  F3logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logY 

qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,4]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,4]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,4]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,4]=( r(sd) ) * _b[LSA1i]

predict F3logYp, xb
gen F3logYnC=F3logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C4: qui xi: cluster2  F4logY   LlogK  LlogH     i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret   LlogY ,  fcluster(permno) tcluster(year)
qui xi: reg  F4logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logY 
  
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,5]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,5]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,5]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,5]=( r(sd) ) * _b[LSA1i]

predict F4logYp, xb
gen F4logYnC=F4logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)


eststo prod_C5: qui xi: cluster2 F5logY    LlogK   LlogH   i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogY , fcluster(permno) tcluster(year)
qui xi: reg  F5logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logY 

qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,6]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,6]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,6]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,6]=( r(sd) ) * _b[LSA1i]

predict F5logYp, xb
gen F5logYnC=F5logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C6: qui xi: cluster2  F6logY    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f   LSA1i LSA1f Lvol_iret  LlogY ,  fcluster(permno) tcluster(year)
qui xi: reg  F6logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logY 
   
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,7]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,7]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,7]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,7]=( r(sd) ) * _b[LSA1i]

predict F6logYp, xb
gen F6logYnC=F6logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

eststo prod_C7: qui xi: cluster2 F7logY    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret   LSA1i LSA1f LlogY ,  fcluster(permno) tcluster(year)
qui xi: reg  F7logY     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  LSA1i LSA1f  Lvol_iret  L.logY 
 
qui sum    LSA2f if e(sample)==1,d
matrix sto2se[1,8]=( r(sd) ) * _b[LSA2f]
qui sum    LSA1f if e(sample)==1,d
matrix sto1se[1,8]=( r(sd) ) * _b[LSA1f]
qui sum    LSA2i if e(sample)==1,d
matrix sto2se[2,8]=( r(sd) ) * _b[LSA2i]
qui sum    LSA1i if e(sample)==1,d
matrix sto1se[2,8]=( r(sd) ) * _b[LSA1i]

predict F7logYp, xb
gen F7logYnC=F7logYp-(_b[LSA2i]*LSA2i + _b[LSA2f]*LSA2f+_b[LSA1i]*LSA1i + _b[LSA1f]*LSA1f)

esttab prod_C*, keep(LSA2i   LSA2f   LSA1i LSA1f) nostar t(2) b(3) brackets

* Standardized coefficients for SM-based measure
mat list sto2se

* Standardized coefficients for CW-based measure
mat list sto1se 
 
 
gen dF0logY=(exp(F0logYp)-exp(F0logYnC))*exp(L.logY)
gen denF0logY=exp(L.logY)
replace denF0logY=. if missing(F0logYp)

gen dF1logY=(exp(F1logYp)-exp(F1logYnC))*exp(L.logY)
gen denF1logY=exp(L.logY)
replace denF1logY=. if missing(F1logYp)

gen dF2logY=(exp(F2logYp)-exp(F2logYnC))*exp(L.logY)
gen denF2logY=exp(L.logY)
replace denF2logY=. if missing(F2logYp)

gen dF3logY=(exp(F3logYp)-exp(F3logYnC))*exp(L.logY)
gen denF3logY=exp(L.logY)
replace denF3logY=. if missing(F3logYp)

gen dF4logY=(exp(F4logYp)-exp(F4logYnC))*exp(L.logY)
gen denF4logY=exp(L.logY)
replace denF4logY=. if missing(F4logYp)

gen dF5logY=(exp(F5logYp)-exp(F5logYnC))*exp(L.logY)
gen denF5logY=exp(L.logY)
replace denF5logY=. if missing(F5logYp)

gen dF6logY=(exp(F6logYp)-exp(F6logYnC))*exp(L.logY)
gen denF6logY=exp(L.logY)
replace denF6logY=. if missing(F6logYp)

gen dF7logY=(exp(F7logYp)-exp(F7logYnC))*exp(L.logY)
gen denF7logY=exp(L.logY)
replace denF7logY=. if missing(F7logYp)
 
gen adF0logY=abs((exp(F0logYp)-exp(F0logYnC))*exp(L.logY))
gen adF1logY=abs((exp(F1logYp)-exp(F1logYnC))*exp(L.logY))
gen adF2logY=abs((exp(F2logYp)-exp(F2logYnC))*exp(L.logY)) 
gen adF3logY=abs((exp(F3logYp)-exp(F3logYnC))*exp(L.logY))
gen adF4logY=abs((exp(F4logYp)-exp(F4logYnC))*exp(L.logY))
gen adF5logY=abs((exp(F5logYp)-exp(F5logYnC))*exp(L.logY))
gen adF6logY=abs((exp(F6logYp)-exp(F6logYnC))*exp(L.logY))
gen adF7logY=abs((exp(F7logYp)-exp(F7logYnC))*exp(L.logY))

gen adF0logYT=abs((exp(F0logY)-1)*exp(L.logY)) if !missing(F0logYp)
gen adF1logYT=abs((exp(F1logY)-1)*exp(L.logY)) if !missing(F1logYp)
gen adF2logYT=abs((exp(F2logY)-1)*exp(L.logY)) if !missing(F2logYp)
gen adF3logYT=abs((exp(F3logY)-1)*exp(L.logY)) if !missing(F3logYp)
gen adF4logYT=abs((exp(F4logY)-1)*exp(L.logY)) if !missing(F4logYp)
gen adF5logYT=abs((exp(F5logY)-1)*exp(L.logY)) if !missing(F5logYp)
gen adF6logYT=abs((exp(F6logY)-1)*exp(L.logY)) if !missing(F6logYp)
gen adF7logYT=abs((exp(F7logY)-1)*exp(L.logY)) if !missing(F7logYp)  
 
gen F0Y = exp(logY)    if !missing(F0logYp)
gen F1Y = exp(F1.logY) if !missing(F1logYp)
gen F2Y = exp(F2.logY) if !missing(F2logYp)
gen F3Y = exp(F3.logY) if !missing(F3logYp)
gen F4Y = exp(F4.logY) if !missing(F4logYp)
gen F5Y = exp(F5.logY) if !missing(F5logYp)
gen F6Y = exp(F6.logY) if !missing(F6logYp)
gen F7Y = exp(F7.logY) if !missing(F7logYp)

 
collapse (sum)   F?Y  dF* adF* denF* (count) permno, by(year)

tsset year
sort year


replace adF0logY = . if F0Y ==0
replace adF1logY = . if F1Y ==0
replace adF2logY = . if F2Y ==0
replace adF3logY = . if F3Y ==0
replace adF4logY = . if F4Y ==0
replace adF5logY = . if F5Y ==0
replace adF6logY = . if F6Y ==0
replace adF7logY = . if F7Y ==0

replace adF0logYT = . if F0Y ==0
replace adF1logYT = . if F1Y ==0
replace adF2logYT = . if F2Y ==0
replace adF3logYT = . if F3Y ==0
replace adF4logYT = . if F4Y ==0
replace adF5logYT = . if F5Y ==0
replace adF6logYT = . if F6Y ==0
replace adF7logYT = . if F7Y ==0

replace denF0logY = . if F0Y ==0
replace denF1logY = . if F1Y ==0
replace denF2logY = . if F2Y ==0
replace denF3logY = . if F3Y ==0
replace denF4logY = . if F4Y ==0
replace denF5logY = . if F5Y ==0
replace denF6logY = . if F6Y ==0
replace denF7logY = . if F7Y ==0

replace F0Y = . if F0Y ==0
replace F1Y = . if F1Y ==0
replace F2Y = . if F2Y ==0
replace F3Y = . if F3Y ==0
replace F4Y = . if F4Y ==0
replace F5Y = . if F5Y ==0
replace F6Y = . if F6Y ==0
replace F7Y = . if F7Y ==0

gen A2netVW0d=  dF0logY/ denF0logY
gen A2netVW1d=  dF1logY/ denF1logY
gen A2netVW2d=  dF2logY/ denF2logY
gen A2netVW3d=  dF3logY/ denF3logY
gen A2netVW4d=  dF4logY/ denF4logY
gen A2netVW5d=  dF5logY/ denF5logY
gen A2netVW6d=  dF6logY/ denF6logY
gen A2netVW7d=  dF7logY/ denF7logY

gen A2TVW0d=  F0Y/ denF0logY -1
gen A2TVW1d=  F1Y/ denF1logY -1
gen A2TVW2d=  F2Y/ denF2logY -1
gen A2TVW3d=  F3Y/ denF3logY -1
gen A2TVW4d=  F4Y/ denF4logY -1
gen A2TVW5d=  F5Y/ denF5logY -1
gen A2TVW6d=  F6Y/ denF6logY -1
gen A2TVW7d=  F7Y/ denF7logY -1

gen realloc1=  adF0logY/ denF0logY
gen realloc2=  adF1logY/ denF1logY
gen realloc3=  adF2logY/ denF2logY
gen realloc4=  adF3logY/ denF3logY
gen realloc5=  adF4logY/ denF4logY
gen realloc6=  adF5logY/ denF5logY
gen realloc7=  adF6logY/ denF6logY
gen realloc8=  adF7logY/ denF7logY

gen realloc1T=  adF0logYT/ denF0logY
gen realloc2T=  adF1logYT/ denF1logY
gen realloc3T=  adF2logYT/ denF2logY
gen realloc4T=  adF3logYT/ denF3logY
gen realloc5T=  adF4logYT/ denF4logY
gen realloc6T=  adF5logYT/ denF5logY
gen realloc7T=  adF6logYT/ denF6logY
gen realloc8T=  adF7logYT/ denF7logY

replace realloc1T=. if realloc1T==0
replace realloc2T=. if realloc2T==0
replace realloc3T=. if realloc3T==0
replace realloc4T=. if realloc4T==0
replace realloc5T=. if realloc5T==0
replace realloc6T=. if realloc6T==0
replace realloc7T=. if realloc7T==0
replace realloc8T=. if realloc8T==0

replace A2netVW0d=. if missing(A2TVW0d)
replace A2netVW1d=. if missing(A2TVW1d)
replace A2netVW2d=. if missing(A2TVW2d)
replace A2netVW3d=. if missing(A2TVW3d)
replace A2netVW4d=. if missing(A2TVW4d)
replace A2netVW5d=. if missing(A2TVW5d)
replace A2netVW6d=. if missing(A2TVW6d)
replace A2netVW7d=. if missing(A2TVW7d)


replace realloc1=. if missing(realloc1T)
replace realloc2=. if missing(realloc2T)
replace realloc3=. if missing(realloc3T)
replace realloc4=. if missing(realloc4T)
replace realloc5=. if missing(realloc5T)
replace realloc6=. if missing(realloc6T)
replace realloc7=. if missing(realloc7T)
replace realloc8=. if missing(realloc8T)


gen nrealloc1=realloc1-abs(A2netVW0d)
gen nrealloc2=realloc2-abs(A2netVW1d)
gen nrealloc3=realloc3-abs(A2netVW2d)
gen nrealloc4=realloc4-abs(A2netVW3d)
gen nrealloc5=realloc5-abs(A2netVW4d)
gen nrealloc6=realloc6-abs(A2netVW5d)
gen nrealloc7=realloc7-abs(A2netVW6d)
gen nrealloc8=realloc8-abs(A2netVW7d)

gen nrealloc1T=realloc1T-abs(A2TVW0d)
gen nrealloc2T=realloc2T-abs(A2TVW1d)
gen nrealloc3T=realloc3T-abs(A2TVW2d)
gen nrealloc4T=realloc4T-abs(A2TVW3d)
gen nrealloc5T=realloc5T-abs(A2TVW4d)
gen nrealloc6T=realloc6T-abs(A2TVW5d)
gen nrealloc7T=realloc7T-abs(A2TVW6d)
gen nrealloc8T=realloc8T-abs(A2TVW7d)

sum A2* nrealloc* 


* Firm Profits and innovation using citation-weighted patents (Panel a of Table 5 in the paper) 

clear all

cd "E:\Dropbox\Patents\codeReplication\Data"

use "firm_data.dta", clear

gen F0logP=(logP)-L.logP
gen F1logP=(F1.logP)-L.logP
gen F2logP=(F2.logP)-L.logP
gen F3logP=(F3.logP)-L.logP
gen F4logP=(F4.logP)-L.logP
gen F5logP=(F5.logP)-L.logP
gen F6logP=(F6.logP)-L.logP
gen F7logP=(F7.logP)-L.logP
 

* Innovation by competing firms
gen LSA2i=L.AcwI

* Innovation by the firm
gen LSA2f=L.Acw

gen LlogP=L.logP

* This matrix holds the standardized coefficients (Innovation scaled to unit standard deviation)
matrix stoSTD = J(2,8,.) 

eststo prod_C0: qui xi: cluster2  F0logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   ,  fcluster(permno) tcluster(year)  
qui xi:  reg F0logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   
qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,1]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,1]=r(sd) * _b[LSA2i]

predict F0logPp, xb
gen F0logPnC=F0logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C1: qui xi: cluster2  F1logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP ,  fcluster(permno) tcluster(year)   
qui xi:  reg F1logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,2]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,2]=r(sd) * _b[LSA2i]

predict F1logPp, xb
gen F1logPnC=F1logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C2: qui xi: cluster2  F2logP    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP ,  fcluster(permno) tcluster(year)   
qui xi:  reg F2logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,3]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,3]=r(sd) * _b[LSA2i]

predict F2logPp, xb
gen F2logPnC=F2logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C3: qui xi: cluster2  F3logP    LlogK LlogH     i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP ,  fcluster(permno) tcluster(year)  
qui xi:  reg F3logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,4]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,4]=r(sd) * _b[LSA2i]

predict F3logPp, xb
gen F3logPnC=F3logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C4: qui xi: cluster2  F4logP   LlogK  LlogH     i.year i.indcd LSA2i   LSA2f  Lvol_iret   LlogP ,  fcluster(permno) tcluster(year)   
qui xi:  reg F4logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,5]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,5]=r(sd) * _b[LSA2i]

predict F4logPp, xb
gen F4logPnC=F4logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f


eststo prod_C5: qui xi: cluster2  F5logP    LlogK   LlogH   i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP ,  fcluster(permno) tcluster(year) 
qui xi:  reg F5logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,6]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,6]=r(sd) * _b[LSA2i]

predict F5logPp, xb
gen F5logPnC=F5logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C6: qui xi: cluster2  F6logP    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP ,  fcluster(permno) tcluster(year)   
qui xi:  reg F6logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,7]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,7]=r(sd) * _b[LSA2i]

predict F6logPp, xb
gen F6logPnC=F6logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

eststo prod_C7: qui xi: cluster2  F7logP    LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP ,  fcluster(permno) tcluster(year)  
qui xi:  reg F7logP     LlogK  LlogH    i.year i.indcd LSA2i   LSA2f  Lvol_iret  LlogP   

qui sum    LSA2f if e(sample)==1,d
matrix stoSTD[1,8]=r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoSTD[2,8]=r(sd) * _b[LSA2i]

predict F7logPp, xb
gen F7logPnC=F7logPp - _b[LSA2i]*LSA2i - _b[LSA2f]*LSA2f

esttab prod_C*, keep(LSA2i   LSA2f) nostar t(2) b(3) brackets

* The standardized coefficients of Panel a of Table 5
mat list stoSTD
  
gen dF0logP=(exp(F0logPp)-exp(F0logPnC))*exp(L.logP)
gen denF0logP=exp(L.logP)
replace denF0logP=. if missing(F0logPp)

gen dF1logP=(exp(F1logPp)-exp(F1logPnC))*exp(L.logP)
gen denF1logP=exp(L.logP)
replace denF1logP=. if missing(F1logPp)

gen dF2logP=(exp(F2logPp)-exp(F2logPnC))*exp(L.logP)
gen denF2logP=exp(L.logP)
replace denF2logP=. if missing(F2logPp)

gen dF3logP=(exp(F3logPp)-exp(F3logPnC))*exp(L.logP)
gen denF3logP=exp(L.logP)
replace denF3logP=. if missing(F3logPp)

gen dF4logP=(exp(F4logPp)-exp(F4logPnC))*exp(L.logP)
gen denF4logP=exp(L.logP)
replace denF4logP=. if missing(F4logPp)

gen dF5logP=(exp(F5logPp)-exp(F5logPnC))*exp(L.logP)
gen denF5logP=exp(L.logP)
replace denF5logP=. if missing(F5logPp)

gen dF6logP=(exp(F6logPp)-exp(F6logPnC))*exp(L.logP)
gen denF6logP=exp(L.logP)
replace denF6logP=. if missing(F6logPp)

gen dF7logP=(exp(F7logPp)-exp(F7logPnC))*exp(L.logP)
gen denF7logP=exp(L.logP)
replace denF7logP=. if missing(F7logPp)
 
gen adF0logP=abs((exp(F0logPp)-exp(F0logPnC))*exp(L.logP))
gen adF1logP=abs((exp(F1logPp)-exp(F1logPnC))*exp(L.logP))
gen adF2logP=abs((exp(F2logPp)-exp(F2logPnC))*exp(L.logP)) 
gen adF3logP=abs((exp(F3logPp)-exp(F3logPnC))*exp(L.logP))
gen adF4logP=abs((exp(F4logPp)-exp(F4logPnC))*exp(L.logP))
gen adF5logP=abs((exp(F5logPp)-exp(F5logPnC))*exp(L.logP))
gen adF6logP=abs((exp(F6logPp)-exp(F6logPnC))*exp(L.logP))
gen adF7logP=abs((exp(F7logPp)-exp(F7logPnC))*exp(L.logP))

gen adF0logPT=abs((exp(F0logP)-1)*exp(L.logP)) if !missing(F0logPp)
gen adF1logPT=abs((exp(F1logP)-1)*exp(L.logP)) if !missing(F1logPp)
gen adF2logPT=abs((exp(F2logP)-1)*exp(L.logP)) if !missing(F2logPp)
gen adF3logPT=abs((exp(F3logP)-1)*exp(L.logP)) if !missing(F3logPp)
gen adF4logPT=abs((exp(F4logP)-1)*exp(L.logP)) if !missing(F4logPp)
gen adF5logPT=abs((exp(F5logP)-1)*exp(L.logP)) if !missing(F5logPp)
gen adF6logPT=abs((exp(F6logP)-1)*exp(L.logP)) if !missing(F6logPp)
gen adF7logPT=abs((exp(F7logP)-1)*exp(L.logP)) if !missing(F7logPp) 
 
gen F0Y = exp(logP)    if !missing(F0logPp)
gen F1Y = exp(F1.logP) if !missing(F1logPp)
gen F2Y = exp(F2.logP) if !missing(F2logPp)
gen F3Y = exp(F3.logP) if !missing(F3logPp)
gen F4Y = exp(F4.logP) if !missing(F4logPp)
gen F5Y = exp(F5.logP) if !missing(F5logPp)
gen F6Y = exp(F6.logP) if !missing(F6logPp)
gen F7Y = exp(F7.logP) if !missing(F7logPp)

 
collapse (sum)   F?Y  dF* adF* denF* (count) permno, by(year)

tsset year
sort year


replace adF0logP = . if F0Y ==0
replace adF1logP = . if F1Y ==0
replace adF2logP = . if F2Y ==0
replace adF3logP = . if F3Y ==0
replace adF4logP = . if F4Y ==0
replace adF5logP = . if F5Y ==0
replace adF6logP = . if F6Y ==0
replace adF7logP = . if F7Y ==0

replace adF0logPT = . if F0Y ==0
replace adF1logPT = . if F1Y ==0
replace adF2logPT = . if F2Y ==0
replace adF3logPT = . if F3Y ==0
replace adF4logPT = . if F4Y ==0
replace adF5logPT = . if F5Y ==0
replace adF6logPT = . if F6Y ==0
replace adF7logPT = . if F7Y ==0

replace denF0logP = . if F0Y ==0
replace denF1logP = . if F1Y ==0
replace denF2logP = . if F2Y ==0
replace denF3logP = . if F3Y ==0
replace denF4logP = . if F4Y ==0
replace denF5logP = . if F5Y ==0
replace denF6logP = . if F6Y ==0
replace denF7logP = . if F7Y ==0

replace F0Y = . if F0Y ==0
replace F1Y = . if F1Y ==0
replace F2Y = . if F2Y ==0
replace F3Y = . if F3Y ==0
replace F4Y = . if F4Y ==0
replace F5Y = . if F5Y ==0
replace F6Y = . if F6Y ==0
replace F7Y = . if F7Y ==0

gen A2netVW0d=  dF0logP/ denF0logP
gen A2netVW1d=  dF1logP/ denF1logP
gen A2netVW2d=  dF2logP/ denF2logP
gen A2netVW3d=  dF3logP/ denF3logP
gen A2netVW4d=  dF4logP/ denF4logP
gen A2netVW5d=  dF5logP/ denF5logP
gen A2netVW6d=  dF6logP/ denF6logP
gen A2netVW7d=  dF7logP/ denF7logP

gen A2TVW0d=  F0Y/ denF0logP -1
gen A2TVW1d=  F1Y/ denF1logP -1
gen A2TVW2d=  F2Y/ denF2logP -1
gen A2TVW3d=  F3Y/ denF3logP -1
gen A2TVW4d=  F4Y/ denF4logP -1
gen A2TVW5d=  F5Y/ denF5logP -1
gen A2TVW6d=  F6Y/ denF6logP -1
gen A2TVW7d=  F7Y/ denF7logP -1

gen realloc1=  adF0logP/ denF0logP
gen realloc2=  adF1logP/ denF1logP
gen realloc3=  adF2logP/ denF2logP
gen realloc4=  adF3logP/ denF3logP
gen realloc5=  adF4logP/ denF4logP
gen realloc6=  adF5logP/ denF5logP
gen realloc7=  adF6logP/ denF6logP
gen realloc8=  adF7logP/ denF7logP

gen realloc1T=  adF0logPT/ denF0logP
gen realloc2T=  adF1logPT/ denF1logP
gen realloc3T=  adF2logPT/ denF2logP
gen realloc4T=  adF3logPT/ denF3logP
gen realloc5T=  adF4logPT/ denF4logP
gen realloc6T=  adF5logPT/ denF5logP
gen realloc7T=  adF6logPT/ denF6logP
gen realloc8T=  adF7logPT/ denF7logP

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

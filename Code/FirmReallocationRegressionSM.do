* Firm Capital/Labor and innovation (Panels c and d of Table 4 in the paper) 

clear all

cd "E:\Dropbox\Patents\codeReplication\Data"

use "firm_data.dta", clear

* Innovation by competing firms
gen LSA2i=L.AfI

* Innovation by the firm
gen LSA2f=L.Af
 
gen ninv1=logK-L.logK
gen ninv2=F1.logK-L.logK
gen ninv3=F2.logK-L.logK
gen ninv4=F3.logK-L.logK
gen ninv5=F4.logK-L.logK
gen ninv6=F5.logK-L.logK
gen ninv7=F6.logK-L.logK
gen ninv8=F7.logK-L.logK

gen demp1=logH-L.logH
gen demp2=F.logH-L.logH
gen demp3=F2.logH-L.logH
gen demp4=F3.logH-L.logH
gen demp5=F4.logH-L.logH
gen demp6=F5.logH-L.logH
gen demp7=F6.logH-L.logH
gen demp8=F7.logH-L.logH

* This matrix holds the standardized coefficients (Innovation scaled to unit standard deviation)
matrix stoIK_se = J(2,8,.) 

eststo i1: qui xi: cluster2  ninv1  LlogK LlogH  i.year i.indcd  LSA2i   LSA2f  Lvol_iret   ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv1  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,1]= r(sd) * _b[LSA2f]

qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,1]= r(sd) * _b[LSA2i]

predict pninv1,xb
gen netIK1 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv1)
gen netI1 =  (exp(pninv1)-exp(pninv1-netIK1)) * L.ppegt if ~missing(pninv1)
gen netIT1 = (exp(ninv1)-1)  * L.ppegt if ~missing(pninv1)
gen LK1 =  L.ppegt
replace LK1=.    if missing(netI1)
replace netIT1=. if missing(netI1) 
replace LK1=.    if missing(netIT1)


eststo i2: qui xi: cluster2  ninv2  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret  i.indcd ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv2  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,2]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,2]= r(sd) * _b[LSA2i]

predict pninv2,xb
gen netIK2 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv2)
gen netI2 =  (exp(pninv2)-exp(pninv2-netIK2)) * L.ppegt if ~missing(pninv2)
gen netIT2 = (exp(ninv2)-1)  * L.ppegt if ~missing(pninv2)
gen LK2 =  L.ppegt 
replace LK2=.    if missing(netI2) 
replace netIT2=. if missing(netI2)
replace LK2=.    if missing(netIT2)

eststo i3: qui xi: cluster2  ninv3  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret i.indcd  ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv3  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,3]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,3]= r(sd) * _b[LSA2i]

predict pninv3,xb
gen netIK3 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv3)
gen netI3 =  (exp(pninv3)-exp(pninv3-netIK3)) * L.ppegt if ~missing(pninv3)
gen netIT3 = (exp(ninv3)-1)  * L.ppegt if ~missing(pninv3)
gen LK3 =  L.ppegt
replace LK3=.    if missing(netI3)
replace netIT3=. if missing(netI3)
replace LK3=.    if missing(netIT3)

eststo i4: qui xi: cluster2  ninv4  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret i.indcd  ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv4  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,4]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,4]= r(sd) * _b[LSA2i]

predict pninv4,xb
gen netIK4 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv4)
gen netI4 =  (exp(pninv4)-exp(pninv4-netIK4))  * L.ppegt if ~missing(pninv4)
gen netIT4 = (exp(ninv4)-1)  * L.ppegt if ~missing(pninv4)
gen LK4 =  L.ppegt
replace LK4=.    if missing(netI4)
replace netIT4=. if missing(netI4)
replace LK4=.    if missing(netIT4)


eststo i5: qui xi: cluster2  ninv5  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret i.indcd  ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv5  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,5]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,5]= r(sd) * _b[LSA2i]

predict pninv5,xb
gen netIK5 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv5)
gen netI5 =  (exp(pninv5)-exp(pninv5-netIK5))  * L.ppegt if ~missing(pninv5)
gen netIT5 = (exp(ninv5)-1)  * L.ppegt if ~missing(pninv5)
gen LK5 =  L.ppegt
replace LK5=.    if missing(netI5)
replace netIT5=. if missing(netI5)
replace LK5=.    if missing(netIT5)


eststo i6: qui xi: cluster2  ninv6  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret i.indcd  ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv6  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,6]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,6]= r(sd) * _b[LSA2i]

predict pninv6,xb
gen netIK6 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv6)
gen netI6 =  (exp(pninv6)-exp(pninv6-netIK6))  * L.ppegt if ~missing(pninv6)
gen netIT6 = (exp(ninv6)-1)  * L.ppegt if ~missing(pninv6)
gen LK6 =  L.ppegt
replace LK6=.    if missing(netI6)
replace netIT6=. if missing(netI6)
replace LK6=.    if missing(netIT6)


eststo i7: qui xi: cluster2  ninv7  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret i.indcd  ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv7  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,7]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,7]= r(sd) * _b[LSA2i]

predict pninv7,xb
gen netIK7 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv7)
gen netI7 =  (exp(pninv7)-exp(pninv7-netIK7))  * L.ppegt if ~missing(pninv7)
gen netIT7 = (exp(ninv7)-1)  * L.ppegt if ~missing(pninv7)
gen LK7 =  L.ppegt
replace LK7=.    if missing(netI7)
replace netIT7=. if missing(netI7)
replace LK7=.    if missing(netIT7)


eststo i8: qui xi: cluster2  ninv8  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret i.indcd  ,  fcluster(permno)  tcluster(year)
qui xi: reg  ninv8  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoIK_se[1,8]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoIK_se[2,8]= r(sd) * _b[LSA2i]

predict pninv8,xb
gen netIK8 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pninv8)
gen netI8 =  (exp(pninv8)-exp(pninv8-netIK8))  * L.ppegt if ~missing(pninv8)
gen netIT8 = (exp(ninv8)-1)  * L.ppegt if ~missing(pninv8)
gen LK8 =  L.ppegt
replace LK8=.    if missing(netI8)
replace netIT8=. if missing(netI8)
replace LK8=.    if missing(netIT8)

* This matrix holds the standardized coefficients (Innovation scaled to unit standard deviation)
matrix stoDE_se = J(2,8,.) 
 
eststo e1: qui xi: cluster2  demp1  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret i.indcd ,  fcluster(permno)  tcluster(year)
qui xi: reg  demp1  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,1]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,1]= r(sd) * _b[LSA2i]

predict pdemp1,xb
gen netDE1 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp1)
gen netE1 =  (exp(pdemp1)-exp(pdemp1-netDE1)) * L.emp if ~missing(pdemp1)
gen netET1 = (exp(demp1)-1) * L.emp if ~missing(pdemp1)
gen LE1 =  L.emp

replace LE1=. if missing(netDE1)
replace LE1=.    if missing(netET1)
replace netET1=. if missing(netE1)

eststo e2: qui xi: cluster2  demp2  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret  i.indcd  ,  fcluster(permno)  tcluster(year)
qui xi: reg  demp2  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,2]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,2]= r(sd) * _b[LSA2i]

predict pdemp2,xb
gen netDE2 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp2)
gen netE2 =  (exp(pdemp2)-exp(pdemp2-netDE2)) * L.emp if ~missing(pdemp2)
gen netET2 = (exp(demp2)-1) * L.emp if ~missing(pdemp2)
gen LE2 =  L.emp

replace LE2=. if missing(netDE2)
replace LE2=.    if missing(netET2)
replace netET2=. if missing(netE2)

eststo e3: qui xi: cluster2  demp3  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd  , fcluster(permno)  tcluster(year)
qui xi: reg  demp3  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,3]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,3]= r(sd) * _b[LSA2i]

predict pdemp3,xb
gen netDE3 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp3)
gen netE3 =  (exp(pdemp3)-exp(pdemp3-netDE3)) * L.emp if ~missing(pdemp3)
gen netET3 = (exp(demp3)-1) * L.emp if ~missing(pdemp3)
gen LE3 =  L.emp

replace LE3=. if missing(netDE3)
replace LE3=.    if missing(netET3)
replace netET3=. if missing(netE3)

eststo e4: qui xi: cluster2  demp4  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd  , fcluster(permno)  tcluster(year)
qui xi: reg  demp4  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,4]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,4]= r(sd) * _b[LSA2i]

predict pdemp4,xb
gen netDE4 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp4)
gen netE4 =  (exp(pdemp4)-exp(pdemp4-netDE4)) * L.emp if ~missing(pdemp4)
gen netET4 = (exp(demp4)-1) * L.emp if ~missing(pdemp4)
gen LE4 =  L.emp

replace LE4=. if missing(netDE4)
replace LE4=.    if missing(netET4)
replace netET4=. if missing(netE4)
 
eststo e5: qui xi: cluster2  demp5  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd  , fcluster(permno)  tcluster(year)
qui xi: reg  demp5  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,5]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,5]= r(sd) * _b[LSA2i]

predict pdemp5,xb
gen netDE5 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp5)
gen netE5 =  (exp(pdemp5)-exp(pdemp5-netDE5)) * L.emp if ~missing(pdemp5)
gen netET5 = (exp(demp5)-1) * L.emp if ~missing(pdemp5)
gen LE5 =  L.emp

replace LE5=. if missing(netDE5)
replace LE5=.    if missing(netET5)
replace netET5=. if missing(netE5)
 
eststo e6: qui xi: cluster2  demp6  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd  , fcluster(permno)  tcluster(year)
qui xi: reg  demp6  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,6]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,6]= r(sd) * _b[LSA2i]

predict pdemp6,xb
gen netDE6 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp6)
gen netE6 =  (exp(pdemp6)-exp(pdemp6-netDE6)) * L.emp if ~missing(pdemp6)
gen netET6 = (exp(demp6)-1) * L.emp if ~missing(pdemp6)
gen LE6 =  L.emp

replace LE6=. if missing(netDE6)
replace LE6=.    if missing(netET6)
replace netET6=. if missing(netE6)
 
 
eststo e7: qui xi: cluster2  demp7  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd  , fcluster(permno)  tcluster(year)
qui xi: reg  demp7  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,7]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,7]= r(sd) * _b[LSA2i]

predict pdemp7,xb
gen netDE7 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp7)
gen netE7 =  (exp(pdemp7)-exp(pdemp7-netDE7)) * L.emp if ~missing(pdemp7)
gen netET7 = (exp(demp7)-1) * L.emp if ~missing(pdemp7)
gen LE7 =  L.emp

replace LE7=. if missing(netDE7)
replace LE7=.    if missing(netET7)
replace netET7=. if missing(netE7)
 
eststo e8: qui xi: cluster2  demp8  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd  , fcluster(permno)  tcluster(year)
qui xi: reg  demp8  LlogK LlogH  i.year   LSA2i   LSA2f  Lvol_iret   i.indcd
qui sum    LSA2f if e(sample)==1,d
matrix stoDE_se[1,8]= r(sd) * _b[LSA2f]
qui sum    LSA2i if e(sample)==1,d
matrix stoDE_se[2,8]= r(sd) * _b[LSA2i]

predict pdemp8,xb
gen netDE8 =  _b[LSA2i]*LSA2i +  _b[LSA2f]*LSA2f if ~missing(pdemp8)
gen netE8 =  (exp(pdemp8)-exp(pdemp8-netDE8)) * L.emp if ~missing(pdemp8)
gen netET8 = (exp(demp8)-1) * L.emp if ~missing(pdemp8)
gen LE8 =  L.emp

replace LE8=. if missing(netDE8)
replace LE8=.    if missing(netET8)
replace netET8=. if missing(netE8)
 
 
esttab i1 i2 i3 i4  i5 i6 i7 i8,   nopar b(3) t(2) nostar keep(LSA2f LSA2i) brackets

esttab e1 e2 e3 e4  e5 e6 e7 e8,   nopar b(3) t(2) nostar keep(LSA2f LSA2i) brackets

* The standardized coefficients of Panel c of Table 4
mat list stoIK_se 

* The standardized coefficients of Panel d of Table 4
mat list stoDE_se 
 

gen crE3=abs(netE3)
gen crET3=abs(netET3)

gen crI3=abs(netI3)
gen crIT3=abs(netIT3)

gen crE2=abs(netE2)
gen crET2=abs(netET2)
 
gen crI2=abs(netI2)
gen crIT2=abs(netIT2)
 
gen crE1=abs(netE1)
gen crET1=abs(netET1)

gen crI1=abs(netI1)
gen crIT1=abs(netIT1)
 
gen crE4=abs(netE4)
gen crET4=abs(netET4)

gen crI4=abs(netI4)
gen crIT4=abs(netIT4)

gen crE5=abs(netE5)
gen crET5=abs(netET5)

gen crI5=abs(netI5)
gen crIT5=abs(netIT5)

gen crE6=abs(netE6)
gen crET6=abs(netET6)

gen crI6=abs(netI6)
gen crIT6=abs(netIT6)

gen crE7=abs(netE7)
gen crET7=abs(netET7)

gen crI7=abs(netI7)
gen crIT7=abs(netIT7)

gen crE8=abs(netE8)
gen crET8=abs(netET8)

gen crI8=abs(netI8)
gen crIT8=abs(netIT8)


collapse (sum)  netI? netIT?  LK?  netE? netET?    LE? cr* , by(year)


gen reallE1  =(crE1    - abs(netE1))/LE1
gen reallET1 =(crET1  - abs(netET1))/LE1
gen reallE2  =(crE2    - abs(netE2))/LE2
gen reallET2 =(crET2  - abs(netET2))/LE2
gen reallE3  =(crE3    - abs(netE3))/LE3
gen reallET3 =(crET3  - abs(netET3))/LE3
gen reallE4  =(crE4    - abs(netE4))/LE4
gen reallET4 =(crET4  - abs(netET4))/LE4 

gen reallI1  =(crI1    - abs(netI1))/LK1
gen reallIT1 =(crIT1  - abs(netIT1))/LK1
gen reallI2  =(crI2    - abs(netI2))/LK2
gen reallIT2 =(crIT2  - abs(netIT2))/LK2
gen reallI3  =(crI3    - abs(netI3))/LK3
gen reallIT3 =(crIT3  - abs(netIT3))/LK3
gen reallI4  =(crI4    - abs(netI4))/LK4
gen reallIT4 =(crIT4  - abs(netIT4))/LK4
  
gen reallE5  =(crE5    - abs(netE5))/LE5
gen reallET5 =(crET5  - abs(netET5))/LE5
gen reallE6  =(crE6    - abs(netE6))/LE6
gen reallET6 =(crET6  - abs(netET6))/LE6
gen reallE7  =(crE7    - abs(netE7))/LE7
gen reallET7 =(crET7  - abs(netET7))/LE7
gen reallE8  =(crE8    - abs(netE8))/LE8
gen reallET8 =(crET8  - abs(netET8))/LE8 

gen reallI5  =(crI5    - abs(netI5))/LK5
gen reallIT5 =(crIT5  - abs(netIT5))/LK5
gen reallI6  =(crI6    - abs(netI6))/LK6
gen reallIT6 =(crIT6  - abs(netIT6))/LK6
gen reallI7  =(crI7    - abs(netI7))/LK7
gen reallIT7 =(crIT7  - abs(netIT7))/LK7
gen reallI8  =(crI8    - abs(netI8))/LK8
gen reallIT8 =(crIT8  - abs(netIT8))/LK8

gen netIK1t = netI1/LK1
gen netDE1t = netE1/LE1
gen netIK1Tt = netIT1/LK1
gen netDE1Tt = netET1/LE1

gen netIK2t = netI2/LK2
gen netDE2t = netE2/LE2
gen netIK2Tt = netIT2/LK2
gen netDE2Tt = netET2/LE2

gen netIK3t = netI3/LK3
gen netDE3t = netE3/LE3
gen netIK3Tt = netIT3/LK3
gen netDE3Tt = netET3/LE3

gen netIK4t = netI4/LK4
gen netDE4t = netE4/LE4
gen netIK4Tt = netIT4/LK4
gen netDE4Tt = netET4/LE4
  
gen netIK5t = netI5/LK5
gen netDE5t = netE5/LE5
gen netIK5Tt = netIT5/LK5
gen netDE5Tt = netET5/LE5

gen netIK6t = netI6/LK6
gen netDE6t = netE6/LE6
gen netIK6Tt = netIT6/LK6
gen netDE6Tt = netET6/LE6

gen netIK7t = netI7/LK7
gen netDE7t = netE7/LE7
gen netIK7Tt = netIT7/LK7
gen netDE7Tt = netET7/LE7

gen netIK8t = netI8/LK8
gen netDE8t = netE8/LE8
gen netIK8Tt = netIT8/LK8
gen netDE8Tt = netET8/LE8
  

sum net???t net???Tt reall*
 
 

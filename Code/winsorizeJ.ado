/***************************
* winsorizeJ.ado
* Winsorize variables, generating variables with designated suffix
*
***************************/

program define winsorizeJ
	* Version 8
	
	syntax varlist [if] [in] [, suffix(string) by(varlist) cuts(numlist max=2 min=2 >=0 <=100)]

	if "`suffix'"=="" local suffix="W"

	if "`cuts'"=="" {
		local low=1
		local high=99
		}
	else {
		tokenize "`cuts'"
		local low=`1'
		mac shift
		local high=`1'
		if `low'>`high' {
			tempname tmp
			local `tmp'=`low'
			local low=`high'
			local high=`tmp'
			}
		}

	* Validate suffix
	foreach k of varlist `varlist' {
		capture confirm variable `k'`suffix', exact
		if _rc == 0 {
			di as error "Suffix `suffix' is invalid for `k'"
			exit 111
			}
		}

	* Validate by list
	if "`by'" != "" {
		capture confirm variable `by'
		if _rc != 0 {
			di as error "by() list is invalid"
			exit 111
			}
		}

	* Winsorize
	tempname if2
	if "`by'" == "" {
		foreach k of varlist `varlist' {
			qui centile `k' `if' `in', centile(`low' `high')
			if "`if'"=="" local `if2' "if ~missing(`k')"
			else local `if2' "`if' & ~missing(`k')"
			qui gen `k'`suffix'=max(min(r(c_2),`k'),r(c_1)) ``if2'' `in'
			local `if2' : variable label `k'
			label variable `k'`suffix' "``if2'' - Winsorized"
			}
		}
	else {
		tempvar pL pH tL
		foreach k of varlist `varlist' {
			if "`if'"=="" local `if2' "if ~missing(`k')"
			else local `if2' "`if' & ~missing(`k')"
			qui egen `pL'=pctile(`k') ``if2'' `in', p(`low') by(`by')
			qui egen `pH'=pctile(`k') ``if2'' `in', p(`high') by(`by')
			qui egen `tL'=rowmax(`pL' `k') ``if2'' `in'
			qui egen `k'`suffix'=rowmin(`pH' `tL') ``if2'' `in'
			qui drop `pL' `pH' `tL'
			local `if2' : variable label `k'
			label variable `k'`suffix' "``if2'' - Winsorized"
			}
		} 

end

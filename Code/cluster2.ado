* cluster2.ado ---- written by Mitchell Petersen -- March 2006 
* Program calculates clustered standard errors in both a firm and time dimension
*  as described by Thompson in "A Simple Formula for Standard Errors that Cluster by Both Firm and Time" and
*      	and Cameron, Gelbach, and Miller, 2006, "Robust Inference with Multi-way Clustering"
*  Additions and edits
*  	Compliant with outreg -- June, 2007 (Jingling Guan) [eclass]
*	Checks for multiple observations per fcluster-tcluster -- June, 2007 (Jingling Guan) 
* this is test of update of file date

#delimit ; 
program define cluster2, eclass sortpreserve byable(recall);
	syntax [varlist] [in] [if], fcluster(varname) tcluster(varname);
	tokenize `varlist';
	marksample touse;
	local depv `"`1'"';
* ---------------------------------------------------------------- ;
* ----- Regression Clustering by First Variable (e.g. Firm) ------ ;
* ---------------------------------------------------------------- ;
	quietly reg `varlist' if `touse', robust cluster(`fcluster');
	matrix vcf = e(V);
	local nfcluster=e(N_clust);
* ---------------------------------------------------------------- ;
* ----- Regression Clustering by Second Variable (e.g. Time) ----- ;
* ---------------------------------------------------------------- ;
	quietly reg `varlist' if `touse', robust cluster(`tcluster');
	matrix vct = e(V);
	local ntcluster=e(N_clust);
* ---------------------------------------------------------------- ;
* ---------------  Regression with "No Clustering"  -------------- ;
* ---------------------------------------------------------------- ;
	capture confirm string variable `fcluster';
	if !_rc {;
		gen bc1 = `fcluster'; /* string variable */
		};
		else {;
		gen bc1 = string(`fcluster'); /* numeric */
		};
	capture confirm string variable `tcluster';
	if !_rc {;
		gen bc2 = `tcluster'; /* string variable */
		};
		else {;
		gen bc2 = string(`tcluster'); /* numeric */
		};
	gen bc3 = bc1 + "_" + bc2;
	* --------------------------------------------------------- ;
	*   Check for multiple observations per fcluster-tcluster   ;
	* --------------------------------------------------------- ;
	bysort bc3: gen unique_obs = _n==1;	* =1 if only one obs per fcluster-tcluster;
	qui sum unique_obs;		

	if r(mean)==1 {;
	   	quietly reg `varlist' if `touse', robust;
	   	local mcluster=0;
		};
	   else {;
	   	quietly reg `varlist' if `touse', robust cluster(bc3);
	   	local mcluster =1 ;
		};
	drop bc1 bc2 bc3 unique_obs;

	local nparm = e(df_m)+1;
	matrix coef = e(b);
	matrix vc = vcf+vct-e(V);
	
* ---------------------------------------------------------------- ;
* ----------------- Print out Regression Results ----------------- ;
* ---------------------------------------------------------------- ;
	tokenize `varlist';  		/* this puts varlist in to the macros `1' `2' etc */
	macro shift;			/* drops first arguement (dep var) and shifts the rest up one */
	
	dis " ";
	dis in green "Linear regression with 2D clustered SEs"
		_column (56) "Number of obs = " %7.0f in yellow e(N);
	dis in green _column(56) "F(" %3.0f e(df_m) "," %6.0f e(df_r) ") =" %8.2f in yellow e(F);
	dis in green _column(56) "Prob > F      ="  %8.4f in yellow 1-F(e(df_m),e(df_r),e(F));
	dis in green "Number of clusters (`fcluster') = " _column(31) %5.0f in yellow $_nfcluster
          in green _column(56) "R-squared     =" %8.4f in yellow e(r2);
   	dis in green "Number of clusters (`tcluster') = " _column(31) %5.0f in yellow $_ntcluster
	    in green _column(56) "Root MSE      =" %8.4f in yellow e(rmse);

* ---------------------------------------------------------------- ;
* ----------------- upload Regression Results into e()------------ ;
* ---------------------------------------------------------------- ;

* save statistics from the last regression (clustered by fcluster+tcluster);
* scalars;
	scalar e_N=e(N);
	scalar e_df_m = e(df_m);
	scalar e_df_r = e(df_r);
	scalar e_F = e(F);
	scalar e_r2 = e(r2);
	scalar e_rmse = e(rmse);
	scalar e_mss = e(mss);
	scalar e_rss = e(rss);
	scalar e_r2_a = e(r2_a);
	scalar e_ll = e(ll);
	scalar e_ll_0 = e(ll_0);

* prepare matrices to upload into e();
	ereturn clear;
	tempname b V;
	matrix `b' = coef;
	matrix `V' = vc;

* post the resuls in e();
	ereturn post `b' `V';
	ereturn scalar N = e_N;
	ereturn scalar df_m = e_df_m;
	ereturn scalar df_r = e_df_r;
 	ereturn scalar F= e_F;
	ereturn scalar r2= e_r2;
	ereturn scalar rmse = e_rmse;
	ereturn scalar mss = e_mss;
	ereturn scalar rss = e_rss;
	ereturn scalar r2_a = e_r2_a;
	ereturn scalar ll = e_ll;
	ereturn scalar ll_0 = e_ll_0;
	ereturn local title "Linear regression with clustered SEs";
	ereturn local method "2-dimension clustered SEs";
	ereturn local depvar "`depv'";
	ereturn local cmd "cluster2";
* end of uploading;
* ==================================================================;

* display coefficients and se;
	ereturn display;
	dis " ";
	if $_mcluster==1 {;
		dis "     SE clustered by " "`fcluster'" " and " "`tcluster'" " (multiple obs per " "`fcluster'" "-" "`tcluster'" ")";
		};
	   else {;
		dis "     SE clustered by " "`fcluster'" " and " "`tcluster'";
		};		
	dis " "; 

	scalar drop e_N e_df_m e_df_r e_F e_r2 e_rmse e_mss e_rss e_r2_a e_ll e_ll_0;
	matrix drop coef vc vcf vct;

end;

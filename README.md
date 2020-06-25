# Replication Code and Data for Kogan, L., Papanikolaou, D., Seru, A. and Stoffman, N., QJE 2017 

This package provides the replication code for the main results in **Kogan, L., Papanikolaou, D., Seru, A. and Stoffman, N., 2017. Technological innovation, resource allocation, and growth. Quarterly Journal of Economics, 132(2), pp. 665-712.** The paper is available at https://academic.oup.com/qje/article/132/2/665/3076284.

The folder ./Code contains all programs, while the folder ./Data includes all needed input data files. 

## Code 

The folder ./Code includes code files of two types of programs: Stata and Matlab. 

### Code files using Stata:

#### Prerequisite:

In order for the code to run correctly, you need the following packages installed in Stata: 

- **winsorizeJ**: Winsorize variables using breakpoints that vary by year. (A winsorizeJ.ado file is provided in the folder ./Code)

- **cluster2**: 2D clustered standard errors. (A cluster2.ado file is provided in the folder ./Code)

- **ivreg2**: IV regression with more features than STATA's ivreg. (Install the package using command "ssc install ivreg2")

- **reghdfe**: Regression with multiple levels of fixed effects. (Install the package using command "ssc install reghdfe")

- **estout**: Output Stata tables in tex format.  (Install the package using command "ssc install estout")

#### File description:

- **FilterReturnsCreateFirmMeasures.do**: Creates the firm-level innovation measure using patent and stock return data

- **PatentValueCites.do**: Descriptive statistics for the patent-level measure, including robustness for alternative distributions (Table 1 in the paper and Table A.6 in the Online Appendix); relates the estimated patent values to forward citations (Table 2 in the paper and Table A.7 in the Online Appendix)

- **CreateFirmSample.do**: Creates the data for the firm-level regressions

- **FirmSummaryStats.do**: Descriptive statistics for the firm-level measure (Table 3 in the paper)
 
- **FirmProfitsRegressionSM.do**: Firm Profits and innovation (Panel a of Table 4 in the paper) 

  **FirmOutputRegressionSM.do**: Firm Output and innovation (Panel b of Table 4 in the paper) 
  
  **FirmReallocationRegressionSM.do**: Firm Capital/Labor and innovation (Panels c and d of Table 4 in the paper ) 
  
  **FirmTFPRegressionSM.do**: Firm TFP and innovation (Panel e of Table 4 in the paper) 	

- **FirmProfitsRegressionCW.do**: Firm Profits and innovation using citation-weighted patents (Panel a of Table 5 in the paper)

  **FirmOutputRegressionCW.do**: Firm Output and innovation using citation-weighted patents (Panel b of Table 5 in the paper)
  
  **FirmReallocationRegressionCW.do**: Firm Capital/Labor and innovation using citation-weighted patents (Panels c and d of Table 5 in the paper) 
  
  **FirmTFPRegressionCW.do**: Firm TFP and innovation using citation-weighted patents (Panel e of Table 5 in the paper) 

- **FirmProfitsRegressionSMCW.do**: Firm Profits and innovation using both our measure and citation-weighted patents (Panel a of Table 6 in the paper) 

  **FirmOutputRegressionSMCW.do**: Firm Output and innovation using both our measure and citation-weighted patents (Panel b of Table 6 in the paper)
  
  **FirmReallocationRegressionSMCW.do**: Firm Capital/Labor and innovation using both our measure and citation-weighted patents (Panels c and d of Table 6 in the paper)
  
  **FirmTFPRegressionSMCW.do**: Firm TFP and innovation using both our measure and citation-weighted patents (Panel e of Table 6 in the paper)

- **PatentValueScatterPlot.do**:  Plots the cross-sectional relation between forward patent citations and patent market value (Figure 2 in the paper)

- **TimeSeriesPlots.do**: Produces and plots the aggregate measures of innovation (Figure 4 in the paper) 
	
- **AggregateOutput.do**: Runs the aggregate OLS regressions and VARs that relate our two innovation indices to output and TFP (The regression results for Figure 5  in the paper and Figure A.3 in the Online Appendix)


### Code files using Matlab:

#### Prerequisite:

In order for the code to run correctly, you need to install the following program as well: 

- **matlab2tikz**: Converts MATLAB®/Octave figures to TikZ/pgfplots figures for smooth integration into LaTeX. (Please go to https://github.com/matlab2tikz/matlab2tikz for detailed installation information)

#### File description:

- **plot_OLS_responses.m**: Take the output of AggregateOutput.do and creates Figure 5 in the paper

- **csvimport.m**: Define the function called in plot_OLS_responses.m which helps import the .csv files

- **jbfill.m**: Define the function called in plot_OLS_responses.m which helps plot the confidence intervals


#### Additional Notes:

- There are some minor discrepancies between the output that the code generates and the results reported in Table 5 (published version of the paper). These minor differences are due to typos in the published version.

- There are copyright restrictions and file size limitations in posting daily data from CRSP. Please contact the authors below to obtain the code and data needed to replicate Figures 1 and 3 in the paper that use this data.


## Contact

Please contact Dimitris Papanikolaou (d-papanikolaou@kellogg.northwestern.edu) or Amit Seru (aseru@stanford.edu) for any questions regarding the codes or data.

**Please see the paper for more information on the codes and data. If you use these codes files or data, please CITE this paper as the source.**




	* ---------------------------------------------------------------------------------------------*
	* Master do-file for the results of "This mine is mine: how minerals fuel conflicts in Africa" *
	* ---------------------------------------------------------------------------------------------*
		
		
clear all
set mem 5g
set matsize 8000
set maxvar  8000

/*
cap ado uninstall ftools
net install ftools, from("https://raw.githubusercontent.com/sergiocorreia/ftools/master/src/") 
*/

/*
ssc install distinct, replace
ssc install geodist, replace
ssc install reghdfe, replace
ssc install tmpdir, replace
ssc install xtpqml, replace
ssc install tuples, replace

* cd directory here
global base "XXXXX"

* Global

global Output_data	"Data_Code_BCRT_AER\Data"
global Results		"Data_Code_BCRT_AER\results"
global Do_files     "Data_Code_BCRT_AER\Do"

cd "$base"
*/

//add your data path and code path here based on your username
if "`c(username)'"=="abdulrazzaktamim" {
	gl Dropbox "/Users/abdulrazzaktamim/Library/CloudStorage/Dropbox/Files/Attended Universities/Berkeley/Courses/E. Spring 2024/Econ 270b/psets/ps2/113068-V1/20150774_data"
	gl git "/Users/abdulrazzaktamim/Documents/GitHub/mines_reproduction"
}

global Output_data	"$Dropbox/Data"
global Results		"$git/results"
global Do_files     "$git/Do"
adopath ++ "$Do_files/ado"

* To run before anything
do "$Do_files/my_spatial_2sls.do"

/* Results */

do $Do_files/Table_2.do								
do $Do_files/Tables_4_A29_to_A31.do					




clear all

cd C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\Train\analysis\code

cap do preclean_departments_wide.do

global labor1970 agr_labor_1970 min_labor_1970 ind_labor_1970 egw_labor_1970 constr_labor_1970 wret_labor_1970 hrest_labor_1970 tsc_labor_1970 fin_labor_1970 pub_labor_1970 rsb_labor_1970 edu_labor_1970 hsw_labor_1970 ot_labor_1970 oth_labor_1970
global labor1991 agr_labor_1991 min_labor_1991 ind_labor_1991 egw_labor_1991 constr_labor_1991 wret_labor_1991 hrest_labor_1991 tsc_labor_1991 fin_labor_1991 pub_labor_1991 rsb_labor_1991 edu_labor_1991 hsw_labor_1991 ot_labor_1991 oth_labor_1991
global shlabor1970 share_agr_labor_1970 share_min_labor_1970 share_ind_labor_1970 share_egw_labor_1970 share_constr_labor_1970 share_wret_labor_1970 share_hrest_labor_1970 share_tsc_labor_1970 share_fin_labor_1970 share_pub_labor_1970 share_rsb_labor_1970 share_edu_labor_1970 share_hsw_labor_1970 share_ot_labor_1970 share_oth_labor_1970
global shlabor1991 share_agr_labor_1991 share_min_labor_1991 share_ind_labor_1991 share_egw_labor_1991 share_constr_labor_1991 share_wret_labor_1991 share_hrest_labor_1991 share_tsc_labor_1991 share_fin_labor_1991 share_pub_labor_1991 share_rsb_labor_1991 share_edu_labor_1991 share_hsw_labor_1991 share_ot_labor_1991 share_oth_labor_1991

gen totlabor1970=agr_labor_1970 + min_labor_1970 + ind_labor_1970 + egw_labor_1970 ///
+ constr_labor_1970 + wret_labor_1970 + hrest_labor_1970 + tsc_labor_1970 ///
+ fin_labor_1970 + pub_labor_1970 + rsb_labor_1970 + edu_labor_1970 ///
+ hsw_labor_1970 + ot_labor_1970 + oth_labor_1970

gen totlabor1991=agr_labor_1991 + min_labor_1991 + ind_labor_1991 + egw_labor_1991 ///
+ constr_labor_1991 + wret_labor_1991 + hrest_labor_1991 + tsc_labor_1991 ///
+ fin_labor_1991 + pub_labor_1991 + rsb_labor_1991 + edu_labor_1991 ///
+ hsw_labor_1991 + ot_labor_1991 + oth_labor_1991

collapse (sum) totlabor1970 totlabor1991 $labor1970 $labor1991 (mean) $shlabor1970 $shlabor1991

foreach var of var $labor1970{
  gen sh_`var'=round(100*`var'/totlabor1970,.01)
}


foreach var of var $labor1991{
  gen sh_`var'=round(100*`var'/totlabor1991,.01)
}


mkmat sh_*1970, mat(A)
mat def sh70 = A'

mkmat sh_*1991, mat(B)
mat def sh91 = B'

mkmat $shlabor1970, mat(C)

mkmat $shlabor1991, mat(D)

mat def sh = (A \ B \ C \ D)

mat def sh = sh'
global indnames  agriculture mining industry "electricity, gas and water" ///
"construction" "wholesale and reatail" "hotels and restaurants" ///
"transportation and communication" "finance" "public admin" ///
"real state and other business" "education" "health and social" ///
"other services" "other houshold services"
matrix rowname sh = $indnames

matrix colname sh = "1970 total" "1991 total" "1970 average" "1991 average"

mat list sh

esttab matrix(sh) using "../output/activities.tex", mtitle("") replace

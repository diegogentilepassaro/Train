use "..\..\base\output\ARG_IPUMS_7080910110.dta", clear
append using "..\temp\c1960_ipums.dta"

drop country

foreach var of var geolev1 geo2_ar{
  egen x=mode(`var'), by(geolev2)
  replace `var'=x if `var'==.
  drop x
}

replace urbpop = urb if urbpop==.
drop urb rur

encode provname, g(y)
egen x=mode(y), by(geolev2)
replace y=x if y==.
drop provname x
ren y provname

foreach var of var urbpop *mig5 *indgen_* *occisco_* *classwk_* *empstat* *college *secondary{
  ren `var' `var'_
}

reshape wide pop urbpop *mig5* *indgen_* *occisco_* *classwk_* *empstat* *college* *secondary*, i(geolev2) j(year)

merge 1:1 geolev2 using "..\temp\ARG_districts_geo.dta"

*assert _merge==3
drop _merge

merge 1:1 geolev2 using "..\temp\ARG_districts_infra_hypo.dta"

*assert _merge==3
drop _merge
**CHECK: MISMATCH IN MERGE FOR TWO OBSERVATIONS FROM C1960_IPUMS


label var geolev2 "id ipums"
label var wheat "wheat pot yield - tons per Ha, average"
label var wheat_std " wheat pot yield- standardized"
label var precal "caloric pot yield pre 1500"
label var precal_std "caloric pot yield pre 1500 - standardized"

ren postCal postcal
ren postCal_std postcal_std

label var postcal "caloric pot yield post 1500"
label var postcal_std "caloric pot yield post 1500 - standardized"

label var elev_mean "average elevation mts"
label var elev_mean_std "average elevation mts - standardized"

label var dist_to_BA "distance to Buenos Aires in kms"
label var dist_to_BA_std "distance to Buenos Aires"
label var rugged_mea "average ruggedness"

gen area_km2 = area_m2/1000000
drop area_m2
label var area_km2 "area - sq. kms"

label var studied_0 "larkin plan kms - not studied"
label var studied_1 "larkin plan kms - studied"
label var statusLP_1 "larkin plan kms - maintain"
label var statusLP_2 "larkin plan kms - to close"
label var statusLP_3 "larkin plan kms - new study"
label var status79_1 "status 1979 kms - active"
label var status79_2 "status 1979 kms - closed in dict."
label var status79_3 "status 1979 kms - closed pre dict."
label var roads54_type1 "roads 1954 kms - paved"
label var roads54_type2 "roads 1954 kms - gravel"
label var roads54_type3 "roads 1954 kms - dirt"
label var roads54_type4 "roads 1954 kms - path"
label var roads70_type1 "roads 1970 kms - paved"
label var roads70_type2 "roads 1970 kms - gravel"
label var roads70_type3 "roads 1970 kms - dirt"
label var roads70_type4 "roads 1970 kms - path"
label var roads86_type1 "roads 1986 kms - paved"
label var roads86_type2 "roads 1986 kms - glavel"
label var roads86_type3 "roads 1986 kms - dirt"
label var roads86_type4 "roads 1986 kms - path"

label var hypo_EUC_MST_kms  "Euclidean MST network (kms)"
label var hypo_LCP_MST_kms  "Least-cost MST network (kms)"

foreach year in 1970 1980 1991 2001 2010{
  label var occisco_1_`year' "`year' occup. legislators, senior officials and managers"
  label var occisco_2_`year' "`year' occup. professionals"
  label var occisco_3_`year' "`year' occup. technicians and associate professionals"
  label var occisco_4_`year' "`year' occup. clerks"
  label var occisco_5_`year' "`year' occup. service workers and shop and market sales"
  label var occisco_6_`year' "`year' occup. skilled agricultural and fishery workers"
  label var occisco_7_`year' "`year' occup. crafts and related trades workers"
  label var occisco_8_`year' "`year' occup. plant and machine operators and assemblers"
  label var occisco_9_`year' "`year' occup. elementary occupations"
  label var occisco_10_`year' "`year' occup. armed forces"

  label var indgen_1_`year' "`year' ind. agriculture, fishing, forestry - % of total labor"
  label var indgen_2_`year' "`year' ind. mining - % of total labor"
  label var indgen_3_`year' "`year' ind. manufacturing - % of total labor"
  label var indgen_4_`year' "`year' ind. electricity, gas and water - % of total labor"
  label var indgen_5_`year' "`year' ind. construction - % of total labor"
  label var indgen_6_`year' "`year' ind. wholesale and retail trade - % of total labor"
  label var indgen_7_`year' "`year' ind. hotels and restaurants - % of total labor"
  label var indgen_8_`year' "`year' ind. transportation, storage and comunications - % of total labor"
  label var indgen_9_`year' "`year' ind. financial services and insurance - % of total labor"
  label var indgen_10_`year' "`year' ind. public administration and defense - % of total labor"
  label var indgen_11_`year' "`year' ind. real estate and business services- % of total labor"
  label var indgen_12_`year' "`year' ind. education - % of total labor"
  label var indgen_13_`year' "`year' ind. health ans social work - % of total labor"
  label var indgen_14_`year' "`year' ind. other services - % of total labor"
  label var indgen_15_`year' "`year' ind. other household services - % of total labor"


  label var mig5_`year' "% of people living in the province they were born - `year'"
  label var nmig5_`year' "# of people living in the province they were born - `year'"

  label var classwk_1_`year' "`year' self-employed"
  label var classwk_2_`year' "`year' waged"
  label var classwk_3_`year' "`year' unpaid"

  label var empstat_1_`year' "`year' employed"
  label var empstat_2_`year' "`year' unemployed"
  label var empstat_3_`year' "`year' inactive"
}

label var roadsall_class1 "existe en 1954 - 1970 - 1986"
label var roadsall_class2 "existe en 1970 - 1986  ; no existe en 1954 "
label var roadsall_class3 "existe en 1986 ; no existe en 1954 - 1970
label var roadsall_class4 "existe en 1954 - 1970 ; no existe en - 1986"
label var roadsall_class5 "existe en 1954 - 1986 ; no existe en - 1970"
label var roadsall_class6 "existe en 1954 ; no existe en - 1970 - 1986"
label var roadsall_class7 "existe en 1970 ; no existe en 1954 - 1986"



foreach var of var *{
  qui mdesc `var'
  if r(miss)==r(total){
    drop `var'
  }
}

drop if geolev2 == 238094004 /* malvinas */
drop if geolev2 == 239094003 /*south georgia and south sandwich*/

list geo2* prov* if area_km2==.
labellist geo2*
drop if area_km2==.

/*one obs is "entrerrios-district unkown", the other one is "unknown"*/

save_data "../output/departments_wide_panel.dta", replace key(geolev2)

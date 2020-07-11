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

foreach var of var indgen_* occisco_* classwk_*{
  ren `var' `var'_
}

reshape wide pop urbpop mig5 indgen_* occisco_* classwk_*, i(geolev2) j(year)

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
label var roads86_type1 "roads 1986 kms - paved"
label var roads86_type2 "roads 1986 kms - glavel"
label var roads86_type3 "roads 1986 kms - dirt"
label var roads86_type4 "roads 1986 kms - path"
label var hypoCMST_kms  "hyp network kms - CMST"
label var hypoEMST_kms  "hyp network kms - EMST"
label var hypomeanEMST_kms  "hyp network kms - mean EMST "


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

  label var indgen_1_`year' "`year' ind. agriculture, fishing, forestry"
  label var indgen_2_`year' "`year' ind. mining"
  label var indgen_3_`year' "`year' ind. manufacturing"
  label var indgen_4_`year' "`year' ind. electricity, gas and water"
  label var indgen_5_`year' "`year' ind. construction"
  label var indgen_6_`year' "`year' ind. wholesale and retail trade"
  label var indgen_7_`year' "`year' ind. hotels and restaurants"
  label var indgen_8_`year' "`year' ind. transportation, storage and comunications"
  label var indgen_9_`year' "`year' ind. financial services and insurance"
  label var indgen_10_`year' "`year' ind. public administration and defense"
  label var indgen_11_`year' "`year' ind. real estate and business services"
  label var indgen_12_`year' "`year' ind. education"
  label var indgen_13_`year' "`year' ind. health ans social work"
  label var indgen_14_`year' "`year' ind. other services"
  label var indgen_15_`year' "`year' ind. other household services"
}


foreach var of var *{
  qui mdesc `var'
  if r(miss)==r(total){
    drop `var'
  }
}

save "..\output\departments_wide_panel.dta", replace

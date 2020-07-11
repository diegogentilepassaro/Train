*I. PREAMBLE

*II. Agricultural Yields - Coffee and Other Crops

clear all

import dbase using "..\temp\use_wheat_d.dbf", clear case(lower)
ren *, lower

ren geolevel2 id_main

bys id_main: egen den=sum(weighta)
gen w=weighta/den
drop weighta den
gen wheat=w*value
drop w value
collapse wheat, by(id_main)
egen wheat_std=std(wheat)
save "..\temp\\use_wheat_d.dta", replace

tempfile a
save `a', replace


*III. Caloric Suitability

foreach s in pre post{
	import dbase using "..\temp\use_`s'Cal_d.dbf", clear case(lower)
	ren *, lower
	ren geolevel2 id_main
	bys id_main: egen den=sum(weighta)
	gen w=weighta/den
	drop weighta den
	gen `s'Cal=w*value
	drop w value
	collapse *Cal*, by(id_main)
	egen `s'Cal_std=std(`s'Cal)
	save "..\temp\\use_`s'Cal_d.dta", replace
}

use "..\temp\use_preCal_d.dta"
ren *, lower

merge 1:1 id_main using "..\temp\use_postCal_d.dta"
assert _merge==3
drop _merge

tempfile b
save `b', replace



*III. Other spatial controls

import dbase using "..\temp\geo2_ar1970_2010_fix.dbf", clear case(lower)
ren *, lower
ren geolevel2 id_main
isid id_main

foreach x in elev_mean rugged_mea /*nl92_mean*/ {
	preserve
	collapse `x', by(id_main)
	egen `x'_std=std(`x')
	save "..\temp\\`x'_d.dta", replace
	restore
}
/*
foreach x in nl92_sum {
	preserve
	collapse (sum) `x', by(id_main)
	egen `x'_std=std(`x')
	save "..\temp\\`x'_d.dta", replace
	restore
}
*/

use "..\temp\\elev_mean_d.dta", clear
foreach x in rugged_mea /*NL92_sum*/ {
	merge 1:1 id_main using "..\temp\\`x'_d.dta"
	assert _merge==3
	drop _merge
}
tempfile c
save `c', replace

*IV. Distance to BA



import dbase using "..\temp\BAdist_districts.dbf", clear case(lower)
ren *, lower
ren geolevel2 id_main

count
ren *, lower
keep id_main hubdist
isid id_main
ren hubdist dist_to_BA

foreach x in dist_to_BA {
	collapse `x', by(id_main)
	egen `x'_std=std(`x')
	save "..\temp\\`x'.dta", replace
}

tempfile d
save `d', replace

*VI. Area and other attributes

import dbase using "..\temp\geo2_ar1970_2010_fix.dbf", clear case(lower)
ren *, lower
keep cntry_name admin_name cntry_code geolevel2 parent area_m2
ren geolevel2 id_main

tempfile e
save `e', replace


*VI. Final Merge

use `a'
merge 1:1 id_main using `a'
assert _merge==3
drop _merge

merge 1:1 id_main using `b'
assert _merge==3
drop _merge


merge 1:1 id_main using `c'
*assert _merge==3
list id_main if _merge!=3
list if _merge!=3
drop _merge

merge 1:1 id_main using `d'
assert _merge==3
drop _merge

merge 1:1 id_main using `e'
assert _merge==3
drop _merge


drop if id_main=="032030000"
*VII. Labels

*VIII. FINAL STEPS
ren id_main geolev2
destring geolev2, replace
save "..\temp\ARG_districts_geo.dta", replace

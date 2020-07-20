*I. PREAMBLE

*II. Trains - larkin plan + follow-up

**larkin plan excel

use "..\..\base\output\larkin_scores.dta", clear
keep orig_segment_id proposed_to_close new_study mantain table

gen statusLP = 1
replace statusLP = 2 if proposed_to_close==1
replace statusLP=3 if new_study==1

gen studied=1
replace studied=0 if table==14

drop table
drop proposed_to_close new_study mantain

tempfile lpscores
save `lpscores', replace
desc

**larkin plan recommendation
import dbase using "..\temp\\inter_lp79_l.dbf", clear case(lower)
ren *, lower

keep id_main length_met geolevel2
gen length_km=length_met/1000
drop length_met
gen orig_segment_id=id_main

merge n:1 orig_segment_id using `lpscores'

collapse (sum) length_km , by(geolevel2 statusLP)

ren length_km statusLP_
reshape wide statusLP_, i(geolevel2) j(statusLP)

tempfile statusLP
save `statusLP', replace

**larkin plan study

import dbase using "..\temp\\inter_lp79_l.dbf", clear case(lower)
ren *, lower

keep id_main length_met geolevel2
gen length_km=length_met/1000
drop length_met
gen orig_segment_id=id_main


merge n:1 orig_segment_id using `lpscores'

collapse (sum) length_km , by(geolevel2 studied)

ren length_km studied_
reshape wide studied_, i(geolevel2) j(studied)

tempfile studied
save `studied', replace

**status 79
clear all
import dbase using "..\temp\\inter_lp79_l.dbf", clear case(lower)
ren *, lower

ren *, lower
keep status1979 length_met geolevel2

gen length_km=length_met/1000
drop length_met
collapse (sum) length_km, by(geolevel2 status1979)
ren length_km status79_
reshape wide status79_, i(geolevel2) j(status1979)

tempfile status79
save `status79', replace



*III. Roads - 1954, 1986 and hypo networks

import dbase using "..\temp\\inter_roads54_l.dbf", clear case(lower)
ren *, lower
keep type length_met geolevel2
gen length_km=length_met/1000
drop length_met
collapse (sum) length_km, by(geolevel2 type)
ren length_km roads54_type
reshape wide roads54_type, i(geolevel2) j(type)

tempfile roads54
save `roads54', replace

import dbase using "..\temp\\inter_roads86_l.dbf", clear case(lower)
ren *, lower
keep type length_met geolevel2
gen length_km=length_met/1000
drop length_met
collapse (sum) length_km, by(geolevel2 type)
ren length_km roads86_type
reshape wide roads86_type, i(geolevel2) j(type)

tempfile roads86
save `roads86', replace


import dbase using "..\temp\\inter_hypoCMST_l.dbf", clear case(lower)
ren *, lower
keep length_met geolevel2

collapse (sum) length_met, by(geolevel2)
ren length_met hypoCMST_kms

tempfile hypoCMST
save `hypoCMST', replace


import dbase using "..\temp\\inter_hypoEMST_l.dbf", clear case(lower)
ren *, lower
keep length_met geolevel2

collapse (sum) length_met, by(geolevel2)
ren length_met hypoEMST_kms

tempfile hypoEMST
save `hypoEMST', replace

import dbase using "..\temp\\inter_hypomeanEMST_l.dbf", clear case(lower)
ren *, lower
keep length_met geolevel2

collapse (sum) length_met, by(geolevel2)
ren length_met hypomeanEMST_kms

tempfile hypomeanEMST
save `hypomeanEMST', replace




*IV MERGE
use `statusLP'
drop if geolevel2==""
merge 1:1 geolevel2 using `studied'
drop if geolevel2==""
assert _merge==3
drop _merge
merge 1:1 geolevel2 using `status79'
assert _merge==3
drop _merge
merge 1:1 geolevel2 using `roads54'
*assert _merge==3
drop _merge
merge 1:1 geolevel2 using `roads86'
assert _merge==3
drop _merge
merge 1:1 geolevel2 using `hypoCMST'
*assert _merge==3
drop _merge
merge 1:1 geolevel2 using `hypoEMST'
*assert _merge==3
drop _merge
merge 1:1 geolevel2 using `hypomeanEMST'
*assert _merge==3
drop _merge

ren geolevel2 id_main

foreach var of var statusLP_1 statusLP_2 statusLP_3 status79_1 studied_0 studied_1 status79_2 status79_3 roads54_type1 roads54_type2 roads54_type3 roads54_type4 roads86_type1 roads86_type2 roads86_type3 roads86_type4 hypoCMST_kms hypoEMST_kms hypomeanEMST_kms {
	recode `var' (.=0)
}


*V. Labels

*VI. FINAL STEPS
ren id_main geolev2
destring geolev2, replace
save "..\temp\ARG_districts_infra_hypo.dta", replace
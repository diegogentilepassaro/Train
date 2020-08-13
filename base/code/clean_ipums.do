use "..\..\raw_data\IPUMS\ipumsi_00007\ipumsi_00007.dta", clear

*II. GENERATING VARIABLES

*Population
bys country year geolev2: egen pop=sum(hhwt)

*Education - percentage of people with ig
gen e=hhwt if edattain==4
bys country year geolev2: egen educ = sum(e)

gen s=hhwt if edattain==4 | edattain==3
bys country year geolev2: egen educ2 = sum(s)

gen x=hhwt if edattain!=0 & edattain!=9
by country year geolev2: egen den = sum(x)

gen college = educ / den
gen secondary = educ2 / den
drop e x educ educ2 den

*Urbanization
gen u=1 if urban==2
replace u=0 if urban==1

bys country year geolev2: egen urbpop=sum(u*hhwt)
drop u
replace urbpop=. if urban==.

*Percentage of Migrants (people not living in their own province)

gen x=1 if migrate5<=30 & migrate5>=10
gen y=1 if migrate5<=12 & migrate5>=10

bys country year geolev2: egen w=sum(x*hhwt)
bys country year geolev2: egen z=sum(y*hhwt)

gen mig5=z/w

drop x y w z

*Industry
gen x=indgen
recode x 0 998 999=.
label values x INDGEN
tab x, g(indgen_)
drop x

*Occupation
gen x=occisco
recode x 97 98 99=.
label values x OCCISCO
tab x, g(occisco_)
drop x

*Class of Work
gen x = classwk
recode x 0 9=.
label values x CLASSWK
tab x, g(classwk_)
drop x

*Employment status

gen x = empstat
recode x 0 9=.
label values x EMPSTAT
tab x, g(empstat_)
drop x

*using weights for Industry, Occupation and Class of work



foreach var of var indgen_* occisco_* classwk_* empstat_*{
gen y=hhwt if `var'!=.
bys year country geolev1 geolev2: egen x=sum(y)
bys year country geolev1 geolev2: egen z=sum(y*`var')
replace `var'=z/x
gen n`var' = z

drop y z x

}

collapse (mean) pop college secondary urbpop mig5 *indgen_* *occisco_*  *classwk_* *empstat_*, by(year country geolev1 geolev2 geo2_ar)

preserve

import excel using "..\..\raw_data\IPUMS\prov_labels.xlsx", clear firstrow
ren GEOLEV1 geolev1
tempfile a
save `a', replace

restore

merge m:1 geolev1 using `a'
assert _merge==3 if label!="UNKNOWN"
keep if _merge==3
drop _merge

ren label provname

save_data "..\output\ARG_IPUMS_7080910110.dta", replace key(geolev2 year)

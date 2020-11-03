*I. PREAMBLE

*II. cleaning LP

**larkin plan

use "..\..\base\output\larkin_scores.dta", clear

gen statusLP = 1
replace statusLP = 2 if proposed_to_close==1
replace statusLP=3 if new_study==1

gen studied=1
replace studied=0 if table==14

tempfile lpscores
save `lpscores', replace
desc

*III.

use "..\..\base\output\estaciones_1946.dta"
isid idlp nom_1946

gen est_merge=nom_1946
tempfile est46
save `est46', replace
desc

*IV. DAMUS - select year 1943-44

use "..\..\base\output\damuspanel_total.dta"
mdesc year194*

list estacion direccion filial year1944 year1943_44 if year1944!=. & year1943_44!=.

/*important decision here: I chose year1943_44 because it has less missing values
- try with different years*/

keep estacion direccion filial year1943_44

ren year1943_44 freight1943_44

gen dir = 1 if direccion=="despachada"
replace dir = 2 if direccion=="recibida"
la de lbldir 1 "despachada" 2 "recibida"
label values dir lbldir
egen id = concat(estacion filial)
encode id, gen(idn)
drop direccion
ren freight1943_44 freight1943_44_

reshape wide freight1943_44_, j(dir) i(idn)
drop idn id
isid estacion filial


gen est_merge=estacion

tempfile y4344
save `y4344', replace
desc

*VI. MERGE - A LOT OF MARGIN TO IMPROVE

use `est46', clear
merge n:m est_merge using `y4344'

/*PROVISIONAL*/
keep if _merge==3
drop _merge

drop if idlp==-99

gen segment_id=int(idlp/10)
merge m:1 segment_id using `lpscores'

/*PROVISIONAL*/
keep if _merge==3

collapse (sum) freight1943_44_1 freight1943_44_2, by(segment_id  studied_code km)

assert studied==0 | studied==1

gen totfreight=freight1943_44_1+freight1943_44_2

foreach var of var totfreight freight1943_44_1 freight1943_44_2{
  gen `var'_pkm=`var'/km
  gen log`var'_pkm=log(`var'_pkm)
}



scatter studied_code totfreight_pkm
graph export "..\temp\rv44_1.png", replace
scatter studied_code freight1943_44_1_pkm
graph export "..\temp\rv44_2.png", replace
scatter studied_code freight1943_44_2_pkm
graph export "..\temp\rv44_3.png", replace



scatter studied_code logtotfreight_pkm
graph export "..\temp\rv44_4.png", replace
scatter studied_code logfreight1943_44_1_pkm
graph export "..\temp\rv44_5.png", replace
scatter studied_code logfreight1943_44_2_pkm
graph export "..\temp\rv44_6.png", replace

*save_data "..\temp\stations1944_LP", replace key(estacion filial)

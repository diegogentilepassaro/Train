clear all
adopath + ../../lib/stata/gslab_misc/ado

import dbase using "..\..\raw_data\estaciones_1946\estaciones_1946.dbf", clear case(lower)
ren *, lower

gen in_today=(entidad!=.)


foreach var of var nam nom_1946{
  replace `var' = subinstr(`var',"á","a",.)
  replace `var' = subinstr(`var',"é","e",.)
  replace `var' = subinstr(`var',"í","i",.)
  replace `var' = subinstr(`var',"ó","o",.)
  replace `var' = subinstr(`var',"ú","u",.)
  replace `var' = subinstr(`var',"ü","u",.)
  replace `var' = subinstr(`var',"ñ","n",.)
  replace `var' = subinstr(`var',"Ñ","N",.)
  replace `var' = upper(subinstr(`var'," ","",.))
  replace `var' = subinstr(`var',"-","",.)
  replace `var' = subinstr(`var',".","",.)
  replace `var' = subinstr(`var',"'","",.)
}

destring idlp, replace

replace nom_1946=nam if nom_1946==""


sort idlp nom_1946

duplicates tag idlp nom_1946, g(x)

list if x!=0
br if x!=0

drop if x!=0
/*
(pendiente) chequear trabajo de Stefano
Missing names
Duplicates in terms of name and larkin plan ID
*/

keep nam nom_1946 in_1946 idlp in_today


*VI. FINAL STEPS
save_data "..\output\estaciones_1946.dta", replace key(nom_1946 idlp)

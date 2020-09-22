adopath + ../../lib/stata/gslab_misc/ado
clear all
local prov "BuenosAires Catamarca Chaco Chubut Cordoba Corrientes EntreRios Formosa Jujuy LaPampa LaRioja Mendoza Misiones Neuquen RioNegro Salta SanJuan SanLuis SantaCruz SantaFe SantiagoDelEstero Tucuman CapitalFederal GranBuenosAires TierraDelFuego"

local i = 1
foreach x in `prov'{
  import excel using "..\..\raw_data\censoEconomico1985\Economico1985_`x'.xlsx", clear first
  foreach var of var Nestab Npers Massal Valprod1 Valprod2{
    cap replace `var'="." if `var'=="----------------" | `var'=="---------------"
    destring `var', replace
  }
  replace Provincia=subinstr(Provincia," ","",.)
  ren Distrito Ncodigo
  drop if Ncodigo==.
  save "..\temp\eco85_`i'.dta", replace

  import excel using "..\..\raw_data\censoEconomico1985\Codigo_`x'.xlsx", clear first
  replace Provincia=subinstr(Provincia," ","",.)
  drop if Ncodigo==.
  cap ren Distrito Departamento
  cap ren Partido Departamento
  replace Provincia="SantiagoDelEstero" if Provincia=="SantiagodelEstero"
  replace Provincia="TierradelFuego" if Provincia=="TERRITORIONACIONALDETIERRADELFUEGOEISLASDELATLANTICOSUR"
  save "..\temp\ecocod_`i'.dta", replace
  desc

  local i=`i'+1

}

*dsfds
forvalues i = 1(1)25{
  use "..\temp\eco85_`i'.dta"
  merge 1:1 Provincia Ncodigo  using "..\temp\ecocod_`i'.dta", force
  save "..\temp\ecocod85_`i'.dta", replace
}

use "..\temp\ecocod85_1.dta"
forvalues i = 2(1)25{
  append using "..\temp\ecocod85_`i'.dta", force
}

foreach var of var *{
  ren `var' `=lower("`var'")'

}

gen year=1985
ren departamento distrito
drop if provincia =="" & distrito==""

drop d e f h


/*THE FOLLOWING OBSERVATIONS ARE BEING CHECKED BY (RA) JUANFRA
(last update: Sept 21)*/

list if _merge!=3

keep if _merge==3
drop _merge

foreach var of var provincia distrito{
  replace `var' = upper(subinstr(`var'," ","",.))
  replace `var' = subinstr(`var',"-","",.)
  replace `var' = subinstr(`var',".","",.)

}


*repeticiones

duplicates tag ncodigo, g(t)
drop if t>0 & provincia=="GRANBUENOSAIRES"
drop t
assert provincia!="GRANBUENOSAIRES"


save_data "..\output\eco1985.dta", replace key(provincia distrito year)

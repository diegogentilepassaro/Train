adopath + ../../lib/stata/gslab_misc/ado
clear all
local prov "BuenosAires Catamarca Chaco Chubut Cordoba Corrientes EntreRios Formosa Jujuy LaPampa LaRioja Mendoza Misiones Neuquen RioNegro Salta SanJuan SanLuis SantaCruz SantaFe SantiagoDelEstero Tucuman"

forvalues i = 20(2)66{
  import excel using "..\..\raw_data\censoIndustrial1954\Industrial1954_`i'.xlsx", clear first
  foreach var of var Nestab Nemp Nobr Massal Valprod{
    cap replace `var'="." if `var'=="----------------" | `var'=="---------------"
    destring `var', replace
  }
  save "..\temp\indu54_`i'.dta", replace
}

use "..\temp\indu54_20.dta"
forvalues i = 22(2)66{
  append using "..\temp\indu54_`i'.dta", force
}

foreach var of var *{
  ren `var' `=lower("`var'")'

}

gen year=1954

drop if provincia =="" & distrito==""

foreach var of var provincia distrito{
  replace `var' = upper(subinstr(`var'," ","",.))
  replace `var' = subinstr(`var',"-","",.)
  replace `var' = subinstr(`var',".","",.)

}

save_data "..\output\indus1954.dta", replace key(provincia distrito year)

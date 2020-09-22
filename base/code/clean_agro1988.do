adopath + ../../lib/stata/gslab_misc/ado

/*
local prov "BuenosAires Catamarca Chaco Chubut Cordoba Corrientes EntreRios Formosa Jujuy LaPampa LaRioja Mendoza Misiones Neuquen RioNegro Salta SanJuan SanLuis SantaCruz SantaFe SantiagoDelEstero Tucuman"

local i=1
foreach prov in `prov'{
  import excel using "..\..\raw_data\censoAgricola1960\Agropecuario1988_`prov'.xlsx", clear first
  foreach var of var nexp areatot_ha{
    cap replace `var'="." if `var'=="-"
    destring `var', replace
  }

  save "..\temp\d_`i'.dta", replace
  local i = `i' + 1
}

use "..\temp\d_1.dta"
forvalues i = 2(1)22{
  append using "..\temp\d_`i'.dta"
}

foreach var of var *{
  ren `var' `=lower("`var'")'

}

gen year=1960

drop if provincia =="" & distrito=="" & nexp==. & areatot_ha==.
drop e

foreach var of var provincia distrito{
  replace `var' = upper(subinstr(`var'," ","",.))
  replace `var' = subinstr(`var',"-","",.)
  replace `var' = subinstr(`var',".","",.)

}

save_data "..\output\agro1988.dta", replace key(provincia distrito year)

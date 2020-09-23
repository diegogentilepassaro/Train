adopath + ../../lib/stata/gslab_misc/ado


local prov "BuenosAires Catamarca Chaco Chubut Cordoba Corrientes EntreRios Formosa Jujuy LaPampa LaRioja Mendoza Misiones Neuquen RioNegro Salta SanJuan SanLuis SantaCruz SantaFe SantiagoDelEstero Tucuman TierraDelFuego"

local i=1
foreach prov in `prov'{
  import excel using "..\..\raw_data\censoAgricola1988\Agricola1988_`prov'.xlsx", clear first
  replace provincia = provincia[_n-1] if provincia==""
  replace distrito = distrito[_n-1] if distrito==""

  save "..\temp\d_`i'.dta", replace
  local i = `i' + 1
}

use "..\temp\d_1.dta"
forvalues i = 2(1)22{
  append using "..\temp\d_`i'.dta", force
}

foreach var of var *{
  ren `var' `=lower("`var'")'

}

gen year=1988

gen g="-"
egen id_s = concat(provincia g distrito)
encode id_s, g(id)
encode unidad, g(unit)
drop unidad

reshape wide valor, i(id) j(unit)

foreach var of var valor*{
  count if `var'!=""
  if r(N)==0{
    drop `var'
  }
}
ren valor19 nexp
ren valor20 areatot_ha

foreach var of var provincia distrito{
  replace `var' = upper(subinstr(`var'," ","",.))
  replace `var' = subinstr(`var',"-","",.)
  replace `var' = subinstr(`var',".","",.)

}

drop id id_s g

destring nexp, replace
destring areatot_ha, replace

save_data "..\output\agro1988.dta", replace key(provincia distrito year)

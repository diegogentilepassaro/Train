adopath + ../../lib/stata/gslab_misc/ado
clear all
local prov "BuenosAires Catamarca Chaco Chubut Cordoba Corrientes EntreRios Formosa Jujuy LaPampa LaRioja Mendoza Misiones Neuquen RioNegro Salta SanJuan SanLuis SantaCruz SantaFe SantiagoDelEstero Tucuman"

local i=1
foreach prov in `prov' ZonaMilitardeComodoroRivadavia{
  import excel using "..\..\raw_data\censo1947\1947_Cuadro1_`prov'.xlsx", clear first
  foreach var of var provincia partido{
    replace `var' = subinstr(`var',"ñ","n",.)
    replace `var' = upper(subinstr(`var'," ","",.))
    replace `var' = subinstr(`var',"-","",.)
    replace `var' = subinstr(`var',".","",.)

  }
  ren n1947 pop
  save "..\temp\pop47_`i'.dta", replace

  import excel using "..\..\raw_data\censo1947\1947_Cuadro14_`prov'.xlsx", clear first
  foreach var of var provincia partido{
    replace `var' = subinstr(`var',"ñ","n",.)
    replace `var' = upper(subinstr(`var'," ","",.))
    replace `var' = subinstr(`var',"-","",.)
    replace `var' = subinstr(`var',".","",.)
  }
  isid provincia partido cUrbano
  if provincia=="BUENOSAIRES"{
    replace partido="MERLO" if partido=="MERIO"
    replace partido="CORONELMARINALNROSALES" if partido=="CNELDEMARINALROSALES"
    replace partido="LEANDRONALEM" if partido=="LEANDONALEM"
    replace partido="GENERALJUANMADARIAGA" if partido=="GENERALMADARIAGA"
  }
  if provincia=="CORDOBA"{
    replace partido="PRESIDENTEROQUESAENZPENA" if partido=="PRESIDROQUESPENA"
  }
  if provincia=="LAPAMPA"{
    replace partido="CONHELLO" if partido=="CONHELO"
  }
  if provincia=="SANTAFE"{
    replace partido="9DEJULIO" if partido=="NUEVEDEJULIO"
  }
  ren n1947 urb
  merge m:1 provincia partido using "..\temp\pop47_`i'.dta"
  list if _merge!=3
  assert _merge!=1
  drop _merge
  destring urb pop, replace
  save "..\temp\popurb47_`i'.dta", replace
  local i = `i' + 1
}



use "..\temp\popurb47_1.dta"
forvalues i = 2(1)23{
  append using "..\temp\popurb47_`i'.dta"
}

foreach var of var *{
  ren `var' `=lower("`var'")'

}

gen year=1947

ren partido distrito

bys provincia distrito: egen urbsum=sum(urb)

collapse (mean) urbsum pop, by(provincia distrito year)
ren urbsum urb


save_data "..\output\urbpop1947.dta", replace key(provincia distrito year)

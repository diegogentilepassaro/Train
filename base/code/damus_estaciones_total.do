adopath + ../../lib/stata/gslab_misc/ado
clear all

local filiales "ANDINO CHUBUT COMODORO DESEADO FC_ESTE FCBAP FCBBNO FCCA FCCBA FCCC FCCGBA FCCNA FCCNO FCCyR FCER FCMBA FCNEA FCNOA FCO FCRPB FCS FCSF FCTA FCTVR"

cap log close
log using "damus_estaciones_total", replace
display "$S_TIME"


foreach filial in `filiales'{
  foreach d in despachada recibida{

  quietly{
    import excel using "..\..\raw_data\damus\ESTACION\ESTACION\\`filial'.xls", clear sheet("Carga `d'")
    if "`filial'"=="FCNEA"{
      drop D
    }
    cap ren Estaci A
    ren A estacion
    ds estacion, not
    tostring `r(varlist)', replace force
    ds estacion, not
    foreach var of var `r(varlist)'{
      replace `var' = subinstr(`var',"/","_",.) in 1
      if `var'[1]!="."{
        ren `var' year`=`var'[1]'
      }
      else {
        drop `var'
      }
    }
    ds estacion, not
    destring `r(varlist)', replace force
    foreach var of var estacion{
      replace `var' = subinstr(`var',"á","a",.)
      replace `var' = subinstr(`var',"é","e",.)
      replace `var' = subinstr(`var',"í","i",.)
      replace `var' = subinstr(`var',"ó","o",.)
      replace `var' = subinstr(`var',"ú","u",.)
      replace `var' = subinstr(`var',"ü","u",.)
      replace `var' = subinstr(`var',"ñ","n",.)
      replace `var' = subinstr(`var',"Ñ","N",.)
      replace `var' = upper(subinstr(`var'," ","",.)  )
      replace `var' = subinstr(`var',"-","",.)
      replace `var' = subinstr(`var',".","",.)
      replace `var' = subinstr(`var',"'","",.)
    }
    gen x=_n if estacion==""
    replace x=x[_n-1] if x==.
    bys x: gen w=_n
    gen q = 0 if w==1
    replace q = 1 if strpos(estacion ,"TOTAL")>0 & strpos(estacion ,"TOTAL")!=.
    replace q=q[_n-1] if q==.
    drop if q==1
    drop q x w
    drop if estacion==""
    compress
    gen direccion = "`d'"
    gen filial = "`filial'"
    noisily display("`filial' - `d'")
    noisily ds
    noisily save "..\temp\damus_`filial'_total_`d'.dta", replace
    }
  }
}


*III. APPEND
quietly{
  clear all
  foreach filial in `filiales'{
    foreach d in despachada recibida{
      append using "..\temp\damus_`filial'_total_`d'.dta"
    }
  }
}


*IV. CLEANING
sort filial estacion direccion
/*
foreach x in TOTAL TRANSITO DISCREPANCIA REDESPACHO SERVICIO OTRASESTACIONES SINCLASIFICAR ANIMALESYVEHICULOS SEGUNTABLA19 DESPACHAD{
  drop if strpos(estacion ,"`x'")>0 & strpos(estacion ,"`x'")!=.
}
*/

foreach var of var year*{
  egen `var'_s = sum(`var'), missing by(filial estacion direccion)
  drop `var'
  ren `var'_s `var'
}

collapse (mean) year*, by(filial estacion direccion)


egen x=rowmin(year*)
list filial estacion direccion if x<0
replace year1924=0 if x<0
drop x

foreach var of var year*{
  qui count if `var'<0
  qui assert `r(N)'==0
}

mdesc
sum


save_data "..\output\damuspanel_total.dta", replace key(estacion direccion filial)
cap log close

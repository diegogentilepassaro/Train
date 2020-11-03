adopath + ../../lib/stata/gslab_misc/ado
clear all

local filiales "ANDINO CHUBUT COMODORO DESEADO FC_ESTE FCBAP FCBBNO FCCA FCCBA FCCC FCCGBA FCCNA FCCNO FCCyR FCER FCMBA FCNEA FCNOA FCO FCRPB FCS FCSF FCTA FCTVR"
local filiales "FCRPB FCS FCSF FCTA FCTVR"

cap log close
*log using "bla", replace
display "$S_TIME"

/*
foreach filial in `filiales'{
  forvalues y =1896(1)1935{
    cap import excel using "..\..\raw_data\damus\ESTACION\ESTACION\\`filial'.xls", clear sheet("`y'") cellrange(A1)
    if _rc ==0{
      display("`filial' - `y'")
      quietly{
        gen a=strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA") in 1/3
        cap replace a = strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA")+strpos(X, "Despachada") in 1/3 if a==0
        cap replace a = strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA")+strpos(U, "DESPACHADA") in 1/3 if a==0
        cap replace a = strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA")+strpos(K, "DESPACHADA") in 1/3 if a==0
        egen b =sum(a)
        if "`filial'"!="FCCNA" | ("`filial'"=="FCCNA" & "`y'"!="1897" & "`y'"!="1898" & "`y'"!="1899"){
          assert b !=0 & b!=.
          count if a==0
          assert `r(N)'>=1
        }
        else {
          noisily display("`filial' - `y' - exception")
        }
        drop a b
      }
    }
  }

  foreach y in `"1942|43"' `"1942|3"' `"1943|44"' `"1943|4"' `"1947|48"'{
    cap import excel using "..\..\raw_data\damus\ESTACION\ESTACION\\`filial'.xls", clear sheet("`y'") cellrange(A1)
    if _rc ==0{
      display("`filial' - `y'")
      quietly{
        gen a=strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA") in 1/3
        cap replace a = strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA")+strpos(X, "Despachada") in 1/3 if a==0
        cap replace a = strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA")+strpos(U, "DESPACHADA") in 1/3 if a==0
        cap replace a = strpos(B, "DESPACHADA")+strpos(C, "DESPACHADA")+strpos(K, "DESPACHADA") in 1/3 if a==0
        egen b =sum(a)
        assert b !=0 & b!=.
        count if a==0
        assert `r(N)'>=1
        drop a b
      }
    }
  }
}
*/

foreach filial in `filiales'{

  forvalues y =1896(1)1935{
    clear
    cap import excel using "..\..\raw_data\damus\ESTACION\ESTACION\\`filial'.xls", clear first sheet("`y'") cellrange(A2)
    if ("`filial'"=="FCCNA" & `y'<1917) |  "`filial'"=="COMODORO" | "`filial'"=="DESEADO" | ("`filial'"=="FCBAP" & `y'>=1900 & `y'<=1918) | ("`filial'"=="FCCA" & `y'>=1900 & `y'<=1907) | ("`filial'"=="FCCC" & `y'>=1900 & `y'<=1915) | "`filial'"=="FCCyR" | ("`filial'"=="FCNEA" & `y'<=1906) | "`filial'"=="FCNOA" | "`filial'"=="FCS" & `y'==1900{
      cap import excel using "..\..\raw_data\damus\ESTACION\ESTACION\\`filial'.xls", clear first sheet("`y'") cellrange(A1)
    }
    quietly{
      if _rc ==0 {
        cap ren Estaci A
        drop if A==""
        gen year="`y'"
        ren A estacion
        ds estacion, not
        destring `r(varlist)', force replace
        foreach var of var estacion{
          replace `var' = upper(subinstr(`var'," ","",.)  )
          replace `var' = subinstr(`var',"-","",.)
          replace `var' = subinstr(`var',".","",.)
        }

        if ("`filial'"=="FCCA" & `y'==1896){
          drop V-AE
        }
        if ("`filial'"=="FCCA" & `y'>=1897 & `y'<1900){
          drop U-AD
        }

        if ("`filial'"=="FCBAP" & `y'<1898){
          drop O-Sebo
        }
        if ("`filial'"=="FCBAP" & `y'==1898){
          drop O-W
        }
        if ("`filial'"=="FCBAP" & `y'==1899){
          drop O-X
        }
        if ("`filial'"=="FCCC" & (`y'==1930)){
          drop AG-IR
        }
        if ("`filial'"=="FCCC" & (`y'==1932)){
          drop AG-IV
        }
        if ("`filial'"=="FCCNA" & (`y'==1904)){
          drop AF-IV
        }
        if ("`filial'"=="FCCNA" & (`y'==1905)){
          drop AG-IV
        }
        if ("`filial'"=="FCCNA" & (`y'==1906)){
          drop AI-IV
        }

        if ("`filial'"=="FCCNA" & (`y'==1907)){
          drop AJ-IV
        }
        if ("`filial'"=="FCCNA" & (`y'==1908)){
          drop AF-IO
        }
        if ("`filial'"=="FCCNA" & (`y'==1910)){
          drop AI-IR
        }
        if ("`filial'"=="FCCNA" & (`y'==1911)){
          drop AI-IS
        }
        if ("`filial'"=="FCCNA" & (`y'==1912)){
          drop AI-IT
        }
        if ("`filial'"=="FCS" & `y'<1900){
          drop L-Sebo
        }
        if ("`filial'"=="FCS" & `y'<1900){
          drop M-X
        }
        if ("`filial'"=="FCSF"){
          if `y'==1896{
            drop O-Sebo
          }

          if `y'>=1897 & `y'<1900{
            N-V
          }
        }
        compress
        save "..\temp\damus_`filial'_`y'.dta", replace
        noisily display("`filial' - `y'")
        noisily ds
      }
    }
  }

  local i=1
  foreach y in `"1942|43"' `"1942|3"' `"1943|44"' `"1943|4"' `"1947|48"'{
    clear
    cap import excel using "..\..\raw_data\damus\ESTACION\ESTACION\\`filial'.xls", clear first sheet("`y'") cellrange(A2)
    if "`filial'"=="COMODORO" | "`filial'"=="DESEADO"{
      cap import excel using "..\..\raw_data\damus\ESTACION\ESTACION\\`filial'.xls", clear first sheet("`y'") cellrange(A1)
    }
    quietly{
      if _rc ==0{
        cap ren Estaci A
        drop if A==""
        gen year="`y'"
        replace year="1942" if year==`"1942|43"'
        replace year="1942" if year==`"1942|3"'
        replace year="1943" if year==`"1943|44"'
        replace year="1943" if year==`"1943|4"'
        replace year="1947" if year==`"1947|48"'
        ren A estacion
        ds estacion, not
        destring `r(varlist)', force replace

        foreach var of var estacion{
          replace `var' = upper(subinstr(`var'," ","",.)  )
          replace `var' = subinstr(`var',"-","",.)
          replace `var' = subinstr(`var',".","",.)
        }
        compress
        save "..\temp\damus_`filial'_194x_`i'.dta", replace
        local i=`i'+1
      }
      noisily display("`filial' - `y'")
      noisily ds
    }
  }
}


display "$S_TIME"
cap log close
log using "varnames", replace
foreach filial in `filiales'{
  forvalues y =1896(1)1935{
    cap use "..\temp\damus_`filial'_`y'.dta"
    noisily display("********************`filial' - `y'********************")
    noisily ds
  }
  forvalues i = 1(1)3{
    cap use "..\temp\damus_`filial'_194x_`i'"
    noisily display("********************`filial' - 194x_`i'********************")
    noisily ds
  }
}
cap log close

dfghjk

*III. APPEND
clear all
foreach filial in `filiales'{
  forvalues y =1896(1)1935{
    cap append using "..\temp\damus_`filial'_`y'.dta"
    cap gen filial="`filial'"
    cap replace filial="`filial'" if filial==""
    assert filial!=""
    foreach var of varlist _all {
      capture assert mi(`var')
      if !_rc {
        drop `var'
      }
    }
  }
  forvalues i = 1(1)3{
    cap append using "..\temp\damus_`filial'_194x_`i'"
    cap gen filial="`filial'"
    cap replace filial="`filial'" if filial==""
    assert filial!=""
    foreach var of varlist _all {
      capture assert mi(`var')
      if !_rc {
        drop `var'
      }
    }
  }
}

*IV. CLEANING

*drop missing values



save_data "..\output\damuspanel.dta", replace key(estacion year filial)
cap log close

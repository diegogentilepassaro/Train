
global networks 1960rails 1954roads 1976rails 1970roads 1979rails 1986roads

local j=1
foreach network in $networks{
  if "`network'"=="1960rails" | "`network'"=="1954roads"{
    global vars pop1960 urbpop_1960
  }
  if "`network'"=="1970rails" | "`network'"=="1970roads"{
    global vars pop1970
  }
  if "`network'"=="1979rails" | "`network'"=="1986roads"{
    global vars pop1991 urbpop_1991
  }
  foreach var in $vars{
    use "../output/departments_wide_panel.dta", clear
    keep `var' geolev2
    ren geolev2 endpoint
    tempfile a
    save `a', replace
    use "..\temp\MA_LCP_`network'.dta", clear
    merge m:1 endpoint using `a'
    assert _merge

    forvalues i=1(1)3{
      gen `var'w`i' = (1/totalcost)^(`i')*`var'
    }

    collapse (sum) `var'w*, by(geolev2)

    forvalues i=1(1)3{
      ren `var'w`i' MA_`network'_`i'_`var'
    }
    save "..\temp\MA_`j'.dta", replace
    local j = `j'+1
  }
}


use "..\temp\MA_1.dta"


forvalues i=2(1)11{
  merge 1:1 geolev2 using "..\temp\MA_`i'.dta"
  assert _merge==3
  drop _merge
}

foreach var of var MA*{
  label var `var' ""
}

foreach network in $networks{
  forvalues i=1(1)3{
    cap ren MA_`network'_`i'_pop MA_`network'_pop_`i'
    cap ren MA_`network'_`i'_urbpop MA_`network'_urb_`i'
  }
}

save_data "..\temp\MA.dta", replace key(geolev2)


global networks 1986roads 1979rails 1970roads 1976rails 1960rails 1954roads

foreach network in $networks{
  forvalues i=0(1)311{
    import dbase using "..\temp\\MA_`network'_LCP_`i'.dbf", clear case(lower)
    count
    ren *, lower
    gen pointid=end_point if total_cost==0
    egen x = mean(pointid)
    replace pointid=x
    drop x

    tempfile a
    save `a', replace
    import dbase using "..\temp\\centroid_`i'.dbf", clear case(lower)
    gen pointid=auto

    merge 1:m pointid using `a'
    assert _merge==3
    drop _merge

    save "..\temp\\MA_`network'_LCP_`i'.dta", replace

    }

  use "..\temp\\MA_`network'_LCP_0.dta"

  forvalues i=1(1)311{
    append using "..\temp\\MA_`network'_LCP_`i'.dta"
  }

  keep geolevel2 pointid end_point total_cost

  preserve

  keep geolevel2 pointid
  duplicates drop

  ren geolevel2 end_point_id
  ren pointid end_point

  tempfile id
  save `id', replace
  list

  restore

  merge m:1 end_point using `id'

  /*the following 3 lines won't be needed since I fix the python (qgis) code to
  exclude malvinas and sandwich island
  */
  assert _merge==3 if end_point!=313
  assert total_cost>0 if end_point==313
  drop if end_point==313 /* malvinas */

  assert _merge==3
  drop _merge

  keep geolevel2 total_cost end_point_id
  ren end_point_id endpoint
  ren total_cost totalcost

  ren geolevel2 geolev2
  destring geolev endpoint, replace
  save_data "..\temp\MA_LCP_`network'.dta", replace key(geolev2 endpoint)

}

clear all

program main
  use "../temp/departments_wide_panel.dta"

  global geo_vars "elev_mean rugged_mea wheat area_km2 dist_to_BA"
  global outcomes_b "pop_1960 urbpop_1960  mig5_1970 sh_primary_1970 sh_secondary_1970 sh_tertiary_1970 "
  global outcomes_f "pop_1991 urbpop_1991  mig5_1991 sh_primary_1991 sh_secondary_1991 sh_tertiary_1991"
  global infra "tot_rails_1960 tot_rails_1986 studied_larkin roads54_type1 roads54_type2 roads86_type1 roads86_type2"

  label var tot_rails_1960 "railroads 1960 kms"
  label var tot_rails_1986 "railroads 1986 kms"

  label var pop_1960 "population 1960"
  label var urbpop_1960 "urban pop 1960"
  label var mig5_1970 "migration 1970 \%"
  label var pop_1991 "population 1991"
  label var urbpop_1991 "urban pop 1991"
  label var mig5_1991 "migration 1990 \%"
  label var sh_primary_1970 "primary labor 1970 \%"
  label var sh_secondary_1970 "secondary labor 1970 \%"
  label var sh_tertiary_1970 "tertiary labor 1970 \%"
  label var sh_primary_1991 "primary labor 1991 \%"
  label var sh_secondary_1991 "secondary labor 1991 \%"
  label var sh_tertiary_1991 "tertiary labor 1991 \%"

  replace rugged_mea = rugged_mea/1000

  label var elev_mean "elevation mts"
  label var rugged_mea "ruggedness mts"
  label var wheat "wheat pot. yield - tons/ha"
  label var area_km2 "area km2"
  label var dist_to_BA "dist. to Buenos Aires kms"

  foreach x in mig5_1970 mig5_1991 sh_primary_1970 sh_secondary_1970 sh_tertiary_1970  sh_primary_1991 sh_secondary_1991 sh_tertiary_1991{
    replace `x'=`x'*100
  }



  foreach x in geo_vars outcomes_b outcomes_f infra{

  estpost sum $`x', listwise
  esttab using "../output/descStats_1_`x'.tex", label replace noobs ///
	cells("mean(fmt(%12.0fc)) sd(fmt(%12.0fc)) min(fmt(%12.0fc)) max(fmt(%12.0fc))")  ///
  nomtitles nonumbers /*varwidth(27) modelwidth(10)*/ ///
    prehead(`"{"'   ///
    /*`"\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}"'*/ ///
    `"\begin{tabular}{lcccc}}{p{0.1\textwidth}p{0.8\textwidth}}"') ///
  postfoot(`"\end{tabular}{p{0.1\textwidth}p{0.8\textwidth}}"' `"}"')
  }

end

main

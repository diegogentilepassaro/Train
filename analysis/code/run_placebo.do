clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear

	    *** Population outcomes
	foreach depvar in log_pop log_urbpop log_share_urbpop {

       run_IV_regression, depvar(chg_`depvar'_60_46) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_60_46_pav_and_grav)
	}
end

program run_IV_regression
    syntax, depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
   
  	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"

    eststo clear
	eststo: qui reghdfe `depvar' `roads_var' `trains_var', absorb(provname)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' ///
	    (`roads_var' `trains_var' = hypo_EUC_total_MST_kms studied_larkin), absorb(provname)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' ///
	    (`roads_var' `trains_var' = hypo_LCP_total_MST_kms studied_larkin), absorb(provname)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)

	esttab * using "../output/placebo_`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
        mtitles("OLS" "EUC" "LCP") ///
		order(`trains_var' `roads_var') label nonotes ///
	    keep(`roads_var' `trains_var') ///
		stats(F_stat_fs N, fmt(a4 a4 a4 a4 a4) ///
	    labels("Cragg-Donald (multivariate) F-stat" "Observations"))
end

main

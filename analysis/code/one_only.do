clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear

    *** 1960 base outcomes
	    *** Population outcomes
	foreach depvar in log_pop log_urbpop {

       run_IV_regression, depvar(chg_`depvar'_91_60) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(one_only_chg_`depvar'_91_60)
	}

    *** 1970 base outcomes
	    *** Population outcomes
	foreach depvar in log_pop {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(one_only_chg_`depvar'_91_70)
	}
end

program run_IV_regression
    syntax, depvar(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
   
 	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
 
    eststo clear
	eststo: qui ivreghdfe `depvar' `geo_vars' `baseline_depvar' ///
		(`trains_var' =  hypo_LCP_total_MST_kms studied_larkin), absorb(provname)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' `baseline_depvar' ///
		(`roads_var' = studied_larkin  hypo_LCP_total_MST_kms), absorb(provname)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' `baseline_depvar' ///
		(`trains_var' `roads_var' =  studied_larkin hypo_LCP_total_MST_kms), absorb(provname)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' `baseline_depvar' ///
		(`trains_var' `roads_var' c.`trains_var'#c.`roads_var' = ///
		studied_larkin hypo_LCP_total_MST_kms c.studied_larkin#c.hypo_LCP_total_MST_kms), absorb(provname)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		order(`trains_var' `roads_var' c.`trains_var'#c.`roads_var' `baseline_depvar') label nonotes ///
	    keep(`roads_var' `trains_var' c.`trains_var'#c.`roads_var' `baseline_depvar') ///
		stats(F_stat_fs N, fmt(a4 a4 a4 a4 a4) ///
	    labels("Cragg-Donald (multivariate) F-stat" "Observations"))
end

main

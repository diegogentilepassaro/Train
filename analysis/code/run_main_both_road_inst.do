clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear

    *** 1960 base outcomes
	    *** Population outcomes
	foreach depvar in log_pop log_urbpop log_share_urbpop {

       run_IV_regression, depvar(chg_`depvar'_91_60) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(IV_both_chg_`depvar'_91_60_pav_and_grav)
	}

    *** 1970 base outcomes
	    *** Population outcomes
	foreach depvar in log_pop {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav)
	}
	
	    *** Migration level
	foreach depvar in log_nmig5 {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav)
	}
	
	    *** Broad sector levels
	foreach depvar in log_primary log_secondary log_tertiary {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav)
	}
end

program run_IV_regression
    syntax, depvar(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
   
 	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"

    eststo clear
	
	eststo: qui reghdfe `depvar' `roads_var' `trains_var', absorb(provname)

	
	eststo: qui ivreghdfe `depvar' `geo_vars' ///
	    (`roads_var' `trains_var' = hypo_EUC_total_MST_kms studied_larkin), absorb(provname)
	 test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' ///
	    (`roads_var' `trains_var' = hypo_LCP_total_MST_kms studied_larkin), absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
        mtitles("OLS" "IV EUC Network" "IV LCP Network") ///
		order(`trains_var' `roads_var') label ///
	    keep(`roads_var' `trains_var') ///
		stats(p_val F_stat_fs N, fmt(a4 a4 a4 a4 a4) ///
	    labels("P-value for testing $\beta_{2} >= \beta_{1}$" ///
		"Cragg-Donald (multivariate) F-stat" "Observations"))
end

main
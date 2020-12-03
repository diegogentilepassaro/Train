clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear
		
   run_IV_regression, ///
        depvars(chg_log_pop_91_60 chg_log_urbpop_91_60 chg_log_nmig5_91_70 ///
		chg_log_agareatot_ha chg_log_indvalprod_85 chg_log_indmassal_85) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_54) ///
		trains_var(chg_tot_rails_86_60) ///
		table_name(IV_different_outcomes)
end

program run_IV_regression
    syntax [if], depvars(str) roads_var(str) trains_var(str) ///
	    table_name(str)[ baseline_depvar(str)]
   
 	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"

    eststo clear
    local n_depvars: word count `depvars'
    forval i = 1/`n_depvars' {
        local depvar: word `i' of `depvars'
		eststo: qui ivreghdfe `depvar' `geo_vars' `baseline_depvar' ///
			(`roads_var' `trains_var' = hypo_LCP_total_MST_kms studied_larkin) ///
			`if', absorb(provname)
		qui test `roads_var' - `trains_var' = 0
		local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
		qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
		qui estadd local F_stat_fs = round(e(cdf), 0.0001)
    }
	
	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		order(`trains_var' `roads_var' `baseline_depvar') label nonotes ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(p_val F_stat_fs N, fmt(a4 a4 a4 a4 a4) ///
	    labels("P-value for testing $\beta_{2} >= \beta_{1}$" ///
		"Cragg-Donald (multivariate) F-stat" "Observations"))
end

main

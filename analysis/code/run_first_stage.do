clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear

**** EUC
    *** 1960 base outcomes
	    **** Kms
       run_first_stage, ///
	        endo_vars(chg_pav_and_grav_86_54 chg_pav_and_grav_86_70) ///
		    table_name(FS_chg_pav_and_grav)
			
       run_first_stage, ///
	        endo_vars(chg_tot_rails_86_60 chg_tot_rails_86_70) ///
		    table_name(FS_chg_tot_rails)
end

program run_first_stage
    syntax, endo_vars(str) table_name(str)
   
 	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"

    eststo clear
	local n_endo_vars: word count `endo_vars'
    forval i = 1/`n_endo_vars' {
        local endo_var: word `i' of `endo_vars'
		eststo: qui reghdfe `endo_var' hypo_EUC_total_MST_kms studied_larkin `geo_vars', ///
		   absorb(provname)
		test hypo_EUC_total_MST_kms = studied_larkin = 0
		qui estadd local f_stat = round(e(F), 0.01)
		
		eststo: qui reghdfe `endo_var' hypo_LCP_total_MST_kms studied_larkin `geo_vars', ///
		   absorb(provname)
		test hypo_LCP_total_MST_kms = studied_larkin = 0
		qui estadd local f_stat = round(e(F), 0.01)
	}

	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		order(hypo_EUC_total_MST_kms hypo_LCP_total_MST_kms studied_larkin) label ///
	    keep(hypo_EUC_total_MST_kms hypo_LCP_total_MST_kms studied_larkin) ///
		stats(f_stat N, fmt(%9.2g %9s %9s %9.0g) ///
	    labels("F-stat from testing both instruments = 0" ///
		"Observations")) nonotes
end

main

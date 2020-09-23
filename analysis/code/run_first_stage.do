clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear

	local instrument_roads "euclidean"

    *** 1960 base outcomes

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_54) ///
		    table_name(FS_EUC_chg_pav_and_grav_86_54) ///
		    instrument_roads(`instrument_roads')

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_70) ///
		    table_name(FS_EUC_chg_pav_and_grav_86_70) ///
		    instrument_roads(`instrument_roads')
			
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_60) ///
		    table_name(FS_EUC_chg_tot_rails_86_60) ///
		    instrument_roads(`instrument_roads')

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_70) ///
		    table_name(FS_EUC_chg_tot_rails_86_70) ///
		    instrument_roads(`instrument_roads')
			
	local instrument_roads "hypo_LCP_MST_kms"

    *** 1960 base outcomes

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_54) ///
		    table_name(FS_LCP_chg_pav_and_grav_86_54) ///
		    instrument_roads(`instrument_roads')

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_70) ///
		    table_name(FS_LCP_chg_pav_and_grav_86_70) ///
		    instrument_roads(`instrument_roads')
			
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_60) ///
		    table_name(FS_LCP_chg_tot_rails_86_60) ///
		    instrument_roads(`instrument_roads')

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_70) ///
		    table_name(FS_LCP_chg_tot_rails_86_70) ///
		    instrument_roads(`instrument_roads')
end

program run_first_stage
    syntax, endo_var(str) baseline_depvar(str) ///
	    table_name(str) ///
		instrument_roads(str)

	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
   
    eststo clear
	
	eststo: qui reghdfe `endo_var' `instrument_roads' studied_larkin, ///
	   noabsorb
	test `instrument_roads' = studied_larkin = 0
    qui estadd local f_stat = round(e(F), 0.01)
	qui estadd local geo_conts "No"
    qui estadd local prov_FE "No"
	
	eststo: qui reghdfe `endo_var' `instrument_roads' studied_larkin ///
	   `geo_vars', noabsorb
	test `instrument_roads' = studied_larkin = 0
    qui estadd local f_stat = round(e(F), 0.01)
    qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "No"
	
	eststo: qui reghdfe `endo_var' `instrument_roads' studied_larkin ///
	    `geo_vars', absorb(provname)
    qui estadd local f_stat = round(e(F), 0.01)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"
	
	eststo: qui reghdfe `endo_var' `instrument_roads' studied_larkin ///
	    `geo_vars' `baseline_depvar', absorb(provname)
    qui estadd local f_stat = round(e(F), 0.01)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"	

	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		mtitles("" "" "" "") /// 
		order(`instrument_roads' studied_larkin `baseline_depvar') label ///
	    keep(`instrument_roads' studied_larkin `baseline_depvar') ///
		stats(f_stat geo_conts prov_FE N, fmt(%9.2g %9s %9s %9.0g) ///
	    labels("F-stat from testing both instruments = 0" ///
		"Geographic controls" ///
	    "Province FE" "Observations")) nonotes
end

main

clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear

**** EUC
    *** 1960 base outcomes
	    **** Kms
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_54) ///
		    table_name(FS_EUC_chg_pav_and_grav_86_54) ///
		    instrument_roads(hypo_EUC_total_MST_kms) ///
			instrument_rails(studied_larkin)

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_70) ///
		    table_name(FS_EUC_chg_pav_and_grav_86_70) ///
		    instrument_roads(hypo_EUC_total_MST_kms) ///
			instrument_rails(studied_larkin)
			
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_60) ///
		    table_name(FS_EUC_chg_tot_rails_86_60) ///
		    instrument_roads(hypo_EUC_total_MST_kms) ///
			instrument_rails(studied_larkin)

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_70) ///
		    table_name(FS_EUC_chg_tot_rails_86_70) ///
		    instrument_roads(hypo_EUC_total_MST_kms) ///
			instrument_rails(studied_larkin)
			
        **** Connected			
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(connected_pav_grav_86_54) ///
		    table_name(FS_EUC_connected_pav_and_grav_86_54) ///
		    instrument_roads(hypo_EUC_dummy) ///
			instrument_rails(studied_larkin_dummy)

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(connected_pav_grav_86_70) ///
		    table_name(FS_EUC_connected_pav_and_grav_86_70) ///
		    instrument_roads(hypo_EUC_dummy) ///
			instrument_rails(studied_larkin_dummy)
			
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(disconnected_rails_86_60) ///
		    table_name(FS_EUC_disconnected_rails_86_60) ///
		    instrument_roads(hypo_EUC_dummy) ///
			instrument_rails(studied_larkin_dummy)

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(disconnected_rails_86_70) ///
		    table_name(FS_EUC_disconnected_rails_86_70) ///
		    instrument_roads(hypo_EUC_dummy) ///
			instrument_rails(studied_larkin_dummy)

**** LCP 
    *** 1960 base outcomes
        **** Kms
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_54) ///
		    table_name(FS_LCP_chg_pav_and_grav_86_54) ///
		    instrument_roads(hypo_LCP_total_MST_kms) ///
			instrument_rails(studied_larkin)

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_pav_and_grav_86_70) ///
		    table_name(FS_LCP_chg_pav_and_grav_86_70) ///
		    instrument_roads(hypo_LCP_total_MST_kms) ///
			instrument_rails(studied_larkin)
			
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_60) ///
		    table_name(FS_LCP_chg_tot_rails_86_60) ///
		    instrument_roads(hypo_LCP_total_MST_kms) ///
			instrument_rails(studied_larkin)

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(chg_tot_rails_86_70) ///
		    table_name(FS_LCP_chg_tot_rails_86_70) ///
		    instrument_roads(hypo_LCP_total_MST_kms) ///
			instrument_rails(studied_larkin)
			
	    **** Connected
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(connected_pav_grav_86_54) ///
		    table_name(FS_LCP_connected_pav_and_grav_86_54) ///
		    instrument_roads(hypo_LCP_dummy) ///
			instrument_rails(studied_larkin_dummy)	
	
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(connected_pav_grav_86_70) ///
		    table_name(FS_LCP_connected_pav_and_grav_86_70) ///
		    instrument_roads(hypo_LCP_dummy) ///
			instrument_rails(studied_larkin_dummy)
			
       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(disconnected_rails_86_60) ///
		    table_name(FS_LCP_disconnected_rails_86_60) ///
		    instrument_roads(hypo_LCP_dummy) ///
			instrument_rails(studied_larkin_dummy)

       run_first_stage, baseline_depvar(log_urbpop_1960) ///
	        endo_var(disconnected_rails_86_70) ///
		    table_name(FS_LCP_disconnected_rails_86_70) ///
		    instrument_roads(hypo_LCP_dummy) ///
			instrument_rails(studied_larkin_dummy)
			
end

program run_first_stage
    syntax, endo_var(str) baseline_depvar(str) ///
	    table_name(str) ///
		instrument_roads(str) instrument_rails(str)

	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
   
    eststo clear
	
	eststo: qui reghdfe `endo_var' `instrument_roads' `instrument_rails', ///
	   noabsorb
	test `instrument_roads' = `instrument_rails' = 0
    qui estadd local f_stat = round(e(F), 0.01)
	qui estadd local geo_conts "No"
    qui estadd local prov_FE "No"
	
	eststo: qui reghdfe `endo_var' `instrument_roads' `instrument_rails' ///
	   `geo_vars', noabsorb
	test `instrument_roads' = `instrument_rails' = 0
    qui estadd local f_stat = round(e(F), 0.01)
    qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "No"
	
	eststo: qui reghdfe `endo_var' `instrument_roads' `instrument_rails' ///
	    `geo_vars', absorb(provname)
	test `instrument_roads' = `instrument_rails' = 0
    qui estadd local f_stat = round(e(F), 0.01)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"
	
	eststo: qui reghdfe `endo_var' `instrument_roads' `instrument_rails' ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	test `instrument_roads' = `instrument_rails' = 0
    qui estadd local f_stat = round(e(F), 0.01)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"	

	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		mtitles("" "" "" "") /// 
		order(`instrument_roads' `instrument_rails' `baseline_depvar') label ///
	    keep(`instrument_roads' `instrument_rails' `baseline_depvar') ///
		stats(f_stat geo_conts prov_FE N, fmt(%9.2g %9s %9s %9.0g) ///
	    labels("F-stat from testing both instruments = 0" ///
		"Geographic controls" ///
	    "Province FE" "Observations")) nonotes
end

main

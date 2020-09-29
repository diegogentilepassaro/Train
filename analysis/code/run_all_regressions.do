clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear

	local instrument_roads "hypo_LCP_total_MST_kms"

    *** 1960 base outcomes
	    *** Population outcomes
	foreach depvar in log_pop log_urbpop share_urbpop {
	
	    run_OLS_regression, depvar(chg_`depvar'_91_60) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(OLS_chg_`depvar'_91_60_pav_and_grav)
       run_IV_regression, depvar(chg_`depvar'_91_60) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(IV_EUC_chg_`depvar'_91_60_pav_and_grav) ///
		    instrument_roads(`instrument_roads')
	}
	
	**** Agricultural census
	foreach depvar in log_agnexp log_agareatot_ha {
	
	    run_OLS_regression, depvar(chg_`depvar'_88_60) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(OLS_chg_`depvar'_88_60_pav_and_grav)
       run_IV_regression, depvar(chg_`depvar'_88_60) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(IV_EUC_chg_`depvar'_88_60_pav_and_grav) ///
		    instrument_roads(`instrument_roads')
	}
	
	**** Industrial census
	foreach depvar in log_indnpers log_indmassal log_indvalprod {
	
	    run_OLS_regression, depvar(chg_`depvar'_85_54) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(OLS_chg_`depvar'_85_54_pav_and_grav)
       run_IV_regression, depvar(chg_`depvar'_85_54) ///
	        baseline_depvar(log_urbpop_1960) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(IV_EUC_chg_`depvar'_85_54_pav_and_grav) ///
		    instrument_roads(`instrument_roads')
	}
	
    *** 1970 base outcomes
		*** Population outcomes 
	run_OLS_regression, depvar(chg_log_pop_91_70) ///
	    baseline_depvar(log_urbpop_1960) ///
	    roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(OLS_chg_log_pop_91_70_pav_and_grav)
    run_IV_regression, depvar(chg_log_pop_91_70) ///
	    baseline_depvar(log_urbpop_1960) ///
	    roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(IV_EUC_chg_log_pop_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		*** Labor shares by activity
	foreach depvar in share_agr_labor share_min_labor share_ind_labor ///
		share_egw_labor share_constr_labor ///
		share_wret_labor share_hrest_labor share_tsc_labor ///
		share_fin_labor share_pub_labor ///
		share_rsb_labor share_edu_labor share_hsw_labor ///
		share_ot_labor share_oth_labor {
		
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)

		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
		}
		
		*** Labor shares by broad sector
	foreach depvar in sh_primary sh_secondary sh_tertiary {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}

		 *** Labor shares by class of workers
	foreach depvar in sh_sew sh_sw sh_uw {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}
		
		*** Education shares
	foreach depvar in secondary_ed college {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}

		*** Migration shares
	run_OLS_regression, depvar(chg_mig5_91_70) ///
		baseline_depvar(log_urbpop_1960) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(OLS_chg_mig5_91_70_pav_and_grav)
		
	run_IV_regression, depvar(chg_mig5_91_70) ///
		baseline_depvar(log_urbpop_1960) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(IV_EUC_chg_mig5_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')

		*** Employment status shares
	foreach depvar in sh_unemployed sh_inactive {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}
		
		**** Labor levels by activity
	foreach depvar in log_agr_labor log_min_labor log_ind_labor ///
		log_egw_labor log_constr_labor ///
		log_wret_labor log_hrest_labor log_tsc_labor ///
		log_fin_labor log_pub_labor ///
		log_rsb_labor log_edu_labor log_hsw_labor ///
		log_ot_labor log_oth_labor {
		
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)

		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
		}

		*** Labor levels by broad sector
	foreach depvar in log_primary log_secondary log_tertiary {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}
	
	**** Labor levels by class of workers
	foreach depvar in log_sew log_sw log_uw {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}

		*** Education levels
	foreach depvar in log_nsecondary_ed log_ncollege {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}

		*** Migration levels
	run_OLS_regression, depvar(chg_log_nmig5_91_70) ///
		baseline_depvar(log_urbpop_1960) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(OLS_chg_log_nmig5_91_70_pav_and_grav)
		
	run_IV_regression, depvar(chg_log_nmig5_91_70) ///
		baseline_depvar(log_urbpop_1960) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(IV_EUC_chg_log_nmig5_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
	**** Employment status levels
	foreach depvar in log_unemployed log_inactive {
	
		run_OLS_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(OLS_chg_`depvar'_91_70_pav_and_grav)
			
		run_IV_regression, depvar(chg_`depvar'_91_70) ///
			baseline_depvar(log_urbpop_1960) ///
			roads_var(chg_pav_and_grav_86_70) ///
			trains_var(chg_tot_rails_86_70) ///
			table_name(IV_EUC_chg_`depvar'_91_70_pav_and_grav) ///
			instrument_roads(`instrument_roads')
	}
end

program run_OLS_regression
    syntax, depvar(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
	
	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
   
    eststo clear
	
	eststo: qui reg `depvar' `roads_var' `trains_var'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local geo_conts "No"
    qui estadd local prov_FE "No"
	
	eststo: qui reg `depvar' `roads_var' `trains_var' ///
	   `geo_vars'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
    qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "No"
	
	eststo: qui areg `depvar' `roads_var' `trains_var' ///
	    `geo_vars', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"
	
	eststo: qui areg `depvar' `roads_var' `trains_var' ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"

	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		mtitles("" "" "" "") ///
		order(`trains_var' `roads_var' `baseline_depvar') label ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(p_val geo_conts prov_FE r2 N, fmt(a4 a4 a4 a4 a4) ///
	    labels("P-value for testing $\beta_{2} >= \beta_{1}$" ///
		"Geographic controls" ///
	    "Province FE" ///
	    "R-squared" "Observations")) nonotes
end

program run_IV_regression
    syntax, depvar(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str) ///
		instrument_roads(str)

	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
   
    eststo clear
	
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(chi2))), 0.0001)
	qui estadd local geo_conts "No"
    qui estadd local prov_FE "No"
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	   `geo_vars'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(chi2))), 0.0001)
    qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "No"
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	    `geo_vars', absorb(provname) 
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local geo_conts "Yes"
    qui estadd local prov_FE "Yes"	
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)

	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		mtitles("" "" "" "") ///
		order(`trains_var' `roads_var' `baseline_depvar') label ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(p_val F_stat_fs geo_conts prov_FE N, fmt(a4 a4 a4 a4 a4) ///
	    labels("P-value for testing $\beta_{2} >= \beta_{1}$" ///
		"Cragg-Donald (multivariate) F-stat" "Geographic controls" ///
	    "Province FE" "Observations"))
end

main

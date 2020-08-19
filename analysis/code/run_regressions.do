clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear
		
    *** 1960 base outcomes
	    *** OLS 
	        *** Population outcomes
	run_OLS_regression, depvar(chg_log_pop_91_60) ///
	    baseline_depvar(log_pop1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_60) ///
		table_name(OLS_chg_log_pop_91_60_pav_and_grav)
	run_OLS_regression, depvar(chg_log_urbpop_91_60) ///
	    baseline_depvar(log_urbpop1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_60) ///
		table_name(OLS_chg_log_urbpop_91_60_pav_and_grav)
	run_OLS_regression, depvar(chg_share_urbpop_91_60) ///
	    baseline_depvar(share_urbpop_1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_60) ///
		table_name(OLS_chg_share_urbpop_91_60_pav_and_grav)

	local instrument_roads "euclidean_hypo_network"
	*local instrument_roads "lcp_hypo_network"
	    
		*** IV
		    *** Population outcomes
    run_IV_regression, depvar(chg_log_pop_91_60) ///
	    baseline_depvar(log_pop1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_60) ///
		table_name(IV_EUC_chg_log_pop_91_60_pav_and_grav) ///
		instrument_roads(`instrument_roads')
	run_IV_regression, depvar(chg_log_urbpop_91_60) ///
	    baseline_depvar(log_urbpop1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_60) ///
		table_name(IV_EUC_chg_log_urbpop_91_60_pav_and_grav) ///
		instrument_roads(`instrument_roads')
	run_IV_regression, depvar(chg_share_urbpop_91_60) ///
	    baseline_depvar(share_urbpop_1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_60) ///
		table_name(IV_EUC_chg_share_urbpop_91_60_pav_and_grav) ///
		instrument_roads(`instrument_roads')	
		
    *** 1970 base outcomes
	    *** OLS
		    *** Population outcomes    
	run_OLS_regression, depvar(chg_log_pop_91_70) ///
	    baseline_depvar(log_pop1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_log_pop_91_70_pav_and_grav)

		    *** Labor shares by activity
	run_OLS_regression, depvar(chg_share_agr_labor_91_70) ///
	    baseline_depvar(share_agr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_share_agr_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_share_min_labor_91_70) ///
	    baseline_depvar(share_min_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_share_min_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_share_ind_labor_91_70) ///
	    baseline_depvar(share_ind_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_share_ind_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_share_egw_labor_91_70) ///
	    baseline_depvar(share_egw_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_share_egw_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_share_constr_labor_91_70) ///
	    baseline_depvar(share_constr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_share_constr_labor_91_70_pav_and_grav)
		
		    *** Labor shares by broad sector
	run_OLS_regression, depvar(chg_sh_primary_91_70) ///
	    baseline_depvar(sh_primary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_sh_primary_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_sh_secondary_91_70) ///
	    baseline_depvar(sh_secondary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_sh_secondary_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_sh_tertiary_91_70) ///
	    baseline_depvar(sh_tertiary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_sh_tertiary_91_70_pav_and_grav)
		
		    *** Labor shares by class of workers
	run_OLS_regression, depvar(chg_sh_sew_91_70) ///
	    baseline_depvar(classwk_1_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_sh_sew_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_sh_sw_91_70) ///
	    baseline_depvar(classwk_2_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_sh_sw_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_sh_uw_91_70) ///
	    baseline_depvar(classwk_3_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_sh_uw_91_70_pav_and_grav)
		
		    *** Education outcomes
	run_OLS_regression, depvar(chg_college_91_70) ///
	    baseline_depvar(college_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_college_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_secondary_ed_91_70) ///
	    baseline_depvar(secondary_ed_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_secondary_ed_91_70_pav_and_grav)

		    *** Migration outcomes
	run_OLS_regression, depvar(chg_mig5_91_70) ///
	    baseline_depvar(mig5_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_mig5_91_70_pav_and_grav)

		    *** Employment outcomes
	run_OLS_regression, depvar(chg_unemployed_91_70) ///
	    baseline_depvar(unemployed_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_unemployed_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_inactive_91_70) ///
	    baseline_depvar(inactive_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_inactive_91_70_pav_and_grav)
		
		    **** Labor levels by activity
    run_OLS_regression, depvar(chg_agr_labor_91_70) ///
	    baseline_depvar(agr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_agr_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_min_labor_91_70) ///
	    baseline_depvar(min_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_min_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_ind_labor_91_70) ///
	    baseline_depvar(ind_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_ind_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_egw_labor_91_70) ///
	    baseline_depvar(egw_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_egw_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_constr_labor_91_70) ///
	    baseline_depvar(constr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_constr_labor_91_70_pav_and_grav)

		    *** Labor levels by broad sector
	run_OLS_regression, depvar(chg_primary_91_70) ///
	    baseline_depvar(primary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_primary_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_secondary_91_70) ///
	    baseline_depvar(secondary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_secondary_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_tertiary_91_70) ///
	    baseline_depvar(tertiary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_tertiary_91_70_pav_and_grav)
		
	    *** IV
		    *** Population outcomes 
    run_IV_regression, depvar(chg_log_pop_91_70) ///
	    baseline_depvar(log_pop1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_log_pop_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    *** Labor shares by activity
    run_IV_regression, depvar(chg_share_agr_labor_91_70) ///
	    baseline_depvar(share_agr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_share_agr_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_share_min_labor_91_70) ///
	    baseline_depvar(share_min_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_share_min_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_share_ind_labor_91_70) ///
	    baseline_depvar(share_ind_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_share_ind_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_share_egw_labor_91_70) ///
	    baseline_depvar(share_egw_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_share_egw_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_share_constr_labor_91_70) ///
	    baseline_depvar(share_constr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_share_constr_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    *** Labor shares by broad sector
    run_IV_regression, depvar(chg_sh_primary_91_70) ///
	    baseline_depvar(sh_primary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_sh_primary_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_sh_secondary_91_70) ///
	    baseline_depvar(sh_secondary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_sh_secondary_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_sh_tertiary_91_70) ///
	    baseline_depvar(sh_tertiary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_sh_tertiary_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    *** Labor shares by class of workers
	run_IV_regression, depvar(chg_sh_sew_91_70) ///
	    baseline_depvar(classwk_1_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_sh_sew_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
	run_IV_regression, depvar(chg_sh_sw_91_70) ///
	    baseline_depvar(classwk_2_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_sh_sw_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
	run_IV_regression, depvar(chg_sh_uw_91_70) ///
	    baseline_depvar(classwk_3_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_sh_uw_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    *** Education outcomes
    run_IV_regression, depvar(chg_college_91_70) ///
	    baseline_depvar(college_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_college_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_secondary_ed_91_70) ///
	    baseline_depvar(secondary_ed_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_secondary_ed_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    *** Migration outcomes
    run_IV_regression, depvar(chg_mig5_91_70) ///
	    baseline_depvar(mig5_1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_mig5_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    *** Employment outcomes
    run_IV_regression, depvar(chg_unemployed_91_70) ///
	    baseline_depvar(unemployed_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_unemployed_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_inactive_91_70) ///
	    baseline_depvar(inactive_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_inactive_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    **** Labor levels by activity
    run_IV_regression, depvar(chg_agr_labor_91_70) ///
	    baseline_depvar(agr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_agr_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_min_labor_91_70) ///
	    baseline_depvar(min_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_min_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_ind_labor_91_70) ///
	    baseline_depvar(ind_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_ind_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_egw_labor_91_70) ///
	    baseline_depvar(egw_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_egw_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_constr_labor_91_70) ///
	    baseline_depvar(constr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_constr_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
		
		    *** Labor levels by broad sector
    run_IV_regression, depvar(chg_primary_91_70) ///
	    baseline_depvar(primary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_primary_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_secondary_91_70) ///
	    baseline_depvar(secondary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_secondary_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_tertiary_91_70) ///
	    baseline_depvar(tertiary_70) ///
	    roads_var(pav_and_grav_chg_86_70) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_tertiary_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')

end

program run_OLS_regression
    syntax, depvar(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
	
	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
   
    eststo clear
	
	eststo: qui reg `depvar' `roads_var' `trains_var'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "No"
    estadd local prov_FE "No"
	
	eststo: qui reg `depvar' `roads_var' `trains_var' ///
	   `geo_vars'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
    estadd local geo_conts "Yes"
    estadd local prov_FE "No"
	
	eststo: qui areg `depvar' `roads_var' `trains_var' ///
	    `geo_vars', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"
	
	eststo: qui areg `depvar' `roads_var' `trains_var' ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"

	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		mtitles("" "" "" "") ///
		order(`trains_var' `roads_var' `baseline_depvar') label ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(p_val geo_conts prov_FE r2 N, fmt(%9.3f %9.0g) ///
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
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(chi2))), 0.001)
	estadd local geo_conts "No"
    estadd local prov_FE "No"
	estadd local F_stat_fs = round(e(cdf), 0.001)
	
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	   `geo_vars'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(chi2))), 0.001)
    estadd local geo_conts "Yes"
    estadd local prov_FE "No"
	estadd local F_stat_fs = round(e(cdf), 0.001)
	
	eststo: qui ivreghdfe `depvar' (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	    `geo_vars', absorb(provname) 
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"
	estadd local F_stat_fs = round(e(cdf), 0.001)
	
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"	
	estadd local F_stat_fs = round(e(cdf), 0.001)

	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
		mtitles("" "" "" "") ///
		order(`trains_var' `roads_var' `baseline_depvar') label ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(p_val F_stat_fs geo_conts prov_FE N, fmt(%9.0g) ///
	    labels("P-value for testing $\beta_{2} >= \beta_{1}$" ///
		"F-stat first stage" "Geographic controls" ///
	    "Province FE" "Observations"))
end

main

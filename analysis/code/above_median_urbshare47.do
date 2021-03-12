clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear
	keep if above_pop_1960 == 1

    *** 1960 base outcomes
	    *** Population outcomes
	foreach depvar in log_pop log_urbpop share_urbpop log_share_urbpop {

       run_IV_regression, depvar(chg_`depvar'_91_60) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_54) ///
		    trains_var(chg_tot_rails_86_60) ///
		    table_name(IV_both_chg_`depvar'_91_60_pav_and_grav_above)
	}

    *** 1970 base outcomes
	    *** Population outcomes
	foreach depvar in log_pop {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav_above)
	}
	
	    *** Migration
	foreach depvar in log_nmig5 mig5 {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav_above)
	}
	
	*** Employment
	foreach depvar in log_unemployed log_inactive sh_unemployed sh_inactive ///
	    sh_sw log_sw {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav_above)
	}
	
	    *** Broad sectors
	foreach depvar in log_primary log_ind log_nt_ind ///
	    log_gov_ed_health log_oth_serv ///
		sh_primary sh_ind sh_nt_ind ///
	    sh_gov_ed_health sh_oth_serv ///
		log_sh_primary log_sh_ind log_sh_nt_ind ///
	    log_sh_gov_ed_health log_sh_oth_serv {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav_above)
	}
	
	    *** By ind code
	foreach depvar in log_agr_labor log_min_labor log_ind_labor log_egw_labor ///
	    log_constr_labor log_wret_labor log_hrest_labor log_tsc_labor ///
	    log_fin_labor log_pub_labor log_rsb_labor log_edu_labor ///
		log_hsw_labor log_ot_labor log_oth_labor {

       run_IV_regression, depvar(chg_`depvar'_91_70) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav_above)
	}
	
	    *** Agr censuses
	foreach depvar in log_agareatot_ha log_agnexp {

       run_IV_regression, depvar(chg_`depvar'_88_60) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_pav_and_grav_above)
	}
	
	    *** Ind censuses
	foreach depvar in log_indvalprod log_indmassal log_indnpers log_indnestab {

       run_IV_regression, depvar(chg_`depvar'_85_54) ///
	        baseline_depvar(chg_log_urbpop_60_47) ///
	        roads_var(chg_pav_and_grav_86_70) ///
		    trains_var(chg_tot_rails_86_70) ///
		    table_name(IV_both_chg_`depvar'_91_70_pav_and_grav_above)
	}
end

program run_IV_regression
    syntax, depvar(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
   
 	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"

    eststo clear
	
	eststo: qui reghdfe `depvar' `geo_vars' `roads_var' `trains_var', absorb(provname)
		
	eststo: qui reghdfe `depvar' `geo_vars' `roads_var' `trains_var' ///
	    `baseline_depvar', absorb(provname)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' ///
	    (`roads_var' `trains_var' = hypo_EUC_total_MST_kms studied_larkin), absorb(provname)
	 test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	eststo: qui ivreghdfe `depvar' `geo_vars' `baseline_depvar' ///
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
	
	eststo: qui ivreghdfe `depvar' `geo_vars' `baseline_depvar' ///
	    (`roads_var' `trains_var' = hypo_LCP_total_MST_kms studied_larkin), absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = sign(_b[`roads_var'] - _b[`trains_var'])
	qui estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.0001)
	qui estadd local F_stat_fs = round(e(cdf), 0.0001)
	
	esttab * using "../output/`table_name'.tex", replace compress ///
	    se star(* 0.10 ** 0.05 *** 0.01) ///
        mtitles("OLS" "OLS" "IV EUC" "IV EUC" "IV LCP" "IV LCP") ///
		order(`trains_var' `roads_var' `baseline_depvar') label nonotes ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(p_val F_stat_fs N, fmt(a4 a4 a4 a4 a4) ///
	    labels("P-value for testing $\beta_{2} >= \beta_{1}$" ///
		"Cragg-Donald (multivariate) F-stat" "Observations"))
end

main

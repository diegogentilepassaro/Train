clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear
	
      run_IV_regression if above_share_urbpop_1947 == 1, ///
        depvars(chg_log_agr_labor chg_log_min_labor chg_log_ind_labor chg_log_egw_labor ///
	    chg_log_constr_labor chg_log_wret_labor chg_log_hrest_labor chg_log_tsc_labor ///
	    chg_log_fin_labor chg_log_pub_labor chg_log_rsb_labor chg_log_edu_labor ///
		chg_log_hsw_labor chg_log_ot_labor chg_log_oth_labor) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(above_IV_both_chg_log_activities_91_70_pav_and_grav)
		
      run_IV_regression if above_share_urbpop_1947 == 1, ///
        depvars(chg_share_agr_labor chg_share_min_labor chg_share_ind_labor chg_share_egw_labor ///
	    chg_share_constr_labor chg_share_wret_labor chg_share_hrest_labor chg_share_tsc_labor ///
	    chg_share_fin_labor chg_share_pub_labor chg_share_rsb_labor chg_share_edu_labor ///
		chg_share_hsw_labor chg_share_ot_labor chg_share_oth_labor) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(above_IV_both_chg_sh_activities_91_70_pav_and_grav)
		
      run_IV_regression if above_share_urbpop_1947 == 1, ///
       depvars(chg_log_primary_91_70 chg_log_ind_91_70 chg_log_nt_ind_91_70 ///
	    chg_log_gov_ed_health_91_70 chg_log_busi_serv_91_70 chg_log_oth_serv_91_70) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(above_IV_both_chg_log_sectors_91_70_pav_and_grav)
		
   run_IV_regression if above_share_urbpop_1947 == 1, ///
        depvars(chg_sh_primary_91_70 chg_sh_ind_91_70 chg_sh_nt_ind_91_70 ///
	    chg_sh_gov_ed_health_91_70 chg_sh_busi_serv_91_70 chg_sh_oth_serv_91_70) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(above_IV_both_chg_sh_sectors_91_70_pav_and_grav)
		
   run_IV_regression if above_share_urbpop_1947 == 1, ///
        depvars(chg_log_sh_primary_91_70 chg_log_sh_ind_91_70 chg_log_sh_nt_ind_91_70 ///
	    chg_log_sh_gov_ed_health_91_70 chg_log_sh_oth_serv_91_70) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(above_IV_both_chg_log_sh_sectors_91_70_pav_and_grav)
		
   run_IV_regression if above_share_urbpop_1947 == 1, ///
        depvars(chg_log_agareatot_ha chg_log_agnexp ///
		chg_log_indvalprod chg_log_indmassal ///
		chg_log_indnpers chg_log_indnestab) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(above_IV_both_chg_ind_agr_censuses_91_70_pav_and_grav)
		
run_IV_regression if above_share_urbpop_1947 == 0, ///
        depvars(chg_log_agr_labor chg_log_min_labor chg_log_ind_labor chg_log_egw_labor ///
	    chg_log_constr_labor chg_log_wret_labor chg_log_hrest_labor chg_log_tsc_labor ///
	    chg_log_fin_labor chg_log_pub_labor chg_log_rsb_labor chg_log_edu_labor ///
		chg_log_hsw_labor chg_log_ot_labor chg_log_oth_labor) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(below_IV_both_chg_log_activities_91_70_pav_and_grav)
		
      run_IV_regression if above_share_urbpop_1947 == 0, ///
        depvars(chg_share_agr_labor chg_share_min_labor chg_share_ind_labor chg_share_egw_labor ///
	    chg_share_constr_labor chg_share_wret_labor chg_share_hrest_labor chg_share_tsc_labor ///
	    chg_share_fin_labor chg_share_pub_labor chg_share_rsb_labor chg_share_edu_labor ///
		chg_share_hsw_labor chg_share_ot_labor chg_share_oth_labor) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(below_IV_both_chg_sh_activities_91_70_pav_and_grav)
		
      run_IV_regression if above_share_urbpop_1947 == 0, ///
       depvars(chg_log_primary_91_70 chg_log_ind_91_70 chg_log_nt_ind_91_70 ///
	    chg_log_gov_ed_health_91_70 chg_log_busi_serv_91_70 chg_log_oth_serv_91_70) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(below_IV_both_chg_log_sectors_91_70_pav_and_grav)
		
   run_IV_regression if above_share_urbpop_1947 == 0, ///
        depvars(chg_sh_primary_91_70 chg_sh_ind_91_70 chg_sh_nt_ind_91_70 ///
	    chg_sh_gov_ed_health_91_70 chg_sh_busi_serv_91_70 chg_sh_oth_serv_91_70) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(below_IV_both_chg_sh_sectors_91_70_pav_and_grav)
		
   run_IV_regression if above_share_urbpop_1947 == 0, ///
        depvars(chg_log_sh_primary_91_70 chg_log_sh_ind_91_70 chg_log_sh_nt_ind_91_70 ///
	    chg_log_sh_gov_ed_health_91_70 chg_log_sh_oth_serv_91_70) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(below_IV_both_chg_log_sh_sectors_91_70_pav_and_grav)
		
   run_IV_regression if above_share_urbpop_1947 == 0, ///
        depvars(chg_log_agareatot_ha chg_log_agnexp ///
		chg_log_indvalprod chg_log_indmassal ///
		chg_log_indnpers chg_log_indnestab) ///
		baseline_depvar(chg_log_urbpop_60_47) ///
		roads_var(chg_pav_and_grav_86_70) ///
		trains_var(chg_tot_rails_86_70) ///
		table_name(below_IV_both_chg_ind_agr_censuses_91_70_pav_and_grav)
end

program run_IV_regression
    syntax [if], depvars(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
   
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

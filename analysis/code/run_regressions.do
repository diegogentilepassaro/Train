clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../../derived/output/departments_wide_panel.dta", clear
    preclean_data
	
	*make_some_plots
	
    *** 1960 base outcomes
	
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

	local instrument_roads "euclidean_hypo_network"
	*local instrument_roads "lcp_hypo_network"
	
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
		
    *** 1970 base outcomes
	run_OLS_regression, depvar(chg_log_pop_91_70) ///
	    baseline_depvar(log_pop1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_log_pop_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_share_agr_labor_91_70) ///
	    baseline_depvar(share_agr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_share_agr_labor_91_70_pav_and_grav)	
	run_OLS_regression, depvar(chg_share_ind_labor_91_70) ///
	    baseline_depvar(share_ind_labor1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_share_ind_labor_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_college_91_70) ///
	    baseline_depvar(college_1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_college_91_70_pav_and_grav)
	run_OLS_regression, depvar(chg_mig5_91_70) ///
	    baseline_depvar(mig51970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(OLS_chg_mig5_91_70_pav_and_grav)
		
    run_IV_regression, depvar(chg_log_pop_91_70) ///
	    baseline_depvar(log_pop1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_log_pop_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_share_agr_labor_91_70) ///
	    baseline_depvar(share_agr_labor1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_share_agr_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_share_ind_labor_91_70) ///
	    baseline_depvar(share_ind_labor1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_share_ind_labor_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_college_91_70) ///
	    baseline_depvar(college_1970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_college_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
    run_IV_regression, depvar(chg_mig5_91_70) ///
	    baseline_depvar(mig51970) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		trains_var(tot_rails_chg_80s_70s) ///
		table_name(IV_EUC_chg_mig5_91_70_pav_and_grav) ///
		instrument_roads(`instrument_roads')
end

program preclean_data
    drop if geolev2 == 32099999 /* Unkown location */
	drop if geolev2 == 238094004 /* Falkland Islands */
	drop if geolev2 == 239094003 /* Sandwhich Islands */
	
	drop if geolev2 == 32002001 /* City of Buenos Aires */
	*drop if geolev2 == 32006001 /* La Plata */
	
	gen log_pop1991 = log(pop1991)
	gen log_pop1970 = log(pop1970)
	gen log_pop1960 = log(pop1960) 
	label var log_pop1960 "Log population 1960"
	label var log_pop1970 "Log population 1970"
	
	label var college_1970 "Share of college 1970"
	
	rename (indgen_1_1970 indgen_3_1970 indgen_1_1991 indgen_3_1991) ///
	    (share_agr_labor1970 share_ind_labor1970 share_agr_labor1991 share_ind_labor1991)
	label var share_ind_labor1970 "Share of manufacturing labor 1970"
	label var share_agr_labor1970 "Share of agricultural labor 1970"
	
	gen chg_log_pop_91_60 = log_pop1991 - log_pop1960
	label var chg_log_pop_91_60 "Change in Log population 1991-1970"
	gen chg_log_pop_91_70 = log_pop1991 - log_pop1970
	label var chg_log_pop_91_70 "Change in Log population 1991-1970"

	gen chg_college_91_70 = college_1991 - college_1970
	label var chg_college_91_70 "Change in college 1991-1970"
	
	gen chg_share_ind_labor_91_70 = share_ind_labor1991 - share_ind_labor1970
	label var chg_share_ind_labor_91_70 "Change in share of industrial labor 1991-1970"
	
	gen chg_share_agr_labor_91_70 = share_agr_labor1991 - share_agr_labor1970
	label var chg_share_agr_labor_91_70 "Change in share of agricultural labor 1991-1970"
	
	gen chg_mig5_91_70 = mig51991 - mig51970
	label var chg_mig5_91_70 "Change in share of people living in province they were born 1991-1970"
	
	gen log_urbpop1991 = log(urbpop1991)
	gen log_urbpop1960 = log(urbpop1960)
	label var log_urbpop1960 "Log urban population 1960"

	gen chg_log_urbpop_91_60 = log_urbpop1991 - log_urbpop1960
	label var chg_log_urbpop_91_60 "Change in Log urban population"	
	gen urbpop_chg_91_60 = urbpop1991 - urbpop1960
	
	rename (roads54_type1 roads54_type2 roads54_type3 roads54_type4 ///
	    roads86_type1 roads86_type2 roads86_type3 roads86_type4) ///
		(paved_roads54 gravel_roads54 dirt_roads54 footprint_roads54 ///
		paved_roads86 gravel_roads86 dirt_roads86 footprint_roads86)
	
	gen tot_roads54 = paved_roads54 + gravel_roads54 + ///
	    dirt_roads54 + footprint_roads54
	gen tot_roads86 = paved_roads86 + gravel_roads86 + ////
	    dirt_roads86 + footprint_roads86
	gen tot_roads_chg_86_54 = tot_roads86 - tot_roads54
	label var tot_roads_chg_86_54 "Change in kms of total roads"
	
	gen pav_and_grav54 = paved_roads54 + gravel_roads54
	gen pav_and_grav86 = paved_roads86 + gravel_roads86
	gen pav_and_grav_chg_86_54 = pav_and_grav86 - pav_and_grav54
	label var pav_and_grav_chg_86_54 "Change in kms of paved and gravel roads"

	gen paved_roads_chg_86_54 = paved_roads86 - paved_roads54
	label var paved_roads_chg_86_54 "Change in kms of paved roads"

	gen tot_rails60 = status79_1 + status79_2 + status79_3
	gen tot_rails70s = status79_1 + status79_2
    gen tot_rails80s = status79_1
	gen tot_rails_chg_80s_60 = tot_rails80s - tot_rails60
	label var tot_rails_chg_80s_60 "Change in kms of railroads"
	gen tot_rails_chg_80s_70s = tot_rails80s - tot_rails70s
	label var tot_rails_chg_80s_70s "Change in kms of railroads"

	rename (hypomeanEMST_kms hypoCMST_kms studied_1) ///
	    (euclidean_hypo_network lcp_hypo_network studied_larkin)
end

program make_some_plots
    twoway (scatter tot_rails_chg tot_roads_chg) ///
	    (lfit tot_rails_chg tot_roads_chg), ///
	    graphregion(color(white)) bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads") ///
		xtitle("Change in kms of all roads")
	graph export "../output/changes_railroads_roads_all.png", replace
		
	twoway (scatter tot_rails_chg pav_and_grav_chg) ///
	    (lfit tot_rails_chg pav_and_grav_chg), ///
	    graphregion(color(white))bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads") ///
		xtitle("Change in kms of paved and gravel roads")
	graph export "../output/changes_railroads_roads_pav_and_grav.png", replace
		
	twoway (scatter tot_rails_chg paved_roads_chg_86_54) ///
	    (lfit tot_rails_chg paved_roads_chg_86_54), ///
	    graphregion(color(white))bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads") ///
		xtitle("Change in kms of paved roads")
	graph export "../output/changes_railroads_roads_paved.png", replace
end

program run_OLS_regression
    syntax, depvar(str) baseline_depvar(str) ///
	    roads_var(str) trains_var(str) table_name(str)
	
	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
   
    eststo clear
	
	eststo: qui reg `depvar' `roads_var' `trains_var'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "No"
    estadd local prov_FE "No"
	estadd local estimation "OLS"
	eststo: qui reg `depvar' `roads_var' `trains_var' ///
	   `geo_vars'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
    estadd local geo_conts "Yes"
    estadd local prov_FE "No"
	estadd local estimation "OLS"
	eststo: qui areg `depvar' `roads_var' `trains_var', ///
	    absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "No"
    estadd local prov_FE "Yes"
	estadd local estimation "OLS"
	eststo: qui areg `depvar' `roads_var' `trains_var' ///
	    `geo_vars', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"
	estadd local estimation "OLS"
	eststo: qui areg `depvar' `roads_var' `trains_var' ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"
	estadd local estimation "OLS"

	esttab * /*using "../output/`table_name'.tex"*/, replace ///
	    se star(* 0.10 ** 0.05 *** 0.01) label ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(estimation p_val geo_conts prov_FE r2 N, fmt(%9.3f %9.0g) ///
	    labels("Estimation" "P-value for testing $\beta_2 >= \beta_1$" ///
		"Geographic controls" ///
	    "Province FE" ///
	    "R-squared" "Observations"))
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
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(chi2))), 0.001)
	estadd local geo_conts "No"
    estadd local prov_FE "No"
	estadd local estimation "IV"
	estadd local F_stat_fs = round(e(cdf), 0.001)
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	   `geo_vars'
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(chi2))), 0.001)
    estadd local geo_conts "Yes"
    estadd local prov_FE "No"
	estadd local estimation "IV"
	estadd local F_stat_fs = round(e(cdf), 0.001)
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin), ///
	    absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "No"
    estadd local prov_FE "Yes"
	estadd local estimation "IV"
	estadd local F_stat_fs = round(e(cdf), 0.001)
	eststo: qui ivreghdfe `depvar' (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	    `geo_vars', absorb(provname) 
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"
	estadd local estimation "IV"
	estadd local F_stat_fs = round(e(cdf), 0.001)
	eststo: qui ivreghdfe `depvar' ///
	    (`roads_var' `trains_var' = `instrument_roads' studied_larkin) ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	qui test `roads_var' - `trains_var' = 0
	local sign_stat = _b[`roads_var'] - _b[`trains_var']
	estadd local p_val = round(normal(`sign_stat'*sqrt(r(F))), 0.001)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"	
	estadd local estimation "IV"
	estadd local F_stat_fs = round(e(cdf), 0.001)

	esttab * /*using "../output/`table_name'.tex"*/, replace ///
	    se star(* 0.10 ** 0.05 *** 0.01) label ///
	    keep(`roads_var' `trains_var' `baseline_depvar') ///
		stats(estimation p_val F_stat_fs geo_conts prov_FE N, fmt(%9.0g) ///
	    labels("Estimation" "P-value for testing $\beta_2 >= \beta_1$" ///
		"F-stat first stage" "Geographic controls" ///
	    "Province FE" "Observations"))
end

main

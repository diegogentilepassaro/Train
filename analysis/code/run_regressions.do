clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../../derived/output/departments_wide_panel.dta", clear
    preclean_data
	
	*make_some_plots
	run_OLS_regression, depvar(chg_log_pop_91_60) ///
	    baseline_depvar(log_pop1960) ///
	    roads_var(tot_roads_chg_86_54) ///
		table_name(chg_log_pop_91_60_all_roads)
	run_OLS_regression, depvar(chg_log_urbpop_91_60) ///
	    baseline_depvar(log_urbpop1960) ///
	    roads_var(tot_roads_chg_86_54) ///
		table_name(chg_log_urbpop_91_60_all_roads)
		
	run_OLS_regression, depvar(chg_log_pop_91_60) ///
	    baseline_depvar(log_pop1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		table_name(chg_log_pop_91_60_pav_and_grav)
	run_OLS_regression, depvar(chg_log_urbpop_91_60) ///
	    baseline_depvar(log_urbpop1960) ///
	    roads_var(pav_and_grav_chg_86_54) ///
		table_name(chg_log_urbpop_91_60_pav_and_grav)

	run_OLS_regression, depvar(chg_log_pop_91_60) ///
	    baseline_depvar(log_pop1960) ///
	    roads_var(paved_roads_chg_86_54) ///
		table_name(chg_log_pop_91_60_paved)
	run_OLS_regression, depvar(chg_log_urbpop_91_60) ///
	    baseline_depvar(log_urbpop1960) ///
	    roads_var(paved_roads_chg_86_54) ///
		table_name(chg_log_urbpop_91_60_paved)
end

program preclean_data
    drop if geolev2 == 32099999 /* Unkown location */
	drop if geolev2 == 238094004 /* Falkland Islands */
	drop if geolev2 == 239094003 /* Sandwhich Islands */
	
	drop if geolev2 == 32002001 /* City of Buenos Aires */
	*drop if geolev2 == 32006001 /* La Plata */
	
	gen log_pop1991 = log(pop1991)
	gen log_pop1960 = log(pop1960) 
	label var log_pop1960 "Log population 1960"
	
	gen chg_log_pop_91_60 = log_pop1991 - log_pop1960
	gen pop_chg_91_60 = pop1991 - pop1960
	
	gen log_urbpop1991 = log(urbpop1991)
	gen log_urbpop1960 = log(urbpop1960)
	label var log_urbpop1960 "Log urban population 1960"

	gen chg_log_urbpop_91_60 = log_urbpop1991 - log_urbpop1960
	gen urbpop_chg_91_60 = urbpop1991 - urbpop1960
	
	rename (roads54_type1 roads54_type2 roads54_type3 roads54_type4 ///
	    roads86_type1 roads86_type2 roads86_type3 roads86_type4) ///
		(paved_roads54 gravel_roads54 dirt_roads54 footprint_roads54 ///
		paved_roads86 gravel_roads86 dirt_roads86 footprint_roads86)
	
	gen tot_roads54 = paved_roads54 + gravel_roads54 + dirt_roads54 + footprint_roads54
	gen tot_roads86 = paved_roads86 + gravel_roads86 + dirt_roads86 + footprint_roads86
	gen tot_roads_chg_86_54 = tot_roads86 - tot_roads54
	label var tot_roads_chg_86_54 "Change in kms of total roads"
	
	gen pav_and_grav54 = paved_roads54 + gravel_roads54
	gen pav_and_grav86 = paved_roads86 + gravel_roads86
	gen pav_and_grav_chg_86_54 = paved_roads86 - paved_roads54
	label var pav_and_grav_chg_86_54 "Change in kms of paved and gravel roads"

	gen paved_roads_chg_86_54 = paved_roads86 - paved_roads54
	label var paved_roads_chg_86_54 "Change in kms of paved roads"

	gen tot_rails60 = status79_1 + status79_2 + status79_3
    gen tot_rails80s = status79_1
	gen tot_rails_chg_80s_60 = tot_rails80s - tot_rails60
	label var tot_rails_chg_80s_60 "Change in kms of railroads"
	
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
	    roads_var(str) table_name(str)
	
	local geo_vars "elev_mean_std rugged_mea_std wheat_std dist_to_BA_std"
   
    eststo clear
	
	eststo: reg `depvar' `roads_var' tot_rails_chg_80s_60
	estadd local geo_conts "No"
    estadd local prov_FE "No"
	eststo: reg `depvar' `roads_var' tot_rails_chg_80s_60 ///
	    `baseline_depvar'
	estadd local geo_conts "No"
    estadd local prov_FE "No"	
	eststo: reg `depvar' `roads_var' tot_rails_chg_80s_60 ///
	   `geo_vars'
    estadd local geo_conts "Yes"
    estadd local prov_FE "No"
	eststo: areg `depvar' `roads_var' tot_rails_chg_80s_60, ///
	    absorb(provname)
	estadd local geo_conts "No"
    estadd local prov_FE "Yes"
	eststo: areg `depvar' `roads_var' tot_rails_chg_80s_60 ///
	    `geo_vars', absorb(provname)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"
	eststo: areg `depvar' `roads_var' tot_rails_chg_80s_60 ///
	    `geo_vars' `baseline_depvar', absorb(provname)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"	

	esttab * using "../output/`table_name'.tex", replace ///
	    se star(* 0.10 ** 0.05 *** 0.01) label ///
	    keep(`roads_var' tot_rails_chg_80s_60 `baseline_depvar') ///
		stats(geo_conts prov_FE r2_a N, fmt(%9.3f %9.0g) ///
	    labels("Geographic controls" ///
	    "Province FE" ///
	    "Adj. R-squared" "Observations"))
end
	/*
	
		eststo: reg chg_log_urbpop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60
	estadd local geo_conts "No"
    estadd local prov_FE "No"
	eststo: reg chg_log_urbpop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60 ///
	   elev_mean_std rugged_mea_std wheat_std dist_to_BA_std
    estadd local geo_conts "Yes"
    estadd local prov_FE "No"
	eststo: areg chg_log_urbpop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60, ///
	    absorb(provname)
	estadd local geo_conts "No"
    estadd local prov_FE "Yes"
    eststo: areg chg_log_urbpop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60 ///
	    elev_mean_std rugged_mea_std wheat_std dist_to_BA_std, absorb(provname)
	estadd local geo_conts "Yes"
    estadd local prov_FE "Yes"
	
	
	eststo clear
	
	eststo: ivreg2 chg_log_pop_91_60 (pav_and_grav_chg_86_54 tot_rails_chg_80s_60 = studied_1 hypoEMST_kms)
	eststo: ivreg2 chg_log_pop_91_60 (pav_and_grav_chg_86_54 tot_rails_chg_80s_60 = studied_1 hypoEMST_kms) ///
	   elev_mean_std
	eststo: ivreg2 chg_log_pop_91_60 (pav_and_grav_chg_86_54 tot_rails_chg_80s_60 = studied_1 hypoEMST_kms) ///
	   elev_mean_std dist_to_BA_std 
	eststo: ivreg2 chg_log_urbpop_91_60 (pav_and_grav_chg_86_54 tot_rails_chg_80s_60 = studied_1 hypoEMST_kms)
	eststo: ivreg2 chg_log_urbpop_91_60 (pav_and_grav_chg_86_54 tot_rails_chg_80s_60 = studied_1 hypoEMST_kms) ///
	   elev_mean_std
	eststo: ivreg2 chg_log_urbpop_91_60 (pav_and_grav_chg_86_54 tot_rails_chg_80s_60 = studied_1 hypoEMST_kms) ///
	   elev_mean_std dist_to_BA_std 
	   
	esttab *, star(* 0.10 ** 0.05 *** 0.01)*/

main

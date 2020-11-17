clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear
	
	eststo clear
	make_diff_means_table,  vars(chg_log_pop_60_46 chg_log_urbpop_60_46) ///
	    by_var(studied_larkin_dummy)
	mat colnames diff_means = "No studied segments" "At least one studied segment" ///
	    "Diff-in-means" "SE Diff-in-means"
	mat rownames diff_means = "Change in log pop 1960-1946" "N" ///
	    "Change in log urb pop 1960-1946" "N"
	esttab matrix(diff_means) using "../output/balance_table.tex", mtitle("") replace

	make_balance_reg, depvar(log_pop)
	make_balance_reg, depvar(log_urbpop)
	make_balance_reg, depvar(log_share_urbpop)
end

program make_diff_means_table
    syntax, vars(str) by_var(str)
	
	clear matrix
	local n_vars: word count `vars'
	clear matrix
    forval i = 1/`n_vars' {
        local var: word `i' of `vars' 
	    qui ttest `var', by(`by_var')
	    matrix diff_means = (nullmat(diff_means) \ r(mu_1), r(mu_2), r(mu_1) - r(mu_2), ///
		    r(se) \ r(N_1), r(N_2), r(N_1) + r(N_2), .)
	}
end
 
program make_balance_reg
    syntax, depvar(str)
	
	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
	
	eststo clear
	
	eststo: qui reg chg_`depvar'_60_46 i.studied_larkin_dummy hypo_LCP_total_MST_kms `geo_vars'
	eststo: qui reg chg_`depvar'_60_46 i.above_median_studied_kms hypo_LCP_total_MST_kms `geo_vars'
	eststo: qui reg chg_`depvar'_60_46 i.studied_kms_quint hypo_LCP_total_MST_kms `geo_vars'
	eststo: qui reg chg_`depvar'_60_46 studied_larkin ///
	    c.studied_larkin#c.studied_larkin c.studied_larkin#c.studied_larkin#c.studied_larkin ///
		hypo_LCP_total_MST_kms `geo_vars'
	
	esttab * using "../output/balance_reg_table_`depvar'.tex", ///
		se star(* 0.10 ** 0.05 *** 0.01) ///
	    keep(1.studied_larkin_dummy 1.above_median_studied_kms ///
		2.studied_kms_quint 3.studied_kms_quint ///
		4.studied_kms_quint 5.studied_kms_quint ///
		studied_larkin c.studied_larkin#c.studied_larkin ///
	    c.studied_larkin#c.studied_larkin#c.studied_larkin) stats(r2 N) label replace
end

main
 
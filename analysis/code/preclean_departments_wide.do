clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../../derived/output/departments_wide_panel.dta", clear
    preclean_data
	
    save_data "../temp/departments_wide_panel.dta", replace key(geolev2)
end

program gen_log_var_and_label
    syntax, var(str) label(str)
	
	gen log_`var' = log(`var')
	label var log_`var' "`label'"
end 

program gen_chg_var_and_label
    syntax, var(str) year_pre(int) year_post(str) label(str)
	
	gen chg_`var'_`year_post'_`year_pre' = `var'_19`year_post' - `var'_19`year_pre'
	label var chg_`var'_`year_post'_`year_pre' "Change in `label' 19`year_post'-19`year_pre'"
end

program preclean_data
    drop if geolev2 == 32099999 /* Unkown location */
	drop if geolev2 == 238094004 /* Falkland Islands */
	drop if geolev2 == 239094003 /* Sandwhich Islands */
	
	drop if geolev2 == 32002001 /* City of Buenos Aires */
	*drop if geolev2 == 32006001 /* La Plata */
	
	**** population outcomes
	rename (pop1946_imputed pop1946 urbpop1946_imputed urbpop1946 pop1960 pop1970 pop1991) ///
	    (pop_imputed_1947 pop_1947 urbpop_imputed_1947 urbpop_1947 pop_1960 pop_1970 pop_1991)
	gen pop_imputed_1960 = pop_1960
	gen urbpop_imputed_1960 = urbpop_1960
	gen_log_var_and_label, var(pop_imputed_1947) label(Log population 1947)
	gen_log_var_and_label, var(pop_1947) label(Log population 1947)
	gen_log_var_and_label, var(pop_1960) label(Log population 1960)
	gen_log_var_and_label, var(pop_imputed_1960) label(Log population 1960)
	gen_log_var_and_label, var(pop_1970) label(Log population 1970)
	gen_log_var_and_label, var(pop_1991) label(Log population 1991)
	
	gen_chg_var_and_label, var(log_pop) year_pre(47) year_post(60) ///
	    label(log population)
	gen_chg_var_and_label, var(log_pop_imputed) year_pre(47) year_post(60) ///
	    label(log population)
	gen_chg_var_and_label, var(log_pop) year_pre(60) year_post(91) ///
	    label(log population)
	gen_chg_var_and_label, var(log_pop) year_pre(70) year_post(91) ///
	    label(log population)

	gen_log_var_and_label, var(urbpop_1947) label(Log urban population 1947)
	gen_log_var_and_label, var(urbpop_imputed_1947) label(Log urban population 1947)
	gen_log_var_and_label, var(urbpop_1960) label(Log urban population 1960)
	gen_log_var_and_label, var(urbpop_imputed_1960) label(Log urban population 1960)
	gen_log_var_and_label, var(urbpop_1991) label(Log urban population 1991)
	
	gen_chg_var_and_label, var(log_urbpop) year_pre(47) year_post(60) ///
	    label(log urban population)
	gen_chg_var_and_label, var(log_urbpop_imputed) year_pre(47) year_post(60) ///
	    label(log urban population)
	gen_chg_var_and_label, var(log_urbpop) year_pre(60) year_post(91) ///
	    label(log urban population)

	gen share_urbpop_1947 = urbpop_1947/pop_1947
	gen share_urbpop_1960 = urbpop_1960/pop_1960
	gen share_urbpop_1991 = urbpop_1991/pop_1991
	
	label var share_urbpop_1947 "Share of urban population 1947"
	label var share_urbpop_1960 "Share of urban population 1960"

	gen_chg_var_and_label, var(share_urbpop) year_pre(47) year_post(60) ///
	    label(share of urban population)
	gen_chg_var_and_label, var(share_urbpop) year_pre(60) year_post(91) ///
	    label(share of urban population)
		
	gen_log_var_and_label, var(share_urbpop_1947) label(Log share population 1947)
	gen_log_var_and_label, var(share_urbpop_1960) label(Log share population 1960)
	gen_log_var_and_label, var(share_urbpop_1991) label(Log share population 1991)
	
	gen_chg_var_and_label, var(log_share_urbpop) year_pre(47) year_post(60) ///
	    label(log share of urban population)
	gen_chg_var_and_label, var(log_share_urbpop) year_pre(60) year_post(91) ///
	    label(log share of urban population)
		
	**** labor shares by activity 
	rename (indgen_1_1970 indgen_2_1970 indgen_3_1970 ///
	    indgen_4_1970 indgen_5_1970 ///
	    indgen_6_1970 indgen_7_1970 indgen_8_1970 ///
		indgen_9_1970 indgen_10_1970 ///
		indgen_11_1970 indgen_12_1970 indgen_13_1970 ///
		indgen_14_1970 indgen_15_1970 ///
	    indgen_1_1991 indgen_2_1991 indgen_3_1991 ///
		indgen_4_1991 indgen_5_1991 ///
		indgen_6_1991 indgen_7_1991 indgen_8_1991 ///
		indgen_9_1991 indgen_10_1991 ///
		indgen_11_1991 indgen_12_1991 indgen_13_1991 ///
		indgen_14_1991 indgen_15_1991) ///
	    (share_agr_labor_1970 share_min_labor_1970 share_ind_labor_1970 ///
		share_egw_labor_1970 share_constr_labor_1970 ///
		share_wret_labor_1970 share_hrest_labor_1970 share_tsc_labor_1970 ///
		share_fin_labor_1970 share_pub_labor_1970 ///
		share_rsb_labor_1970 share_edu_labor_1970 share_hsw_labor_1970 ///
		share_ot_labor_1970 share_oth_labor_1970 ///
		share_agr_labor_1991 share_min_labor_1991 share_ind_labor_1991 ///
		share_egw_labor_1991 share_constr_labor_1991 ///
		share_wret_labor_1991 share_hrest_labor_1991 share_tsc_labor_1991 ///
		share_fin_labor_1991 share_pub_labor_1991 ///
		share_rsb_labor_1991 share_edu_labor_1991 share_hsw_labor_1991 ///
		share_ot_labor_1991 share_oth_labor_1991)
	label var share_agr_labor_1970 "Share of agricultural labor 1970"
	label var share_min_labor_1970 "Share of mining labor 1970"
	label var share_ind_labor_1970 "Share of industrial labor 1970"
	label var share_egw_labor_1970 "Share of electric, gas, and water labor 1970"
	label var share_constr_labor_1970 "Share of construction labor 1970"
    label var share_wret_labor_1970 "Share of wholesale and retail labor 1970"
	label var share_hrest_labor_1970 "Share of hotels and restaurants labor 1970"
	label var share_tsc_labor_1970 "Share of transportation, storage, and communications labor 1970"
	label var share_fin_labor_1970 "Share of financial services and insurance labor 1970"
	label var share_pub_labor_1970 "Share of public administration labor 1970"
	label var share_rsb_labor_1970 "Share of real state and business labor 1970"
	label var share_edu_labor_1970 "Share of education labor 1970"
	label var share_hsw_labor_1970 "Share of health and social work labor 1970"
	label var share_ot_labor_1970 "Share of other services labor 1970"
	label var share_oth_labor_1970 "Share of other household services labor 1970"
	
	gen_chg_var_and_label, var(share_agr_labor) year_pre(70) year_post(91) ///
	    label(share of agricultural labor)
	gen_chg_var_and_label, var(share_min_labor) year_pre(70) year_post(91) ///
	    label(share of mining labor)
		
	gen_chg_var_and_label, var(share_ind_labor) year_pre(70) year_post(91) ///
	    label(share of industrial labor)
		
	gen_chg_var_and_label, var(share_egw_labor) year_pre(70) year_post(91) ///
	    label(share of electric, gas, and water labor)
	gen_chg_var_and_label, var(share_constr_labor) year_pre(70) year_post(91) ///
	    label(share of construction labor)
		
	gen_chg_var_and_label, var(share_pub_labor) year_pre(70) year_post(91) ///
	    label(share of public administration labor)
	gen_chg_var_and_label, var(share_edu_labor) year_pre(70) year_post(91) ///
	    label(share of education labor)
	gen_chg_var_and_label, var(share_hsw_labor) year_pre(70) year_post(91) ///
	    label(share of health and social work labor)
		
	gen_chg_var_and_label, var(share_wret_labor) year_pre(70) year_post(91) ///
	    label(share of wholesale and retail labor)
	gen_chg_var_and_label, var(share_hrest_labor) year_pre(70) year_post(91) ///
	    label(share of hotels and restaurants labor)
	gen_chg_var_and_label, var(share_tsc_labor) year_pre(70) year_post(91) ///
	    label(share of transportation, storage, and communications labor)
	gen_chg_var_and_label, var(share_fin_labor) year_pre(70) year_post(91) ///
	    label(share of financial services and insurance labor)
	gen_chg_var_and_label, var(share_rsb_labor) year_pre(70) year_post(91) ///
	    label(share of real state and business labor)
	
	
	gen_chg_var_and_label, var(share_ot_labor) year_pre(70) year_post(91) ///
	    label(share of other services labor)
	gen_chg_var_and_label, var(share_oth_labor) year_pre(70) year_post(91) ///
	    label(share of other household services labor)

	**** labor shares by broad sectors
	gen sh_primary_1970 = share_agr_labor_1970 + share_min_labor_1970
	label var sh_primary_1970 "Share of agriculture and mining 1970"
	gen sh_ind_1970 = share_ind_labor_1970
	label var sh_ind_1970 "Share of industrial 1970"
	gen sh_nt_ind_1970 = share_egw_labor_1970 + share_constr_labor_1970
	label var sh_nt_ind_1970 "Share of non-tradable industrial 1970"
    gen sh_gov_ed_health_1970 = share_pub_labor_1970 + share_edu_labor_1970 + share_hsw_labor_1970
	label var sh_gov_ed_health_1970 "Share of education, health, and public services 1970"
	gen sh_busi_serv_1970 = share_wret_labor_1970 + share_hrest_labor_1970 + ///
	    share_tsc_labor_1970 + share_fin_labor_1970 + share_rsb_labor_1970
	label var sh_busi_serv_1970 "Share of business services 1970"
	gen sh_oth_serv_1970 = share_ot_labor_1970 + share_oth_labor_1970
	label var sh_oth_serv_1970 "Share other services 1970"

	
	gen sh_primary_1991 = share_agr_labor_1991 + share_min_labor_1991
	label var sh_primary_1991 "Share agriculture and mining 1991"
	gen sh_ind_1991 = share_ind_labor_1991
	label var sh_ind_1991 "Share industrial 1991"
	gen sh_nt_ind_1991 = share_egw_labor_1991 + share_constr_labor_1991
	label var sh_nt_ind_1991 "Share non-tradable industrial 1991"
    gen sh_gov_ed_health_1991 = share_pub_labor_1991 + share_edu_labor_1991 + share_hsw_labor_1991
	label var sh_gov_ed_health_1991 "Share education, health, and public services 1991"
	gen sh_busi_serv_1991 = share_wret_labor_1991 + share_hrest_labor_1991 + ///
	    share_tsc_labor_1991 + share_fin_labor_1991 + share_rsb_labor_1991
	label var sh_busi_serv_1991 "Share business services 1991"
	gen sh_oth_serv_1991 = share_ot_labor_1991 + share_oth_labor_1991
	label var sh_oth_serv_1991 "Share other services 1991"
	
	gen_chg_var_and_label, var(sh_primary) year_pre(70) year_post(91) ///
	    label(share agriculture and mining)
	gen_chg_var_and_label, var(sh_ind) year_pre(70) year_post(91) ///
	    label(share industrial)
	gen_chg_var_and_label, var(sh_nt_ind) year_pre(70) year_post(91) ///
	    label(share non-tradeable industrial)
	gen_chg_var_and_label, var(sh_gov_ed_health) year_pre(70) year_post(91) ///
	    label(share education, health, and public services)
	gen_chg_var_and_label, var(sh_busi_serv) year_pre(70) year_post(91) ///
	    label(share business services)
	gen_chg_var_and_label, var(sh_oth_serv) year_pre(70) year_post(91) ///
	    label(share other services)

	gen_log_var_and_label, var(sh_primary_1970) label(Log share agriculture and mining 1970)
	gen_log_var_and_label, var(sh_primary_1991) label(Log share agriculture and mining 1991)
	gen_log_var_and_label, var(sh_ind_1970) label(Log share industrial 1970)
	gen_log_var_and_label, var(sh_ind_1991) label(Log share industrial 1991)
	gen_log_var_and_label, var(sh_nt_ind_1970) label(Log share non-tradeable industrial 1970)
	gen_log_var_and_label, var(sh_nt_ind_1991) label(Log share non-tradeable industrial 1991)
	gen_log_var_and_label, var(sh_gov_ed_health_1970) label(Log share education, health, and public services 1970)
	gen_log_var_and_label, var(sh_gov_ed_health_1991) label(Log share education, health, and public services 1991)
	gen_log_var_and_label, var(sh_busi_serv_1970) label(Log share business services 1970)
	gen_log_var_and_label, var(sh_busi_serv_1991) label(Log share business services 1991)
	gen_log_var_and_label, var(sh_oth_serv_1970) label(Log share other services 1970)
	gen_log_var_and_label, var(sh_oth_serv_1991) label(Log share other services 1991)
		
	gen_chg_var_and_label, var(log_sh_primary) year_pre(70) year_post(91) ///
	    label(log share agriculture and mining)
	gen_chg_var_and_label, var(log_sh_ind) year_pre(70) year_post(91) ///
	    label(log share industrial)
	gen_chg_var_and_label, var(log_sh_nt_ind) year_pre(70) year_post(91) ///
	    label(log share non-tradeable industrial)
	gen_chg_var_and_label, var(log_sh_gov_ed_health) year_pre(70) year_post(91) ///
	    label(log share ducation, health, and public services)
	gen_chg_var_and_label, var(log_sh_busi_serv) year_pre(70) year_post(91) ///
	    label(log share business services)
	gen_chg_var_and_label, var(log_sh_oth_serv) year_pre(70) year_post(91) ///
	    label(log share other services)
		
	**** labor shares by class of workers
	rename (classwk_1_1970 classwk_2_1970 classwk_3_1970 ///
	    classwk_1_1991 classwk_2_1991 classwk_3_1991) ///
	    (sh_sew_1970 sh_sw_1970 sh_uw_1970 ///
		sh_sew_1991 sh_sw_1991 sh_uw_1991)
	label var sh_sew_1970 "Share of self-employed 1970"
	label var sh_sw_1970 "Share of salary workers 1970"
	label var sh_uw_1970 "Share of unpaid workers 1970"
	
	gen_chg_var_and_label, var(sh_sew) year_pre(70) year_post(91) ///
	    label(share of self-employed workers)
	gen_chg_var_and_label, var(sh_sw) year_pre(70) year_post(91) ///
	    label(share of salary workers)
	gen_chg_var_and_label, var(sh_uw) year_pre(70) year_post(91) ///
	    label(share of unpaid workers)
	
	**** education shares 
	rename (secondary_1970 secondary_1991) ///
	    (secondary_ed_1970 secondary_ed_1991)
	label var college_1970 "Share of at least college 1970"
	label var secondary_ed_1970 "Share of at least secondary education 1970"

	gen_chg_var_and_label, var(college) year_pre(70) year_post(91) ///
	    label(share of at least college education)
	gen_chg_var_and_label, var(secondary_ed) year_pre(70) year_post(91) ///
	    label(share of at least secondary education)

	**** migration shares
	label var mig5_1970 "Share of people living in the province they were born 1970"

	gen_chg_var_and_label, var(mig5) year_pre(70) year_post(91) ///
	    label(share of people living in the province they were born)

	**** employment status shares
	rename (empstat_2_1970 empstat_3_1970 empstat_2_1991 empstat_3_1991) ////
	    (sh_unemployed_1970 sh_inactive_1970 sh_unemployed_1991 sh_inactive_1991)
		
	label var sh_unemployed_1970 "Share of unemployed 1970"
	label var sh_inactive_1970 "Share of inactive 1970"
	
	gen_chg_var_and_label, var(sh_unemployed) year_pre(70) year_post(91) ///
	    label(share of unemployed)
	gen_chg_var_and_label, var(sh_inactive) year_pre(70) year_post(91) ///
	    label(share of inactive)

	**** labor levels by activity 
		rename (nindgen_1_1970 nindgen_2_1970 nindgen_3_1970 ///
	    nindgen_4_1970 nindgen_5_1970 ///
	    nindgen_6_1970 nindgen_7_1970 nindgen_8_1970 ///
		nindgen_9_1970 nindgen_10_1970 ///
		nindgen_11_1970 nindgen_12_1970 nindgen_13_1970 ///
		nindgen_14_1970 nindgen_15_1970 ///
	    nindgen_1_1991 nindgen_2_1991 nindgen_3_1991 ///
		nindgen_4_1991 nindgen_5_1991 ///
		nindgen_6_1991 nindgen_7_1991 nindgen_8_1991 ///
		nindgen_9_1991 nindgen_10_1991 ///
		nindgen_11_1991 nindgen_12_1991 nindgen_13_1991 ///
		nindgen_14_1991 nindgen_15_1991) ///
	    (agr_labor_1970 min_labor_1970 ind_labor_1970 ///
		egw_labor_1970 constr_labor_1970 ///
		wret_labor_1970 hrest_labor_1970 tsc_labor_1970 ///
		fin_labor_1970 pub_labor_1970 ///
		rsb_labor_1970 edu_labor_1970 hsw_labor_1970 ///
		ot_labor_1970 oth_labor_1970 ///
		agr_labor_1991 min_labor_1991 ind_labor_1991 ///
		egw_labor_1991 constr_labor_1991 ///
		wret_labor_1991 hrest_labor_1991 tsc_labor_1991 ///
		fin_labor_1991 pub_labor_1991 ///
		rsb_labor_1991 edu_labor_1991 hsw_labor_1991 ///
		ot_labor_1991 oth_labor_1991)
				
	foreach year in 70 91 {
		gen_log_var_and_label, var(agr_labor_19`year') label(Log agricultural labor 19`year')
		gen_log_var_and_label, var(min_labor_19`year') label(Log mining labor 19`year')
		gen_log_var_and_label, var(ind_labor_19`year') label(Log manufacturing labor 19`year')
		gen_log_var_and_label, var(egw_labor_19`year') label(Log electric, gas, and water labor 19`year')
		gen_log_var_and_label, var(constr_labor_19`year') label(Log construction labor 19`year')
		gen_log_var_and_label, var(wret_labor_19`year') label(Log wholesale and retail labor 19`year')
		gen_log_var_and_label, var(hrest_labor_19`year') label(Log hotels and restaurants labor 19`year')
		gen_log_var_and_label, var(tsc_labor_19`year') label(Log transportation, storage, and communications labor 19`year')
		gen_log_var_and_label, var(fin_labor_19`year') label(Log financial services and insurance labor 19`year')
		gen_log_var_and_label, var(pub_labor_19`year') label(Log public administration labor 19`year')
		gen_log_var_and_label, var(rsb_labor_19`year') label(Log real state and business labor 19`year')
		gen_log_var_and_label, var(edu_labor_19`year') label(Log education labor 19`year')
		gen_log_var_and_label, var(hsw_labor_19`year') label(Log health and social work labor 19`year')
		gen_log_var_and_label, var(ot_labor_19`year') label(Log other services labor 19`year')
		gen_log_var_and_label, var(oth_labor_19`year') label(Log other household services labor 19`year')
	}
	
	gen_chg_var_and_label, var(log_agr_labor) year_pre(70) year_post(91) ///
	    label(log of agricultural labor)
	gen_chg_var_and_label, var(log_min_labor) year_pre(70) year_post(91) ///
	    label(log of mining labor)
	gen_chg_var_and_label, var(log_ind_labor) year_pre(70) year_post(91) ///
	    label(log of manufacturing labor)
	gen_chg_var_and_label, var(log_egw_labor) year_pre(70) year_post(91) ///
	    label(log of electric, gas, and water labor)
	gen_chg_var_and_label, var(log_constr_labor) year_pre(70) year_post(91) ///
	    label(log of construction labor)
	gen_chg_var_and_label, var(log_wret_labor) year_pre(70) year_post(91) ///
	    label(log of wholesale and retail labor)
	gen_chg_var_and_label, var(log_hrest_labor) year_pre(70) year_post(91) ///
	    label(log of hotels and restaurants labor)
	gen_chg_var_and_label, var(log_tsc_labor) year_pre(70) year_post(91) ///
	    label(log of transportation, storage, and communications labor)
	gen_chg_var_and_label, var(log_fin_labor) year_pre(70) year_post(91) ///
	    label(log of financial services and insurance labor)
	gen_chg_var_and_label, var(log_pub_labor) year_pre(70) year_post(91) ///
	    label(log of public administration labor)
	gen_chg_var_and_label, var(log_rsb_labor) year_pre(70) year_post(91) ///
	    label(log of real state and business labor)
	gen_chg_var_and_label, var(log_edu_labor) year_pre(70) year_post(91) ///
	    label(log of education labor)
	gen_chg_var_and_label, var(log_hsw_labor) year_pre(70) year_post(91) ///
	    label(log of health and social work labor)
	gen_chg_var_and_label, var(log_ot_labor) year_pre(70) year_post(91) ///
	    label(log of other services labor)
	gen_chg_var_and_label, var(log_oth_labor) year_pre(70) year_post(91) ///
	    label(log of other household services labor)
		
	**** labor levels by broad sector 
	gen primary_1970 = agr_labor_1970 + min_labor_1970
	label var primary_1970 "Agriculture and mining 1970"
	gen ind_1970 = ind_labor_1970
	label var ind_1970 "Industrial 1970"
	gen nt_ind_1970 = egw_labor_1970 + constr_labor_1970
	label var nt_ind_1970 "Non-tradable industrial 1970"
    gen gov_ed_health_1970 = pub_labor_1970 + edu_labor_1970 + hsw_labor_1970
	label var gov_ed_health_1970 "Education, health, and public services 1970"
	gen busi_serv_1970 = wret_labor_1970 + hrest_labor_1970 + ///
	    tsc_labor_1970 + fin_labor_1970 + rsb_labor_1970
    label var busi_serv_1970 "Business services 1970"
	gen oth_serv_1970 = ot_labor_1970 + oth_labor_1970
	label var oth_serv_1970 "Other services 1970"
	
	gen primary_1991 = agr_labor_1991 + min_labor_1991
	label var primary_1991 "Agriculture and mining 1991"
	gen ind_1991 = ind_labor_1991
	label var ind_1991 "Industrial 1991"
	gen nt_ind_1991 = egw_labor_1991 + constr_labor_1991
	label var nt_ind_1991 "Non-tradable industrial 1991"
    gen gov_ed_health_1991 = pub_labor_1991 + edu_labor_1991 + hsw_labor_1991
	label var gov_ed_health_1991 "Education, health, and public services 1991"
	gen busi_serv_1991 = wret_labor_1991 + hrest_labor_1991 + ///
	    tsc_labor_1991 + fin_labor_1991 + rsb_labor_1991
	label var busi_serv_1991 "Business services 1991"
    gen oth_serv_1991 = ot_labor_1991 + oth_labor_1991
	label var oth_serv_1991 "Other services 1991"
	
	gen_chg_var_and_label, var(primary) year_pre(70) year_post(91) ///
	    label(agriculture and mining)
	gen_chg_var_and_label, var(ind) year_pre(70) year_post(91) ///
	    label(industrial)
	gen_chg_var_and_label, var(nt_ind) year_pre(70) year_post(91) ///
	    label(non-tradeable industrial)
	gen_chg_var_and_label, var(gov_ed_health) year_pre(70) year_post(91) ///
	    label(education, health, and public services)
	gen_chg_var_and_label, var(busi_serv) year_pre(70) year_post(91) ///
	    label(business services)
	gen_chg_var_and_label, var(oth_serv) year_pre(70) year_post(91) ///
	    label(other services)

	gen_log_var_and_label, var(primary_1970) label(Log agriculture and mining 1970)
	gen_log_var_and_label, var(primary_1991) label(Log agriculture and mining 1991)
	gen_log_var_and_label, var(ind_1970) label(Log industrial 1970)
	gen_log_var_and_label, var(ind_1991) label(Log industrial 1991)
	gen_log_var_and_label, var(nt_ind_1970) label(Log non-tradeable industrial 1970)
	gen_log_var_and_label, var(nt_ind_1991) label(Log non-tradeable industrial 1991)
	gen_log_var_and_label, var(gov_ed_health_1970) label(Log education, health, and public services 1970)
	gen_log_var_and_label, var(gov_ed_health_1991) label(Log education, health, and public services 1991)
	gen_log_var_and_label, var(busi_serv_1970) label(Log business services 1970)
	gen_log_var_and_label, var(busi_serv_1991) label(Log business services 1991)
	gen_log_var_and_label, var(oth_serv_1970) label(Log other services 1970)
	gen_log_var_and_label, var(oth_serv_1991) label(Log other services 1991)
		
	gen_chg_var_and_label, var(log_primary) year_pre(70) year_post(91) ///
	    label(log agriculture and mining)
	gen_chg_var_and_label, var(log_ind) year_pre(70) year_post(91) ///
	    label(log industrial)
	gen_chg_var_and_label, var(log_nt_ind) year_pre(70) year_post(91) ///
	    label(log non-tradeable industrial)
	gen_chg_var_and_label, var(log_gov_ed_health) year_pre(70) year_post(91) ///
	    label(log education, health, and public services)
	gen_chg_var_and_label, var(log_busi_serv) year_pre(70) year_post(91) ///
	    label(log business services)
	gen_chg_var_and_label, var(log_oth_serv) year_pre(70) year_post(91) ///
	    label(log other services)
	
	**** labor levels by class of workers
	rename (nclasswk_1_1970 nclasswk_2_1970 nclasswk_3_1970 ///
	    nclasswk_1_1991 nclasswk_2_1991 nclasswk_3_1991) ///
	    (sew_1970 sw_1970 uw_1970 ///
		sew_1991 sw_1991 uw_1991)
	
	foreach year in 70 91 {
		gen_log_var_and_label, var(sew_19`year') label(Log self-employed workers 19`year')
		gen_log_var_and_label, var(sw_19`year') label(Log salary workers 19`year')
		gen_log_var_and_label, var(uw_19`year') label(Log unpaid workers 19`year')
	}
	
	gen_chg_var_and_label, var(log_sew) year_pre(70) year_post(91) ///
	    label(log self-employed workers)
	gen_chg_var_and_label, var(log_sw) year_pre(70) year_post(91) ///
	    label(log salary workers)
	gen_chg_var_and_label, var(log_uw) year_pre(70) year_post(91) ///
	    label(log unpaid workers)
	
	**** Education levels 
	rename (nsecondary_1970 nsecondary_1991) ///
	    (nsecondary_ed_1970 nsecondary_ed_1991)
		
	foreach year in 70 91 {
		gen_log_var_and_label, var(ncollege_19`year') label(Log number of people with at least college 19`year')
		gen_log_var_and_label, var(nsecondary_ed_19`year') label(Log number of people with at least secondary education 19`year')
	}
	
	gen_chg_var_and_label, var(log_ncollege) year_pre(70) year_post(91) ///
	    label(number of people with at least college education)
	gen_chg_var_and_label, var(log_nsecondary_ed) year_pre(70) year_post(91) ///
	    label(number of people with at least secondary education)
		
	**** Migration levels
	foreach year in 70 91 {
		gen_log_var_and_label, var(nmig5_19`year') label(Log number of people living in the province they were born 19`year')
	}
	
	gen_chg_var_and_label, var(log_nmig5) year_pre(70) year_post(91) ///
	    label(number of people living in the province they were born)	
	
	**** Employment status levels
	rename (nempstat_2_1970 nempstat_3_1970 nempstat_2_1991 nempstat_3_1991) ////
	    (unemployed_1970 inactive_1970 unemployed_1991 inactive_1991)
	
    foreach year in 70 91 {
		gen_log_var_and_label, var(unemployed_19`year') label(Log unemployed 19`year')
		gen_log_var_and_label, var(inactive_19`year') label(Log inactive 19`year')
	}
	
	gen_chg_var_and_label, var(log_unemployed) year_pre(70) year_post(91) ///
	    label(log unemployed)
	gen_chg_var_and_label, var(log_inactive) year_pre(70) year_post(91) ///
	    label(log inactive)
	
	**** Agr and Ind censuses
	gen_log_var_and_label, var(agnexp_1960) label(Log number of farms 1960)
	gen_log_var_and_label, var(agnexp_1988) label(Log number of farms 1988)
	gen_chg_var_and_label, var(log_agnexp) year_pre(60) year_post(88) ///
	    label(log number of farms)
		
	gen_log_var_and_label, var(agareatot_ha_1960) label(Log agricultural area (ha) 1960)
	gen_log_var_and_label, var(agareatot_ha_1988) label(Log agricultural area (ha) 1988)
	gen_chg_var_and_label, var(log_agareatot_ha) year_pre(60) year_post(88) ///
	    label(log agricultural area (ha))
		
	gen agr_labor_per_ha_1970 = agr_labor_1970/agareatot_ha_1960
	gen agr_labor_per_ha_1991 = agr_labor_1991/agareatot_ha_1988

	gen agr_labor_per_farm_1970 = agr_labor_1970/agnexp_1960
	gen agr_labor_per_farm_1991 = agr_labor_1991/agnexp_1988
	
    gen_log_var_and_label, var(agr_labor_per_ha_1970) label(Log agricultural workers per ha 1970)
	gen_log_var_and_label, var(agr_labor_per_ha_1991) label(Log agricultural workers per ha 1991)
	gen_chg_var_and_label, var(log_agr_labor_per_ha) year_pre(70) year_post(91) ///
	    label(log agricultural workers per ha)
		
    gen_log_var_and_label, var(agr_labor_per_farm_1970) label(Log agricultural workers per farm 1970)
	gen_log_var_and_label, var(agr_labor_per_farm_1991) label(Log agricultural workers per farm 1991)
	gen_chg_var_and_label, var(log_agr_labor_per_farm) year_pre(70) year_post(91) ///
	    label(log agricultural workers per farm)
		
	gen_log_var_and_label, var(indnestab_1954) label(Log number of firms 1954)
	gen_log_var_and_label, var(indnestab_1985) label(Log number of firms 1985)
	gen_chg_var_and_label, var(log_indnestab) year_pre(54) year_post(85) ///
	    label(log number of firms)
	gen_log_var_and_label, var(indnpers_1954) label(Log number of employees 1954)
	gen_log_var_and_label, var(indnpers_1985) label(Log number of employees 1985)
	gen_chg_var_and_label, var(log_indnpers) year_pre(54) year_post(85) ///
	    label(log number of employees)
	gen_log_var_and_label, var(indmassal_1954) label(Log total paid wages 1954)
	gen_log_var_and_label, var(indmassal_1985) label(Log total paid wages 1985)
	gen_chg_var_and_label, var(log_indmassal) year_pre(54) year_post(85) ///
	    label(log total paid wages)
	gen indvalprod_1985 = indvalprod1_1985 + indvalprod2_1985
	gen_log_var_and_label, var(indvalprod_1954) label(Log total value of production 1954)
	gen_log_var_and_label, var(indvalprod_1985) label(Log total value of production 1985)
	gen_chg_var_and_label, var(log_indvalprod) year_pre(54) year_post(85) ///
	    label(log total value of production)	
		
	gen indnestab_pc_1954 = indnestab_1954/indnpers_1954
	gen indnestab_pc_1985 = indnestab_1985/indnpers_1985

	gen indmassal_pc_1954 = indmassal_1954/indnpers_1954
	gen indmassal_pc_1985 = indmassal_1985/indnpers_1985

	gen indvalprod_pc_1954 = indvalprod_1954/indnpers_1954
	gen indvalprod_pc_1985 = indvalprod_1985/indnpers_1985
	
	gen_log_var_and_label, var(indnestab_pc_1954) ///
	    label(Log number of firms per worker 1954)
	gen_log_var_and_label, var(indnestab_pc_1985) ///
	    label(Log number of firms per worker 1985)
	gen_chg_var_and_label, var(log_indnestab_pc) year_pre(54) year_post(85) ///
	    label(log number of firms per worker)
		
	gen_log_var_and_label, var(indmassal_pc_1954) label(Log paid wages per worker 1954)
	gen_log_var_and_label, var(indmassal_pc_1985) label(Log paid wages per worker 1985)
	gen_chg_var_and_label, var(log_indmassal_pc) year_pre(54) year_post(85) ///
	    label(log paid wages per worker)
		
	gen_log_var_and_label, var(indvalprod_pc_1954) ///
	    label(Log value of production per worker 1954)
	gen_log_var_and_label, var(indvalprod_pc_1985) ///
	    label(Log value of production per worker 1985)
	gen_chg_var_and_label, var(log_indvalprod_pc) year_pre(54) year_post(85) ///
	    label(log value of production per worker)

	**** instruments 
	rename (roads54_type1 roads54_type2 roads54_type3 roads54_type4 ///
	    roads70_type1 roads70_type2 roads70_type3 roads70_type4 ///
		roads86_type1 roads86_type2 roads86_type3 roads86_type4) ///
		(paved_roads_1954 gravel_roads_1954 dirt_roads_1954 footprint_roads_1954 ///
		paved_roads_1970 gravel_roads_1970 dirt_roads_1970 footprint_roads_1970 ///
		paved_roads_1986 gravel_roads_1986 dirt_roads_1986 footprint_roads_1986)
	
	/*gen tot_roads_1954 = paved_roads_1954 + gravel_roads_1954 + ///
	    dirt_roads_1954 + footprint_roads_1954
	gen tot_roads_1970 = paved_roads_1970 + gravel_roads_1970 + ///
	    dirt_roads_1970 + footprint_roads_1970
	gen tot_roads_1986 = paved_roads_1986 + gravel_roads_1986 + ////
	    dirt_roads_1986 + footprint_roads_1986
	
	gen_chg_var_and_label, var(tot_roads) year_pre(54) year_post(86) ///
	    label(kms of total roads)
	gen_chg_var_and_label, var(tot_roads) year_pre(70) year_post(86) ///
	    label(kms of total roads)*/
	
	gen old_pav_and_grav_1954 = paved_roads_1954 + gravel_roads_1954
	gen old_pav_and_grav_1970 = paved_roads_1970 + gravel_roads_1970
	gen old_pav_and_grav_1986 = paved_roads_1986 + gravel_roads_1986
	
	gen_chg_var_and_label, var(old_pav_and_grav) year_pre(54) year_post(86) ///
	    label(kms of paved and gravel roads)
	gen_chg_var_and_label, var(old_pav_and_grav) year_pre(70) year_post(86) ///
	    label(kms of paved and gravel roads)
		
	gen_chg_var_and_label, var(paved_roads) year_pre(54) year_post(86) ///
	    label(kms of paved roads)
	gen_chg_var_and_label, var(paved_roads) year_pre(70) year_post(86) ///
	    label(kms of paved roads)
		
	/*gen connected_paved_86_54 = (chg_paved_roads_86_54 > 0)
	gen connected_paved_86_70 = (chg_paved_roads_86_70 > 0)
	*/
	
	gen pav_and_grav_1954 = roadsall_class1 + roadsall_class4 + ///
	    roadsall_class5 + roadsall_class6
	gen pav_and_grav_1970 = roadsall_class1 + roadsall_class2 + ///
	    roadsall_class4 + roadsall_class7
    gen pav_and_grav_1986 = roadsall_class1 + roadsall_class2 + ///
	    roadsall_class3 + roadsall_class5
	
	gen_chg_var_and_label, var(pav_and_grav) year_pre(54) year_post(86) ///
	    label(kms of roads)
	gen_chg_var_and_label, var(pav_and_grav) year_pre(54) year_post(70) ///
	    label(kms of roads)
	gen_chg_var_and_label, var(pav_and_grav) year_pre(70) year_post(86) ///
	    label(kms of roads)

	gen connected_pav_grav_86_54 = (chg_pav_and_grav_86_54 > 0 & pav_and_grav_1954 == 0)
	gen connected_pav_grav_86_70 = (chg_pav_and_grav_86_70 > 0 & pav_and_grav_1970 == 0)

	gen tot_rails_1960 = status79_1 + status79_2 + status79_3
	gen tot_rails_1970 = status79_1 + status79_2
    gen tot_rails_1986 = status79_1

    gen_chg_var_and_label, var(tot_rails) year_pre(60) year_post(86) ///
	    label(kms of railroads)
    gen_chg_var_and_label, var(tot_rails) year_pre(60) year_post(70) ///
	    label(kms of railroads)
    gen_chg_var_and_label, var(tot_rails) year_pre(70) year_post(86) ///
	    label(kms of railroads)
		
	gen disconnected_rails_86_60 = (tot_rails_1986 == 0 & tot_rails_1960 > 0)
	gen disconnected_rails_86_70 = (tot_rails_1986 == 0 & tot_rails_1970 > 0)
	
	label var hypo_EUC_MST_kms  "Euclidean MST network (kms)"
	label var hypo_LCP_MST_kms  "Least-cost MST network (kms)"
	label var hypo_EUC_total_MST_kms  "Euclidean MST network (kms)"
	label var hypo_LCP_total_MST_kms  "Least-cost MST network (kms)"
	*label var hypo_LCP_plain_MST_kms  "Least-cost plain MST network (kms)"
	
	rename (hypomeanEMST_kms hypoCMST_kms studied_1) ///
	    (euclidean_hypo_network lcp_hypo_network studied_larkin)
	label var studied_larkin "Studied railroad tracks (kms)"
	gen studied_larkin_sq = studied_larkin*studied_larkin
	label var studied_larkin_sq "Studied railroad tracks (kms) square"
	gen studied_larkin_cu = studied_larkin*studied_larkin*studied_larkin
	label var studied_larkin_cu "Studied railroad tracks (kms) cube"
	gen studied_larkin_quart = studied_larkin*studied_larkin*studied_larkin*studied_larkin
	label var studied_larkin_quart "Studied railroad tracks (kms) fourth"
	
	qui sum studied_larkin, d
	gen above_median_studied_kms = (studied_larkin >= r(p50))
	label var above_median_studied_kms "Studied kms above median"
	
	qui sum share_urbpop_1947, d
	gen above_share_urbpop_1947 = (share_urbpop_1947 >= r(p50)) if !missing(share_urbpop_1947)

	qui sum share_urbpop_1960, d
	gen above_share_urbpop_1960 = (share_urbpop_1960 >= r(p50)) if !missing(share_urbpop_1960)
	
	qui sum pop_1960, d
	gen above_pop_1960 = (pop_1960 >= r(p50)) if !missing(pop_1960)
	
	egen studied_kms_quint = xtile(studied_larkin), n(5)
	label var studied_kms_quint "Quintile of studied kms"
	
    gen share_studied_larkin = studied_larkin/tot_rails_1960
	label var share_studied_larkin "Share of studied kms"
	gen studied_larkin_dummy = (studied_larkin > 0)
	label var studied_larkin_dummy "At least one studied segment"
	
	gen hypo_EUC_dummy = (hypo_EUC_total_MST_kms > 0)
	gen hypo_LCP_dummy = (hypo_LCP_total_MST_kms > 0)

	/*label var euclidean_hypo_network "Euclidean spanning tree network (kms)"
	label var lcp_hypo_network "Least-cost path spanning tree network (kms)"*/
end

main

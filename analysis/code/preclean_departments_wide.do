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
	rename (pop1960 pop1970 pop1991) ///
	    (pop_1960 pop_1970 pop_1991)
	gen_log_var_and_label, var(pop_1960) label(Log population 1960)
	gen_log_var_and_label, var(pop_1970) label(Log population 1970)
	gen_log_var_and_label, var(pop_1991) label(Log population 1991)
	
	gen_chg_var_and_label, var(log_pop) year_pre(60) year_post(91) ///
	    label(log population)
	gen_chg_var_and_label, var(log_pop) year_pre(70) year_post(91) ///
	    label(log population)

	gen_log_var_and_label, var(urbpop_1960) label(Log urban population 1960)
	gen_log_var_and_label, var(urbpop_1991) label(Log urban population 1991)
	
	gen_chg_var_and_label, var(log_urbpop) year_pre(60) year_post(91) ///
	    label(log urban population)

	gen share_urbpop_1960 = urbpop_1960/pop_1960
	gen share_urbpop_1991 = urbpop_1991/pop_1991
	label var share_urbpop_1960 "Share of urban population 1960"
	gen_chg_var_and_label, var(share_urbpop) year_pre(60) year_post(91) ///
	    label(share of urban population)
		
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
	label var share_ind_labor_1970 "Share of manufacturing labor 1970"
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
	    label(share of manufacturing labor)
	gen_chg_var_and_label, var(share_egw_labor) year_pre(70) year_post(91) ///
	    label(share of electric, gas, and water labor)
	gen_chg_var_and_label, var(share_constr_labor) year_pre(70) year_post(91) ///
	    label(share of construction labor)
	gen_chg_var_and_label, var(share_wret_labor) year_pre(70) year_post(91) ///
	    label(share of wholesale and retail labor)
	gen_chg_var_and_label, var(share_hrest_labor) year_pre(70) year_post(91) ///
	    label(share of hotels and restaurants labor)
	gen_chg_var_and_label, var(share_tsc_labor) year_pre(70) year_post(91) ///
	    label(share of transportation, storage, and communications labor)
	gen_chg_var_and_label, var(share_fin_labor) year_pre(70) year_post(91) ///
	    label(share of financial services and insurance labor)
	gen_chg_var_and_label, var(share_pub_labor) year_pre(70) year_post(91) ///
	    label(share of public administration labor)
	gen_chg_var_and_label, var(share_rsb_labor) year_pre(70) year_post(91) ///
	    label(share of real state and business labor)
	gen_chg_var_and_label, var(share_edu_labor) year_pre(70) year_post(91) ///
	    label(share of education labor)
	gen_chg_var_and_label, var(share_hsw_labor) year_pre(70) year_post(91) ///
	    label(share of health and social work labor)
	gen_chg_var_and_label, var(share_ot_labor) year_pre(70) year_post(91) ///
	    label(share of other services labor)
	gen_chg_var_and_label, var(share_oth_labor) year_pre(70) year_post(91) ///
	    label(share of other household services labor)

	**** labor shares by broad sector 
	gen sh_primary_1970 = share_agr_labor_1970 + share_min_labor_1970
	gen sh_secondary_1970 = share_ind_labor_1970 + share_egw_labor_1970 + share_constr_labor_1970
	gen sh_tertiary_1970 = 1 - sh_primary_1970 - sh_secondary_1970
	label var sh_primary_1970 "Share of primary labor 1970"
	label var sh_secondary_1970 "Share of secondary labor 1970"
	label var sh_tertiary_1970 "Share of tertiary labor 1970"
	
	gen sh_primary_1991 = share_agr_labor_1991 + share_min_labor_1991
	gen sh_secondary_1991 = share_ind_labor_1991 + share_egw_labor_1991 + share_constr_labor_1991
	gen sh_tertiary_1991 = 1 - sh_primary_1991 - sh_secondary_1991
	
	gen_chg_var_and_label, var(sh_primary) year_pre(70) year_post(91) ///
	    label(share of primary sector labor)
	gen_chg_var_and_label, var(sh_secondary) year_pre(70) year_post(91) ///
	    label(share of secondary sector labor)
	gen_chg_var_and_label, var(sh_tertiary) year_pre(70) year_post(91) ///
	    label(share of tertiary sector labor)
	
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
	gen secondary_1970 = ind_labor_1970 + egw_labor_1970 + constr_labor_1970
	gen tertiary_1970 = wret_labor_1970 + hrest_labor_1970 + tsc_labor_1970 + ///
		fin_labor_1970 + pub_labor_1970 + rsb_labor_1970 + edu_labor_1970 + ///
		hsw_labor_1970 + ot_labor_1970 + oth_labor_1970
	label var primary_1970 "Primary sector labor 1970"
	label var secondary_1970 "Secondary sector labor 1970"
	label var tertiary_1970 "Tertiary sector labor 1970"
	
	gen primary_1991 = ind_labor_1991 + egw_labor_1991 + constr_labor_1991
	gen secondary_1991 = ind_labor_1991 + egw_labor_1991 + constr_labor_1991
	gen tertiary_1991 = wret_labor_1991 + hrest_labor_1991 + tsc_labor_1991 + ///
		fin_labor_1991 + pub_labor_1991 + rsb_labor_1991 + edu_labor_1991 + ///
		hsw_labor_1991 + ot_labor_1991 + oth_labor_1991
	
	foreach year in 70 91 {
		gen_log_var_and_label, var(primary_19`year') label(Log primary sector labor 19`year')
		gen_log_var_and_label, var(secondary_19`year') label(Log secondary sector labor 19`year')
		gen_log_var_and_label, var(tertiary_19`year') label(Log tertiary sector labor 19`year')
	}
	
	gen_chg_var_and_label, var(log_primary) year_pre(70) year_post(91) ///
	    label(log primary sector labor)
	gen_chg_var_and_label, var(log_secondary) year_pre(70) year_post(91) ///
	    label(log secondary sector labor)
	gen_chg_var_and_label, var(log_tertiary) year_pre(70) year_post(91) ///
	    label(log tertiary sector labor)
	
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
	
	**** instruments 
	/*rename (roads54_type1 roads54_type2 roads54_type3 roads54_type4 ///
	    roads70_type1 roads70_type2 roads70_type3 roads70_type4 ///
		roads86_type1 roads86_type2 roads86_type3 roads86_type4) ///
		(paved_roads_1954 gravel_roads_1954 dirt_roads_1954 footprint_roads_1954 ///
		paved_roads_1970 gravel_roads_1970 dirt_roads_1970 footprint_roads_1970 ///
		paved_roads_1986 gravel_roads_1986 dirt_roads_1986 footprint_roads_1986)
	
	gen tot_roads_1954 = paved_roads_1954 + gravel_roads_1954 + ///
	    dirt_roads_1954 + footprint_roads_1954
	gen tot_roads_1970 = paved_roads_1970 + gravel_roads_1970 + ///
	    dirt_roads_1970 + footprint_roads_1970
	gen tot_roads_1986 = paved_roads_1986 + gravel_roads_1986 + ////
	    dirt_roads_1986 + footprint_roads_1986
	
	gen_chg_var_and_label, var(tot_roads) year_pre(54) year_post(86) ///
	    label(kms of total roads)
	gen_chg_var_and_label, var(tot_roads) year_pre(70) year_post(86) ///
	    label(kms of total roads)
	
	gen pav_and_grav_1954 = paved_roads_1954 + gravel_roads_1954
	gen pav_and_grav_1970 = paved_roads_1970 + gravel_roads_1970
	gen pav_and_grav_1986 = paved_roads_1986 + gravel_roads_1986
	
	gen_chg_var_and_label, var(pav_and_grav) year_pre(54) year_post(86) ///
	    label(kms of paved and gravel roads)
	gen_chg_var_and_label, var(pav_and_grav) year_pre(70) year_post(86) ///
	    label(kms of paved and gravel roads)
		
	gen_chg_var_and_label, var(paved_roads) year_pre(54) year_post(86) ///
	    label(kms of paved roads)
	gen_chg_var_and_label, var(paved_roads) year_pre(70) year_post(86) ///
	    label(kms of paved roads)
		
	gen connected_paved_86_54 = (chg_paved_roads_86_54 > 0)
	gen connected_paved_86_70 = (chg_paved_roads_86_70 > 0)
	*/
	
	gen pav_and_grav_1954 = roadsall_class1 + roadsall_class4 + ///
	    roadsall_class5 + roadsall_class6
	gen pav_and_grav_1970 = roadsall_class1 + roadsall_class2 + ///
	    roadsall_class4 + roadsall_class7
    gen pav_and_grav_1986 = roadsall_class1 + roadsall_class2 + ///
	    roadsall_class3 + roadsall_class5
	
	gen_chg_var_and_label, var(pav_and_grav) year_pre(54) year_post(86) ///
	    label(kms of paved and gravel roads)
	gen_chg_var_and_label, var(pav_and_grav) year_pre(70) year_post(86) ///
	    label(kms of paved and gravel roads)

	gen connected_pav_grav_86_54 = (chg_pav_and_grav_86_54 > 0)
	gen connected_pav_grav_86_70 = (chg_pav_and_grav_86_70 > 0)

	gen tot_rails_1960 = status79_1 + status79_2 + status79_3
	gen tot_rails_1970 = status79_1 + status79_2
    gen tot_rails_1986 = status79_1

    gen_chg_var_and_label, var(tot_rails) year_pre(60) year_post(86) ///
	    label(kms of railroads)
    gen_chg_var_and_label, var(tot_rails) year_pre(70) year_post(86) ///
	    label(kms of railroads)
		
	gen disconnected_rails_86_60 = (chg_tot_rails_86_60 < 0)
	gen disconnected_rails_86_70 = (chg_tot_rails_86_70 < 0)

	rename (hypomeanEMST_kms hypoCMST_kms studied_1) ///
	    (euclidean_hypo_network lcp_hypo_network studied_larkin)
		
	label var euclidean_hypo_network "Hypothetical LCP MST (Euclidean distance)(kms)"
	label var lcp_hypo_network "Hypothetical LCP MST (Construction cost)(kms)"
    label var studied_larkin "Studied railroad tracks (kms)"
end

main

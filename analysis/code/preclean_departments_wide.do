clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../../derived/output/departments_wide_panel.dta", clear
    preclean_data
	
    save_data "../temp/departments_wide_panel.dta", replace key(geolev2)
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
	
	gen sh_primary_70 = indgen_1_1970 + indgen_2_1970
	gen sh_secondary_70 = indgen_3_1970 + indgen_4_1970 + indgen_5_1970
	gen sh_tertiary_70 = 1 - sh_primary_70 - sh_secondary_70
	label var sh_primary_70 "Share of primary labor 1970"
	label var sh_secondary_70 "Share of secondary labor 1970"
	label var sh_tertiary_70 "Share of tertiary labor 1970"
	
	gen sh_primary_91 = indgen_1_1991 + indgen_2_1991
	gen sh_secondary_91 = indgen_3_1991 + indgen_4_1991 + indgen_5_1991
	gen sh_tertiary_91 = 1 - sh_primary_91 - sh_secondary_91
	
	gen chg_sh_primary_91_70 = sh_primary_91 - sh_primary_70 
	gen chg_sh_secondary_91_70 = sh_secondary_91 - sh_secondary_70 
	gen chg_sh_tertiary_91_70 = sh_tertiary_91 - sh_tertiary_70 
	label var chg_sh_primary_91_70 "Change in share of primary labor 1991-1970"
	label var chg_sh_secondary_91_70 "Change in share of secondary labor 1991-1970"
	label var chg_sh_tertiary_91_70 "Change in share of tertiary labor 1991-1970"
	
	label var classwk_1_1970 "Share of self-employed 1970"
	label var classwk_2_1970 "Share of salary workers 1970"
	label var classwk_3_1970 "Share of unpaid workers 1970"
	
	gen chg_sh_sew_91_70 = classwk_1_1991 - classwk_1_1970 
	gen chg_sh_sw_91_70 = classwk_2_1991 - classwk_2_1970 
	gen chg_sh_uw_91_70 = classwk_3_1991 - classwk_3_1970 
	label var chg_sh_sew_91_70 "Change in share of self-employed labor 1991-1970"
	label var chg_sh_sw_91_70 "Change in share of salary workers 1991-1970"
	label var chg_sh_uw_91_70 "Change in share of unpaid workers 1991-1970"
	
	rename (indgen_1_1970 indgen_2_1970 indgen_3_1970 indgen_4_1970 indgen_5_1970 ///
	    indgen_1_1991 indgen_2_1991 indgen_3_1991 indgen_4_1991 indgen_5_1991) ///
	    (share_agr_labor1970 share_min_labor1970 share_ind_labor1970 ///
		share_egw_labor1970 share_constr_labor1970 ///
		share_agr_labor1991 share_min_labor1991 share_ind_labor1991 ///
		share_egw_labor1991 share_constr_labor1991)
	label var share_agr_labor1970 "Share of agricultural labor 1970"
	label var share_min_labor1970 "Share of mining labor 1970"
	label var share_ind_labor1970 "Share of manufacturing labor 1970"
	label var share_egw_labor1970 "Share of electric, gas, and water labor 1970"
	label var share_constr_labor1970 "Share of construction labor 1970"
	label var college_1970 "Share of college 1970"

	gen chg_log_pop_91_60 = log_pop1991 - log_pop1960
	label var chg_log_pop_91_60 "Change in Log population 1991-1970"
	gen chg_log_pop_91_70 = log_pop1991 - log_pop1970
	label var chg_log_pop_91_70 "Change in Log population 1991-1970"

	gen chg_college_91_70 = college_1991 - college_1970
	label var chg_college_91_70 "Change in college 1991-1970"
	gen chg_share_agr_labor_91_70 = share_agr_labor1991 - share_agr_labor1970
	label var chg_share_agr_labor_91_70 "Change in share of agricultural labor 1991-1970"
	gen chg_share_min_labor_91_70 = share_min_labor1991 - share_min_labor1970
	label var chg_share_min_labor_91_70 "Change in share of mining labor 1991-1970"
	gen chg_share_ind_labor_91_70 = share_ind_labor1991 - share_ind_labor1970
	label var chg_share_ind_labor_91_70 "Change in share of industrial labor 1991-1970"
	gen chg_share_egw_labor_91_70 = share_egw_labor1991 - share_egw_labor1970
	label var chg_share_egw_labor_91_70 "Change in share of electric, gas, and water labor 1991-1970"
	gen chg_share_constr_labor_91_70 = share_constr_labor1991 - share_constr_labor1970
	label var chg_share_constr_labor_91_70 "Change in share of construction labor 1991-1970"
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

main

clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    import dbase "../../raw_data/IPUMS/geo2_ar1970_2010/centroids_coordinates.dbf", ///
	    clear case(lower)
	rename geolevel2 geolev2
	destring geolev2, replace
    merge 1:1 geolev2 using "../temp/departments_wide_panel.dta", nogen keep(3)
	
	keep if !missing(chg_log_urbpop_91_60)
	
	qui sum x
	local x_min = r(min)
	local x_max = r(max)
	
	qui sum y
	local y_min = r(min)
	local y_max = r(max)
	local max_dist = sqrt((`x_max' - `x_min')^2 + (`y_max' - `y_min')^2)
	
	local max_band = round(`max_dist')
	
	spatwmat, name(bilateral_distance_weights) xcoord(x) ycoord(y) band(0 `max_band')
	
	spatgsa chg_log_pop_91_60 chg_log_pop_91_70 chg_log_urbpop_91_60 ///
	    chg_tot_rails_86_60 chg_tot_rails_86_70 ///
		chg_pav_and_grav_86_54 chg_pav_and_grav_86_70 ///
		studied_larkin hypo_EUC_total_MST_kms hypo_LCP_total_MST_kms, ///
		weights(bilateral_distance_weights) moran
		
	local geo_vars "elev_mean_std rugged_mea_std wheat_std area_km2 dist_to_BA_std"
	
    foreach var in chg_log_pop_60_47 chg_log_pop_91_60 chg_log_pop_91_70 ///
	    chg_log_urbpop_60_47 chg_log_urbpop_91_60 ///
	    chg_tot_rails_86_60 chg_tot_rails_86_70 ///
		chg_pav_and_grav_86_54 chg_pav_and_grav_86_70 ///
		studied_larkin hypo_EUC_total_MST_kms hypo_LCP_total_MST_kms {
		
	    areg `var' `geo_vars', absorb(provname)
		predict `var'_resid, residuals
	}
	
    spatgsa chg_log_pop_91_60_resid chg_log_pop_91_70_resid chg_log_urbpop_91_60_resid ///
	    chg_tot_rails_86_60_resid chg_tot_rails_86_70_resid ///
		chg_pav_and_grav_86_54_resid chg_pav_and_grav_86_70_resid ///
		studied_larkin_resid hypo_EUC_total_MST_kms_resid hypo_LCP_total_MST_kms_resid, ///
		weights(bilateral_distance_weights) moran
		
	keep if !missing(chg_log_urbpop_60_47)
	spatwmat, name(bilateral_distance_weights) xcoord(x) ycoord(y) band(0 `max_band')

    spatgsa chg_log_pop_60_47 chg_log_urbpop_60_47 ///
	    chg_log_pop_60_47_resid chg_log_urbpop_60_47_resid, ///
		weights(bilateral_distance_weights) moran
end

main

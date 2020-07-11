clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../../derived/output/departments_wide_panel.dta"
    preclean_data
	
	run_regressions

	make_some_plots
end

program preclean_data
    drop if geolev2 == 32099999 /* Unkown location */
	drop if geolev2 == 238094004 /* Falkland Islands */
	drop if geolev2 == 239094003 /* Sandwhich Islands */
	
	drop if geolev2 == 32002001 /* City of Buenos Aires */
	drop if geolev2 == 32006001 /* La Plata */
	
	gen log_pop1991 = log(pop1991)
	gen log_pop1960 = log(pop1960) 
	gen chg_log_pop_91_60 = log_pop1991 - log_pop1960
	gen pop_chg_91_60 = pop1991 - pop1960
	
	gen log_urbpop1991 = log(urbpop1991)
	gen log_urbpop1960 = log(urbpop1960) 
	gen chg_log_urbpop_91_60 = log_urbpop1991 - log_urbpop1960
	gen urbpop_chg_91_60 = urbpop1991 - urbpop1960
	
	rename (roads54_type1 roads54_type2 roads54_type3 roads54_type4 ///
	    roads86_type1 roads86_type2 roads86_type3 roads86_type4) ///
		(paved_roads54 gravel_roads54 dirt_roads54 footprint_roads54 ///
		paved_roads86 gravel_roads86 dirt_roads86 footprint_roads86)
	
	gen tot_roads54 = paved_roads54 + gravel_roads54 + dirt_roads54 + footprint_roads54
	gen tot_roads86 = paved_roads86 + gravel_roads86 + dirt_roads86 + footprint_roads86
	gen tot_roads_chg_86_54 = tot_roads86 - tot_roads54
	
	gen pav_and_grav54 = paved_roads54 + gravel_roads54
	gen pav_and_grav86 = paved_roads86 + gravel_roads86
	gen pav_and_grav_chg_86_54 = paved_roads86 - paved_roads54

	gen paved_roads_chg_86_54 = paved_roads86 - paved_roads54
	
	gen tot_rails60 = status79_1 + status79_2 + status79_3
    gen tot_rails80s = status79_1
	gen tot_rails_chg_80s_60 = tot_rails80s - tot_rails60
end

program make_some_plots
    twoway (scatter tot_rails_chg tot_roads_chg) ///
	    (lfit tot_rails_chg tot_roads_chg), ///
	    graphregion(color(white)) bgcolor(white)
	twoway (scatter tot_rails_chg pav_and_grav_chg) ///
	    (lfit tot_rails_chg pav_and_grav_chg), ///
	    graphregion(color(white))bgcolor(white)
end

program run_regressions
    eststo clear
	
	eststo: reg chg_log_pop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60
	eststo: reg chg_log_pop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60 ///
	   elev_mean_std 
	eststo: reg chg_log_pop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60 ///
	   elev_mean_std dist_to_BA_std
	eststo: reg chg_log_urbpop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60
	eststo: reg chg_log_urbpop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60 ///
	   elev_mean_std
	eststo: reg chg_log_urbpop_91_60 pav_and_grav_chg_86_54 tot_rails_chg_80s_60 ///
	   elev_mean_std dist_to_BA_std 

	   	esttab *

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
	   
	esttab *
end 

main

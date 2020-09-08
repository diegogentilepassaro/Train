clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear
	
	make_some_plots
end

program make_some_plots
	twoway (scatter chg_tot_rails_86_60 chg_pav_and_grav_86_54) ///
	    (lfit chg_tot_rails_86_60 chg_pav_and_grav_86_54), ///
	    graphregion(color(white))bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads 1986-1960") ///
		xtitle("Change in kms of paved and gravel roads 1986-1954")
	graph export "../output/changes_railroads_roads_pav_and_grav.png", replace
		
	/*twoway (scatter chg_tot_rails_86_60 chg_paved_roads_86_54) ///
	    (lfit chg_tot_rails_86_60 chg_paved_roads_86_54), ///
	    graphregion(color(white))bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads 1986-1960") ///
		xtitle("Change in kms of paved roads 1986-1954")
	graph export "../output/changes_railroads_roads_paved.png", replace*/
end

main

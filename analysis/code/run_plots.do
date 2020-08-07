clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

program main
    use "../temp/departments_wide_panel.dta", clear
	
	make_some_plots
end

program make_some_plots
    twoway (scatter tot_rails_chg_80s_60 tot_roads_chg) ///
	    (lfit tot_rails_chg_80s_60 tot_roads_chg), ///
	    graphregion(color(white)) bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads") ///
		xtitle("Change in kms of all roads")
	graph export "../output/changes_railroads_roads_all.png", replace
		
	twoway (scatter tot_rails_chg_80s_60 pav_and_grav_chg) ///
	    (lfit tot_rails_chg_80s_60 pav_and_grav_chg), ///
	    graphregion(color(white))bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads") ///
		xtitle("Change in kms of paved and gravel roads")
	graph export "../output/changes_railroads_roads_pav_and_grav.png", replace
		
	twoway (scatter tot_rails_chg_80s_60 paved_roads_chg_86_54) ///
	    (lfit tot_rails_chg_80s_60 paved_roads_chg_86_54), ///
	    graphregion(color(white))bgcolor(white) ///
		legend(off) ytitle("Change in kms of railroads") ///
		xtitle("Change in kms of paved roads")
	graph export "../output/changes_railroads_roads_paved.png", replace
end

main

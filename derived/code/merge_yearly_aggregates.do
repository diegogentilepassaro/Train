clear all
adopath + ../../lib/stata/gslab_misc/ado

cd "/Users/dgentil1/Desktop/Diego/Train/derived/code"

program main
    merge_and_derive
end

 program merge_and_derive
    use "../../base/output/trains.dta", clear
    merge 1:1 year using "../../base/output/roads.dta", nogen
    merge 1:1 year using "../../base/output/maddison_ARG.dta", nogen
	*merge 1:1 year using "../../base/output/maddison_USA.dta", nogen
	merge 1:1 year using "../../base/output/gdp_shares.dta", nogen
	
	keep if year >=1855 & year <=1990
	
    gen real_gdp_pc_agric = real_gdp_per_cap_ARG*agriculture
	gen real_gdp_pc_ind = real_gdp_per_cap_ARG*industry
	
	label var real_gdp_pc_agric "Real GDP per capita - Agriculture"
	label var real_gdp_pc_ind "Real GDP per capita - Manufactures"

	tsset year
	
	save_data "../output/yearly_aggregates.dta", key(year) replace
end

* EXECUTE
main

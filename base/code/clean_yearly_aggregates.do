clear all
adopath + ../../lib/stata/gslab_misc/ado

cd "/Users/dgentil1/Desktop/Diego/Train/base/code"

program main
    import_and_clean_maddison, code(ARG)
	*import_and_clean_maddison, code(USA)
	import_roads
	import_trains
	import_gdp_shares
end

program import_and_clean_maddison
    syntax, code(string)
    use "../../raw_data/maddison/mpd2018.dta", clear

    keep if countrycode == "`code'"
    drop i_bm i_cig countrycode country rgd
	
	rename (cgdppc pop) (real_gdp_per_cap_`code' pop_`code')
	label var real_gdp_per_cap_`code' "Real GDP per capita - Total"
	label var pop_`code' "Population"

    save_data "../output/maddison_`code'.dta", key(year) replace
end

program import_roads
    import excel "../../raw_data/kms_road_arg/kmVia_DNV.xlsx", sheet("Sheet1") firstrow clear
    drop F G
	rename (Ano Pavimento Ripio Tierra) (year kms_paved_roads kms_gravel_roads kms_dirt_road)
	gen total_kms_road = kms_paved_roads + kms_gravel_roads
	label var total_kms_road "Total paved and gravel roads (Kms)"
    label var kms_paved_roads "Total paved roads (Kms)"
    label var kms_gravel_roads "Total gravel roads (Kms)"
    label var kms_dirt_road "Total dirt roads (Kms)"

	save_data "../output/roads.dta", key(year) replace
end

program import_trains
    import excel "../../raw_data/kms_train_arg/data_trains.xlsx", ///
        sheet("Sheet1") firstrow clear
	
    label var kms_rail "Total railroads (Kms)"
		
	save_data "../output/trains.dta", key(year) replace
end

program import_gdp_shares
    import excel "../../raw_data/gdp_shares_arg/GDP_shares.xlsx", ///
        sheet("Sheet2") firstrow clear
	
	drop Resto
	rename (Año Agricultura Explota Industr Electrici Construc Comerci Transport Intermedi Administra) ///
	    (year agriculture mining industry utilities construction commerce trsp_strg_comm finance_real_state public)
	
	ds year*, not
	
	foreach var in `r(varlist)' {
	replace `var' = `var'/100
	}
	
	drop if missing(year)
			
	save_data "../output/gdp_shares.dta", key(year) replace
end
 
* EXECUTE
main

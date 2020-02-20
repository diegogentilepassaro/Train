clear all
adopath + ../../lib/stata/gslab_misc/ado

cd "/Users/dgentil1/Desktop/Diego/Train/analysis/code"

program main
    use "../../derived/output/yearly_aggregates.dta", clear
    plot_yearly_aggregates
end

program plot_yearly_aggregates
	twoway (line kms_rail year, lcolor(navy) yaxis(1) ytitle("Network extension (Kms)", axis(1))) ///
		(line kms_paved_road year, lcolor(green) yaxis(1)) ///
		(line real_gdp_per_cap_ARG year, lcolor(red) yaxis(2) ytitle("GDP per capita (USD 2011)", axis(2))), ///
		legend(cols(1) rows(4) region(lwidth(none))) graphregion(color(white)) ///
		bgcolor(white) ///
		xline(1947 1983, lpattern(dash) lcolor(gs5)) ///
		xline(1962, lpattern(dash) lcolor(orange)) xtitle("Year") ///
		xline(1976 1983, lpattern(dash) lcolor(purple)) ///
		xlabel("1850 1870 1890 1910 1930 1950 1970 1990") ///
		text(35000 1962 "Larkin Plan", size(small) color(orange)) ///
		text(30000 1976 "Last dictatorship", size(small) color(purple)) ///
		text(25000 1947 "Railroads nationalization", size(small) color(gs5))
		
	graph export "../output/figure_1.png", replace

	keep if year >=1935 & year <=1990

	*(connected kms_dirt_road year, mcolor(red) msize(vsmall) lcolor(red))
	twoway (connected kms_rail year, mcolor(navy) msize(vsmall) ///
		lcolor(navy) ytitle("Network extension (Kms)", size(medium))) ///
		(connected kms_gravel_road year, mcolor(brown) msize(vsmall) lcolor(brown)) ///
		(connected kms_paved_road year, mcolor(green) msize(vsmall) lcolor(green)), ///
		legend(cols(2) rows(2) size(medium) region(lwidth(none))) graphregion(color(white)) ///
		bgcolor(white) 	ylabel(0(10000)50000, grid glwidth(medium) glcolor(gs14)) ///
		xline(1947 1983, lpattern(dash) lcolor(gs5)) ///   
		xline(1961, lpattern(dash) lcolor(orange)) xtitle("Year", size(medium)) ///
		xline(1976 1983, lpattern(dash) lcolor(purple)) ///
		xlabel("1935 1940 1945 1950 1955 1960 1965 1970 1975 1980 1985 1990") ///
		text(40000 1961 "Larkin Plan", size(medsmall) color(orange)) ///
		text(30000 1981 "Last dictatorship", size(medsmall) color(purple)) ///
		text(20000 1947 "Railroads nationalization", size(medsmall) color(gs5)) ///
		name(fig_2)
		
	graph export "../output/figure_2.png", replace

	twoway (connected pop_ARG year, mcolor(navy) msize(vsmall) ///
		lcolor(navy) yaxis(1) ytitle("Population (thousands)", size(medium) axis(1))) ///
		(connected real_gdp_per_cap_ARG year, mcolor(brown) msize(vsmall) ///
		lcolor(brown) yaxis(2) ytitle("Real GDP per capita (USD 2011)", size(medium) axis(2))) ///
		(connected real_gdp_pc_agric year, mcolor(green) msize(vsmall) ///
		lcolor(green) yaxis(2) ytitle("Real GDP per capita (USD 2011)", size(medium) axis(2))) ///
		(connected real_gdp_pc_ind year, mcolor(red) msize(vsmall) ///
		lcolor(red) yaxis(2) ytitle("Real GDP per capita (USD 2011)", size(medium) axis(2))), ///
		legend(cols(2) rows(2) size(medium) region(lwidth(none))) graphregion(color(white)) ///
		bgcolor(white) 	ylabel(0(4000)16000, axis(2)) ///
		xline(1947 1983, lpattern(dash) lcolor(gs5)) ///   
		xline(1961, lpattern(dash) lcolor(orange)) xtitle("Year") ///
		xline(1976 1983, lpattern(dash) lcolor(purple)) ///
		xlabel("1935 1940 1945 1950 1955 1960 1965 1970 1975 1980 1985 1990") ///
		text(28000 1961 "Larkin Plan", size(medsmall) color(orange)) ///
		text(24000 1981 "Last dictatorship", size(medsmall) color(purple)) ///
		text(33000 1947 "Railroads nationalization", size(medsmall) color(gs5)) ///
		name(fig_3)
		
	graph export "../output/figure_3.png", replace
		
	graph combine fig_2 fig_3, col(2) xsize(30) ysize(10) ///
		graphregion(color(white))
		
	graph export "../output/figure_2_and_3_comb.png", replace 
 end

* EXECUTE
main

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

	keep if year >=1940 & year <=1990

twoway (line kms_rail year, lcolor(navy) ytitle("Network extension (Kms)")) ///
    (line kms_gravel_road year, lcolor(brown)) ///
    (line kms_paved_road year, lcolor(green)), ///
	legend(cols(2) rows(2) region(lwidth(none))) graphregion(color(white)) ///
	bgcolor(white) 	ylabel(0(10000)50000, grid glwidth(medium) glcolor(gs14)) ///
	xline(1947 1983, lpattern(dash) lcolor(gs5)) ///   
	xline(1961, lpattern(dash) lcolor(orange)) xtitle("Year") ///
    xline(1976 1983, lpattern(dash) lcolor(purple)) ///
	xlabel("1940 1950 1960 1970 1980 1990") ///
	text(40000 1961 "Larkin Plan", size(small) color(orange)) ///
	text(30000 1981 "Last dictatorship", size(small) color(purple)) ///
	text(20000 1947 "Railroads nationalization", size(small) color(gs5))
	
    graph export "../output/figure_2.png", replace

twoway (line pop_ARG year, lcolor(navy) yaxis(1) ytitle("Population (thousands)", axis(1))) ///
    (line real_gdp_per_cap_ARG year, lcolor(brown) yaxis(2) ytitle("GDP per capita (USD 2011)", axis(2))) ///
    (line real_gdp_pc_agric year, lcolor(red) yaxis(2) ytitle("GDP per capita (USD 2011)", axis(2))) ///
    (line real_gdp_pc_ind year, lcolor(green) yaxis(2) ytitle("GDP per capita (USD 2011)", axis(2))), ///
	legend(cols(2) rows(4) region(lwidth(none))) graphregion(color(white)) ///
	bgcolor(white) 	ylabel(0(4000)16000, axis(2)) ///
	xline(1947 1983, lpattern(dash) lcolor(gs5)) ///   
	xline(1961, lpattern(dash) lcolor(orange)) xtitle("Year") ///
    xline(1976 1983, lpattern(dash) lcolor(purple)) ///
	xlabel("1940 1950 1960 1970 1980 1990") ///
	text(28000 1961 "Larkin Plan", size(small) color(orange)) ///
	text(24000 1981 "Last dictatorship", size(small) color(purple)) ///
	text(33000 1947 "Railroads nationalization", size(small) color(gs5))
	
    graph export "../output/figure_3.png", replace
 end

* EXECUTE
main

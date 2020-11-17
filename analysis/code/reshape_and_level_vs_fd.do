clear all

cd "/Users/diegog/Desktop/Diego/Train/analysis/code"

use "../temp/departments_wide_panel.dta", clear

keep geolev2 provname pop_1946 pop_1960 pop_1970 pop_1991 ///
    tot_rails_1960 tot_rails_1970 tot_rails_1986 ///
	pav_and_grav_1954 pav_and_grav_1970 pav_and_grav_1986 ///
	studied_larkin hypo_EUC_total_MST_kms hypo_LCP_total_MST_kms

rename (pop_1946 pop_1960 pop_1970 pop_1991 ///
    tot_rails_1960 tot_rails_1970 tot_rails_1986 ///
	pav_and_grav_1954 pav_and_grav_1970 pav_and_grav_1986) ///
    (pop0 pop1 pop2 pop3 ///
	tot_rails1 tot_rails2 tot_rails3 ///
	pav_and_grav1 pav_and_grav2 pav_and_grav3)

reshape long pop tot_rails pav_and_grav, i(geolev2) j(period)


foreach var in pop tot_rails pav_and_grav {
	gen log_`var' = log(`var')
	}

xtset geolev2 period 

eststo clear
eststo: qui reghdfe D.log_pop D.tot_rails D.pav_and_grav, absorb(period) nocons
eststo: qui ivreghdfe D.log_pop (D.tot_rails D.pav_and_grav = studied_larkin hypo_EUC_total_MST_kms), ///
    absorb(period)
eststo: qui ivreghdfe D.log_pop (D.tot_rails D.pav_and_grav = studied_larkin hypo_LCP_total_MST_kms), ///
    absorb(period)
esttab *, stats(r2 N)

drop if period == 3
eststo clear
eststo: qui reghdfe L.D.log_pop D.tot_rails D.pav_and_grav, absorb(period) nocons
eststo: qui ivreghdfe L.D.log_pop (D.tot_rails D.pav_and_grav = studied_larkin hypo_EUC_total_MST_kms), ///
    absorb(period)
eststo: qui ivreghdfe L.D.log_pop (D.tot_rails D.pav_and_grav = studied_larkin hypo_LCP_total_MST_kms), ///
    absorb(period)
esttab *, stats(r2 N)

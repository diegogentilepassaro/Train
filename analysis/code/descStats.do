clear all

program main
    use "../../derived/output/departments_wide_panel.dta"
    preclean_data
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

main

global depvar pop1960 pop1991 urbpop1960 urbpop1991
global control elev_mean rugged_mea dist_to_BA area_km2
global rail60 tot_rails60 statusLP_1 statusLP_2 statusLP_3 studied_0 studied_1
global rail80 tot_rails80s status79_1 status79_2 status79_3
global road54 tot_roads54  paved_roads54 gravel_roads54 dirt_roads54 footprint_roads54
global road86 tot_roads86 paved_roads86 gravel_roads86 dirt_roads86 footprint_roads86
global hyp hypomeanEMST_kms

label var tot_rails60 "railroads baseline kms - total"
label var tot_rails80s "railroads follow-up kms - total"
label var tot_roads54 "roads baseline kms - total"
label var tot_roads86 "roads follow-up kms - road"

label var pop1960 "population baseline"
label var urbpop1960 "urban population baseline"

label var pop1991 "population follow-up"
label var urbpop1991 "urban population follow-up"

estpost sum $depvar $control $rail60 $rail80 $road54 $road86 $hyp, listwise
esttab using "../output/descStats_1.tex", label replace ///
cells("mean(fmt(%12.0fc)) sd(fmt(%12.0fc)) min(fmt(%12.0fc)) max(fmt(%12.0fc))")  ///
title("Descriptive Statistics")

gen studsh=studied_1/tot_rails60

gen studied=(studsh>0.4 & studsh!=.)

iebaltab pop1960 urbpop1960 $control tot_rails60 tot_roads54, grpv(studied) ///
savet(../output/descStats_2.tex) replace rowv format(%12.0fc) grpl(0 "less than 40 per cent" @ 1 "more than 40 per cent")

gen hyp=1-(hypoCMST_kms==0)
iebaltab pop1960 urbpop1960 $control tot_rails60 tot_roads54, grpv(hyp) ///
savet(../output/descStats_3.tex) replace rowv format(%12.0fc) grpl(0 "no hyp. net." @ 1 "some hyp. net.")


iebaltab pop1960 urbpop1960 $control tot_rails60 tot_roads54, grpv(studied) ///
savet(../output/descStats_4.tex) replace rowv format(%12.0fc) grpl(0 "less than 40 per cent" @ 1 "more than 40 per cent") ///
fix(geolev1)

iebaltab pop1960 urbpop1960 $control tot_rails60 tot_roads54, grpv(hyp) ///
savet(../output/descStats_5.tex) replace rowv format(%12.0fc) grpl(0 "no hyp. net." @ 1 "some hyp. net.") ///
fix(geolev1)



foreach var of var pop1960 urbpop1960 $control tot_rails60 tot_roads54{
  plot `var' studsh
}

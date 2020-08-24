clear all
adopath + ../../lib/stata/gslab_misc/ado
use "../../derived/output/departments_wide_panel.dta", clear

do preclean_departments_wide.do

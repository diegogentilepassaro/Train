clear all
adopath + ../../lib/stata/gslab_misc/ado

program main
    import excel "../../raw_data/larkin_scores/larkin_plan.xlsx", ///
	    sheet("Sheet1") firstrow cellrange(A1:U544)

	rename id orig_segment_id
	gen segment_id = _n
	order segment_id
  keep if check=="1"
  drop A B
	save_data ../output/larkin_scores.dta, key(segment_id) replace
end

* EXECUTE
main

clear all
adopath + ../../lib/stata/gslab_misc/ado

program main
    import excel "../../raw_data/larkin_scores/larkin_plan_segments_master.xlsx", ///
	    sheet("Table14 y 15, consolidadas") firstrow cellrange(A1:Y626) 

	rename id orig_segment_id
	gen segment_id = _n
	order segment_id
	
	save_data ../output/larkin_scores.dta, key(segment_id) replace
end

* EXECUTE
main

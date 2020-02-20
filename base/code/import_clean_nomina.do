clear all
adopath + ../../lib/stata/gslab_misc/ado

program main
    import_nomina_sheet, sheet_name(FCCNA) cellrange(A6:AE255) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(fccna) notes_col(AE)
		
    import_nomina_sheet, sheet_name(CC TA TVR) cellrange(A6:AD98) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(cctatvr) notes_col(NO)

    import_nomina_sheet, sheet_name(SF CGBA RPB) cellrange(A6:AE132) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(sfcgbarpb) notes_col(AE)
		
    import_nomina_sheet, sheet_name(CBA ER NEA) cellrange(A6:AE137) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(cbaernea) notes_col(AE)
		
    import_nomina_sheet, sheet_name(FCS BBNO) cellrange(A6:AE269) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(fcsbbno) notes_col(AE)
		
    import_nomina_sheet, sheet_name(FCO) cellrange(A6:AD102) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(fco) notes_col(NO)

    import_nomina_sheet, sheet_name(BAP GOA) cellrange(A6:AH174) ///
	    dropcols(T U V W X Y) ///
		col_names(A B C D E F G H I J K L M N O P Q R S Z AA AB AC AD AE AF AG) ///
		name(bapgoa) notes_col(AH)
		
    import_nomina_sheet, sheet_name(FCCA) cellrange(A6:AD240) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(fcca) notes_col(NO)
		
    import_nomina_sheet, sheet_name(Patagonia) cellrange(A6:AD54) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(patagonia) notes_col(NO)
		
    import_nomina_sheet, sheet_name(BAM PBA) cellrange(A6:AE41) ///
	    dropcols(T U V) ///
		col_names(A B C D E F G H I J K L M N O P Q R S W X Y Z AA AB AC AD) ///
		name(bampba) notes_col(AE)
		
	use ../temp/nomina_fccna.dta, clear
	foreach name in cctatvr sfcgbarpb cbaernea fcsbbno fco bapgoa ///
	    fcca patagonia bampba {
		append using ../temp/nomina_`name'.dta
		}
		
	gen nomina_segment_id = _n
	order nomina_segment_id
	save_data ../output/nomina.dta, key(nomina_segment_id) replace
end 

program import_nomina_sheet
    syntax, sheet_name(str) cellrange(str) dropcols(str) col_names(str) ///
	    notes_col(str) name(str)
	
	import excel ../temp/damus/STATS/nomina.xls, ///
        sheet(`sheet_name') cellrange(`cellrange') clear
	
	drop `dropcols'
	
	if "`notes_col'" == "NO" {
	    gen notes = .
		tostring notes, replace
	}
	else {
	   rename `notes_col' notes
	}
	
	rename (`col_names') ///
	    (de a line_kms deviation_kms tot_kms concesion_law_nbr concesion_law_year ///
		concesion_law_day concesion_law_month construction_contract_year ///
		construction_contract_day construction_contract_month construction_company ///
		opening_decree_year opening_decree_day opening_decree_month opening_year ///
		opening_day opening_month closing_decree_nbr closing_decree_year ///
		closing_decree_day closing_decree_month lifting_decree_nbr ///
		lifting_decree_year lifting_decree_day lifting_decree_month)
	
	drop if (missing(concesion_law_nbr) & missing(concesion_law_year) ///
		& missing(concesion_law_day) & missing(concesion_law_month) ///
		& missing(construction_contract_year) & missing(construction_contract_day) ///
		& missing(construction_contract_month) & missing(construction_company) ///
		& missing(opening_decree_year) & missing(opening_decree_day) ///
		& missing(opening_decree_month) & missing(opening_year) ///
		& missing(opening_day) & missing(opening_month) & missing(closing_decree_nbr) ///
		& missing(closing_decree_year) & missing(closing_decree_day) ///
		& missing(closing_decree_month) & missing(lifting_decree_nbr) ///
		& missing(lifting_decree_year) & missing(lifting_decree_day) ///
		& missing(lifting_decree_month))
	
	drop if missing(de)
	gen total_row = (missing(a))
	
	cap tostring lifting_decree_nbr, replace
	cap tostring closing_decree_nbr, replace
	cap tostring concesion_law_nbr, replace
	
	
	cap destring line_kms, replace force
	cap destring deviation_kms, replace force
	cap destring tot_kms, replace force
	replace tot_kms = line_kms + deviation_kms ///
	    if (!missing(line_kms) & !missing(deviation_kms))
	replace tot_kms = line_kms ///
	    if (!missing(line_kms) & missing(deviation_kms))
	replace tot_kms = deviation_kms ///
	    if (missing(line_kms) & !missing(deviation_kms))	
	drop line_kms
	
	foreach stub_var in concesion_law construction_contract opening_decree ///
	    opening closing_decree lifting_decree {
		cap replace `stub_var'_year = strtrim(regexs(0)) if regexm(`stub_var'_year, "[0-9]+")
		cap destring `stub_var'_year, replace force
		*gen `stub_var'_date = mdy(`stub_var'_month, `stub_var'_day, `stub_var'_year)
		*format `stub_var'_date %td
	    drop `stub_var'_month `stub_var'_day
		}

	gen file = "`name'"
	
	order file de a total_row
	save ../temp/nomina_`name'.dta, replace
end

*EXECUTE
main

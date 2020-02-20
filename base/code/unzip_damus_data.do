clear all
adopath + ../../lib/stata/gslab_misc/ado

program main
	shell unzip ../../raw_data/damus/STATS.zip -d ../temp/damus
	shell unzip ../../raw_data/damus/ESTACION.zip -d ../temp/damus
	
	* The important among the unzipped files are STATS/EFEA.xls, STATS/Nomina.xls, and all the files under ESTACION/
end

*EXECUTE
main

clear all

cd "/Users/dgentil1/Desktop/Diego/Train/base/code"
* cd cote

shell rm -r ../output/
shell mkdir ../output

shell rm -r ../temp/
shell mkdir ../temp

do clean_yearly_aggregates.do
do import_larkin_scores.do
do unzip_damus_data.do
do import_clean_nomina.do

clear all

cap cd "/Users/diegog/Desktop/Diego/Train/base/code"
cap cd "C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\Train\base\code"

shell rm -r ../output/
shell mkdir ../output

do clean_yearly_aggregates.do
do import_larkin_scores.do
do clean_ipums.do
do import_c1960.do
do clean_agro1960.do
*do clean_agro1988.do
do clean_Economico1985.do
do clean_Industrial1954.do

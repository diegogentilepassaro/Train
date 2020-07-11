clear all

cd "/Users/diegog/Desktop/Diego/Train/base/code"
*cd "C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\__repoGitHub\base\code"

shell rm -r ../output/
shell mkdir ../output

do clean_yearly_aggregates.do
do import_larkin_scores.do
do clean_ipums.do
do import_c1960.do

clear all

cap cd "/Users/diegog/Desktop/Diego/Train/analysis/code"
*cap cd  "C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\__repoGitHub\analysis\code"

shell rm -r ../output/
shell mkdir ../output

do plot_yearly_aggregates.do
do preclean_departments_wide.do
*do descStats.do
do run_plots.do
do run_first_stage.do
do run_main_regressions.do
do run_interaction_regressions.do

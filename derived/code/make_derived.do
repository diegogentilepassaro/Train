clear all

cap cd "/Users/diegog/Desktop/Diego/Train/derived/code"
cap cd  "C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\__repoGitHub\derived\code"

adopath + ../../lib/stata/gslab_misc/ado

shell rm -r ../temp/
shell mkdir ../temp

shell rm -r ../output/
shell mkdir ../output



*Aggregates
do 001_merge_yearly_aggregates.do

*Geographical controls at district level
shell qgis-ltr-bin-g7 --code  101_geoControls_create_districts.py
do 					          102_geoControls_toStata
shell qgis-ltr-bin-g7 --code  002_create_hypo_networks.py
shell qgis-ltr-bin-g7 --code  103_infra_create_districts.py
do 					          104_infra_toStata
do                            201_merge_c1960_to_IPUMS.do
do                            202_merge_ag1960_to_IPUMS.do
do                            203_merge_in1954_to_IPUMS.do
do                            204_merge_ec1985_to_IPUMS.do
do                            205_merge_ag1988_to_IPUMS.do
do                            206_merge_popurb1946_to_IPUMS.do
do                            301_assembling

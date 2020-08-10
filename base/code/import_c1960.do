clear all

program de clean
  args a b
  import excel using "..\..\raw_data\censo1960\5_excel\1c1960_`a'_1.xlsx", clear first
  gen page=1
  forvalues i=2(1)`b'{
    preserve
    import excel using "..\..\raw_data\censo1960\5_excel\1c1960_`a'_`i'.xlsx", clear first
    gen page=`i'
    destring pop, replace
    tempfile aux
    save `aux', replace
    restore
    append using `aux'
  }
  keep distrito pop provincia page
  drop if distrito=="" & pop==. & provincia==""

  foreach var of var distrito provincia{
    replace `var' = subinstr(`var', ",", "",.)
    replace `var' = subinstr(`var', ".", "",.)
    replace `var' = subinstr(`var', "-", "",.)
    replace `var' = subinstr(`var', "'", "",.)
    replace `var' = subinstr(`var', "·", "",.)
    replace `var' = subinstr(`var', " ", "",.)
    replace `var' = upper(`var')
  }
end

program de repd
  args a b
  replace distrito="`a'" if distrito=="`b'"
end

*Part 2 - Capital Federal
import excel using "..\..\raw_data\censo1960\5_excel\1c1960_2.xlsx", clear first

gen provincia="CAPITALFEDERAL"
ren partido distrito
replace distrito=upper(distrito)


tempfile p2
save `p2', replace

*Part 3 - Buenos Aires and La Pampa

clean 3 8
tab provincia
assert provincia=="BUENOSAIRES" | provincia=="LAPAMPA"
replace distrito="AVELLANEDA" if distrito=="AVALLANEDA"
replace distrito="SANCAYETANO" if distrito=="18NSANCAYETANO"
replace distrito="BRANDSEN" if distrito=="BRANSEN" | distrito=="BRANDEN"
replace distrito="CARMENDEARECO" if distrito=="CARMENDEARACO" | distrito=="CARMRENDEARECO"
replace distrito="CHALILEO" if distrito=="CHALILES"
replace distrito="GENERALJMADARIAGA" if distrito=="GENERALJUANMADARIAGA" | distrito=="GENERALMADARIAGA" | distrito=="GENERALMADRIAGA"
replace distrito="GENERALCHAVES" if distrito=="GENERALCHAVEZ"
replace distrito="GUAMINI" if distrito=="GUAMANI"
replace distrito="LEANDRONALEM" if distrito=="LEANDROSALEM"
replace distrito="LINCOLN" if distrito=="LICOLN"
replace distrito="REALICO" if distrito=="REATICO"
replace distrito="SANANDRESDEGILES" if distrito=="SANANDRESDEGILESDE"
replace distrito="SANANTONIODEARECO" if distrito=="SANANTONIODEARACO"
replace distrito="SANNICOLAS" if distrito=="SANNICOLAN"
replace distrito="TRENQUELAUQUEN" if distrito=="TRANQUELAUQUEN"
replace distrito="UTRACAN" if distrito=="ULTRACAN"
replace distrito="EXALTACIONDELACRUZ" if distrito=="X&L�AC16NEXALTACIONDELACRUZ"
replace distrito="VILLARINO" if distrito=="VILLAMARINO" | distrito=="VILLARINAO"
replace distrito="GONZALEZCHAVES" if distrito=="GONZALEZCHAVEZ"
replace distrito="CASEROS" if distrito=="CASERES"
replace distrito="ROJAS" if distrito=="REJAS"
replace distrito="LOVENTUE" if distrito=="LEVENTUE"
replace distrito="RANCUL" if distrito=="RACUL"

*some special changes...
replace provincia="BUENOSAIRES" if distrito=="CASEROS" & provincia=="LAPAMPA"
/* De CASEROS- LAPAMPA a DIAREAUX - BUENOS AIRES

THERE IS ONLY ONE ROW WITH THE COMBINATION CASEROS - LAPAMPA
It CORRESPONDS TO A PLACE CALLED LA LARGA WHICH IS ACTUALLY IN BUENOS AIRES

I looked for this location in GIS, and there is only one localidad called
"la larga", located in the partido "Daireaux" in the provincia "Buenos Aires"

"Daireaux" is the new name of partido partido "Caseros". It changed in 1970.
https://es.wikipedia.org/wiki/Partido_de_Daireaux

For consistency, the change to the partido name was made in the corresponding
do-file in folder "derived"
*/

tab distrito

tempfile p3
save `p3', replace

*Part 4

clean 4 7

tab provincia
assert provincia=="CORDOBA" | provincia=="SANTAFE"

repd PUNILLA 1PUNILLA
repd CALAMUCHITA CALAMACHITA
repd CALAMUCHITA CALAMUCHITATA
repd CALAMUCHITA CALAZUCHITA
repd CASTELLANOS CASETELLANO
repd GENERALROCA GENERALBOCA
repd GENERALOBLIGADO IGENERALOBLIGADO
repd JUAREZCELMAN IJUAREZCELMAN
repd SANCRISTOBAL ISANCRISTOBAL
repd ISCHILIN ISCHILLIN
repd ISCHILIN IACHILIN
repd TERCEROARRIBA ITERCEROARRIBA
repd MARCOSJUAREZ MARCOJUAREZ
repd PRESIDENTEROQUESAENZPENA PRESIDENTEROQUEZSAENZPENA
repd PRESIDENTEROQUESAENZPENA PUENTEROQUESAENZPENA
repd PRESIDENTEROQUESAENZPENA PRESIDENTROQUESAENZPENA
repd PUNILLA PUNILLO
repd PUNILLA PUNTILLA
repd SANLORENZO SANLORENZOI
repd SANTAMARIA SANTAMARIAI
repd SANJAVIER SANJAVIERR
repd TERCEROARRIBA TERCEROARRIBAL
repd TERCEROARRIBA TERCEROARRRIBA
repd 9DEJULIO NUEVEDEJULIO

repd SANMARTIN SANMIGUEL
/*I had issues merging this observation. When looking at the source, I noticed
it is correctly scanned. Nervertheless, it is only one row corresponding to a
location called Piamonte. When I look for Piamonte-Santa Fe in google,
this refers to the SANMARTIN department. I confirmed this with GIS shapefiles */

tab distrito

tempfile p4
save `p4', replace

*Part 5 - Corrientes, Entre Rios, Misiones
clean 5 3
tab provincia
assert provincia=="CORRIENTES" | provincia=="ENTRERIOS" | provincia=="MISIONES"


repd LIBERTADORGENERALSANMARTIN BERTADORGENERALSANMARTIN
repd GUALEGUAY GUALAGUAY
repd GUALEGUAYCHU GUALEGUAYOBU
repd GUALEGUAYCHU GUALEGUYCHU
repd ITUZAINGO ITUZAINGU
repd LIBERTADORGENERALSANMARTIN LIBERTADORGENERARLSANMARTIN
repd VICTORIA VICTORIAI
repd VILLAGUAY VILLAGUAS
repd TALA TELA
repd SANTOTOME SANTOTOMAS
tab distrito

tempfile p5
save `p5', replace

*Part 6 - Chaco Formosa Santiago del Estero
clean 6 3
tab provincia
assert provincia=="CHACO" | provincia=="FORMOSA" | provincia=="SANTIAGODELESTERO"

repd ATAMISQUI ATAMIAQUI
repd LIBERTADORGENERALSANMARTIN LIBERALGENERALSANMARTIN
repd GENERALTABOADA NERALTABOADA
repd QUEBRACHOS BRACHOS

tab distrito

tempfile p6
save `p6', replace

*Part 7 - Catamarca, Jujuy, La Rioja, Salta, Tucuman
clean 7 4
tab provincia
assert provincia=="CATAMARCA" | provincia=="JUJUY" | provincia=="LARIOJA" | provincia=="SALTA" | provincia=="TUCUMAN"

repd BURRUYACU BURRUCUYU
repd BURRUYACU BURRUYACUJ
repd BURRUYACU BURRRUYACU
repd CAPAYAN CAPAYAM
repd CAPAYAN CARAYAN
repd CASTROBARROS CASTROPARRON
repd CHICLIGASTA CHICLIGASTAI
repd CHICLIGASTA CHICLIGASTE
repd HUMAHUACA HUMAHUACAI
repd LAVINA LAVINAI
repd ANTOFAGASTADELASIERRA NTOFAGASTADELASIERRA
repd FAMAILLA PAMAILLA
repd FAMAILLA PAMPILLA
repd METAN MATAN
repd PACLIN PAOLIN
repd POMAN POPAN
repd RINCONADA RINCONADA�
repd SUSQUES SUAQUES
repd SUSQUES SUSQUES+
repd VELEZSARSFIELD VELESSARSFIELD
repd LACALDERA CALDERA
repd GOBERNADORGORDILLO GENERALGORDILLO



tab distrito

tempfile p7
save `p7', replace

*Part 8 - Mendoza, San Juan, San Luis
clean 8 2

assert provincia=="MENDOZA" | provincia=="SANJUAN" | provincia=="SANLUIS"
repd CAUCETE CAUCETEL

tab distrito

tempfile p8
save `p8', replace

*Part 9 - CHUBUT, NEUQUEN, RIONEGRO, SANTACRUZ, TIERRADELFUEGO
clean 9 2

assert provincia=="CHUBUT" | provincia=="NEUQUEN" | provincia=="RIONEGRO" ///
| provincia=="SANTACRUZ" | provincia=="TIERRADELFUEGO"

repd ADOLFOALSINA ADOLFOALSINAS
repd RIOSENGUER RIOSENGUERR
repd RIOSENGUER RIOSENGUERRR
repd TEHUELCHES TAHUELCHES

tab distrito

tempfile p9
save `p9', replace

*APPENDING

use `p2'
append using `p3'
append using `p4'
append using `p5'
append using `p6'
append using `p7'
append using `p8'
append using `p9'

drop page

*COLLAPSING + URBANIZATION CALCULATION

*1 observation for city of buenos Aires
replace distrito="CITYOFBUENOSAIRES" if provincia=="CAPITALFEDERAL"

gen urban=(pop>2000)
collapse (sum) pop, by(provincia distrito urban)




gen g="-"
egen x=concat(provincia g distrito)
encode x, g(id)
drop g x

reshape wide pop, i(id) j(urban)

recode pop0 (.=0)
recode pop1 (.=0)

ren pop0 rur
ren pop1 urb
gen pop = rur + urb

label var rur "rural population"
label var urb "urban population"
label var pop "total population"
label var distrito "distrito o partido"
gen year=1960

order id provincia distrito pop urb rur

save_data "..\output\c1960_urb.dta", replace key(id)

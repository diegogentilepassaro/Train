clear all

*I. CLEAN NAMES AND RESHAPE IPUMS DATA
use "..\temp\ip.dta", replace
tempfile ip
save `ip', replace
desc

*II. OPEN DATA CENSUS 1960 AND ACCOMODATE NAMES
/*
-WHEN IT IS A MATTER OF SPELLING, THERE IS NO EXPLANATION IN THE CHANGE.
-WHEN IT IS A MATTER OF CHANGE OF NAME, THERE IS AN EXPLANATION.
 */

use "..\..\base\output\eco1985.dta"

drop if provincia=="CAPITALFEDERAL"

gen provmerge=provincia
gen distmerge=distrito

*accomodating spelling
program de clean
  args a b p
  replace distmerge="`a'" if distmerge=="`b'" & provmerge=="`p'"
end

local pr = "BUENOSAIRES"
clean TRESDEFEBRERO 3DEFEBRERO `pr'
clean ARRECIFES BARTOLOMEMITRE `pr'
/*change of name. source:
https://es.wikipedia.org/wiki/Arrecifes_(Argentina)
*/
clean ALMIRANTEBROWN ALTEBROWN `pr'
clean CORONELDEMARINELROSALES CNELDEMARINALEONARDOROSALES `pr'
clean CORONELDEMARINELROSALES CNELDEMARINALROSALES `pr'
clean ADOLFOGONZALEZCHAVES ADOLFOGONZALESCHAVES `pr'
clean GENERALJUANMADARIAGA GENERALJMADARIAGA `pr'
clean GENERALJUANMADARIAGA GENERALMADARIAGA `pr'
clean DAIREAUX CASEROS `pr'
/* Change of name. source:
https://es.wikipedia.org/wiki/Partido_de_Daireaux
*/
clean BENITOJUAREZ JUAREZ `pr'
clean LAMATANZA MATANZA `pr'
clean 25DEMAYO VEINTICINCODEMAYO `pr'
clean 9DEJULIO NUEVEJULIO  `pr'
clean LEANDRONALEM LEANDRON `pr'
clean LOMASDEZAMORA LOMASDE `pr'
clean CARMENDEARECO CARMENDEARAUCO `pr'
clean TORNQUIST TORQUINST `pr'
clean BRANDSEN CORONELBRANDSEN `pr'
clean LACOSTA MUNICIPIOURBANODELACOSTA `pr'
clean MONTEHERMOSO MUNICIPIOURBANODEMONTEHERMOSO `pr'
clean PINAMAR MUNICIPIOURBANODEPINAMAR `pr'
clean VILLAGESELL MUNICIPIOURBANODEVILLAGESELL `pr'
clean SALLIQUELO SALIQUELO `pr'


local pr = "CATAMARCA"
clean FRAYMAMERTOESQUIU FRAYMAMERTO `pr'

local pr = "CHACO"

clean 12DEOCTUBRE DOCEDEOCTUBRE `pr'
clean 1DEMAYO PRIMERODEMAYO `pr'
clean 25DEMAYO VEINTICINCODEMAYO `pr'
clean 9DEJULIO NUEVEDEJULIO  `pr'
clean FRAYJUSTOSTAMARIADEORO FRAYJUSTOSANTAMARIADEORO  `pr'
clean OHIGGINS CAPITANGENERALOHIGGINS `pr'
clean OHIGGINS CAPITALGENERALOHIGGINS `pr'
clean TAPENAGA TAPEGANA `pr'

clean ALMIRANTEBROWN ALTEBROWN `pr'
clean LIBERTADORGENERALSANMARTIN LIBGENERALSANMARTIN `pr'
clean COMANDANTEFERNANDEZ CMDTEFERNANDEZ `pr'
clean OHIGGINS O'HIGGINS `pr'
clean PRESIDENCIADELAPLAZA PTEDELAPLAZA `pr'


local pr = "CHUBUT"
replace provmerge = "CHUBUT" if provmerge=="ZONAMILITARDECOMODORORIVADAVIA"


clean DESEADO LASHERAS CHUBUT
clean DESEADO PICOTRUNCADO CHUBUT
replace provmerge="SANTACRUZ" if distmerge=="DESEADO" & provmerge=="CHUBUT"

/* LAS HERAS, DESEADO y PICOTRUNCADO en ZONAMILITARDECOMODORORIVADAVIA (aqui habiamos cambiado a chubut)
corresponden hoy a DESEADO - SANTACRUZ
https://es.wikipedia.org/wiki/Departamento_Las_Heras_(Zona_Militar_de_Comodoro_Rivadavia)
https://es.wikipedia.org/wiki/Departamento_Pico_Truncado
https://es.wikipedia.org/wiki/Departamento_Deseado
*/


clean PASODELOSINDIOS PASODEINDIOS `pr'
clean RIOSENGUER ALTORIOSENGUER `pr'
clean RIOSENGUER RIOSENGUERR `pr'

replace provmerge="SANTACRUZ" if provmerge=="CHUBUT" & distmerge=="LAGOBUENOSAIRES"

/*
CAMBIO DE PROVINCIA DESDE 1955
https://es.wikipedia.org/wiki/Departamento_Lago_Buenos_Aires
*/

clean RIOSENGUER PASORIOMAYO `pr'

/*
PASORIOMAYO ocupaba territorios del actual RIOSENGUER
https://es.wikipedia.org/wiki/Departamento_Alto_R%C3%ADo_Mayo

*/

local pr = "CORDOBA"
clean GENERALSANMARTIN GRALSANMARTIN `pr'
clean PRESIDENTEROQUESAENZPENA PTEROQUESAENZPENA `pr'


local pr = "ENTRERIOS"
clean URUGUAY CONCEPCIONDELURUGUAY `pr'
clean TALA ROSARIOTALA `pr'

local pr = "FORMOSA"
clean RAMONLISTA RAMONLISTA `pr'

local pr = "JUJUY"
clean DRMANUELBELGRANO CAPITAL `pr'


/* La capital de jujuy es San Salvador de Jujuy. Esta se ubica en el distrito
Doctor Manuel Belgrano
*/

local pr = "LAPAMPA"
clean LEVENTUE LOVENTUE `pr'
clean LEVENTUE LOVENTUEL `pr'
clean CONHELLO CONHELO `pr'

local pr = "LARIOJA"
clean CORONELFELIPEVARELA GENERALLAVALLE `pr'
clean ROSARIOVERAPENALOZA GENERALROCA `pr'
clean CHAMICAL GOBERNADORGORDILLO `pr'
clean CHAMICAL GENERALGORDILLO `pr'
clean VINCHINA GENERALSARMIENTO `pr'
clean VINCHINA SARMIENTO `pr'
clean GENERALJUANFQUIROGA RIVADAVIA `pr'
clean GENERALANGELVPENALOZA VELEZSARFIELD `pr'
clean GENERALSANMARTIN SANMARTIN `pr'
clean GENERALANGELVPENALOZA GRALANGELVPENALOZA `pr'
clean GENERALJUANFQUIROGA GRALJUANFQUIROGA `pr'
clean GENERALMANUELBELGRANO GRALBELGRANO `pr'
clean LIBERTADORGENERALSANMARTIN LIBGRALSANMARTIN `pr'


/*la rioja changes of names
source:
https://es.wikipedia.org/wiki/Anexo:Municipios_de_La_Rioja_(Argentina)
https://es.wikipedia.org/wiki/Departamento_General_%C3%81ngel_V._Pe%C3%B1aloza
*/


local pr = "MENDOZA"
clean LUJANDECUYO LUJAN `pr'

local pr = "MISIONES"
clean GENERALMANUELBELGRANO FRONTERA  `pr'

/*
cabecera de BELGRANO es IRIGOYEN
IRIGOYEN era parte de FRONTERA en 1947.
Frontera ya no existe mas.
https://es.wikipedia.org/wiki/Departamento_General_Manuel_Belgrano
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_2.pdf

*/

clean GENERALMANUELBELGRANO GRALMBELGRANO `pr'
clean LIBERTADORGENERALSANMARTIN LIBGRALSANMARTIN `pr'

list if provmerge=="MISIONES"

local pr = "RIONEGRO"
clean CONESA GENERALCONESA `pr'
clean 25DEMAYO VEINTICINCODEMAYO `pr'

local pr = "NEUQUEN"
clean PEHUENCHES PEHENCHES `pr'

local pr = "SALTA"
clean GENERALJOSEDESANMARTIN SANMARTIN `pr'
clean GENERALGUEMES GENERALMARTINMIGUELDEGUEMES  `pr'
clean GENERALGUEMES GENERALMARTINMDEGUEMES `pr'
clean LACANDELARIA CANDELARIA `pr'
clean LACALDERA CALDERA `pr'
clean ANTA ANTE `pr'
clean GENERALJOSEDESANMARTIN GRALJDESANMARTIN `pr'
clean CAPITAL LACAPITAL `pr'
clean ROSARIODELERMA ROSARIODELEPMA `pr'
clean GOBERNADORDUPUY GDORDUPUY `pr'
clean LIBERTADORGENERALSANMARTIN LIBGRALSANMARTIN `pr'



local pr = "SANJUAN"
clean 25DEMAYO VEINTICINCODEMAYO `pr'
clean 9DEJULIO NUEVEDEJULIO `pr'
clean IGLESIA IGLESIAS `pr'
clean ULLUM ULLUN `pr'

local pr = "SANLUIS"
clean LIBERTADORGENERALSANMARTIN SANMARTIN `pr'
clean LIBERTADORGENERALSANMARTIN LIBGRALSANMARTIN `pr'
clean CORONELPRINGLES PRINGLES `pr'
clean GOBERNADORDUPUY GOBERNADORVICENTEDUPUY `pr'
clean BELGRANO GENERALBELGRANO `pr'
clean GOBERNADORDUPUY GDORDUPUY `pr'

local pr = "SANTAFE"
clean 9DEJULIO NUEVEDEJULIO `pr'

local pr = "SANTIAGODELESTERO"
clean QUEBRACHOS QUEBRACHO `pr'
clean JUANFIBARRA MATARA `pr'
/*
changed name. source:
https://es.wikipedia.org/wiki/Departamento_Juan_Felipe_Ibarra
*/
clean GENERALTABOADA GENERALATABOADA `pr'

clean JUANFIBARRA BRIGJFELIPEIBARRA `pr'

local pr = "TIERRADELFUEGO"
clean RIOGRANDE SANSEBASTIAN `pr'
/*cambio de nombre : fuente
https://es.wikipedia.org/w/index.php?title=Anexo:Departamentos_de_la_provincia_de_Tierra_del_Fuego,_Ant%C3%A1rtida_e_Islas_del_Atl%C3%A1ntico_Sur&oldid=120854475
*/

local pr = "TUCUMAN"
clean GRANERO GRANEROS `pr'
clean TAFIDELVALLE TAFI `pr'

/* TAFI VIEJO fue segregado del antiguo departamento de TAFI.
en la wiki de TAFI DEL VALLE, se refieren a TAFI.
la asignacion no es perfecta, pero es suficiente para la agregacion que hace
IPUMS (chequeado en GIS)
source:
https://es.wikipedia.org/wiki/Departamento_Taf%C3%AD_Viejo
https://es.wikipedia.org/wiki/Departamento_Taf%C3%AD_del_Valle
*/

clean BURRUYACU BURRUCAYU `pr'
clean JUANBAUTISTAALBERDI JUANBALBERDI `pr'
clean TAFIVIAJO TAFIVIEJO `pr'
clean CAPITAL SANMIGUELDETUCUMAN `pr'

/*
SANMIGUELDETUCUMAN es capital provinciales
https://es.wikipedia.org/wiki/San_Miguel_de_Tucum%C3%A1n
*/



*III. FIRST ATTEMPT: merging using corrected names
merge 1:1 provmerge distmerge using `ip'
sort provmerge distmerge

sort _merge
list provmerge distmerge _merge if _merge!=3
tempfile a
save `a', replace


*IV. CHECK 1
/*Every obs with _merge==2 has a geolev2 value. Let A be this set of values .
Since geolev2 value is what matters at the end of the day, it is sufficient for
us to check that for every value in A, there is at least one observation with
_merge==3. Then, we can discard from A obs with __merge for which this condition is
true.

*/

preserve
keep if _merge==2
list provmerge distmerge geolev2
keep geolev2
duplicates drop
tempfile b
save `b', replace

restore
keep if _merge==3
drop _merge
merge n:1 geolev2 using `b'
list if _merge==2
keep if _merge==3
keep geolev2
gen __merge=2
duplicates drop
tempfile c
save `c', replace

use `a'
ren _merge __merge
merge m:1 geolev2 __merge using `c'
assert _merge!=2
drop if _merge==3
drop _merge
ren __merge _merge
tempfile d
save `d'


*V. MANUAL MERGE 1
/*matching in IPUMS that were not found in econ1954 after
checking name changes

*those are (should be) districts created after 1954

* Obs corresponding to TIERRA DEL FUEGO + CITYOFBUENOSAIRES
are ignored.  SEE LINE 250
*/


assert _merge!=2 if provmerge!="CAPITALFEDERAL"
drop if provmerge =="CAPITALFEDERAL"

*VI. MANUEL MERGE 2
/*matching the unmatched from indus1954
I print the list on the screen and go one for one
when changing names was sufficient I implemented the modification wherever
it corresponds. In import_c1960.do if it is required before aggregating at the
departamento level. Or in this do-file if not. All these changes have a note below
*/
assert _merge!=1







*VII. Aggregation
/* The unit of analysis is the departamento as defined by IPUMS

There are three type of matches

- 1 to 1 (no problem)
- many econ 1985 to 1 ipums (just sum by ipums)
- 1 econ 1985 to many ipums (there are no cases of this)

 */

duplicates tag, g(t)
assert t==0
drop t

isid provincia distrito districtIPUMS

gen a = 1
egen x=count(a), by(provincia distrito)

assert x==1
drop x a


collapse (sum) nestab npers massal valprod1 valprod2, by(geolev2)

gen year=1985

save_data "..\temp\ec1985_ipums.dta", replace key(geolev2)

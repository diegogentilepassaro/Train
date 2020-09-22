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

use "..\..\base\output\indus1954.dta"
gen provmerge=provincia
gen distmerge=distrito

*accomodating spelling
program de clean
  args a b p
  replace distmerge="`a'" if distmerge=="`b'" & provmerge=="`p'"
end

local pr = "BUENOSAIRES"
*clean TRESDEFEBRERO 3DEFEBRERO `pr'
clean ARRECIFES BARTOLOMEMITRE `pr'
/*change of name. source:
https://es.wikipedia.org/wiki/Arrecifes_(Argentina)
*/
*clean CORONELDEMARINELROSALES CNELDEMARINALEONARDOROSALES `pr'
clean CORONELDEMARINELROSALES CNELDEMARINALROSALES `pr'
clean ADOLFOGONZALEZCHAVES GONZALEZCHAVES `pr'
*clean GENERALJUANMADARIAGA GENERALJMADARIAGA `pr'
clean GENERALJUANMADARIAGA GENERALMADARIAGA `pr'
clean DAIREAUX CASEROS `pr'
/* Change of name. source:
https://es.wikipedia.org/wiki/Partido_de_Daireaux
*/
clean BENITOJUAREZ JUAREZ `pr'
*clean LAMATANZA MATANZA `pr'
clean 25DEMAYO VEINTICINCODEMAYO `pr'
clean 9DEJULIO NUEVEJULIO  `pr'
clean LEANDRONALEM LEANDRON `pr'
clean LOMASDEZAMORA LOMASDE `pr'
clean CARMENDEARECO CARMENDEARAUCO `pr'
clean TORNQUIST TORQUINST `pr'
clean BRANDSEN CORONELBRANDSEN `pr'


local pr = "CATAMARCA"
clean FRAYMAMERTOESQUIU FRAYMAMERTO `pr'

local pr = "CHACO"

clean 12DEOCTUBRE DOCEDEOCTUBRE `pr'
clean 1DEMAYO PRIMERODEMAYO `pr'
clean 25DEMAYO VEINTICINCODEMAYO `pr'
clean 9DEJULIO NUEVEDEJULIO  `pr'
clean FRAYJUSTOSTAMARIADEORO FRAYJUSTOSANTAMARIADEORO  `pr'
*clean OHIGGINS CAPITANGENERALOHIGGINS `pr'
clean OHIGGINS CAPITALGENERALOHIGGINS `pr'
clean TAPENAGA TAPEGANA `pr'

local pr = "CHUBUT"
replace provmerge = "CHUBUT" if provmerge=="ZONAMILITARDECOMODORORIVADAVIA"


expand 2 if distmerge=="CAMARONES" & provmerge=="CHUBUT", g(x)
tab x
replace distmerge="ESCALANTE" if distmerge=="CAMARONES" & provmerge=="CHUBUT" & x==0
replace distmerge="FLORENTINOAMEGHINO" if distmerge=="CAMARONES" & provmerge=="CHUBUT" & x==1
drop x

/*
CAMARONES comprendia territorios de los actuales ESCALANTE y FLORENTINO AMEGHINO
https://es.wikipedia.org/wiki/Departamento_Camarones
*/

expand 2 if distmerge=="COMODORORIVADAVIA" & provmerge=="CHUBUT", g(x)
tab x
replace distmerge="ESCALANTE" if distmerge=="COMODORORIVADAVIA" & provmerge=="CHUBUT" & x==0
replace distmerge="DESEADO" if distmerge=="COMODORORIVADAVIA" & provmerge=="CHUBUT" & x==1
replace provmerge="SANTACRUZ" if distmerge=="DESEADO" & provmerge=="CHUBUT" & x==1
drop x

/*
COMODORO RIVADAVIA ocupaba territorios que hoy son de ESCALANTE (CHUBUT) y
DESEADO (SANTACRUZ)
https://es.wikipedia.org/wiki/Departamento_Comodoro_Rivadavia
*/

clean DESEADO LASHERAS CHUBUT
clean DESEADO PICOTRUNCADO CHUBUT
replace provmerge="SANTACRUZ" if distmerge=="DESEADO" & provmerge=="CHUBUT"

/* LAS HERAS, DESEADO y PICOTRUNCADO en ZONAMILITARDECOMODORORIVADAVIA (aqui habiamos cambiado a chubut)
corresponden hoy a DESEADO - SANTACRUZ
https://es.wikipedia.org/wiki/Departamento_Las_Heras_(Zona_Militar_de_Comodoro_Rivadavia)
https://es.wikipedia.org/wiki/Departamento_Pico_Truncado
https://es.wikipedia.org/wiki/Departamento_Deseado
*/


*clean PASODELOSINDIOS PASODEINDIOS `pr'
clean RIOSENGUER ALTORIOSENGUER `pr'

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

local pr = "ENTRERIOS"
*clean URUGUAY CONCEPCIONDELURUGUAY `pr'
*clean TALA ROSARIOTALA `pr'

local pr = "FORMOSA"
*clean RAMONLISTA RAMONLISTA `pr'

local pr = "JUJUY"
clean DRMANUELBELGRANO CAPITAL `pr'


/* La capital de jujuy es San Salvador de Jujuy. Esta se ubica en el distrito
Doctor Manuel Belgrano
*/

local pr = "LAPAMPA"
*clean LEVENTUE LOVENTUE `pr'
clean LEVENTUE LOVENTUEL `pr'


local pr = "LARIOJA"
clean CORONELFELIPEVARELA GENERALLAVALLE `pr'
clean ROSARIOVERAPENALOZA GENERALROCA `pr'
clean CHAMICAL GOBERNADORGORDILLO `pr'
*clean VINCHINA GENERALSARMIENTO `pr'
clean VINCHINA SARMIENTO `pr'
*clean GENERALJUANFQUIROGA RIVADAVIA `pr'
clean GENERALANGELVPENALOZA VELEZSARFIELD `pr'
clean GENERALSANMARTIN SANMARTIN `pr'

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

list if provmerge=="MISIONES"

local pr = "RIONEGRO"
*clean CONESA GENERALCONESA `pr'
clean 25DEMAYO VEINTICINCODEMAYO `pr'

local pr = "SALTA"
clean GENERALJOSEDESANMARTIN SANMARTIN `pr'
*clean GENERALGUEMES GENERALMARTINMIGUELDEGUEMES  `pr'
clean GENERALGUEMES GENERALMARTINMDEGUEMES `pr'
clean LACANDELARIA CANDELARIA `pr'
clean LACALDERA CALDERA `pr'
clean ANTA ANTE `pr'


local pr = "SANJUAN"
clean 25DEMAYO VEINTICINCODEMAYO `pr'
*clean 9DEJULIO NUEVEDEJULIO `pr'
clean IGLESIA IGLESIAS `pr'
clean ULLUM ULLUN `pr'

local pr = "SANLUIS"
clean LIBERTADORGENERALSANMARTIN SANMARTIN `pr'
*clean CORONELPRINGLES PRINGLES `pr'
*clean GOBERNADORDUPUY GOBERNADORVICENTEDUPUY `pr'
clean BELGRANO GENERALBELGRANO `pr'

local pr = "SANTAFE"
clean 9DEJULIO NUEVEDEJULIO `pr'

local pr = "SANTIAGODELESTERO"
*clean QUEBRACHOS QUEBRACHO `pr'
clean JUANFIBARRA MATARA `pr'
/*
changed name. source:
https://es.wikipedia.org/wiki/Departamento_Juan_Felipe_Ibarra
*/
clean GENERALTABOADA GENERALATABOADA `pr'

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




*III. FIRST ATTEMPT: merging using corrected names
merge m:1 provmerge distmerge using `ip'
sort provmerge distmerge
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

/*matching in IPUMS that were not found in indus1954 after
checking name changes

*those are (should be) districts created after 1954

* Obs corresponding to TIERRA DEL FUEGO + CITYOFBUENOSAIRES
are ignored.  SEE LINE 250
*/

list provmerge distmerge _merge if _merge!=3

list provmerge distmerge if _merge==2

keep provmerge distmerge geolev2 provname districtIPUMS

expand 2 if distmerge=="ESCOBAR" & provmerge=="BUENOSAIRES", g(x)
tab x
replace distmerge="PILAR" if distmerge=="ESCOBAR" & provmerge=="BUENOSAIRES" & x==0
replace distmerge="TIGRE" if distmerge=="ESCOBAR" & provmerge=="BUENOSAIRES" & x==1
drop x
/* segregated in 1959 from PILAR y TIGRE.
https://es.wikipedia.org/wiki/Partido_de_Escobar#Elecciones_en_la_d%C3%A9cada_de_1970_y_1960
https://es.wikipedia.org/wiki/Bel%C3%A9n_de_Escobar
*/

 clean LAPLATA BERISSO BUENOSAIRES

/* segregated in 1957 from LA PLATA
https://es.wikipedia.org/wiki/Partido_de_Berisso
*/

clean LAPLATA ENSENADA BUENOSAIRES
/*
Ensenada limita con LAPLATA, BERAZATEGUI y BERISSO. Sabemos que BERISSO pertenecia a la plata.
https://es.wikipedia.org/wiki/Ensenada_(Buenos_Aires)
Ademas, Ensenada es mencionada en la historia de Berisso, como dependiente la plata en 1882.
https://es.wikipedia.org/wiki/Partido_de_Berisso
*/

clean GENERALSANMARTIN TRESDEFEBRERO BUENOSAIRES
/* segregated from. GENERALSANMARTIN:
https://es.wikipedia.org/wiki/Partido_de_Tres_de_Febrero
*/


clean QUILMES BERAZATEGUI BUENOSAIRES


*CHUBUT

/*
ESCALANTE no aparece en ind1954 aunque existia con el nombre de pico salamanca.
segun la descripcion de abajo, probablamente no aparece pq no habia industria en
el lugar.

lo que esta en brackets [] no se implemento finalmente. tras hacer el ajuste de
nombre a otras provincias, no fue necesario

[Parece seguro asumir valores 0. Esta modificacion se hace en lineas 392-398]

"Con el mismo objetivo se buscó desarrollar nuevas zonas y se creó el
Departamento de Pico Salamanca, donde se pensaba fundar al menos una localidad,
este departamento actualmente no existe, sus territorios hoy pertenecen al
Departamento Escalante y su territorio aún sin poblarse,
a excepción del caserío de Pampa Salamanca. "
FUENTE: https://es.wikipedia.org/wiki/Zona_Militar_de_Comodoro_Rivadavia#Divisi%C3%B3n_administrativa
*/


clean BERMEJO RAMONLISTA FORMOSA
clean BERMEJO MATACOS FORMOSA
/*
Dada la ubicacion geografica y los limites provinciales,
asumo que Rmon Lista y Matacos pertenecian a BERMEJO

https://es.wikipedia.org/wiki/Departamento_Ram%C3%B3n_Lista
https://es.wikipedia.org/wiki/Departamento_Matacos
*/

clean PATINO BERMEJO FORMOSA
/*
due to adjustments in "part IV. CHECK 1" I adjust name of department from BERMEJO
to PATINO. Notice below: they have the same number in geolev2 (relevant identifier).
------------------------------------------
geolev2	provname	districtIPUMS	provmerge
32034004	FORMOSA	BERMEJO	FORMOSA
32034004	FORMOSA	PATINO	FORMOSA
*/

clean CANDELARIA OBERA MISIONES
/*
EN 1947,
OBERA ERA PARTE DE CANDELARIA
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_1.pdf
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_2.pdf
*/
clean IGUAZU ELDORADO MISIONES
/*
EN 1947,
ELDORADO ERA PARTE DE IGUAZU
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_1.pdf
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_2.pdf
*/


clean CAINGUAS LIBERTADORGENERALSANMARTIN MISIONES

/*
cabecera de LIBERTADORGENERALSANMARTIN es PUERTORICO

EN 1947,
PUERTORICO ERA PARTE DE CAINGUAS
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_1.pdf
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_2.pdf

*/



clean SANPEDRO MONTECARLO MISIONES
/*
EN 1947,
MONTECARLO ERA PARTE DE SANPEDRO
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_1.pdf
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_2.pdf
*/

clean SANJAVIER 25DEMAYO MISIONES

/*
cabecera de SANJAVIER 25DEMAYO es ALBAPOSSE
https://es.wikipedia.org/wiki/Provincia_de_Misiones
EN 1947,
COLONIA ALBAPOSSE ERA PARTE DE SANJAVIER
https://biblioteca.indec.gob.ar/bases/minde/1c1947x4_2.pdf
*/

tempfile seg
save `seg', replace

use `d'
drop if _merge==2
ren _merge __merge

merge m:n provmerge distmerge using `seg', replace update

keep if provmerge!="TIERRADELFUEGO" & provmerge!="CITYOFBUENOSAIRES" & provmerge!="CAPITALFEDERAL"

assert (_merge==3 | _merge==5)
/*
assert (_merge==3 | _merge==5) if distmerge!="ESCALANTE"
assert _merge==2 if distmerge=="ESCALANTE"
 exception for ESCALANTE is explained in LINE 299

foreach var of var nestab nemp nobr massal valprod{
  replace `var'=0 if distmerge=="ESCALANTE" & provmerge=="CHUBUT"
}
*/


drop _merge
ren __merge _merge



tempfile e
save `e', replace

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
- many agro 1960 to 1 ipums (just sum by ipums)
- 1 agro 1960 to many ipums

*THE CASE OF QUILMES appears in every census of 1960 to it has a special solution
----It is divided in 2/3 and 1/3. This is very roughly their population proportions today

*FOR THE REST, I DIVIDE EQUALLY IN THE NUMBER OF CORRESPONDING DISTRICTS
 */

*common case: all but Quilmes

duplicates tag, g(t)
assert t==0
drop t

isid provincia distrito districtIPUMS

gen a = 1
egen x=count(a), by(provincia distrito)

tab x

foreach var of var nestab nemp nobr massal valprod {
  replace `var'=`var'*(1/x)
}

drop x

 *special case: QUILMES

list if distmerge=="QUILMES"
foreach var of var nestab nemp nobr massal valprod {
  replace `var'=`var'*(1/3) if geolev2==32006087
  replace `var'=`var'*(2/3) if geolev2==32006076

}


collapse (sum) nestab nemp nobr massal valprod, by(geolev2)

gen year=1954

save_data "..\temp\in1954_ipums.dta", replace key(geolev2)

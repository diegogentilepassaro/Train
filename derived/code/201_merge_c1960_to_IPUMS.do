clear all

*I. CLEAN NAMES AND RESHAPE IPUMS DATA
/*such that ther is on observation for each ever exiting distrito. this implies
that GEOLEV2 is not a unique identifier anymore */
use "..\..\base\output\ARG_IPUMS_7080910110.dta"

keep if year==1991

decode geo2_ar, g(x)
split x, parse(,)
drop x
reshape long x, i(geolev2) j(d)
drop if x==""


foreach var of var x{
  replace `var' = subinstr(`var', " ", "",.)
  replace `var' = subinstr(`var', ".", "",.)
  replace `var' = subinstr(`var', "'", "",.)
  replace `var' = subinstr(`var', "-", "",.)
  replace `var' = subinstr(`var', "ã³", "o",.)
  replace `var' = subinstr(`var', "-", "",.)
  replace `var' = subinstr(`var', "ã­", "i",.)
  replace `var' = subinstr(`var', "ã¡", "a",.)
  replace `var' = subinstr(`var', "ã©", "e",.)
  replace `var' = subinstr(`var', "ã±", "n",.)
  replace `var' = subinstr(`var', "ãº", "u",.)
  replace `var' = subinstr(`var', "ã¼", "u",.)
  replace `var' = subinstr(`var', "ã", "n",.)
  replace `var' = upper(`var')
}

keep geolev1 geolev2 provname x geo*
ren x districtIPUMS

gen provmerge=provname
gen distmerge=districtIPUMS

duplicates tag provmerge distmerge, g(aux)
list if aux!=0
drop aux
list if geolev2==32006032 | geolev2==32006073


replace distmerge = "MARCOSPAZ" if geolev2==32006032 & distmerge=="MAIPU"
/*I found the problem when checking merge. It is just a typo in the shapefile
and the database of ipums*/


isid provmerge distmerge
keep provmerge distmerge districtIPUMS provname geolev2

tempfile ip
save `ip', replace

*II. OPEN DATA CENSUS 1960 AND ACCOMODATE NAMES
/*WHEN IT IS A MATTER OF SPELLING, THERE IS NO EXPLANATION IN THE CHANGE
WHEN IT IS A MATTER OF CHANGE OF NAME, THERE IS AN EXPLANATION
 */

use "..\..\base\output\c1960_urb.dta"
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
clean CORONELDEMARINELROSALES CORONELROSALES `pr'
clean ADOLFOGONZALEZCHAVES GONZALEZCHAVES `pr'
clean GENERALJUANMADARIAGA GENERALJMADARIAGA `pr'
clean DAIREAUX CASEROS `pr'
/* Change of name. source:
https://es.wikipedia.org/wiki/Partido_de_Daireaux
*/
clean BENITOJUAREZ JUAREZ `pr'


local pr = "CHACO"
clean 12DEOCTUBRE DOCEDEOCTUBRE `pr'
clean 1DEMAYO PRIMERODEMAYO `pr'
clean 25DEMAYO VEINTICINCODEMAYO `pr'
clean 9DEJULIO NUEVEDEJULIO  `pr'
clean FRAYJUSTOSTAMARIADEORO FRAYJSANTAMARIADEORO  `pr'
clean OHIGGINS CAPITANGENERALOHIGGINS `pr'

local pr = "CHUBUT"
clean PASODELOSINDIOS PASODEINDIOS `pr'

local pr = "FORMOSA"
clean RAMONLISTA RAMONLIATA `pr'

local pr = "JUJUY"
clean DRMANUELBELGRANO CAPITAL `pr'
/* La capital de jujuy es San Salvador de Jujuy. Esta se ubica en el distrito
Doctor Manuel Belgrano
*/

local pr = "LAPAMPA"
clean LEVENTUE LOVENTUE `pr'

local pr = "LARIOJA"
clean CORONELFELIPEVARELA GENERALLAVALLE `pr'
clean ROSARIOVERAPENALOZA GENERALROCA `pr'
clean CHAMICAL GOBERNADORGORDILLO `pr'
clean VINCHINA GENERALSARMIENTO `pr'
clean GENERALJUANFQUIROGA RIVADAVIA `pr'
clean GENERALANGELVPENALOZA VELEZSARSFIELD `pr'

/*la rioja changes of names
source:
https://es.wikipedia.org/wiki/Anexo:Municipios_de_La_Rioja_(Argentina)
https://es.wikipedia.org/wiki/Departamento_General_%C3%81ngel_V._Pe%C3%B1aloza
*/


local pr = "MENDOZA"
clean LUJANDECUYO LUJAN `pr'

local pr = "MISIONES"
clean GENERALMANUELBELGRANO GENERALBELGRANO  `pr'

local pr = "RIONEGRO"
clean CONESA GENERALCONESA `pr'

local pr = "SALTA"
clean GENERALJOSEDESANMARTIN GENERALJDESANMARTIN `pr'
clean GENERALGUEMES GENERALMARTINMIGUELDEGUEMES  `pr'
clean LACANDELARIA CANDELARIA `pr'

local pr = "SANJUAN"
clean 25DEMAYO VEINTICINCODEMAYO `pr'
clean 9DEJULIO NUEVEDEJULIO `pr'
clean IGLESIA IGLESIAS `pr'
clean ULLUM ULLUN `pr'

local pr = "SANLUIS"
clean LIBERTADORGENERALSANMARTIN SANMARTIN `pr'

local pr = "SANTIAGODELESTERO"
clean JUANFIBARRA MATARA `pr'
/*
changed name. source:
https://es.wikipedia.org/wiki/Departamento_Juan_Felipe_Ibarra
*/

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


*III. FIRST ATTEMPT: merging using corrected names
merge 1:1 provmerge distmerge using `ip'
sort provmerge distmerge
list provmerge distmerge _merge if _merge!=3
tempfile a
save `a', replace

*IV. CHECK 1
/*Every obs with _merge==2 has a geolev2 value. Let A be this set of values .
Since geolev2 value is what matters at the end of the day, it is sufficient for
us to check that for every value in A, there is at least one observation with
_merge==3. Then, we can discard obs with __merge for which this condition is
true.

After trying this for the first time, we could get rid of 39/43 obs. T
his meant that at that stage, there were only 4 obs in IPUMS to which no value
in 1960 had been assigned. Among these 4, we found 3 changes of names that were
included in the previous section. When trying this procedure again, only one 1
obs resulted. This was the partido Berazategui that was founded in 1960 but used
to belong to Quilmes. That is fixed in the next section.
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
/*matching 1 obs in IPUMS that was not found in c1960 after
checking name changes
*/
list if _merge==2
keep provmerge distmerge geolev2 provname districtIPUMS
clean QUILMES BERAZATEGUI BUENOSAIRES
tempfile beraz
save `beraz', replace

use `d'
drop if _merge==2
ren _merge __merge
count
gen a=`r(N)'
merge m:n provmerge distmerge using `beraz', replace update
count
gen b=`r(N)'
gen c=a+1
assert b==c
drop a b c
assert _merge==3 | _merge==5
drop _merge
ren __merge _merge

tempfile e
save `e', replace

*VI. MANUEL MERGE 2
/*matching the unmatched from c1960
I print the list on the screen and go one for one
when changing names was sufficient I implemented the modification wherever
it corresponds. In import_c1960.do if it is required before aggregating at the
departamento level. Or in this do-file if. All these changes have a note below
*/
assert _merge!=1

*VII. Aggregation
/* The unit of analysis is the departamento as defined by IPUMS

There are three type of matches

- 1 to 1 (no problem)
- many c1960 to 1 ipums (just sum by ipums)
- 1 c1960 to many ipums (it is only one case of 1 to 2)
------in the meantime, I will divide equally 2/3 and 1/3. This is very roughly
      the proportion today
 */

list if distmerge=="QUILMES"

foreach var of var pop urb rur {
  replace `var'=`var'*(1/3) if geolev2==32006087
  replace `var'=`var'*(2/3) if geolev2==32006076

}


collapse (sum) pop urb rur, by(geolev2)

gen year=1960

label var pop "total population"
label var rur "rural population"
label var urb "urban population"

save "..\temp\c1960_ipums.dta", replace

# Week-5 game-of-life
Denna vecka ska vi pröva på att göra ett spel, rättare sagt game of
life!  Om ni vill göra något annat coolt spel med åtminstone samma
komplexitets nivå får ni självklart göra det också! (Om du är osäker
på att något har samma komplexitetsnivå så fråga Tomas eller
godtycklig äldre student).

## Förberedelse

### Stack som byggverktyg
Denna vecka ska vi inte bara kompilera kod direkt utan ska använda vad
som kallas för ett bygg verktyg det finns många sådana för olika språk
men Haskells största sådant är ett verktyg som heter stack. Ni kan läsa
mer om detaljerna för detta på denna länk:
[DOCS](https://docs.haskellstack.org/en/stable/README/)


Men ni får en liten halvdålig crash course av mig!

Stack används för att se till att bibliotek alltid installeras korrekt
samt att organisera många filer i större projekt. För att starta stack
bör ni skriva kommandot `stack setup` vart som helst i terminalen och
låta den tugga ett tag. När den är klar bör ni navigera er till mappen
där koden i detta repository finns och skriva `stack init` sedan
`stack build`. Om ni inte har modifierat min originalkod kommer den
inte lyckas att göra något vettigt då det saknas kod för själva
grundlogiken.  Om ni lyckas ska det går att köra stack exec
game-of-life och programmet börjar rendera kuber!

Jag har redan skapat ett grundprojekt till er
som följer med i mappen. Strukturen av ett stack projekt är följande:

#### .cabal filen (game-of-life.cabal)
Säger till stack vilka program och biblioteksfiler ni vill ska finnas
med när man bygger projektet men det säger även vilka tredjeparts
bibliotek som ska existera samt lite andra små detaljer.

#### app
Här finns mainfilerna för olika möjliga exekverbara filer som man vill
skapa. Om ni känner för att vara lata kan ni skriva all kod här. Men
egentligen bör man skriva spel logiken i någon fil i "src" mappen.  Om
ni vill använda tredjeparts bibliotek i mainfilen måste ni lägga till
namnet av biblioteket i `game-of-life.cabal` filen.

#### src
Här bör all källkod finnas, i alla fall den största delen av
den. Normalt sett delar man upp koden i flera moduler där varje modul
har ett eget nichat område. Titta lite på hur jag har gjort.

### GLFW
Detta projekt är beroende av ett bibliotek som heter GLFW och ni
hittar deras hemsida här:
[GLFW](http://www.glfw.org/)

Kortfattat är det ettbibliotek som gör det enkelt att öppna rutor och
hantera input för olika operativsystem. (Cross platform ftw!)

#### Mac
Ni som använder mac bör kunna få tag på biblioteket via `homebrew`
eller `macports` eller vad det rekommenderade är nu
förtiden. Alternativt kan ni installera det själva (googla)
#### Linux
Ni som använder linux bör det bara vara någonting i stil med `sudo apt
install libglfw3` eller motsvarande för andra linux distros.

#### Windows
Ledsen, ingen aning hur det fungerar där! Fråga närmaste
windows guru! (googla)

### Annat
I mappen shaders finns det kod i ett språk som heter GLSL. Låt dessa
vara där. När programmet körs kommer den att leta efter dessa filer
och försöka kompilera dem på din dator. Ni kan försöka ändra lite
saker där om vågar! :)

## Uppgifter
Om ni tittar i `/app/Main.hs` ser ni att jag redan har definierat en
rätt enkel datastruktur vid namn `State` Tanken är att ni ska
definiera ett eget "State" och en funktion som uppdaterar "statet"
beroende på vilket input som ni får in. För att se möjliga inputs
titta i filen `/src/Input/Events.hs`.

Kom ihåg att den datastrukturen jag har skrivit är endast där som
exempel och är ganska dum.

Börja med något simpelt så som att bara rita en godtycklig kub.  Sen
kanske ni vill modifiera kameran lite beroende om någon klickar på
piltangenterna.

När ni känner er redo är det dags för att göra hela spelet. Förklaring
för reglerna finns på många ställen men kan rekommendera:

[WIKIPEDIA](http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

### Extra utmaning
En första lösning brukar vara att man definierar en matris som ritas
ut. Problemet med detta är att man begränsar "värdlen" till en viss
storlek. Samt att koden för att uppdatera saker blir rätt
knepig. Speciellt i Haskell. Men det finns rätt schyssta lösningar för
båda dessa problemen! Kom ihåg att det finns många standard datatyper
till hjälp i Haskells container bibliotek!
[HÄR!](http://hackage.haskell.org/package/containers-0.5.10.2)

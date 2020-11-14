# Prolog

Som vi talade om låter prolog oss definera predikat. Dessa kan liknas vid funktioner som endast returnerar `true` eller `false` beroende på givna "argument" (inte faktiskt argument med det är vad vi kan jämföra med).

Två exempel på predikat kan se ut som följande.

```prolog
barn_till(knatte, kalle).
barn_till(fnatte, kalle).
```

> I detta exempel borde predikatet heta `syskonbarn_till` för att dem namnen ska funka men det skiter jag i :)

Följande exempel är på hur kod kan fungera, vilket jag försökte visa på övningen men det fungera inte med elev-assistent exemplet:

Vi kan definera ett predikat syskon/2 (/2 är praxis för att skriva hur många s.k "argument" ett predikat tar) på följande sätt.

```prolog
syskon(X, Y) :- barn_till(X, Z), barn_till(Y, Z).
```

> Notera att stora bokstaver samt ord som börjar med stor bokstav är variabler. Så detta predikat ska kallas på med ett givet X och Y och kommer sedan testa predikatet barn_till/2 med givet X och Y

> En till notering är att om tillräckligt många barn_till/2 är definerade så kan syskon/2 kallas på med bara en av variablerna givna. Så `syskon(knatte, Y).` Kommer returnera att Y = fnatte.

Detta exempel säger att om X är barn till Z och Y är barn till Z, så är X och Y syskon. Uppenbarligen är detta inte korrekt i praktiken då man kan ha definierat att en person är definierad som barn till mamman och en annan till pappan, då är dem ändå syskon, i det här exemplet kollar vi bara om dem är barn till samma person. Information saknas men beviset blir korrekt.

Med det här kan vi skapa relationer mellan data och göra lite kola grejer, vi kan tillexempel bygga ut mitt kalle-anka exempel till att definiera en helt släkt.

## Hur räknar prolog?

I exemplet oven med `syskon/2` kan vi be Prolog ge oss vilka bindings (Lös: värden på varibler) som löser (resulterar i sant) predikatet. Just det exemplet kan kännas enkelt, men hur gör Prolog med större exempel? 

Om vi skapar ett predikat som kollar om en lista är sorterad så ställer vi frågan: kan Prolog ge ut en sorterad lista? Svar Ja. Prolog listar ut detta på exakt samma sätt som den listar ut vilka Y som är syskon till knatte. Prolog bygger upp ett räd med olika alternativ och gissar sig fram tills den hittar en lista (eller syskon) som ger värdet sant om det passeras till predikatet. 

> Om detta låter mycket som en AI (neural network) är det för att det är väldigt nära. Prolog används faktiskt mycket inom AI!

Att prolog gillar att kolla i träd kan göra att det hittar flera möjliga resultat. Det är ju skitpraktiskt! Men om man vill ha en slumpad lista kan ske man inte vill ha ALLA slumpade listor. Hmm. Men om vi vill ha ALLA möjliga delmängder av en mängd så är ju det här superpraktiskt. Om bara det finns ett sätt för oss att välja... MEN DET GÖR DET JU. Prolog har en cut operator `!` som förhindrar programmet från att hoppa tillbaka upp (ner?) i trädet efter att en viss tidpunkt passerad. Man kan alltså så på en `!` operator som en envägs-dörr.

## På tal om listor
I praktiken vill vi troligen kunna göra lite praktiska kod-saker med språket också, och då är det bra med listor.

En lista kan i grunden definieras på 4 sätt:

### Varianter

* [ ]

Det första exemplet är strikt en tom lista!

* X

Det andra exemplet är med en variabel. Jajamen, precis som i haskell eller python kan en variabel vara vad som helst. Skillnaden är bara att i `Prolog` kan vi inte riktigt definiera det i förväg om vi skulle vela. X är alltså bara en lista om vi skickar en lista som input!

* [X]

Det andra exemplet är vanligt, vi säger i princip att vi har en lista som kan innehåll ett element, vilket kan vara en annan lista eller bara ett värde.

* [Head|Tail]

I det sista exemplet kräver vi att listan innehåller mer än ett element, ty det krävs för att uppfylla kravet av vad den definitionen innebär. Det vi säger är att vi tar en lista OCH vi vill få tillgång till det första elementet samt allting efter.

Med listor kan vi göra mycket fina saker!

### Append

```prolog
appendEl(X, [], [X]).                       % []+X == [X]
appendEl(X, [H | T], [H | Y]) :-            % T+X  == Y   -> T[0] = Y[0]
           appendEl(X, T, Y).
```

I detta exempel appendar vi ett element till slutet av en lista. Det kan kännas som att koden är lite väl komplicerad för det enkla endamålet, men om vi kollar på hur koden funkar är den nästan lite magisk. 

Vi ser enkelt att den här koden är rekursiv, och förstår då att det första predikatet `appendEl(X, [], [X]).` är ett basfall. Vi säger att  givet ett element och en tom lista så bör den resulterande listan ha elementet i sig. 

>Kom ihåg att vi bygger koden på det sättet att: "Om givet den här datan, har vi gjort rätt?", och förväntar oss svaret ja (True) eller nej (False).

Det andra predikatet:

```prolog
appendEl(X, [H | T], [H | Y]) :-            % T+X  == Y   -> T[0] = Y[0]
           appendEl(X, T, Y).
```

Säger att om givet X och en lista [H | T], så borde den resulterande listan [H | Y] självklart ha samma element som den första vid ett givet index (Därför har dem båda samma variabel H i predikatet).

`appendEl(4, [1,2,3], [1,2,3,4]).` kommer returnera sant, så vi kollar hur predikatet går igenom listorna.

```prolog
4
[1,2,3]
[1,2,3,4]
 ^
 OK
```

Pilen i kodblocket ovan kollar först på första elementet och eftersom dem är samma och det finns element efter i listorna kommer vi patternmatcha med `appendEl(X, [H | T], [H | Y])` vilket rekursivt kallar på `appendEl/3` igen fast utan det första elementet, dvs pilen ovan.

```prolog
4
[1,2,3]
[1,2,3,4]
       ^
 OK
```

Till slut hamnar pilen på det sista elementet och vi matchar istället med basfallet `appendEl(X, [], [X]).`. KALLAS! Vi ser ju att vi har en 4, en tom lista, och en lista med 4 i. Vi vet att dettta stämmer!

Nu ser vi enkelt hur om vi skulle kalla på predikatet utan resultat-listan, så skulle prolog veta vad som behövs göras för att returnera sant! Detta är min rekomenderade anfallsvinkel för att förstå sig på prolog, fundera först på hur ett predikat ger SANT givet den data vi vill jobba med, och fundera sedan på om detta funkar för att returnera ett sökt värde!

### Remove duplicate element from list

Vi går igenom ett svårare problem med rekursion och listor, givet en lista (tex [1,2,3,3,3,4,5,5,5,1,2,3,]) vill vi returnera en lista utan duplicerade element (tex [1,2,3,4,5]).

```prolog
% Solutions:
remove_duplicate(X, E) :-           % Acc == [] -> X && E
    remove_duplicate(X,[],E).
remove_duplicate([], Acc, Acc).     % X == [] -> E == Acc   (base case)
remove_duplicate([X|Xs], Acc, E) :- % 
    \+ member(X, Acc),              % if not X in Acc,
    appendEl(X, Acc, Accc),         %     remove_duplicate(Xs, [X]+Acc, E)
    remove_duplicate(Xs, Accc, E),  % 
    !.                              % if values satifies base case ? break : step out
remove_duplicate([_|Xs], Acc, E) :- % else, remove_duplicate(Xs, Acc, E)
    remove_duplicate(Xs, Acc, E).   % 
```

Vi vill att indatan ska vara en lista och en likadan lista fast utan återkommande element och sedan returnera sant om detta stämmer. Vi ser då att första predikatet `remove_duplicate/2` används bara som ett insteg till nästa predikat, ty vi behöver mer data medans vi jobbar. 

För att lösa detta problem använder vi oss av en ackumulator där vi sparar alla element den första gången vi ser dem. Det andra predikatet `remove_duplicate([], Acc, Acc).` är vårat basfall som säger att när original-listan är tom (dvs vi har rekursivt gått igenom hela) så ska våran ackumulator vara samma som E vilket är den resulterande listan.

Det trejde predikatet gör helt enkelt följande:

`\+ member(X, Acc),` Är elementet med i ackumulatorn? (utläses "not member") då ska den sedan läggas i där med `appendEl(X, Acc, Accc),` och `remove_duplicate/3` kallas på igen med den nya ackumulatorn. 

Utropstäcknet betyder cut, och gör att prolog INTE får steppa tillbaka i beslutsträdet. Detta på grund av att den annars kommer hoppa tillbaka tills innan elementet lades till i ackumulatorn. Vad vi säger är: "Har ett element lagts till i ackumulatorn är det permanent och ska inte tas bort". Testa köra koden utan ! tecknet. Ni kommer se att prolog kommer ge tillbaka fler lösningar på E.

Om `\+ member(X, Acc),` skulle faila, dvs X _är_ en medlem av ackumulatorn, då kommer det nuvarande predikatet `remove_duplicate/3` faila vilket gör att följande anropas istället (Med samma indata).

```prolog
remove_duplicate([_|Xs], Acc, E) :-
    remove_duplicate(Xs, Acc, E).
```

Detta predikat är ett "Catch all", varför vi har den bör ni kunna lista ut själva, men vad den säger (implicerat av hur förra predikatet fungerar) är att OM vi hittar ett element som redan finns i ackumulatorn så skippar vi helt enkelt det talet och går vidare till nästa.

> Ett _ betyder precis som i haskell: "Vadsomhelst, jag skiter i vad, men det måste vara nånting".
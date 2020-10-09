# Task-7
**OBS: Om ej annat anges så ska allt printas på separata linjer med hjälp av newline (`\n`).**


Börja med att installera valfri C-kompilator, exempelvis gcc. I gcc så kompilerar ni med `gcc -o programnamn filnamn.c` och ni kör programmet med `./programnamn`

#### Windows:
Om ni använder Windows rekommenderar jag att ni installerar [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) (Windows Subsystem for Linux), och skaffar en distribution som t.ex. [Ubuntu](https://www.microsoft.com/store/apps/9n6svws3rx71). `gcc` som jag använde på övningen är då förinstallerad. Filerna som ligger i Windows kommer ni åt via pathen `/mnt/c/` (för C:\ drive).

#### Linux & Mac:
`gcc` kommer antingen förinstallerat eller kan enkelt installeras via apt eller brew. Googla vad som gäller för just ert operativsystem.  

## Att koda:
### 1.
Skapa ett program `hello.c`, som ska göra följande: 
1. Printa "Hello world!"
2. Skapa en variabel `a` med värdet 3
3. Printa värdet av `a`

Tips: Använd `printf` från `stdio.h`. 
 
### 2.
Skapa ett program `echo.c` som ska göra följande:
1. Skapa en variabel `buffer` av typen sträng (array av chars) med storlek 50
2. Printa "Write something: "
3. Läs input från stdin (alltså det användaren skriver in i terminalen)
4. Printa "You wrote: " följt av det användaren skrev in, utan någon newline

Tips: Använd `scanf` från `stdio.h`

### 3.
Skapa ett program `whoami.c` som ska göra följande:

1. Fråga användaren om deras namn och ålder, som ska läsas från stdin i formatet "namn ålder"
2. Spara namn och ålder i två separata variabler med lämpliga datatyper.
3. Skriv ut namn följt av både åldern och åldern i kvadrat. Ingen ny variabel ska introduceras.

Exempelinput: "Jens 20"

Exempeloutput: "Jens 20 400"

### 4.
Kopiera `whoami.c` till `whoami2.c` och gör följande ändringar:
1. Skapa två funktioner för att räkna ut kvadraten: `square`, som returnerar det kvadrerade talet, och `squaref` som använder en referens för att mutera variabeln istället för att returnera en ny kopia.
2. Använd båda dessa funktioner för att skriva ut kvadraten två gånger istället. Denna gång får nya variabler introduceras om det behövs. 

Exempelinput: "Jens 20"

Exempeloutput: "Jens 20 400 400"

### 5.
Skapa ett program `loop.c` som ska göra följande:
1. Kopiera in följande kod
```c
#include <stdio.h>

void floop(int n) {}

void wloop(int n) {}

void rloop(int n) {}

int main(void) {
	int n = 5;
	printf("Starting for-loop\n");
	floop(n);
	printf("Starting while-loop\n");
	wloop(n);
	printf("Starting rec-loop\n");
	rloop(n);
	printf("Done!\n");
	return 0;
}
```
2. Implementera floop, wloop, och rloop med for-loop, while-loop, och rekursion respektive. Funktionerna ska printa alla heltal i det slutna intervallet [1, 5]

Output ska se ut som följande:
```
Starting for-loop
5
4
3
2
1
Starting while-loop
5
4
3
2
1
Starting rec-loop
5
4
3
2
1
Done!
```

### 6.
Skapa ett program `pointers.c` som ska göra följande:
1. Skapa en array `v1` med rum för 10000 integers.
2. Använd valfri loop-metod och indexera in i arrayen med `v1[index]` för att fylla den med talen [0, 9999]
3. Upprepa processen för en ny array `v2`, men denna gång får du ej använda dig av indexerings-syntaxet `[]`.
4. Printa första, sista, och 5000e elementet i båda arrayer. Du får återigen inte använda []-indexering för arrayen `v2`.
4. Printa dina arrayers storlek i bytes med hjälp av `sizeof`.

### 7.
Skapa programmet `multiply.c` som ska göra följande för de naturliga talen a,b:
1. Skapa en funktion `int mult(int a, int b)` som returnerar a * b
2. Skapa en funktion `int div(int a, int b)` som returnerar a / b
3. Skapa en funktion `int multadd(int a, int b)` som returnerar a * b genom upprepad addition.
4. Skapa en funktion `int divsub(int a, int b)` som returnerar a / b genom upprepad subtraktion
5. Printa resultaten av alla funktioner med värdena a = 3598, b = 419

### 8.
Skapa programmet `euklides.c` som ska göra följande:
1. Skapa en funktion `uint64_t rebase(uint64_t n, const unsigned int to)` som tar ett positivt heltal `n` i talbas 10 och returnerar talet `n` i talbasen `to` med hjälp av euklides algoritm. Du kan anta att `2 <= to <= 10` och att returvärdet ej överstiger storleken av en uint64_t.

2. Printa rebase(4567, 2), rebase(1456755, 8), och rebase(12345, 10)
 
Tips: `uint64_t` importeras från `stdint.h` och är lämplig att använda istället för int i denna funktion.

### 9. Frivillig extrauppgift:
Ändra programmet `euklides.c` till att ha följande egenskaper:
* Ge `rebase` en parameter `from` som säger vilken talbas `n` ursprungligen befinner sig i.
* Låt `rebase` istället returnera en sträng på max 100 bokstäver, vilket ökar begränsningen på både storlek och talbas. `rebase` ska nu kunna hantera talbaser upp t.o.m. bas 16.

## Att besvara:
#### 1a. Vad händer om du använder scanf och användaren skriver in en sträng som är längre än den buffer du skapat? Varför?

#### 1b. Vad kan ovanstående problem få för sideffekter?

#### 1c. Hur kan man undvika detta problem? (Googla alternativ!)

#### 2a. Hur många bytes är en int? (Testa med sizeof(int)). Kan du vara säker på att du alltid får samma svar med olika system och kompilatorer? Varför/varför inte?

#### 2b. Hur räknar `sizeof`-funktionen ut hur stora dina arrayer är?

#### 3. Vad hade du kunnat få för problem med `int` istället för `uint64_t` i #8?

#### 4. Vad gör uttrycket `printf("%u", -1);`? Varför?

#### 5. Studera och testkör följande kod:
```c
char hello[] = "hello world!\n";
for (char * c = hello; *c != 0; c++) {
    printf("%c", *c);
}
```
##### a. Vad är variabeln `hello`?

##### b. Vad är variabeln `c`?

##### c. När termineras for-loopen? Varför?

##### d. Vad gör `c++`?

##### e. Vad händer om du tar bort dereferensoperatorn ur for-loopens villkorstest?

#### 6. Studera och testkör följande kod:
```c
char * hello = "hello world!\n";
for (;*hello;) {
    printf("%c", *hello++);
}
```
##### a. Vad är variabeln `hello`?

##### b. När termineras for-loopen? Varför?

##### c. Vad gör `hello++`?

##### d. Vilka är skillnaderna mellan koden i fråga 5 och 6?

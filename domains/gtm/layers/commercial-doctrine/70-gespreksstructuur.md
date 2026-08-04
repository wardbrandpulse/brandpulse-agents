# Gespreksstructuur

> **Bewijslast: n=0.** Externe, niet-gevalideerde kennis. Nul gesprekken gevoerd,
> nul replies gecodeerd. Zie [`LAYER.md`](LAYER.md).

Hoe een verkoopgesprek is opgebouwd, en wat daarvan overgaat naar schriftelijke
outbound.

Actief op stand `standaard` en hoger.

---

## 1. Zes stappen

1. **Verhelderen waarom iemand er is.** In zijn woorden, niet in de onze. Wat
   bracht hem hier, en waarom nu.
2. **Het probleem preciezer benoemen dan de ander deed.** Dit is het moment waarop
   je vertrouwen verdient of niet. Wie het probleem scherper terugkrijgt dan hij
   het gaf, gaat verder.
3. **Vorige pogingen uitvragen.** Wat is er al geprobeerd, wat gebeurde er, en
   waaraan lag het volgens hem. Dit levert de bezwaren op voordat ze bezwaren
   worden.
4. **De uitkomst verkopen, niet de werkwijze.** Wat er verandert, niet hoe het
   werkt. De werkwijze komt aan de orde als hij ernaar vraagt, en dan is het een
   antwoord in plaats van een presentatie.
5. **Bezwaren wegnemen.** Zie sectie 3.
6. **Het besluit bevestigen.** Expliciet, met wat er nu gebeurt en door wie.

## 2. Verdeling: het gewicht ligt vooraan

**Het meeste gewicht op stap 1 en stap 3, niet op stap 4.**

De gangbare fout is de omgekeerde verhouding: kort verhelderen, geen vraag naar
vorige pogingen, en dan een lange presentatie. Dat levert een gesprek op waarin de
verkoper de meeste woorden zei en het minste weet.

Twee redenen waarom stap 3 zo zwaar weegt. Wie eerder iets probeerde, heeft een
verklaring waarom het niet werkte, en die verklaring is de overtuiging waar je
straks tegenaan loopt. En bij een categorie die nog uitleg nodig heeft, is "niets
geprobeerd" zelf een antwoord: dan is het probleem nog niet als probleem erkend, en
dan is stap 4 nog niet aan de orde.

## 3. Bezwaren: de zeven codes zijn de bron

**De codelijst uit [`taxonomie.md`](../../playbooks/taxonomie.md), sectie 6, is
canoniek.** Die zeven codes worden gebruikt bij het coderen, bij het rapporteren en
bij het terugzoeken, en ze zijn bij ingest afgedwongen met een check-constraint.

De vier categorieën uit de bron (prijs, tijd, mandaat, geschiktheid) zijn een
**secundaire lens**: bruikbaar om te zien welk soort antwoord past, en nooit een
vervanging van de codes. **Verzin geen achtste code.**

| Code (canoniek) | Secundaire lens | Wat er onder zit | Waar het antwoord op aangrijpt |
|---|---|---|---|
| `geen-budget` | prijs | geen post op de begroting, want geen categorie | de breuk, niet de prijs. Zie principe 4 |
| `te-vroeg` | tijd | de deadline voelt ver weg, of men gelooft in uitstel | wat er nu al kost, los van de datum. **Nooit de datum aanscherpen** (grens 1) |
| `geen-eigenaar` | mandaat | het valt tussen afdelingen in | wie er last van heeft, niet wie erover gaat |
| `doet-leverancier-al` | geschiktheid | een bestaande partij claimt dit te dekken | wat er precies gedekt is, feitelijk nagegaan |
| `intern-bouwen` | geschiktheid | het lijkt op iets dat IT ook kan | de doorlooptijd en het onderhoud, niet de bouwbaarheid |
| `wat-is-dpp` | **geen vakje**, zie hieronder | de categorie is onbekend | eerst dat er een keuze te maken valt |
| `anders` | nvt | restcategorie | nvt, en hij hoort klein te blijven |

**Groeit `anders` boven een tiende van de replies, dan ontbreekt er een code.** Dat
gaat vóór het beantwoorden van de bezwaren, en de route voor een nieuwe code loopt
via [`taxonomie.md`](../../playbooks/taxonomie.md), niet via deze laag.

### Het viercategorieënmodel heeft geen vakje voor onbekendheid

`wat-is-dpp` is **geen bezwaar over geschiktheid maar over begrip.** Wie niet weet
wat de categorie is, heeft geen mening over of het past: hij heeft geen kader om die
mening in te hebben.

**Dat is een tekort van het bronmodel, niet van de taxonomie.** De vier categorieën
gaan ervan uit dat de koper de categorie kent en alleen nog twijfelt over prijs,
timing, bevoegdheid of geschiktheid. Bij een nieuwe categorie klopt die aanname
niet, en dan valt het meest voorkomende bezwaar buiten het model.

Dat het niet in het model past, betekent niet dat het klein is. Waar de categorie
nieuw is, is onbekendheid het dominante probleem, en dat staat zo in de
positionering van de klant (`clients/<klant>/gtm/positionering.md`): de eerste taak
is niet overtuigen dat wij de beste keuze zijn, maar dat er een keuze te maken valt.
Een gesprek dat met differentiatie begint, praat langs de meeste ontvangers heen.

Praktisch: bij `wat-is-dpp` slaat stap 4 niet aan en zijn stap 1 tot 3 het hele
gesprek.

## 4. Per bezwaar: vier bewegingen, en debatteren is er geen van

1. **Erkennen.** Zonder "maar" erachter.
2. **Terugkoppelen naar wat de ander zelf zei.** Zijn eigen woorden uit stap 1 en
   stap 3. Dit werkt alleen als die stappen echt gedaan zijn, en dat is de tweede
   reden dat het gewicht vooraan ligt.
3. **De onderliggende overtuiging adresseren**, niet de geuite zin. "Te duur" is
   zelden een uitspraak over geld; "te vroeg" zelden een uitspraak over een datum.
4. **Opnieuw vragen.** Een bezwaar wegnemen zonder de vraag te herhalen laat het
   gesprek op de bezwaarafhandeling eindigen.

**Niet debatteren.** Een gewonnen discussie levert geen ondertekening op, en bij
meerdere beslissers levert hij iemand op die intern moet uitleggen waarom hij
overtuigd raakte.

**En niet corrigeren op regelgeving.** Denkt iemand dat een verplichting later
ingaat dan wij menen, dan is dat geen debatpunt: wij geven geen juridische duiding
(grens 2), en een datum mag alleen genoemd worden als hij aan de bron geverifieerd
is (grens 1). Zolang die verificatie er niet is, is het eerlijke antwoord dat wij het
niet vaststellen.

## 5. Toepassing op schriftelijke outbound

**Een eerste bericht doet twee dingen: benoemen, plus één concrete volgende stap.**

Dat is alles. Geen zes stappen, geen probleemontleding, geen risico-omkering, geen
aanvullende waarde.

**Dit is de meest voorkomende fout bij het overzetten naar tekst:** de hele
gespreksstructuur in één mail. Die mail is dan lang, hij presenteert voordat hij
verheldert, en hij vraagt om een besluit van iemand die nog geen probleem heeft
erkend. De structuur werkt in een gesprek omdat de ander antwoordt; in een mail
antwoordt niemand tussendoor.

Wat wél meegaat naar tekst:

- **Stap 2, het probleem preciezer benoemen dan de ander deed.** Dat is het enige
  deel dat in één richting werkt, en het is de reden dat iemand antwoordt.
- **Eén volgende stap**, concreet, met een laagste-moeite-vorm. Zie de moeitevariabele
  in [`10-aanbodarchitectuur.md`](10-aanbodarchitectuur.md).

Wat er niet in gaat: een deadline die niet aan de bron geverifieerd is, een
compliance-belofte, en meer dan één vraag.

**De rest van de reeks is dekking, geen herhaling.** Vijf contactmomenten op stand
`standaard`, zeven op `scherp`, en elk moment doet iets nieuws in plaats van
hetzelfde vriendelijker. Zie [`40-kanaaldoctrine.md`](40-kanaaldoctrine.md).

# Aanbodsequentie

> **Bewijslast: n=0.** Externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).

Vier posities. Een klant kan er nul, één of alle vier bezet hebben, en welke
ontbreekt bepaalt wat er misgaat.

Actief op stand `standaard` en hoger.

---

## De vier posities

| Positie | Doet | Ontbreekt hij, dan |
|---|---|---|
| instapaanbod | zet vreemden om in klanten en dekt de acquisitiekosten | is de eerste transactie meteen de grote, en die is koud moeilijk |
| uitbreiding | verkoopt het probleem dat de eerste aankoop blootlegt | blijft de klantwaarde staan op de eerste aankoop |
| verlaging na een nee | vangt een afwijzing op zonder de prijs van hetzelfde te verlagen | is een nee definitief |
| doorlopend | levert terugkerende omzet | begint elke maand weer bij nul |

## 1. Instapaanbod

**Doel:** vreemden omzetten in klanten, en de acquisitiekosten dekken.

**Richtpunt: kosten terugverdiend binnen 30 dagen.** Extern richtpunt om te
testen, geen vastgestelde waarde. Zie
[`60-acquisitiemath.md`](60-acquisitiemath.md).

Twee vormen die in een zakelijke, consultatieve verkoop bruikbaar zijn:

- **Een betaalde diagnose of nulmeting.** Klein, afgebakend, met een uitkomst die
  de klant houdt ook als hij niet verder gaat. Het feit dat er betaald wordt is
  het punt: het selecteert op koopintentie in plaats van op nieuwsgierigheid.
- **Een lokaanbod dat contrasteert met het volledige pakket.** Een kleine,
  duidelijk begrensde variant die het volledige pakket in verhouding zet.

**Uitgesloten als instapaanbod:** verlotingen, loterijen en weggeefacties. Zie
[`90-uitsluitingen.md`](90-uitsluitingen.md), punt 1.

**Bedragen staan in `clients/<klant>/`** (grens 8). De laag mag vaststellen dat er
geen instapaanbod is, en dat is een bevinding.

## 2. Uitbreiding

**Doel:** het probleem verkopen dat de eerste aankoop blootlegt. Niet meer van
hetzelfde, maar het volgende probleem, dat pas zichtbaar werd doordat het eerste
opgelost is.

Drie technieken:

- **Keuze tussen twee opties in plaats van ja of nee.** Twee opties maken de vraag
  "welke" in plaats van "of". Beide opties moeten wel echt passen, anders is het
  een truc die één keer werkt.
- **Ontraden wat de klant niet nodig heeft.** Dit bouwt vertrouwen en verhoogt de
  aanname van de rest. Het werkt alleen als het echt is: één keer iets ontraden dat
  hij wel nodig had, kost meer dan het ooit opbracht.
- **Het eerder betaalde bedrag laten meetellen** bij een grotere stap. De klant
  ziet dan geen dubbele uitgave maar een opwaardering.

Die derde is een prijsafspraak en dus een klantbesluit: of het eerder betaalde
bedrag meetelt, en hoeveel, staat in `clients/<klant>/`.

## 3. Verlaging na een nee

**De regel die alles bepaalt: nooit hetzelfde voor minder geld.** Verander de
betaalvorm of de inhoud, niet de prijs van hetzelfde. Dezelfde inhoud goedkoper
maken vertelt de klant dat de eerste prijs niet klopte, en dat werkt door in elk
volgend voorstel.

Drie vormen:

| Vorm | Wat er verandert | Let op |
|---|---|---|
| betaalvorm aanpassen | spreiden, of deels vooruit | het totaal blijft gelijk. Zie [`50-betaalstructuur.md`](50-betaalstructuur.md) |
| omvang of onderdelen weghalen | de inhoud wordt kleiner, de prijs mee | vaak ziet de klant hierdoor pas de waarde van wat je weghaalt |
| proefvorm | een begrensde periode of scope | **de boetevariant is uitgesloten**, zie [`90-uitsluitingen.md`](90-uitsluitingen.md), punt 5 |

Die tweede vorm heeft een nuttig neveneffect: door een onderdeel weg te halen
wordt de waarde ervan concreet, en niet zelden komt de klant er zelf op terug.
Dat is geen tactiek maar een gevolg, en het werkt alleen als je het onderdeel
werkelijk weghaalt.

**Welke verlagingsvormen zijn toegestaan en tot welke grens: klantbesluit.** Staat
in `clients/<klant>/`, en is een open vraag in de besluitenlijst van fase D. Op
stand `scherp` staat de ladder standaard klaar, wat betekent dat de vormen vooraf
bepaald zijn en niet ter plekke verzonnen worden. Vooraf bepaald door een mens, niet
door de laag.

## 4. Doorlopend aanbod

**Doel:** terugkerende omzet, zodat acquisitie niet elke maand opnieuw hetzelfde
werk is.

Technieken die bij een bestaand doorlopend aanbod nog niet benut hoeven te zijn:

- **Een eenmalige waardetoevoeging bij directe ondertekening.** Waarde toevoegen in
  plaats van prijs weghalen, conform principe 4.
- **Vrije maanden in ruil voor een langere looptijd.** Verandert de betaalvorm, niet
  de prijs van hetzelfde.
- **Een opstartbedrag dat bij een jaarcontract vervalt.** Maakt de langere looptijd
  aantrekkelijk zonder de maandprijs aan te tasten.
- **Een langere factuurcyclus verlaagt opzeggingen.** Minder momenten waarop
  iemand de afweging opnieuw maakt.

Alle vier zijn prijsbesluiten. Aantallen, percentages en looptijden staan in
`clients/<klant>/` (grens 8), en de facturatiekant staat in
[`50-betaalstructuur.md`](50-betaalstructuur.md).

**Uitgesloten bij de factuurcyclus:** facturatie per 28 dagen om dertien cycli per
jaar te halen. Zie [`90-uitsluitingen.md`](90-uitsluitingen.md), punt 2. Een langere
cyclus mag, een cyclus die per jaar een extra factuur binnensmokkelt niet.

---

## Vaststellen welke posities bezet zijn

**Doe dit vóór er aan een tekst of een kanaal gewerkt wordt.** Het is de
sequentievariant van principe 1: eerst vaststellen wat er ontbreekt.

Per klant, in deze volgorde:

1. Welke van de vier posities is bezet, en waarmee?
2. Wat is de eerste transactie die een nieuwe klant doet, en is die koud of warm
   verkocht?
3. Welke positie ontbreekt, en wat kost dat?

**Een sequentie met alleen een doorlopend aanbod is het meest voorkomende geval,
en het grootste gat.** De eerste transactie is dan meteen de terugkerende
verplichting, koud verkocht. Dat vraagt van een vreemde in één stap het grootste
commitment dat er is, en er is geen tussenstap waarop hij zich kan laten zien.

**Benoem dat gat, beslis het niet.** Of er een instapaanbod komt, in welke vorm en
tegen welk bedrag, is een menselijk besluit met commerciële gevolgen. Het gaat naar
de besluitenlijst in `clients/<klant>/` (fase D), niet naar een voorstel van de
laag. De vaststelling per klant hoort ook op de klantas: welke posities daar bezet
zijn, verandert per klant en is dus geen methodiek.

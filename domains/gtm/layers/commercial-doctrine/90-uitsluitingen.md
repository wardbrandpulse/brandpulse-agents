# Uitsluitingen

> **Bewijslast: n=0.** Deze laag is externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).

Mechanieken die de bron wél voorschrijft en die wij bewust **niet** gebruiken,
met de reden erbij.

**Dit bestand bestaat om één reden:** zodat niemand ze later "herstelt" in de
veronderstelling dat ze vergeten zijn. Een uitsluiting zonder opgeschreven reden
komt terug, want hij ziet uit als een gat in de doctrine.

Uitsluitingen gelden op **elke** stand van de intensiteitsschijf, ook op
`scherp`. Ze worden niet afgezwakt door een hogere stand; een hogere stand zet
meer mechaniek aan, geen andere grenzen.

**Een uitsluiting is niet hetzelfde als een grens.** Een grens
([`99-grenzen.md`](99-grenzen.md)) begrenst wat de doctrine mag voorstellen. Een
uitsluiting verwerpt een concreet mechanisme dat de bron aanreikt. Verwerpen is
een keuze en kan later herzien worden, met een besluit in
[`memory/decisions.md`](../../../../memory/decisions.md). Stilzwijgend
terugbouwen kan niet.

## Uitsluitingen zijn laag-eigen, en dat is geen tekort

De projectieregel in [`99-grenzen.md`](99-grenzen.md) eist dat elke grens een
bron buiten de laag heeft. **Voor uitsluitingen geldt die eis niet, en het zou
misleidend zijn er bronnen bij te zoeken.**

De reden is dat een uitsluiting een mechanisme verwerpt dat zonder deze laag niet
bestaat. Er is in deze repo niets dat een verloting als instapaanbod voorstelt, of
facturatie per 28 dagen, of een anti-garantie. Die mechanica komt binnen met de
doctrine en gaat eruit met de doctrine.

**Daarmee is elke uitsluiting removal-neutraal.** Verwijder de laag en je haalt de
doctrineregel én de verwerping in één keer weg. Netto nul, dus de
verwijderbelofte blijft heel zonder dat er ergens een externe bron nodig is.

Twee uitsluitingen hebben er alsnog een, en dat is toeval en geen eis: punt 1
(kansspelwetgeving) berust op de wet en punt 7 op een vastgelegde propositiekeuze
van de klant. Bij die twee gaat de beperking dus verder dan deze laag. De volledige
lijst staat onderaan in "Herkomst per uitsluiting".

---

## 1. Loterijen, verlotingen en weggeefacties als instapaanbod

**Wat de bron voorschrijft.** Een verloting of weggeefactie als goedkope manier
om vreemden in een lijst te krijgen, met de trekking als aanleiding voor het
eerste contact.

**Waarom niet.** Het raakt de Nederlandse Wet op de kansspelen. Dat is geen
inschatting van ons: de productdocumentatie van de eerste klant in dit domein
merkt hetzelfde aandachtspunt al op bij win-acties in het product, met de
constatering dat de opdrachtgever verantwoordelijk blijft voor naleving. Wat voor
het product van een klant geldt, geldt net zo goed voor onze eigen acquisitie.
De vindplaats staat bij het activeringsblok van die klant.

**Wat we in plaats daarvan doen.** Zie de instappositie in
`20-aanbodsequentie.md` (fase B): een betaalde diagnose of nulmeting, of een
lokaanbod dat contrasteert met het volledige pakket.

## 2. Facturatie per 28 dagen om dertien cycli per jaar te halen

**Wat de bron voorschrijft.** Factureren per vier weken in plaats van per
kalendermaand, wat dertien in plaats van twaalf facturen per jaar oplevert.

**Waarom niet.** Rekenkundig waar en commercieel onverstandig. Dit is het soort
constructie dat bij de eerste factuurcontrole van een inkoopafdeling opvalt, en
dan is niet de constructie het gespreksonderwerp maar je betrouwbaarheid. In een
inkoopproces met meerdere beslissers is dat een dure ruil voor één extra cyclus.

## 3. Gefabriceerde schaarste en tijdsdruk

**Wat de bron voorschrijft.** Een deadline of een oplopende prijs als
standaardonderdeel van elk aanbod, ongeacht of er een echte grens onder zit.

**Waarom niet.** Schaarste mag alleen genoemd worden als hij feitelijk waar is: een
capaciteitsgrens die echt bestaat, of een datum die echt vaststaat. Een
geconstrueerde deadline en een verzonnen capaciteitsgrens zijn beide uitgesloten,
ook als ze werken, en ook op stand `scherp`.

**Deze uitsluiting draagt het hele verbod, en dat is met opzet.** In de eerste
opzet stond het in grens 1. Bij het narekenen van de projectieregel bleek dat het
in deze repo geen voorganger had: er staat nergens iets over verzonnen feitelijke
claims in klantcommunicatie. Een grens zonder bron zou de projectieregel
decoratief maken, dus is het hier terechtgekomen, waar geen bron nodig is.

**Wat grens 1 wél dekt**, en dat is een projectie met een echte bron: een datum mag
alleen genoemd worden als hij aan de bron is nagegaan, en indicatieve termijnen
worden nooit aangescherpt. Er is op dit moment geen bruikbare vaste datum, want de
enige kandidaat is geblokkeerd tot verificatie.

**Waar dit hoort te eindigen.** Een verzonnen deadline of capaciteitsgrens is in de
eerste plaats misleiding en dus een kwestie van recht, geen commerciële smaak.
Zodra `domains/gtm/playbooks/juridisch-kader-outbound.md` bestaat, hoort het daar
te staan en kan grens 1 het als projectie opnemen. Tot die tijd draagt deze
uitsluiting het, en zolang de laag uit staat is er ook geen doctrineregel die het
zou voorstellen.

## 4. De anti-garantie

**Wat de bron voorschrijft.** De omkering "als je een garantie nodig hebt, is dit
niet voor jou", die twijfel bij de koper omzet in een zelfselectie.

**Waarom niet.** Het werkt bij individuele consumentenverkoop, waar één persoon
beslist en de trots meebeslist. In een zakelijk inkoopproces met meerdere
beslissers werkt het tegen: degene die het aan de rest moet verkopen, krijgt geen
argument mee maar een houding. Bovendien vraagt inkoop juist wél om zekerheden,
en die vraag is legitiem.

**Wat we in plaats daarvan doen.** Risico-omkering in de drie vormen die wél
gebruikt worden, in `10-aanbodarchitectuur.md` (fase B): onvoorwaardelijk,
voorwaardelijk en prestatiegebonden, en altijd op proces of inspanning en nooit
op een wettelijke uitkomst (grens 2).

## 5. Proefperiode met boeteclausule

**Wat de bron voorschrijft.** Een gratis of goedkope proefperiode met een boete
of nabetaling als de klant zich niet aan de voorwaarden houdt.

**Waarom niet zelfstandig.** Dit is geen absolute uitsluiting maar een
bevoegdheidsgrens: **de agent stelt dit nooit zelf voor.** Een boete bij
niet-naleving is in een zakelijke Nederlandse context contractueel iets anders
dan een gratis pilot, en het vraagt juridische toetsing plus een expliciet
besluit van een mens.

Zolang het juridisch kader ontbreekt ([`LAYER.md`](LAYER.md), sectie 5), is die
toetsing niet uit te voeren en blijft de vorm dus buiten gebruik. De gewone
proefvorm zonder boeteclausule staat in `20-aanbodsequentie.md` (fase B) bij de
verlaging na een nee.

## 6. De volumenorm van honderd acties per dag

**Dit is een echte afwijking van de bron, geen nuance.**

**Wat de bron voorschrijft.** Honderd primaire acties per dag, als vaste
dagelijkse norm.

**Waarom niet.** Die norm is gebouwd voor een markt die praktisch oneindig is.
Onze doelgroep is eindig: in dit eerste segment gaat het om Nederlandse merken met
een paspoortplicht, in de duizenden. Bij honderd acties per dag is die markt in
een kwartaal aangeraakt, en daarna bestaat hij nog wel maar reageert hij niet meer.
De schade is bovendien niet terug te draaien: een lijst die verbrand is, is
verbrand, en de domeinreputatie gaat mee.

**Wat we in plaats daarvan doen: dekkingsdiscipline.** Elk account krijgt een
volledige reeks contactmomenten (vijf op `standaard`, zeven op `scherp`), en we
meten dekking en reekscompletering in plaats van dagvolume. De uitwerking staat in
`40-kanaaldoctrine.md` (fase B).

**Dekking is geen route om het bestaande volumeprincipe heen.**
[`outbound-principes.md`](../../playbooks/outbound-principes.md), principe 6,
blijft onverkort gelden: volume verhogen is een aparte beslissing. Zodra de lijst
groeit, wordt "vijf tot zeven contactmomenten per account" een volumeafspraak, en
dan geldt principe 6 op die afspraak.

## 7. Schaarste of een limiet op datavergaring

**Wat de bron voorschrijft.** Toegang en volume begrenzen om upgradedruk te
maken, ongeacht waar die begrenzing landt.

**Waarom niet.** Waar een klant datavergaring bewust ongelimiteerd heeft gemaakt,
is dat een propositiekeuze en geen omissie die wij mogen dichtzetten. Een
doctrineregel die daar schaarste of een limiet op legt, verkoopt tegen de
propositie in.

Bij de eerste klant in dit domein gaat het concreet om ongelimiteerde scans,
consumentenprofielen en resolver-calls op elk pakket, expliciet vastgelegd als
kernregel in de eigen prijsdocumentatie: klanten worden niet afgestraft op
datavergaring, want meer scans betekent meer waarde voor de klant en dus een
sterker argument om uit te breiden. De vindplaats staat bij het activeringsblok
van die klant.

**Hoe je dit toepast.** Voor elke klant geldt: stel vóór gebruik van deze laag
vast welke grootheid de klant bewust ongelimiteerd houdt, en sluit die grootheid
uit als aangrijpingspunt voor schaarste, limieten en upgradedruk. Is dat niet
vastgesteld, dan is dat een vraag aan Ward en geen aanname.

---

## Herkomst per uitsluiting

De tegenhanger van de bronnenlijst in [`99-grenzen.md`](99-grenzen.md). Hier is
"laag-eigen" de verwachte uitkomst en geen uitzondering, om de reden bovenaan dit
bestand.

| # | Uitsluiting | Bron buiten de laag | Removal-neutraal |
|---|---|---|---|
| 1 | loterijen en weggeefacties als instapaanbod | de Wet op de kansspelen, met corroboratie in de productdocumentatie van de eerste klant | ja, en de wettelijke beperking blijft ook zonder de laag gelden |
| 2 | facturatie per 28 dagen | geen | ja |
| 3 | gefabriceerde schaarste en tijdsdruk | geen. Hoort in het juridisch kader outbound zodra dat bestaat | ja |
| 4 | de anti-garantie | geen | ja |
| 5 | proefperiode met boeteclausule | geen, en de toetsing die hij vereist kan niet plaatsvinden zolang het juridisch kader ontbreekt | ja |
| 6 | de volumenorm van honderd acties per dag | geen als verbod, maar `outbound-principes.md` principe 6 blijft onafhankelijk gelden op elke volumeafspraak | ja, en principe 6 blijft ook zonder de laag gelden |
| 7 | schaarste of limiet op datavergaring | de vastgelegde propositiekeuze van de klant, vindplaats bij het activeringsblok | ja, en de propositiekeuze blijft ook zonder de laag gelden |

**Wat "removal-neutraal" hier betekent.** Verwijder de laag en er verandert geen
gedrag, want de mechanica die deze punten verwerpen bestaat dan niet meer. Bij de
punten 1, 6 en 7 blijft er daarnaast een beperking staan die niet van deze laag
afhangt, en die was er ook voordat deze laag bestond.

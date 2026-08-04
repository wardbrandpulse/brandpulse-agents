# Grenzen

> **Bewijslast: n=0.** Deze laag is externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).

Negen grenzen. Ze gelden op **elke** stand van de intensiteitsschijf, ook op
`off`, en ze gelden ongeacht wat een doctrineregel voorstelt.

Overtreding is een fout, geen afweging.

## De projectieregel, en de toets erachter

Een grens ontstaat bij voorkeur niet hier. Hij is een beperking die elders al
geldt, en dit bestand wijst er alleen naar. Dat is wat de laag verwijderbaar maakt
zonder gedragsverandering: haal hem weg en de beperking staat er nog, want de bron
ervan is niet verdwenen.

**Die regel is alleen waar als hij per grens klopt.** Daarom staat bij elke grens
de bron, met een letterlijke aanhaling waar die bestaat, en staat onderaan de
auditlijst met per grens een verdict.

**De toets is één vraag: zou de agent dit ook voorstellen zonder de laag?** Dat
antwoord bepaalt de categorie, en de categorie bepaalt of de verwijderbelofte voor
die regel geldt.

| Categorie | Wat de regel beperkt | Bron nodig | Verwijderen is |
|---|---|---|---|
| **1. projectie** | gedrag dat er zonder de laag ook is | ja, en die is er | neutraal |
| **2. laag-eigen, removal-neutraal** | alleen wat de laag zelf introduceert | nee | neutraal, want regel en mechanica verdwijnen samen |
| **3. laag-eigen, niet removal-neutraal** | gedrag dat er zonder de laag ook is | ja, maar die is er niet | **versoepelt iets. Dit is een gat in de repo** |

Van de negen grenzen zijn er zeven categorie 1, één categorie 2 (grens 5) en één
categorie 3 (grens 9).

**Categorie 1 en 2 sluiten elkaar niet uit.** Een regel kan laag-eigen zijn én een
bron buiten de laag hebben, en dan worden beide genoteerd. Ze zeggen verschillende
dingen: laag-eigen zegt dat verwijderen niets versoepelt, de externe bron zegt dat het
gedekt blijft mocht dezelfde tactiek langs een andere route binnenkomen. Bij de
grenzen komt die combinatie nu niet voor; bij de uitsluitingen wel, zie
[`90-uitsluitingen.md`](90-uitsluitingen.md), punt 2 en punt 6.

**Categorie 3 is wél exclusief.** Hij is de enige die iets over verwijderbaarheid
ontkent, dus een regel met een bron buiten de laag kan nooit categorie 3 zijn.

**Categorie 3 is geen restcategorie en geen nette oplossing.** Het is een gat, en
het staat als gat gelabeld omdat de andere twee uitwegen slechter zijn: een bron
aanwijzen die de beperking niet werkelijk oplegt maakt de projectieregel
decoratief, en de regel weglaten zou de beperking laten vallen. Een gat dat
zichtbaar is, wordt gedicht. Een gat dat als projectie is gelabeld, niet.

---

## Grens 1. Een datum alleen als hij aan de bron geverifieerd is

Een datum mag alleen genoemd worden als hij aan de bron is nagegaan. Niet als hij
plausibel is, niet als hij in een nieuwsbericht stond, en niet als hij intern al
een keer is doorgegeven.

**Het batterijpaspoort is de enige verplichting die als vaste datum in aanmerking
komt, en ook die is geblokkeerd tot verificatie aan de bron.**

Dat is strenger dan "de enige vaste datum", en niet uit voorzichtigheid maar
omdat de sectorlaag het zo vastlegt:

> **Openstaand, vóór extern gebruik:** de exacte datum, reikwijdte en vraag op
> wie de verplichting precies rust, verifiëren aan de bron. Zolang dat niet
> gedaan is, mag deze deadline niet als feit in klantcommunicatie worden
> gebruikt. `TODO: door Ward te laten verifiëren.`
>
> [`memory/sectors/ebike.md`](../../memory/sectors/ebike.md), sectie "Aannames,
> onbevestigd" (op 2026-08-04 regels 76 tot 79)

De aanhaling is het anker, niet het regelnummer: verschuiven de regels, dan geldt
de aangehaalde tekst nog steeds.

Daaruit volgt de stand van vandaag: er is **nul** bruikbare vaste datum. De enige
kandidaat is geblokkeerd. Een doctrineregel die om een datum vraagt, krijgt er dus
geen, en dat is de uitkomst en niet een omissie.

**Indicatieve termijnen worden nooit aangescherpt.** Niet in tekst, niet
impliciet, en niet door ze als haak te gebruiken. Geen "per <datum> verplicht"
waar de bron indicatief is, en geen formulering die strakker klinkt dan de bron.
Een indicatieve termijn mag als richting genoemd worden, met dat voorbehoud er
letterlijk bij. Dit geldt in elke regelgedreven markt en niet alleen in de sector
waar het voor het eerst opkwam.

**Het verbod op een geconstrueerde deadline staat apart, in grens 9.** Deze grens
gaat over een datum die bestaat en niet nagegaan is. Grens 9 gaat over een datum
die niet bestaat. Dat zijn twee verschillende fouten met een verschillende
herkomst, en grens 9 valt in categorie 3.

**De klantlaag kan strenger zijn en wint dan.** Staat er in het klantprofiel een
strengere eis over het noemen van deadlines, dan geldt die, conform de
root-`CLAUDE.md`, regels 55 tot 58: de specifiekere laag wint, en de
tegenstrijdigheid wordt gemeld. De concrete eis van de eerste klant staat bij het
activeringsblok in de config van die klant, want een klanteis hoort op de
klantas.

## Grens 2. Geen garantie op een wettelijke uitkomst, en geen toezegging die levering niet kan nakomen

Geen garantie dat iemand "compliant is", dat hij "aan de verplichting voldoet", of
dat een controle goed zal aflopen. En geen toezegging over iets dat er nog niet
is.

**Bron, en beide helften hebben er een.** Het klantprofiel, sectie
"Gevoeligheden":

> **Regelgeving niet als juridisch advies presenteren.** Qrius helpt bij het
> voldoen aan verplichtingen, maar bepaalt niet wat er juridisch van iemand wordt
> geëist. Het verschil tussen die twee moet in elke tekst overeind blijven.

Een compliance-garantie laat precies dat verschil instorten, dus die is hierdoor
verboden. En:

> **Geen toezeggingen over functionaliteit die nog niet in het product zit.**

Dat dekt de tweede helft: een garantie die levering niet kan nakomen is zo'n
toezegging.

Daarnaast plaatst [`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 1,
juridische duiding buiten dit domein, dus de laag mag de vraag niet eens
beantwoorden.

**Let op de sterkte van deze bron.** De sectie "Gevoeligheden" in het klantprofiel
staat daar gelabeld als "Afgeleid uit het product, nog te bevestigen". De
projectie is echt, maar de bron is zelf nog niet bevestigd. Wordt die sectie
verworpen of herschreven, dan verliest deze grens zijn grond en moet hij opnieuw
worden beoordeeld.

**Wat hier bewust níet staat.** Welke garanties wél mogen. Een grens zegt wat
verboden is; wat toegestaan is, is doctrine. De drie toegestane vormen van
risico-omkering (onvoorwaardelijk, voorwaardelijk, prestatiegebonden) komen in
`10-aanbodarchitectuur.md` in fase B, met de verwijzing terug naar deze grens.

## Grens 3. Het juridisch kader wint altijd

Doctrine bepaalt wat werkt, het juridisch kader bepaalt wat mag. Bij conflict:
juridisch, zonder afweging en zonder uitzondering.

**Bron.** [`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 1, sluit juridische
duiding uit dit domein, dus deze laag kan de vraag niet beantwoorden. De rangorde
zelf is een besluit van 2026-08-04 in
[`memory/decisions.md`](../../../../memory/decisions.md).

**Dat kader bestaat nog niet.** Zie [`LAYER.md`](LAYER.md), sectie 5. Zolang het
ontbreekt, is de vraag "mag dit" onbeantwoordbaar, en een onbeantwoordbare vraag
is geen groen licht.

## Grens 4. De huisstijl van de klant is het plafond

De laag verhoogt de toon nooit boven wat het klantprofiel toestaat.

Dat is de hele grens. Er staan hier bewust **geen** concrete toonregels: toon is
klantcontext en hoort op de klantas, in `clients/<klant>/profiel.md`. Zou dit
bestand voorschrijven hoe een tekst klinkt, dan zou de methodiek de context
overschrijven en zou de laag bij een tweede klant de verkeerde stijl afdwingen.

Praktisch betekent dit drie dingen:

- Wat het klantprofiel over toon zegt, geldt onverkort en gaat vóór elke
  doctrineregel over formulering.
- Staat er in het klantprofiel niets over een toonaspect, dan is dat geen
  vrijbrief. Dan is de vraag open en gaat hij naar Ward, niet naar de doctrine.
- De laag stelt zelf nooit een toonregel vast, ook niet als hij een gat ziet. Hij
  mag het gat melden.

**Bron.** De root-[`CLAUDE.md`](../../../../CLAUDE.md), sectie 1: als het antwoord
verandert zodra je een andere klant kiest, is het klantcontext. Het concrete
plafond staat in `clients/<klant>/profiel.md`, secties "Tone of voice" en
"Woordkeuze".

## Grens 5. De bronnaam komt nergens naar buiten

> **Deze grens is laag-eigen en niet geprojecteerd.**

De naam van de auteur achter deze mechanica staat nergens in output, en nergens in
de repo behalve in [`SOURCES.md`](SOURCES.md) binnen deze laag.

Geen letterlijke brontekst in de repo. Frameworks toepassen is normaal,
formuleringen overnemen niet. Alles staat in eigen Nederlandse termen; de
termenlijst staat in [`SOURCES.md`](SOURCES.md).

Het eigen vocabulaire is de reden dat er niets kan lekken. Het is geen cosmetica
en het is niet optioneel: wie een brongerichte term terugzet, haalt de
bescherming eruit.

**Waarom laag-eigen.** Er staat in deze repo niets over bronvermelding, citeren of
overnemen van formuleringen. Deze grens heeft dus geen voorganger en er is er ook
geen bij te zoeken. De bron is het besluit van 2026-08-04 in
[`memory/decisions.md`](../../../../memory/decisions.md).

**Consequentie voor de verwijderbelofte.** Die geldt hier langs een andere weg dan
bij de andere zeven, en hij geldt wel: verdwijnt de laag, dan verdwijnt
`SOURCES.md` mee, en dan staat er geen bronnaam meer in de repo om te beschermen.
Netto nul, net als bij een uitsluiting. Wat níet geldt is de projectie: er is geen
bestand buiten de laag dat deze regel oplegt.

## Grens 6. De laag raakt het ICP niet aan

Niet het scoremodel, niet de vijf diskwalificatiecriteria, niet de weging van de
assen, niet de ondergrenzen. Bij conflict wint het ICP.

Dit staat er expliciet omdat de verleiding bekend is: criteria versoepelen levert
volume op, en volume voelt als voortgang.

**Ook niet langs een omweg.** Het ICP van de eerste klant leidt zijn ondergrens
voor het aantal modellen af uit de eigen instapprijs. Een laag die aan de prijs
raakt, raakt daarmee aan een diskwalificatiecriterium. Dat is de tweede reden dat
de betaalstructuur gesplitst is; zie [`LAYER.md`](LAYER.md), sectie 3.

**Bron.** De root-[`CLAUDE.md`](../../../../CLAUDE.md), sectie 1, en het
twee-assenbesluit van 2026-07-29 in
[`memory/decisions.md`](../../../../memory/decisions.md): `domains/` bevat
uitsluitend methodiek, `clients/` uitsluitend context, en een wijziging aan de ene
as die de andere afdwingt betekent dat de scheiding is doorbroken. Het ICP is
klantcontext, vastgesteld door Ward. Een domeinlaag die het wijzigt, doorbreekt de
dragende keuze van de repo.

## Grens 7. De laag presenteert zichzelf niet als vastgestelde kennis

Elk bestand in deze laag opent met het bewijslastlabel. In output wordt een
doctrineregel nooit gepresenteerd als eigen bevinding, als playbook, als
sectorkennis of als "wat we hebben gezien".

Wordt een doctrineregel in een advies gebruikt, dan staat erbij dat hij extern en
niet-gevalideerd is, met n=0.

**Bron.** De root-[`CLAUDE.md`](../../../../CLAUDE.md), sectie 4: een uitspraak
zonder n is geen uitspraak maar een indruk, en dan hoort het woord "indruk" er
letterlijk bij. En sectie 3: playbookniveau is het eindpunt van een promotie over
twee sectoren, dus geen startpositie. Deze laag als vastgestelde kennis
presenteren zou de promotieregel omzeilen.

## Grens 8. De laag stelt geen bedragen vast

Geen bedrag, geen percentage, geen looptijd, geen kortingshoogte, geen
betaalsplitsingsverhouding, geen capaciteitsgrens en geen garantietermijn.

Die horen in `clients/<klant>/`, want het zijn menselijke besluiten met
commerciële en juridische gevolgen. De laag beschrijft de methode en mag
signaleren dat een bedrag ontbreekt. Hij vult het niet in, ook niet als voorbeeld,
ook niet als plaatsvervangend getal, en ook niet met een bereik.

**Bron.** Drie, die elk afzonderlijk volstaan. De
root-[`CLAUDE.md`](../../../../CLAUDE.md), sectie 1 (bedragen veranderen per
klant, dus klantcontext) en sectie 9 ("Liever een leeg veld dan een verzonnen
veld"). En [`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 1, dat prijsbepaling
buiten dit domein plaatst.

**Reden dat dit een aparte grens is en niet een detail:** een verzonnen bedrag in
een methodiekbestand wordt bij de volgende klant hergebruikt als uitgangspunt.

## Grens 9. Geen geconstrueerde schaarste of tijdsdruk

> **Categorie 3: laag-eigen en niet removal-neutraal. Dit is een gat in de repo.**

Geen deadline die wij verzinnen. Geen capaciteitsgrens die niet bestaat. Geen
oplopende prijs die niet gaat oplopen. Ook niet als het werkt, en ook niet op stand
`scherp`.

Schaarste mag alleen genoemd worden als hij feitelijk waar is: een capaciteitsgrens
die er echt is, of een datum die echt vaststaat. De enige vorm van tijdsdruk die
deze laag mag gebruiken is een aangekondigde prijsverhoging die werkelijk doorgaat,
en de voorwaarden daarvoor staan in
[`50-betaalstructuur.md`](50-betaalstructuur.md), sectie 5.

**Waarom dit een gat is en niet een projectie.** Deze beperking heeft in deze repo
geen voorganger: er staat nergens iets over verzonnen feitelijke claims in
klantcommunicatie. En de mechanica bestaat wél zonder de laag, want elke agent die
outboundcopy schrijft kan urgentie verzinnen. De toets valt dus twee keer verkeerd
uit: geen bron, en niet removal-neutraal.

**De consequentie, letterlijk.** Wordt deze laag verwijderd, dan verdwijnt deze
beperking en verbiedt niets in deze repo nog een verzonnen deadline. Dat is geen
theoretisch risico: het is precies het soort claim dat onder druk ontstaat en dat
achteraf niet meer te herstellen is.

**Waar dit hoort te eindigen.** Een verzonnen deadline of capaciteitsgrens is in de
eerste plaats misleiding en dus een kwestie van recht, geen commerciële smaak. Het
hoort in `domains/gtm/playbooks/juridisch-kader-outbound.md`. Zodra dat bestaat,
verhuist deze grens daarheen en wordt hij categorie 1. Tot die tijd staat hij hier
met dit label.

**Eerder stond dit als tweede helft van grens 1 en daarna als uitsluiting 3.** Beide
plekken waren fout: in grens 1 stond het zonder bron alsof het geprojecteerd was, en
als uitsluiting las het als removal-neutraal, wat het niet is. Zie het besluit van
2026-08-04 in [`memory/decisions.md`](../../../../memory/decisions.md).

---

## Herkomst per grens

Dit is de auditlijst van de projectieregel. Staat hier een grens met verdict
"laag-eigen", dan is dat een bewuste, gemarkeerde uitzondering en geen
vergeetachtigheid.

| Grens | Zou de agent dit ook zonder de laag doen? | Bron buiten de laag | Categorie |
|---|---|---|---|
| 1, datum aan de bron geverifieerd | ja | `memory/sectors/ebike.md` (verbatim aangehaald), en strenger op de klantas in `clients/<klant>/profiel.md`, sectie "Gevoeligheden" | 1, projectie |
| 2, geen wettelijke garantie of onnakombare toezegging | ja | `clients/<klant>/profiel.md`, sectie "Gevoeligheden", twee bullets, plus `domains/gtm/CLAUDE.md` sectie 1 | 1, projectie, **maar de bron is zelf gelabeld als afgeleid en nog te bevestigen** |
| 3, juridisch kader wint | ja | `domains/gtm/CLAUDE.md` sectie 1, plus het besluit van 2026-08-04. Het kader zelf bestaat nog niet | 1, projectie, met openstaande afhankelijkheid |
| 4, huisstijl is het plafond | ja | root-`CLAUDE.md` sectie 1, plus `clients/<klant>/profiel.md` | 1, projectie |
| 5, bronnaam nergens naar buiten | **nee**, er is zonder de laag geen bron om te noemen | geen, en geen nodig | 2, laag-eigen en removal-neutraal |
| 6, laag raakt het ICP niet aan | ja | root-`CLAUDE.md` sectie 1, het twee-assenbesluit van 2026-07-29, en `clients/<klant>/gtm/icp.md` | 1, projectie |
| 7, niet als vastgestelde kennis | ja | root-`CLAUDE.md` sectie 3 en sectie 4 | 1, projectie |
| 8, geen bedragen | ja | root-`CLAUDE.md` sectie 1 en sectie 9, plus `domains/gtm/CLAUDE.md` sectie 1 | 1, projectie |
| 9, geen geconstrueerde schaarste | **ja**, elke agent die copy schrijft kan urgentie verzinnen | **geen** | **3, laag-eigen en niet removal-neutraal. Gat in de repo** |

**Er staat precies één gat in deze lijst, en het is grens 9.** Zolang het juridisch
kader outbound ontbreekt, draagt deze laag een beperking die bij verwijdering
verdwijnt terwijl hij zou moeten blijven. Dat staat als openstaand punt op de
klantas, met de prioriteit die eraan hangt.

**Grens 2 is geen gat maar wel de zwakste projectie.** De bron bestaat, maar staat in
het klantprofiel gelabeld als afgeleid en nog te bevestigen. Bevestigen is een
openstaand punt met Ward als eigenaar. Wordt die sectie herschreven, dan verliest
deze grens zijn grond en moet hij opnieuw beoordeeld worden.

# Grenzen

> **Bewijslast: n=0.** Deze laag is externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).

Acht grenzen. Ze gelden op **elke** stand van de intensiteitsschijf, ook op
`off`, en ze gelden ongeacht wat een doctrineregel voorstelt.

**Geen enkele grens hier ontstaat hier.** Elke grens is een projectie van een
beperking die elders al geldt. Dat is met opzet: haal de laag weg en er verdwijnt
geen beperking, want de bron ervan staat er nog. Bij elke grens staat de bron
erbij. Blijkt een grens geen bron te hebben, dan is dat een fout in dit bestand
en niet een nieuwe regel.

Overtreding is een fout, geen afweging.

---

## Grens 1. Schaarste en tijdsdruk alleen als ze feitelijk waar zijn

Een capaciteitsgrens mag alleen genoemd worden als hij echt bestaat, en een
datum alleen als hij echt vaststaat.

**Het batterijpaspoort is de enige verplichting die als vaste datum in
aanmerking komt, en ook die is geblokkeerd tot verificatie aan de bron.**

Dat is strenger dan "de enige vaste datum", en dat is niet strenger uit
voorzichtigheid maar omdat de sectorlaag het zo vastlegt:

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
letterlijk bij. Dit geldt in elke regelgedreven markt en niet alleen in de
sector waar het voor het eerst opkwam.

**Nooit een geconstrueerde deadline.** Zie ook uitsluiting 3 in
[`90-uitsluitingen.md`](90-uitsluitingen.md).

**De klantlaag kan strenger zijn en wint dan.** Staat er in het klantprofiel een
strengere eis over het noemen van deadlines, dan geldt die, conform de
root-`CLAUDE.md`, regels 55 tot 58: de specifiekere laag wint, en de
tegenstrijdigheid wordt gemeld. De concrete eis van de eerste klant staat bij het
activeringsblok in de config van die klant, want een klanteis hoort op de
klantas.

## Grens 2. Geen compliance-belofte

Geen garantie op een wettelijke uitkomst. Niet dat iemand "compliant is", niet
dat hij "aan de verplichting voldoet", niet dat een controle goed zal aflopen.

Garanties mogen alleen op **proces of inspanning**, en alleen als levering ze kan
nakomen. Een garantie die levering niet kan nakomen is geen commercieel
instrument maar een schuld.

**Bron.** De klant helpt bij het voldoen aan verplichtingen en bepaalt niet wat
er juridisch van iemand wordt geëist; dat onderscheid moet in elke tekst
overeind blijven. Het staat als gevoeligheid in het klantprofiel en volgt
daarnaast uit [`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 1, dat
juridische duiding buiten dit domein plaatst.

## Grens 3. Het juridisch kader wint altijd

Doctrine bepaalt wat werkt, het juridisch kader bepaalt wat mag. Bij conflict:
juridisch, zonder afweging en zonder uitzondering.

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

**Bron.** De root-`CLAUDE.md`, sectie 1: als het antwoord verandert zodra je een
andere klant kiest, is het klantcontext.

## Grens 5. De bronnaam komt nergens naar buiten

De naam van de auteur achter deze mechanica staat nergens in output, en nergens
in de repo behalve in [`SOURCES.md`](SOURCES.md) binnen deze laag.

Geen letterlijke brontekst in de repo. Frameworks toepassen is normaal,
formuleringen overnemen niet. Alles staat in eigen Nederlandse termen; de
termenlijst staat in [`SOURCES.md`](SOURCES.md).

Het eigen vocabulaire is de reden dat er niets kan lekken. Het is geen cosmetica
en het is niet optioneel: wie een brongerichte term terugzet, haalt de
bescherming eruit.

## Grens 6. De laag raakt het ICP niet aan

Niet het scoremodel, niet de vijf diskwalificatiecriteria, niet de weging van de
assen, niet de ondergrenzen. Bij conflict wint het ICP.

Dit staat er expliciet omdat de verleiding bekend is: criteria versoepelen levert
volume op, en volume voelt als voortgang.

**Ook niet langs een omweg.** Het ICP van de eerste klant leidt zijn ondergrens
voor het aantal modellen af uit de eigen instapprijs. Een laag die aan de prijs
raakt, raakt daarmee aan een diskwalificatiecriterium. Dat is de tweede reden dat
de betaalstructuur gesplitst is; zie [`LAYER.md`](LAYER.md), sectie 3.

## Grens 7. De laag presenteert zichzelf niet als vastgestelde kennis

Elk bestand in deze laag opent met het bewijslastlabel. In output wordt een
doctrineregel nooit gepresenteerd als eigen bevinding, als playbook, als
sectorkennis of als "wat we hebben gezien".

Wordt een doctrineregel in een advies gebruikt, dan staat erbij dat hij extern en
niet-gevalideerd is, met n=0. Zonder dat label is het een uitspraak zonder n, en
dan hoort het woord "indruk" er letterlijk bij (root-`CLAUDE.md`, sectie 4).

## Grens 8. De laag stelt geen bedragen vast

Geen bedrag, geen percentage, geen looptijd, geen kortingshoogte, geen
betaalsplitsingsverhouding, geen capaciteitsgrens en geen garantietermijn.

Die horen in `clients/<klant>/`, want het zijn menselijke besluiten met
commerciële en juridische gevolgen. De laag beschrijft de methode en mag
signaleren dat een bedrag ontbreekt. Hij vult het niet in, ook niet als
voorbeeld, ook niet als plaatsvervangend getal, en ook niet met een bereik.

**Reden dat dit een aparte grens is en niet een detail:** een verzonnen bedrag in
een methodiekbestand wordt bij de volgende klant hergebruikt als uitgangspunt.
Liever een leeg veld dan een verzonnen veld (root-`CLAUDE.md`, sectie 9).

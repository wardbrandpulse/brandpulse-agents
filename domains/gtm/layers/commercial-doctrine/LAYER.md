# Laag: commerciële doctrine

> **Bewijslast: n=0.** Alles in deze laag is externe, niet-gevalideerde kennis.
> Nul gesprekken, nul verzonden reeksen, nul gecodeerde replies waaruit hier
> iets is afgeleid. Er is geen enkele uitspraak in deze laag die een drempel uit
> [`significantie-drempels.md`](../../playbooks/significantie-drempels.md)
> haalt, en er is geen enkele uitspraak die dat op korte termijn gaat halen.
> Zie de bewijslastregel in de root-[`CLAUDE.md`](../../../../CLAUDE.md),
> sectie 4.

- **Naam:** `commercial-doctrine`
- **Versie:** 1
- **Status:** extern, niet-gevalideerd, niet gepromoveerd
- **Aangemaakt:** 2026-08-04
- **Herkomst:** zie [`SOURCES.md`](SOURCES.md)

---

## 1. Wat dit is, en wat het uitdrukkelijk niet is

Een verwijderbare, uitbreidbare laag met commerciële mechanica: aanbodontwerp,
aanbodsequentie, weggevers, kanaalkeuze, betaalstructuur, acquisitierekenwerk en
gespreksstructuur. De laag beïnvloedt **wat er besloten wordt**, niet **hoe het
klinkt**.

Dat onderscheid is het ontwerp en niet een nuance. De mechanica is bruikbaar; de
retoriek van de bron is dat niet.

**Dit is geen playbook.** Een playbook geldt altijd, in elke sector, bij elke
klant, en verandert zelden (root-`CLAUDE.md`, sectie 1). Deze laag is het
tegenovergestelde: extern van herkomst, ongetoetst, en per klant aan of uit. Om
die reden staat hij in `layers/` en niet in `playbooks/`, en om die reden mag hij
niet als vastgestelde kennis worden gepresenteerd (zie
[`99-grenzen.md`](99-grenzen.md), grens 7).

**Promotie loopt alleen via de bestaande route.** Een regel uit deze laag klimt
niet naar sector- of playbookniveau door hier te staan. Hij ontstaat als lering
in `clients/<klant>/gtm/memory/learnings.md` en klimt via de promotieregel uit
de root-`CLAUDE.md`, sectie 3, altijd met bevestiging van Ward. Er is geen
sluiproute en deze laag is er geen.

## 2. Wanneer deze laag meedoet

In de vorm van de playbooktabel in
[`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 2, zodat een lezer die die
tabel kent deze regel kan plaatsen. De laag staat daar bewust **niet** in: geen
enkel bestaand bestand verwijst naar deze laag, zie sectie 6.

| Laag | Geldt bij | Status |
|---|---|---|
| `commercial-doctrine` | een aanbod-, sequentie-, weggever-, kanaal-, betaalstructuur- of gespreksvraag, **en** alleen als hij voor deze klant aan staat | extern, niet-gevalideerd, niet gepromoveerd |

Aan of uit staat per klant in `clients/<klant>/gtm/config.md`, sectie "Lagen".
Staat de laag daar niet, dan staat hij uit. Ontbreken van de regel is niet
hetzelfde als een ontbrekende beslissing: uit is de veilige stand en de default.

## 3. Scope

### Mag beïnvloeden

- outbound-copy, in de zin van welke keuze de tekst maakt, niet hoe hij klinkt
- aanbodontwerp en de opbouw van een aanbod
- beoordeling van de pijplijn
- de opvolgcadans en de dekking van een contactreeks

### Mag niet beïnvloeden

- **ICP-scoring en de vijf diskwalificatiecriteria.** Bij conflict wint het ICP.
  Dit staat er expliciet omdat de verleiding bestaat om criteria te versoepelen
  voor volume.
- **Juridische afweging.** De laag bepaalt wat werkt, het juridisch kader
  bepaalt wat mag. Zie sectie 5.
- **Het vaststellen van bedragen.** Geen bedrag, geen percentage, geen looptijd,
  geen kortingshoogte en geen capaciteitsgrens ontstaat in deze laag. Die komen
  uit `clients/<klant>/`.
- **Prijsbepaling.** [`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 1, sluit
  prijsbepaling uit dit domein. Dat blijft zo, en deze laag verruimt dat niet.

### Waarom prijsbepaling apart genoemd staat

Omdat het onderscheid tussen "presenteren" en "bepalen" bij de meeste
onderdelen niet standhoudt. Een bedrag boven het doelbedrag ankeren is een
prijsbesluit, net als een vooruitbetaalkorting en net als een aangekondigde
verhoging. Daarom is de betaalstructuur gesplitst: de techniek staat in
[`50-betaalstructuur.md`](50-betaalstructuur.md) (fase B), en het ankerbedrag,
de vooruitbetaalkorting, de splitsingsverhouding en de vraag of er een verhoging
wordt aangekondigd staan in `clients/<klant>/`.

Er is een tweede, zwaardere reden. Het ICP van de eerste klant leidt zijn
ondergrens voor het aantal modellen af **uit de eigen instapprijs**. Via de prijs
kon deze laag dus een diskwalificatiecriterium verschuiven, en daarmee precies
doen wat de scopegrens hierboven verbiedt. Met de splitsing kan dat niet meer.

**Wat de laag wél mag:** signaleren dát er geen anker of geen vooruitbetaalprikkel
in de structuur zit. Dat signaal gaat terug naar Ward. De laag zet er nooit zelf
een.

## 4. Precedence

Van hoog naar laag:

```
root-CLAUDE.md
        v
juridisch kader outbound        (bestaat nog niet, zie sectie 5)
        v
99-grenzen.md
        v
90-uitsluitingen.md
        v
ICP van de klant
        v
doctrine (00 tot en met 70)
```

**Dit is geen nieuwe botsregel.** De twee regels die botsingen beslechten,
bestaan al en blijven ongewijzigd gelden:

> Als een domeinregel en een regel uit dit bestand botsen, wint dit bestand.
>
> root-[`CLAUDE.md`](../../../../CLAUDE.md), regel 7

> Bij tegenstrijdigheid tussen lagen wint de specifiekere laag voor het advies
> van dat moment, maar de tegenstrijdigheid wordt **expliciet gemeld** in de
> output. Stil oplossen is niet toegestaan: een klant die structureel afwijkt
> van de sector is zelf een bevinding.
>
> root-[`CLAUDE.md`](../../../../CLAUDE.md), regels 55 tot 58

De rangorde hierboven is een **filter op wat de doctrine mag voorstellen**, geen
rangorde tussen geheugenlagen. Tussen geheugenlagen geldt onverkort de tweede
regel: specifieker wint, en de tegenstrijdigheid wordt gemeld.

Twee gevolgen die anders verkeerd gelezen worden:

- **"99-grenzen boven ICP" betekent niet dat het domein de klant overrulet.** Het
  betekent dat een grens een doctrinevoorstel blokkeert, ook als het ICP het zou
  toestaan. Een prospect met de hoogste score geeft geen recht op een
  geconstrueerde deadline. Omgekeerd gebeurt nooit: geen enkele grens versoepelt
  ooit een ICP-criterium, en grens 6 verbiedt dat expliciet.
- **De meldplicht geldt ook binnen deze laag.** Botst een doctrineregel met een
  grens, een uitsluiting, het ICP of een andere geheugenlaag, dan wordt dat in de
  output benoemd in de sectie "Wat ik niet kon vaststellen". Stil oplossen mag
  niet, ook niet als de uitkomst evident lijkt.

### Een geblokkeerd voorstel wordt gemeld

Het filter werkt niet stil. Houdt een grens of een uitsluiting een
doctrinevoorstel tegen, dan is dat geen ruis maar informatie: het laat zien waar
de methodiek en onze beperkingen uiteenlopen.

Wat er gemeld wordt, per blokkade: welk voorstel, welke grens of uitsluiting hem
tegenhield, en wat er in plaats daarvan is gedaan. Dat hoort in de sectie "Wat ik
niet kon vaststellen" van de output, in dezelfde geest als de meldplicht bij
tegenstrijdigheid tussen geheugenlagen (root-`CLAUDE.md`, regels 55 tot 58).

**Waarom dit meer is dan netheid.** Het aantal blokkades is een maat voor de
aansluiting van de laag op deze markt. Veel blokkades betekent dat de doctrine
slecht past, en dat is precies de bevinding waarop later besloten wordt hem te
verwijderen. Een stil filter zou dat signaal weggooien en de laag onweerlegbaar
maken. Blokkades worden daarom meegenomen in het voorstel voor de
aanbevelingentabel in fase C, naast de voorspelkwaliteit.

## 5. Het juridisch kader is een openstaande afhankelijkheid

**Het bestaat nog niet.** De precedenceverwijzing hierboven wijst naar een
document dat er niet is. Voorziene plek:
`domains/gtm/playbooks/juridisch-kader-outbound.md`, als
randvoorwaardendocument dat vastgelegde operationele beperkingen registreert, en
niet als juridische duiding. Dat onderscheid is dragend, want
[`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 1, sluit juridische duiding
uit en dat blijft zo.

**De consequentie, en die is hard.** Zolang dat kader ontbreekt, kan geen enkele
laag de vraag "mag dit" beantwoorden. Deze laag kan hem zeker niet beantwoorden:
hij bepaalt wat werkt.

### Het kader heeft inmiddels twee vastgestelde onderdelen die erop wachten

Dit is geen vage TODO meer. Uit fase A en B kwamen twee beperkingen die wij zelf
hebben opgeschreven en die daar horen te staan in plaats van hier:

1. **Geen geconstrueerde deadline of capaciteitsgrens.** Nu grens 9, categorie 3,
   dus een beperking die bij verwijdering van de laag verdwijnt.
2. **Geen garantie over een wettelijke uitkomst.** Nu grens 2, en de bron daarvan
   staat in het klantprofiel gelabeld als afgeleid en nog te bevestigen.

**Dat verandert de prioriteit.** Zolang het kader ontbreekt draagt deze laag twee
regels die bij verwijdering wegvallen terwijl ze zouden moeten blijven. Het gaat
daarmee niet om netheid maar om twee beperkingen die op de verkeerde plek staan.
Beide staan als openstaand punt op de klantas.

**Een inhoudelijk gereede laag opent de verzendpoort niet.** Die poort staat in
[`outbound-principes.md`](../../playbooks/outbound-principes.md), principe 2, en
sluit met: "Zonder een ingevuld verzenddomein wordt er geen outbound verstuurd."
Verzenddomein, opwarmdatum en verzendplatform staan in de config van de eerste
klant alle drie op `TODO`. Dat er doctrine klaarstaat, verandert daar niets aan.
Een volledig gevulde laag op stand `scherp` met een lege verzendconfiguratie
betekent: er gaat niets uit.

## 6. Intensiteitsschijf

Eén stand per klant, in `clients/<klant>/gtm/config.md`. De bestanden 00 tot en
met 70 komen in fase B; de schijf staat hier nu al vast zodat de nummering en de
standen niet later bijgebogen worden.

| Stand | Actieve bestanden | Wat het doet |
|---|---|---|
| `off` | geen | laag inert, gedrag identiek aan zonder laag |
| `licht` | 00, 40, 60 | alleen diagnose, kanaalkeuze en rekenwerk. Geen persuasiemechaniek |
| `standaard` | + 10, 20, 30, 70 | aanbodarchitectuur, sequentie, weggevers, gespreksstructuur |
| `scherp` | + 50 | betaalstructuur actief: ankeren en vooruitbetaling als techniek, toegepast op bedragen die uit `clients/<klant>/` komen. Verlagingsladder standaard klaar, achter-de-hand-waarde harder ingezet, opvolgcadans naar het maximum (zeven contactmomenten), feitelijke schaarste expliciet benoemd binnen grens 1 |

**Op elke stand, ook op `scherp`:** de laag stelt geen bedragen vast, en grenzen
en uitsluitingen gelden onverkort.

**Drie bestanden staan buiten de schijf** en gelden zodra de laag aan staat:
[`99-grenzen.md`](99-grenzen.md), [`90-uitsluitingen.md`](90-uitsluitingen.md) en
[`80-meetkoppeling.md`](80-meetkoppeling.md). De eerste twee begrenzen, de derde
registreert. Geen van de drie beïnvloedt een besluit, dus ze horen niet in een stand
thuis.

### Waarom `off` echt inert is, en niet "inert op papier"

[`99-grenzen.md`](99-grenzen.md) en [`90-uitsluitingen.md`](90-uitsluitingen.md)
gelden op elke stand. Dat lijkt te botsen met "op `off` is het gedrag identiek
aan zonder laag". Het botst niet, maar de reden is voor grenzen en uitsluitingen
verschillend, en dat onderscheid moet scherp blijven.

**De toets is één vraag: zou de agent dit ook doen zonder de laag?** Dat antwoord
bepaalt de categorie, en de categorie bepaalt of de verwijderbelofte voor die regel
geldt. Drie categorieën, en ze gelden voor grenzen en uitsluitingen door elkaar:

| Categorie | Beperkt | Bron nodig | Verwijderen is |
|---|---|---|---|
| **1. projectie** | gedrag dat er zonder de laag ook is | ja, en die is er | neutraal |
| **2. laag-eigen, removal-neutraal** | alleen wat de laag introduceert | nee | neutraal, regel en mechanica verdwijnen samen |
| **3. laag-eigen, niet removal-neutraal** | gedrag dat er zonder de laag ook is | ja, maar die is er niet | **versoepelt iets. Een gat in de repo** |

**Categorie 1 is waar de meeste beperkingen thuishoren.** Een projectie ontstaat niet
hier; de beperking staat in de root-`CLAUDE.md`, in het domein, in het klantprofiel,
in het ICP, in de sectorlaag of in de wet. Haal de laag weg en ze staat er nog.

**Categorie 2 heeft geen bron nodig en dat is geen tekort.** Verwerpt een regel
mechanica die alleen via de doctrine binnenkomt, dan haalt verwijderen beide in één
keer weg. Er een bron bij zoeken zou misleidend zijn.

**Categorie 3 is een gat, en het staat als gat gelabeld.** Er valt op dit moment
precies één regel in: grens 9, het verbod op geconstrueerde schaarste. Verwijder de
laag en die beperking verdwijnt terwijl hij zou moeten blijven. De twee alternatieven
zijn slechter: een bron aanwijzen die de beperking niet werkelijk oplegt maakt de
projectieregel decoratief, en de regel weglaten laat de beperking vallen.

**Categorie 1 en 2 sluiten elkaar niet uit; categorie 3 wel.** Een regel kan
laag-eigen zijn **en** een bron buiten de laag hebben. Dan worden beide genoteerd, want
ze zeggen verschillende dingen: laag-eigen zegt dat verwijderen niets versoepelt, en
de externe bron zegt dat het gedekt blijft mocht dezelfde tactiek ooit langs een andere
route binnenkomen. Uitsluiting 2 en uitsluiting 6 zijn beide, en punt 2 is het
duidelijkste geval.

Categorie 3 is de enige die iets over verwijderbaarheid **ontkent**, en daarom de
enige die exclusief is: een regel met een bron buiten de laag kan nooit categorie 3
zijn.

**Waar elke regel valt, staat in de twee auditlijsten:**
[`99-grenzen.md`](99-grenzen.md) sectie "Herkomst per grens" en
[`90-uitsluitingen.md`](90-uitsluitingen.md) sectie "Herkomst per uitsluiting".
Beide hebben de toetsvraag als kolom, zodat de indeling na te rekenen is en niet
alleen te vertrouwen.

## 7. Verwijderprocedure

Zes stappen. Daarna houdt de agent identiek gedrag.

1. **Verwijder de regel `commercial-doctrine`** uit de tabel in sectie "Lagen"
   van `clients/<klant>/gtm/config.md`, voor elke klant waar hij staat. Blijft de
   sectie leeg achter, verwijder dan de sectie.
2. **Verwijder de map** `domains/gtm/layers/commercial-doctrine/`. Blijft
   `domains/gtm/layers/` leeg achter, verwijder die dan ook.
3. **Verwijder** `infra/laag-check.sh`. Dat script bestaat uitsluitend om deze
   laag te controleren en heeft zonder de laag geen functie. Blijft het staan,
   dan faalt het voor altijd op een ontbrekend activeringsblok en wordt een rode
   check normaal, en dat is erger dan geen check.
4. **Zet een statusnotitie bij de besluiten in `memory/decisions.md`.** De
   besluiten blijven staan en worden niet verwijderd, maar ze krijgen de
   markering vervallen met datum en de reden, conform de praktijk in dat bestand
   (zie het vervallen besluit van 2026-07-29 over `utm_medium`) en de
   degradatieregel in de root-`CLAUDE.md`, sectie 3. Een besluit dat spoorloos
   verdwijnt, wordt over een jaar opnieuw genomen. Een besluit dat blijft staan
   zonder notitie, leest als geldend beleid over een laag die er niet meer is.
5. **Drop de twee check-constraints op `source_layer`**, in
   `agent_recommendations` en `agent_blocked_proposals`. Die noemen de laag bij
   naam. Met een **nieuwe** migratie, niet door de bestaande aan te passen
   ([`infra/migratie-proces.md`](../../../../infra/migratie-proces.md), sectie 1 en
   6). **De kolommen en de tabel blijven staan:** een lege kolom is
   gedragsneutraal, een constraint die naar een verdwenen laag verwijst is dat
   niet. Zie [`80-meetkoppeling.md`](80-meetkoppeling.md), sectie 7.
6. **Verifieer** dat er niets achterblijft:

   ```
   grep -ril "commercial-doctrine" . --exclude-dir=.git
   ```

   Verwacht: uitsluitend treffers in `memory/decisions.md` en in
   `supabase/migrations/`. Beide blijven bij ontwerp staan, want een besluit en een
   toegepaste migratie worden nooit gewist. Elke andere treffer is een restant.

### Wat verwijderen kost, en wat de garantie waard is

**Eerst de kosten, dan de garantie.** In die volgorde, omdat de kosten gegroeid zijn
en een bestand dat zijn eigen drift laat zien meer waard is dan een bestand dat klopt.

| Stap | Handeling | Waar |
|---|---|---|
| 1 | één tabelregel weg, en de sectie als hij leegvalt | `clients/<klant>/gtm/config.md` |
| 2 | één map weg, en `layers/` als die leegvalt | `domains/gtm/layers/commercial-doctrine/` |
| 3 | één script weg | `infra/laag-check.sh` |
| 4 | statusnotitie bij elf besluiten, die blijven staan | `memory/decisions.md` |
| 5 | **een nieuwe migratie schrijven en toepassen** die twee constraints dropt | `supabase/migrations/` |
| 6 | verifiëren met een grep | hele repo |

**Wat permanent achterblijft:** vijf lege kolommen op `agent_recommendations`, vier op
`gtm_events`, één lege tabel, en het migratiebestand.

**Bij oplevering van fase A waren dit twee handelingen: één map en één configregel.**
De groei zit volledig in fase C, die de meetkoppeling toevoegde. Dat is een bewuste
ruil, want zonder meting is de laag niet te evalueren en dus niet eerlijk te
verwijderen, maar het is wel een ruil en niet gratis. Wie deze tabel over een jaar
leest, moet kunnen zien dat de belofte is opgeschoven.

**En wat de garantie dan waard is.** Na deze zes stappen is het gedrag identiek aan het
gedrag van vóór de laag, om vier redenen die alle vier machinaal of per inspectie te
controleren zijn:

1. Geen enkel bestand onder `domains/` verwijst naar de laag. Dit wordt getest,
   zie `infra/laag-check.sh`.
2. **Er zijn precies vier verwijzingen van buiten, en de procedure handelt ze alle
   vier af.** Het activeringsblok verdwijnt (stap 1), het checkscript verdwijnt
   (stap 3), de besluiten blijven staan met een statusnotitie (stap 4), en het
   migratiebestand blijft staan terwijl de constraints die de laag bij naam noemen
   worden gedropt (stap 5).

   **Vier is het plafond en niet de stand.** Het activeringsblok plus drie
   uitzonderingscategorieën in `infra/laag-check.sh`. Er komt geen vijfde bij. Is er
   een vijfde nodig, dan is dat het signaal en niet de oplossing: dan is deze laag
   minder geïsoleerd dan hier geclaimd wordt, en volgt er een herbeoordeling van de
   plaatsing met een besluit in
   [`memory/decisions.md`](../../../../memory/decisions.md). Niet een vierde
   uitzondering erbij en de check groen houden.

   **De handhaving is de diff op dat script en niet iets automatisch.** Een categorie
   toevoegen kan alleen door de lijst erin te wijzigen, en dat is zichtbaar in review.
   Dat is een beperking, en hij staat hier zodat niemand denkt dat de check het
   plafond zelf bewaakt.
3. Geen grens die als projectie is gemarkeerd ontstaat hier, dus verwijderen
   heft die beperking niet op. Voor de twee laag-eigen grenzen geldt dat niet, en
   dat staat per grens in [`99-grenzen.md`](99-grenzen.md). Uitsluitingen zijn
   laag-eigen maar removal-neutraal, want ze verwerpen mechanica die zonder de
   laag niet bestaat. Zie sectie 6.
4. De laag heeft nooit een bedrag, een taxonomiewaarde, een ICP-criterium of een
   drempel vastgesteld. Die staan allemaal buiten de laag en blijven staan.

**Waar de garantie ophoudt.** Fase C voegt kolommen toe aan de aanbevelingentabel en
een tabel voor geblokkeerde voorstellen; zie
[`80-meetkoppeling.md`](80-meetkoppeling.md). Een toegepaste migratie wordt nooit
teruggedraaid ([`infra/migratie-proces.md`](../../../../infra/migratie-proces.md),
sectie 6). Na fase C blijven die kolommen dus staan als de laag verdwijnt. Dat is
het enige onomkeerbare residu, het bestaat uit lege kolommen, en het verandert
geen gedrag. Het staat hier zodat niemand het later als een gebroken belofte
leest.

**Eén zesde stap komt erbij zodra fase C gebouwd is.** De check-constraints op
`source_layer` noemen de laag bij naam in de database. Die zijn dan de enige
verwijzing buiten de repo, en ze worden opgeruimd met een migratie van één regel.
Verwijderen van de constraint, niet van de kolom: een kolom laten staan is
gedragsneutraal, een constraint die naar een verdwenen laag verwijst is dat niet.

## 8. Bestanden in deze laag

| Bestand | Wat het is | Fase |
|---|---|---|
| `LAYER.md` | dit manifest | A |
| [`99-grenzen.md`](99-grenzen.md) | harde grenzen, gelden op elke stand | A |
| [`90-uitsluitingen.md`](90-uitsluitingen.md) | mechanieken die de bron voorschrijft en wij bewust niet gebruiken | A |
| [`SOURCES.md`](SOURCES.md) | herkomst en eigen termenlijst | A |
| [`00-principes.md`](00-principes.md) | vijf principes | B |
| [`10-aanbodarchitectuur.md`](10-aanbodarchitectuur.md) | waardeformule, probleemontleding, risico-omkering | B |
| [`20-aanbodsequentie.md`](20-aanbodsequentie.md) | instap, uitbreiding, verlaging na een nee, doorlopend | B |
| [`30-weggever.md`](30-weggever.md) | negen stappen plus kwaliteitstoets | B |
| [`40-kanaaldoctrine.md`](40-kanaaldoctrine.md) | de vier kanalen en dekkingsdiscipline | B |
| [`50-betaalstructuur.md`](50-betaalstructuur.md) | betaalsplitsing, factuurritme, ankeren als techniek | B |
| [`60-acquisitiemath.md`](60-acquisitiemath.md) | levensduurmarge tegen acquisitiekosten, terugverdientijd | B |
| [`70-gespreksstructuur.md`](70-gespreksstructuur.md) | zes stappen, bezwaren op de canonieke codes | B |
| [`80-meetkoppeling.md`](80-meetkoppeling.md) | voorspelling, verdict en blokkades. Gebouwd en toegepast 2026-08-04 | C |

Genummerd per tiental zodat er tussengevoegd kan worden zonder te hernummeren.
Hernummeren breekt de verwijzingen in de intensiteitsschijf.

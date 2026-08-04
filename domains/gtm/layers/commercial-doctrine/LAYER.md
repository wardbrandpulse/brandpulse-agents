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

### Waarom `off` echt inert is, en niet "inert op papier"

[`99-grenzen.md`](99-grenzen.md) en [`90-uitsluitingen.md`](90-uitsluitingen.md)
gelden op elke stand. Dat lijkt te botsen met "op `off` is het gedrag identiek
aan zonder laag", maar dat doet het niet, om één reden:

**Geen enkele grens en geen enkele uitsluiting ontstaat in deze laag.** Ze zijn
allemaal een projectie van een beperking die elders al geldt: in de
root-`CLAUDE.md`, in het domein, in het klantprofiel, in het ICP, in de
sectorlaag of in de wet. Haal de laag weg en er verdwijnt geen enkele beperking,
want de bron ervan staat er nog.

Dat is precies wat de laag verwijderbaar maakt zonder gedragsverandering. Zou een
grens hier ontstaan in plaats van geprojecteerd worden, dan zou verwijderen een
beperking opheffen, en dan was de verwijderbelofte onwaar.

## 7. Verwijderprocedure

Vijf stappen. Daarna houdt de agent identiek gedrag.

1. **Verwijder de regel `commercial-doctrine`** uit de tabel in sectie "Lagen"
   van `clients/<klant>/gtm/config.md`, voor elke klant waar hij staat. Blijft de
   sectie leeg achter, verwijder dan de sectie.
2. **Verwijder de map** `domains/gtm/layers/commercial-doctrine/`. Blijft
   `domains/gtm/layers/` leeg achter, verwijder die dan ook.
3. **Verwijder** `infra/laag-check.sh`. Dat script bestaat uitsluitend om deze
   laag te controleren en heeft zonder de laag geen functie.
4. **Laat `memory/decisions.md` staan.** Besluiten worden niet verwijderd; een
   teruggedraaid besluit krijgt de markering vervallen met datum, conform de
   praktijk in dat bestand en de degradatieregel in de root-`CLAUDE.md`, sectie
   3. Een besluit dat spoorloos verdwijnt, wordt over een jaar opnieuw genomen.
5. **Verifieer** dat er niets achterblijft:

   ```
   grep -ril "commercial-doctrine" . --exclude-dir=.git
   ```

   Verwacht: uitsluitend treffers in `memory/decisions.md`. Elke andere treffer
   is een restant.

### De garantie, en waar hij ophoudt

Na deze vijf stappen is het gedrag identiek aan het gedrag van vóór de laag, om
vier redenen die alle vier machinaal of per inspectie te controleren zijn:

1. Geen enkel bestand onder `domains/` verwijst naar de laag. Dit wordt getest,
   zie `infra/laag-check.sh`.
2. De enige verwijzing van buiten is het activeringsblok, en stap 1 verwijdert
   dat.
3. Geen grens en geen uitsluiting ontstaat hier, dus verwijderen heft geen
   beperking op. Zie sectie 6.
4. De laag heeft nooit een bedrag, een taxonomiewaarde, een ICP-criterium of een
   drempel vastgesteld. Die staan allemaal buiten de laag en blijven staan.

**Waar de garantie ophoudt.** Fase C voegt kolommen toe aan de aanbevelingentabel
om de laag te kunnen evalueren. Een toegepaste migratie wordt nooit
teruggedraaid ([`infra/migratie-proces.md`](../../../../infra/migratie-proces.md),
sectie 6). Na fase C blijven die kolommen dus staan als de laag verdwijnt. Dat is
het enige onomkeerbare residu, het bestaat uit lege kolommen, en het verandert
geen gedrag. Het staat hier zodat niemand het later als een gebroken belofte
leest.

## 8. Bestanden in deze laag

| Bestand | Wat het is | Fase |
|---|---|---|
| `LAYER.md` | dit manifest | A |
| [`99-grenzen.md`](99-grenzen.md) | harde grenzen, gelden op elke stand | A |
| [`90-uitsluitingen.md`](90-uitsluitingen.md) | mechanieken die de bron voorschrijft en wij bewust niet gebruiken | A |
| [`SOURCES.md`](SOURCES.md) | herkomst en eigen termenlijst | A |
| `00-principes.md` | vijf principes | B |
| `10-aanbodarchitectuur.md` | waardeformule, probleemontleding, risico-omkering | B |
| `20-aanbodsequentie.md` | instap, uitbreiding, verlaging na een nee, doorlopend | B |
| `30-weggever.md` | negen stappen plus kwaliteitstoets | B |
| `40-kanaaldoctrine.md` | de vier kanalen en dekkingsdiscipline | B |
| `50-betaalstructuur.md` | betaalsplitsing, factuurritme, ankeren als techniek | B |
| `60-acquisitiemath.md` | levensduurmarge tegen acquisitiekosten, terugverdientijd | B |
| `70-gespreksstructuur.md` | zes stappen, bezwaren op de canonieke codes | B |
| meetkoppeling | voorspelling en uitkomst per doctrineregel | C |

Genummerd per tiental zodat er tussengevoegd kan worden zonder te hernummeren.
Hernummeren breekt de verwijzingen in de intensiteitsschijf.

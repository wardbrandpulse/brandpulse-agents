# Besluiten

Architectuur- en methodiekbesluiten, nieuwste bovenaan. Een besluit dat hier
niet staat, is geen besluit maar een gewoonte.

Format per besluit:

```markdown
## JJJJ-MM-DD, <besluit in één zin>
**Context.** Waarom lag dit op tafel.
**Besluit.** Wat is er besloten.
**Alternatieven.** Wat is afgevallen en waarom.
**Gevolg.** Wat verandert er hierdoor, en wat breekt er als je het terugdraait.
**Herzien wanneer.** Welk signaal maakt dit besluit opnieuw open.
```

---

## 2026-07-29, de feedbackloop heet `agent_recommendations` en krijgt een `domain`-kolom

**Context.** De tabel met voorspelling en uitkomst was gepland als
`gtm_recommendations`. Bij het optillen van de outputstructuur naar de root bleek
dat de loop zelf niet GTM-specifiek is: elk domein doet een aanbeveling, doet een
voorspelling en kan achteraf getoetst worden. Een `gtm_`-prefix zou een tweede
domein dwingen tot een tweede, identieke tabel.
**Besluit.** De tabel heet `agent_recommendations` en krijgt een `domain`-kolom
naast `client`. `gtm_events` en `gtm_objections` houden hun prefix: die zijn wel
domeinspecifiek van vorm.
**Alternatieven.** Per domein een eigen tabel: afgevallen, want dan is er geen
enkele plek waar over domeinen heen te zien is of de adviezen kloppen, en dat is
precies wat je van een feedbackloop wilt weten.
**Gevolg.** Uit te werken in fase 1B. Bij elke schrijfactie moeten `client` én
`domain` gezet worden; een ontbrekende `domain` maakt de rij onvindbaar in plaats
van fout, wat erger is.
**Herzien wanneer.** Als blijkt dat de velden per domein zo verschillen dat de
gedeelde tabel voornamelijk uit lege kolommen bestaat.

## 2026-07-29, het diagnoseprincipe blijft in GTM en wordt alleen als kandidaat genoteerd

**Context.** In `domains/gtm/playbooks/kanaal-diagnose.md` zit een onderliggend
principe dat breder lijkt te gelden: diagnosticeer op volgorde van
goedkoop-uitsluitbaar naar duur-uitsluitbaar, en stop bij de eerste stap die het
verschijnsel verklaart. Voorstel was om dat naar de root te tillen.
**Besluit.** Niet doen. Het principe blijft volledig in GTM. Het wordt hier
genoteerd als **promotiekandidaat**, niet als promotie.
**Alternatieven.** Nu al naar de root tillen: afgevallen. Met één domein is er
geen tweede onafhankelijke context, dus de promotieregel uit de `CLAUDE.md` is
niet gehaald. Die regel geldt ook voor onze eigen architectuur; een uitzondering
maken omdat het over de repo zelf gaat, holt hem uit op de enige plek waar wij
hem zelf zouden merken.
**Gevolg.** Het principe staat voorlopig op één plek en wordt bij een tweede
domein opnieuw beoordeeld. Blijkt het daar ook te gelden, dan is dát de tweede
context en mag het naar de root.
**Herzien wanneer.** Bij het tweede domein.

## 2026-07-29, de outputstructuur staat in de root, de drempels in het domein

**Context.** De structuur (bevinding, bewijs met n, aanbeveling, voorspeld
effect, hoe we toetsen, wat ik niet kon vaststellen) stond in
`domains/gtm/CLAUDE.md`, terwijl alleen de drempels erin GTM-specifiek zijn.
**Besluit.** De structuur staat in de root-`CLAUDE.md`, sectie 8, en geldt in
elk domein. Welke drempels gelden blijft domeinspecifiek. Domeinen mogen secties
toevoegen, niet weglaten.
**Alternatieven.** Per domein een eigen structuur: afgevallen, want dan is
output tussen domeinen niet vergelijkbaar en verdwijnt "voorspeld effect" bij het
eerste domein dat er geen zin in heeft.
**Gevolg.** `domains/gtm/CLAUDE.md` sectie 4 is teruggebracht tot de
GTM-specifieke aanvullingen en verwijst naar de root.
**Herzien wanneer.** Als een tweede domein een sectie structureel niet kan
vullen. Dan is de vraag of de sectie te GTM-gekleurd is, of dat dat domein een
gat heeft.

## 2026-07-29, de metaregel over canonieke waardelijsten staat in de root, de waarden in het domein

**Context.** In `taxonomie.md` stonden twee soorten regels door elkaar: de
GTM-waarden zelf, en de discipline eromheen (nooit ad hoc toevoegen, nooit
hernoemen, datalaag volgt het document, ontbrekende labels heten ongelabeld).
Dat tweede is domeinonafhankelijk. Een tweede domein zou het overschrijven in
plaats van erven.
**Besluit.** De metaregel staat in de root-`CLAUDE.md`, sectie 5. De waarden
blijven in `domains/gtm/playbooks/taxonomie.md`, samen met wat er binnen GTM
aanvullend geldt.
**Alternatieven.** Alles in het domein laten: afgevallen om bovenstaande reden.
**Gevolg.** `taxonomie.md` is korter en verwijst voor de regels naar de root.
**Herzien wanneer.** Niet voorzien.

## 2026-07-29, `utm_medium` houdt zijn conventionele betekenis, segment gaat in `seg`

**Vervangt het besluit van dezelfde dag hieronder, dat segment in `utm_medium`
zette.**

**Context.** Het eerdere besluit koos voor een één-op-één-toewijzing van de drie
dimensies op drie UTM-parameters, met segment in `utm_medium`. Dat leverde een
afdwingbare gesloten lijst per dimensie op, maar botste met wat `utm_medium`
elders betekent.
**Besluit.** `utm_source` = `source`, `utm_medium` = het kanaaltype in de
conventionele betekenis (`email`, `social`, `cpc`, `organic`, `referral`),
`seg` = `segment`, `utm_content` = `asset`, `utm_campaign` = vrije
campagnenaam.
**Reden voor de omkering.** `utm_medium` stuurt de automatische
channel grouping in vrijwel elke analyticstool. Een segment daarin breekt die
groepering **stil**: geen foutmelding, en het gaat ook mis voor iedereen die er
later naar kijkt zonder onze conventie te kennen. De winst van het eerdere
besluit, afdwingbaarheid, was bovendien op de verkeerde plek gezocht: een URL is
publiek en door derden aan te passen, dus die dwingt sowieso niets af.
Afdwinging hoort bij ingest, in de route handler en de check-constraint. Dat is
nu als algemene regel opgenomen in de root-`CLAUDE.md`, sectie 5.
**Gevolg.** `seg` heeft bewust geen `utm_`-prefix, zodat analyticstools hem
negeren. Hij moet wel elke redirect overleven en bij het eerste bezoek worden
vastgelegd, anders is het segment bij een latere conversie weg. Dat is een eis
aan de tracking in fase 1B.
**Herzien wanneer.** Als er een vierde dimensie bij komt, of als een platform
`seg` onderweg laat vallen op een plek waar we hem niet kunnen behouden.

## 2026-07-29, `domains/gtm/agents/` is de bron, koppeling aan het uitvoeringsplatform komt later

**Context.** Claude Code laadt subagents uit `.claude/agents/`. Dat is één
uitvoeringsplatform van meerdere mogelijke.
**Besluit.** De domeinmap `domains/<domein>/agents/` is de bron van
agentdefinities. Hoe die aan een uitvoeringsplatform gekoppeld worden (kopie,
symlink, generatiestap, iets anders) is een uitvoeringskeuze voor fase 2 en
wordt nu niet opgelost. In fase 1 is de map leeg.
**Alternatieven.** Meteen `.claude/agents/` als bron gebruiken: afgevallen omdat
dat de repo vastzet op één platform, in strijd met de platformneutraliteitsregel.
**Gevolg.** De agentdefinities zijn straks verplaatsbaar. Er is wel een
koppelstap nodig die er nu nog niet is.
**Herzien wanneer.** Bij de eerste agent in fase 2.

## 2026-07-29, geen agent-registry, routing of orchestrator in fase 1

**Context.** Er komen waarschijnlijk meer domeinen bij. De verleiding is om daar
nu al een laag voor te bouwen.
**Besluit.** Geen registry, geen routing tussen domeinen, geen
meta-orchestrator, geen gedeelde toolingabstractie.
**Alternatieven.** Nu al een routinglaag bouwen: afgevallen. Er is één domein.
Elke voorziening voor een tweede is een gok op hoe dat tweede domein eruitziet,
en die gok is bij het bouwen van de laag niet te toetsen.
**Gevolg.** Het tweede domein kost eenmalig wat meer werk. In ruil daarvoor is
de structuur nu leesbaar en klopt hij aantoonbaar voor het domein dat bestaat.
**Herzien wanneer.** Bij het tweede domein, en dan pas als blijkt dat er
daadwerkelijk gedeeld gedrag is.

## 2026-07-29, `utm_medium` draagt het segment, niet de standaardbetekenis (VERVALLEN)

**Vervallen op 2026-07-29, dezelfde dag, door het besluit hierboven. Blijft
staan omdat een teruggedraaid besluit anders over een jaar opnieuw genomen
wordt.**

**Context.** De taxonomie heeft drie dimensies (`segment`, `source`, `asset`)
die overal identiek moeten gelden, ook op plekken met weinig velden. UTM heeft
vier bruikbare parameters.
**Besluit.** `utm_source` = `source`, `utm_medium` = `segment`, `utm_content` =
`asset`, `utm_campaign` = vrije campagnenaam.
**Alternatieven.** Segment in `utm_campaign` als prefix zetten en `utm_medium`
zijn gebruikelijke betekenis laten houden: afgevallen omdat het segment dan in
een vrij tekstveld zit en dus niet afdwingbaar is met een gesloten waardelijst.
**Waarom het niet klopte.** De redenering ging ervan uit dat de URL de plek is
waar een gesloten lijst afgedwongen wordt. Dat is hij niet: hij is publiek en
aanpasbaar. De prijs, een stil gebroken channel grouping in elke analyticstool,
werd betaald voor een garantie die er nooit was.

## 2026-07-29, instructies zijn platformneutraal, tools staan in de omgeving

**Context.** Instructies die een concrete tool of tabel noemen, verhuizen niet
mee naar een ander uitvoeringsplatform en verouderen bij elke
infrastructuurwijziging.
**Besluit.** Playbooks en agentinstructies beschrijven wat en waarom, nooit hoe
in termen van een tool. Concrete bronnen, verbindingen en tabelnamen staan
uitsluitend in `clients/<klant>/<domein>/config.md`.
**Alternatieven.** Tools direct in de instructie benoemen: leest makkelijker,
maar zet de hele repo vast op één platform.
**Gevolg.** Eén extra plek om te raadplegen bij uitvoering, in ruil voor
verplaatsbaarheid.
**Herzien wanneer.** Niet voorzien. Dit is een van de dragende regels.

## 2026-07-29, drie geheugenlagen met expliciete, bevestigde promotie

**Context.** Kennis moet hergebruikt kunnen worden zonder dat klantkennis
weglekt naar een andere klant.
**Besluit.** Klant, sector, playbook. Promotie naar sector na een tweede
onafhankelijke context, naar playbook na een tweede sector, altijd
geanonimiseerd en altijd door Ward bevestigd. Zie de root-`CLAUDE.md`.
**Alternatieven.** Automatisch promoveren zodra de telvoorwaarde gehaald is:
afgevallen. Dan bepaalt de teller wat waar is, en klimt een toevallige
samenloop naar de laag die overal geldt.
**Gevolg.** Promotie kost een handeling. Dat is bedoeld: de wrijving is de
kwaliteitsbewaking.
**Herzien wanneer.** Als het aantal wachtende kandidaten zo groot wordt dat de
handmatige stap het knelpunt is. Dan is het antwoord waarschijnlijk niet
"automatiseren" maar "vaker een promotieronde inplannen".

## 2026-07-29, twee assen: domein en klant, strikt gescheiden

**Context.** Het bureau bedient meerdere klanten en krijgt waarschijnlijk
meerdere domeinen. Methodiek en context door elkaar zetten maakt beide
onbruikbaar: de methodiek is niet herbruikbaar en de klantkennis is niet
isoleerbaar.
**Besluit.** `domains/<domein>/` bevat uitsluitend methodiek, `clients/<klant>/`
uitsluitend context. Een nieuwe klant is één map, een nieuw domein is één map,
en in beide gevallen verandert er niets aan de rest.
**Alternatieven.** Per klant een eigen kopie van de methodiek: afgevallen, want
dan divergeert de methodiek per klant en is er geen gedeelde leercurve.
**Gevolg.** Als een wijziging aan de ene as een wijziging aan de andere
afdwingt, is de scheiding doorbroken en gaat dat voor op de wijziging zelf.
**Herzien wanneer.** Niet voorzien. Dit is de dragende keuze van de repo.

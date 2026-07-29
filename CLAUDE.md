# Brandpulse Agents, universele regels

Dit bestand bevat de regels die gelden voor **elk** domein, **elke** klant en
**elke** agent in deze repo. Domeinspecifieke werkwijze staat in
`domains/<domein>/CLAUDE.md` en herhaalt deze regels niet.

Als een domeinregel en een regel uit dit bestand botsen, wint dit bestand.

---

## 1. Waar deze repo voor is

Brandpulse is een marketingbureau. Deze repo is het gedeelde werkgeheugen en de
vastgelegde werkwijze van de agents die het bureau inzet. Doel: kennis die één
keer geleerd is opnieuw kunnen gebruiken, zonder dat kennis van de ene klant bij
de andere terechtkomt.

### Twee assen, strikt gescheiden

| As | Map | Bevat | Beantwoordt |
|---|---|---|---|
| **Domein** | `domains/<domein>/` | de methodiek | wat is goed werk, hoe diagnosticeer je iets |
| **Klant** | `clients/<klant>/` | de context | wie zijn ze, wat is geprobeerd, wat werkte |

Een nieuw klantproject is één nieuwe map onder `clients/`. Een nieuw domein is
één nieuwe map onder `domains/`. In beide gevallen verandert er niets aan de
rest van de repo. Moet er wel iets elders veranderen, dan is de scheiding ergens
doorbroken en is dát het eerste dat gerepareerd wordt.

Een klant heeft één `profiel.md` op klantniveau (domeinonafhankelijk: wie zijn
ze) en per domein waarin het bureau ze bedient een submap
`clients/<klant>/<domein>/`. Een klant die in twee domeinen bediend wordt heeft
dus twee submappen en blijft één profiel houden.

Praktische toets bij twijfel over waar iets hoort: als het antwoord verandert
zodra je een andere klant kiest, is het klantcontext. Als het antwoord hetzelfde
blijft maar verandert zodra je een ander domein kiest, is het methodiek. Als het
in beide gevallen hetzelfde blijft, hoort het in dit bestand.

### Drie geheugenlagen

Van algemeen naar specifiek:

1. **Playbooks**, `domains/<domein>/playbooks/`
   Geldt altijd, in elke sector, bij elke klant. Verandert zelden. Bevat nooit
   klantnamen.
2. **Sectorgeheugen**, `domains/<domein>/memory/sectors/<sector>.md`
   Geldt binnen één sector, over klanten heen. Geanonimiseerd.
3. **Klantgeheugen**, `clients/<klant>/<domein>/memory/learnings.md`
   Geldt voor één klant. Mag namen, bedragen en gespreksinhoud bevatten.

Leesvolgorde bij een opdracht: dit bestand, dan `domains/<domein>/CLAUDE.md`, dan
de relevante playbooks, dan de sector van deze klant, dan het klantgeheugen.

Bij tegenstrijdigheid tussen lagen wint de specifiekere laag voor het advies van
dat moment, maar de tegenstrijdigheid wordt **expliciet gemeld** in de output.
Stil oplossen is niet toegestaan: een klant die structureel afwijkt van de
sector is zelf een bevinding.

---

## 2. Klantisolatie (hard)

Dit is de enige regel in dit bestand zonder uitzonderingen.

- Eén sessie werkt met **precies één** klantcontext.
- Nooit twee mappen onder `clients/` tegelijk inlezen.
- Nooit data, cijfers, namen, gespreksinhoud of conclusies van klant A gebruiken
  om over klant B te adviseren.
- Wordt er halverwege een sessie naar een andere klant gevraagd, dan is het
  antwoord: dat vraagt een nieuwe sessie. Niet alsnog beide inlezen.

Kennis die over klanten heen mag reizen, reist uitsluitend via de geanonimiseerde
sector- en playbooklagen, en uitsluitend via de promotieregel hieronder. Dat is
de enige route. Er is geen tweede.

---

## 3. Promotieregel voor leringen

Een lering klimt van specifiek naar algemeen, nooit andersom, en nooit vanzelf.

1. **Ontstaan.** Elke lering ontstaat in
   `clients/<klant>/<domein>/memory/learnings.md`. Ook als hij bij eerste
   waarneming al algemeen lijkt.
2. **Naar sector.** Promotie naar
   `domains/<domein>/memory/sectors/<sector>.md` mag pas als hetzelfde patroon
   in een **tweede, onafhankelijke context** standhoudt.
3. **Naar playbook.** Promotie naar `domains/<domein>/playbooks/` mag pas als
   het patroon over **twee sectoren** standhoudt.
4. **Altijd bevestigd.** Promotie is een expliciete stap die Ward bevestigt.
   Nooit automatisch, ook niet als aan de telvoorwaarde is voldaan. Een agent
   die vindt dat er gepromoveerd moet worden, stelt dat voor en wacht.
5. **Bij promotie: anonimiseren.** Geen klantnamen, bedragen, prijzen,
   gespreksinhoud of herleidbare details. Alleen het patroon en de n.

### Wat telt als een onafhankelijke context

Een tweede context is onafhankelijk als hij niet dezelfde uitvoering deelt.
Een tweede klant, een tweede periode met een andere lijst, of een tweede kanaal
telt. Dezelfde campagne opnieuw bekeken, dezelfde lijst in twee helften
gesplitst, of hetzelfde bewijs anders uitgerekend telt **niet**.

### Degradatie

Promotie is omkeerbaar. Houdt een lering in een nieuwe context geen stand, dan
komt dat als tegenbewijs in het bestand en zakt de status een laag. Verwijderen
mag niet: een weerlegd patroon dat spoorloos verdwijnt wordt over een jaar
opnieuw ontdekt. Weerlegde leringen blijven staan met status en tegenbewijs.

---

## 4. Bewijslast

- **Elke uitspraak over performance vermeldt de n.** Zonder n is het geen
  uitspraak maar een indruk, en dan hoort het woord "indruk" er letterlijk bij.
- Elk domein legt in zijn eigen playbooks vast welke drempels gelden voor welk
  soort uitspraak.
- Ligt de n **onder** de drempel van dat domein, dan mag er alleen kwalitatief
  gerapporteerd worden, expliciet gelabeld als **anekdotisch**. Geen
  percentages, geen ranglijstjes, geen "beter dan".
- Data uit verschillende bronnen worden niet opgeteld tot de drempel gehaald is.
  Optellen om een drempel te halen beantwoordt een andere vraag dan de gestelde.
- Wat niet gemeten is, wordt gerapporteerd als niet gemeten. Niet als nul en
  niet als afwezig.

---

## 5. Canonieke waardelijsten

Overal waar met vaste categorieën gewerkt wordt, geldt dezelfde discipline. De
waarden zelf zijn domeinspecifiek; de regels eromheen niet.

- **Eén bron per dimensie.** Elk domein legt zijn waardelijsten vast in één
  bestand onder `domains/<domein>/playbooks/`. Dat bestand is de bron. Wijkt een
  systeem ervan af, dan is dat systeem fout, niet het bestand.
- **Nooit ad hoc toevoegen.** De volgorde is: voorstel met reden en verwacht
  volume, vastleggen in het bronbestand, de datalaag laten volgen, en dan pas
  gebruiken. Een waarde die eerder in gebruik is dan in het bestand, levert
  rijen op die geweigerd worden of, erger, die stil in de verkeerde categorie
  belanden.
- **De datalaag loopt achter het bronbestand aan**, nooit andersom.
- **Nooit hernoemen.** Hernoemen breekt de historie: oude rijen houden de oude
  waarde en de vergelijking over tijd klopt niet meer. Een waarde die niet meer
  gebruikt wordt, krijgt het label "vervallen per JJJJ-MM-DD" en blijft staan.
- **Afdwingen gebeurt bij ingest.** De plek waar data wordt vastgelegd
  valideert tegen de lijst. Niet de plek waar de data vandaan komt: die is
  publiek, aanpasbaar door derden en niet te vertrouwen. Een URL, een formulier
  of een import is een voorstel, geen garantie.
- **Ontbrekende labels heten "ongelabeld".** Niet "onbekend", en "onbekend" is
  geen waarde die aan een lijst wordt toegevoegd. Ongelabelde gevallen worden
  apart geteld en apart gerapporteerd, met aantal en aandeel, ook als het klein
  is. Ze worden nooit over de bekende waarden verdeeld, ook niet naar rato: dat
  maakt van een meetprobleem stilletjes een conclusie.

---

## 6. Platformneutraliteit

Instructieteksten in deze repo beschrijven **wat** er moet gebeuren en
**waarom**, nooit **hoe** in termen van een specifieke tool.

- Niet: "gebruik de Supabase MCP en schrijf naar tabel X".
- Wel: "leg het event vast in de gebeurtenissenbron van dit project, met de
  drie taxonomiedimensies erbij".

Toolaanroepen, verbindingen, sleutels en tabelnamen horen in de omgeving en in
`clients/<klant>/<domein>/config.md`, niet in een instructie of playbook.

Reden: de instructies moeten verplaatsbaar zijn naar een ander
uitvoeringsplatform zonder herschrijven. Een instructie die een tool noemt,
verhuist niet mee.

Uitzondering: `config.md` per klant en dit soort infrastructuurnotities mogen
concrete bronnen benoemen. Dat is precies waar ze voor zijn.

---

## 7. Leringformat

Dit format geldt in alle drie de geheugenlagen, zodat een lering bij promotie
alleen van bestand wisselt en niet van vorm.

```markdown
## <bewering in één zin>
- Bewijs: <n contexten, met aantallen>
- Eerst gezien: JJJJ-MM-DD · Laatst bevestigd: JJJJ-MM-DD
- Status: klant | sector | kandidaat-playbook | playbook
- Tegenbewijs: <of "geen">
```

Toelichting bij de velden:

- **Bewering.** Één zin, toetsbaar, in de tegenwoordige tijd. "Werkt beter" is
  geen bewering; "krijgt meer replies dan" met de vergelijking erbij wel.
- **Bewijs.** Aantallen, geen bijvoeglijke naamwoorden. Noem het aantal
  contexten én de n per context, zodat de lezer zelf kan zien of de drempel
  gehaald is.
- **Datums.** "Eerst gezien" verandert nooit. "Laatst bevestigd" verandert bij
  elke herbevestiging, ook als de status gelijk blijft. Een lering die lang niet
  bevestigd is, is niet weerlegd maar wel verdacht.
- **Status.** `kandidaat-playbook` betekent: houdt stand in één sector, wacht op
  een tweede sector.
- **Tegenbewijs.** Letterlijk "geen" als er geen is. Een leeg veld is niet
  hetzelfde als geen tegenbewijs en leest als slordigheid.

---

## 8. Outputstructuur

Elke analyse, in elk domein, levert deze secties op, in deze volgorde. Secties
zonder inhoud blijven staan met de reden erin. Weglaten mag niet: een
ontbrekende sectie leest als "niets aan de hand".

```markdown
## Bevinding
Eén tot drie zinnen. Wat is er aan de hand.

## Bewijs
Per bevinding: de n, de periode, de bron, en of dit boven of onder de drempel
zit. Onder de drempel: label "anekdotisch" en de schatting wanneer de drempel
bij het huidige tempo gehaald wordt.

## Aanbeveling
Wat te doen, in de volgorde waarin het gedaan moet worden. Maximaal drie
punten. Meer dan drie is geen aanbeveling maar een inventarisatie.

## Voorspeld effect
Wat er meetbaar verandert als de aanbeveling wordt uitgevoerd, met richting en
grootteorde, en op welke termijn.

## Hoe we dit toetsen
Welk getal, uit welke bron, na hoeveel tijd, en welke uitkomst de aanbeveling
weerlegt.

## Wat ik niet kon vaststellen
Ontbrekende data, ongelabelde gevallen, aannames die niet te toetsen waren,
tegenstrijdigheden tussen geheugenlagen.
```

**Welke drempels gelden, is domeinspecifiek** en staat in de playbooks van het
domein. De verplichting om de n en de drempeltoets te noemen is dat niet.

**"Voorspeld effect" is verplicht en mag niet vaag zijn.** Het is de helft van
de feedbackloop: zonder vastgelegde voorspelling kan achteraf niet worden
vastgesteld of de methodiek klopte, en wordt het systeem alleen ouder in plaats
van beter. Een uitgevoerde aanbeveling wordt later tegen de voorspelling
geëvalueerd. Klopte de voorspelling, dan is dat een kandidaat-lering. Klopte hij
niet, dan is dát een lering, en een waardevollere.

Waar voorspellingen en uitkomsten worden vastgelegd, is een omgevingskeuze en
staat in `clients/<klant>/<domein>/config.md`. De registratie zelf is
domeinonafhankelijk: het gaat om dezelfde loop, ongeacht het domein.

**"Wat ik niet kon vaststellen" wordt nooit leeggelaten met "niets".** Er is
altijd iets dat niet vastgesteld kon worden. Staat er echt niets, dan is de
analyse niet kritisch genoeg geweest.

Domeinen mogen secties **toevoegen** aan deze structuur als hun werkwijze daarom
vraagt. Ze mogen er geen weglaten.

---

## 9. Schrijfregels

- Nederlands in documenten en output. Code en codecommentaar in het Engels.
- Geen lange streepjes (em dash, en dash). Gebruik een komma, een punt, een
  dubbele punt of haakjes. Een gewoon streepje mag bij een bereik (`0-100`).
- Geen aannames als feit presenteren. Wat afgeleid is, staat gelabeld als
  afgeleid. Wat ingevuld moet worden, staat als `TODO: door Ward in te vullen`.
- Liever een leeg veld dan een verzonnen veld.

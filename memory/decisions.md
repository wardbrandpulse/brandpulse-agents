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

## 2026-08-04, een voorspelling die niet te weerleggen is, wordt niet weggeschreven

**Context.** De laag wordt afgerekend op voorspelkwaliteit, met een verdict van drie
waarden waarvan `niet-vast-te-stellen` er een is. Bij het uitwerken bleek dat die
derde waarde geen restcategorie is maar de waarschijnlijkste faalvorm: niet dat de
doctrine ernaast zit, maar dat ze te vaag voorspelt om ernaast te kunnen zitten. Zonder
tegenmaatregel kan de laag op onweerlegbaarheid overleven, en dat is precies wat de
maatstaf moest uitsluiten.

De eerste voorspelling die werd opgeschreven liet het probleem meteen zien. "`wat-is-dpp`
wordt de meest voorkomende bezwaarcode" is een rangordeclaim over zeven categorieën, en
die is bij lage aantallen niet te beslechten.

**Besluit.** Twee dingen.

1. **Een voorspelling die bij het verwachte volume niet te weerleggen is, hoort niet
   weggeschreven te worden.** Dan is het geen voorspelling maar een mening met een
   tijdstempel. Getoetst vóór het wegschrijven: bij welk aantal waarnemingen is dit te
   beslechten, en halen we dat binnen de evaluatietermijn.
2. **Het aandeel `niet-vast-te-stellen` wordt bijgehouden en is zelf een bevinding.**
   Loopt het op, dan is de eerste bevinding niet de kwaliteit van de voorspellingen
   maar de formulering ervan. Blijft het oplopen ná herformulering, dan is het de laag.

Praktisch bij kleine aantallen: paarsgewijze vergelijkingen in plaats van
rangordeclaims. "A komt vaker voor dan B" is met tien waarnemingen zinvol, "A is de
meest voorkomende van zeven" niet. De eerste voorspelling is daarop herschreven naar
`wat-is-dpp` tegen `geen-budget`, de twee codes die staan voor de twee verklaringen die
tegen elkaar in gaan.

**Alternatieven.** Een drempel zetten voor een rangordeclaim over zeven categorieën:
afgevallen. Om die drempel te kiezen moet je weten welke n volstaat, en dat weten we bij
n=0 niet. Een getal nu vastleggen is gokken, en dat is wat de bewijslastregel moet
voorkomen. De drempel wordt later gezet, mét informatie in plaats van ervoor. Tot die
tijd: absolute aantallen, expliciet gelabeld als anekdotisch.

**Gevolg.** Er komt geen nieuwe drempel in `significantie-drempels.md`.

**Kandidaat voor promotie, niet gepromoveerd.** De onderliggende regel is niet
laagspecifiek en niet GTM-specifiek: hij geldt voor elke voorspelling in de
aanbevelingentabel, in elk domein. Hij staat nu in
`domains/gtm/layers/commercial-doctrine/80-meetkoppeling.md`, dus op de smalste plek.
Met één domein en één laag is er geen tweede onafhankelijke context, dus de
promotieregel uit de root-`CLAUDE.md` is niet gehaald. Dezelfde behandeling als het
diagnoseprincipe (2026-07-29) en de breuk-in-de-reeksregel (2026-07-30).

**Herzien wanneer.** Bij een tweede laag of een tweede domein dat voorspellingen
wegschrijft. Blijkt de regel daar ook te gelden, dan is dát de tweede context.

## 2026-08-04, `domeinbreed` als expliciete segmentwaarde, alleen in de aanbevelingentabel

**Context.** Een advies kan over alle segmenten gaan. De eerste opzet gebruikte
daarvoor `segment = NULL` in `agent_recommendations`. Maar in `gtm_events` en
`gtm_objections` betekent `NULL` **ongelabeld**, dus "we weten het niet". Dezelfde
`NULL` met twee betekenissen over twee tabellen is de ambiguïteit die over een jaar
bijt, en documenteren lost dat alleen op voor wie de documentatie leest.

**Besluit.** `agent_recommendations.segment` wordt `not null`, met één extra waarde
`domeinbreed`, vastgelegd in `domains/gtm/playbooks/taxonomie.md`, sectie 6. Dat is het
bronbestand; de datalaag volgt daarachteraan.

**⚠️ De waarde geldt uitsluitend in de aanbevelingentabel.** Niet in `gtm_events` en
niet in `gtm_objections`. Een aanraking heeft een segment of hij is ongelabeld;
"domeinbreed" bestaat daar niet. Zou de waarde in de eventlijst belanden, dan
verschijnt hij in elke segmentrapportage naast de echte segmenten alsof hij er een van
is, en dat verbiedt sectie 5 van de root-`CLAUDE.md`.

**Alternatieven.** `NULL` met een gedocumenteerde afwijking, zoals bij
`gtm_accounts.motion`: afgevallen. Dat precedent gaat over een waarde die juist géén
`NULL` mag zijn; hier zou het gaan over `NULL` met een tweede betekenis, en dat is het
omgekeerde. Een expliciete waarde legt zichzelf uit en wordt bij ingest afgedwongen.

**Gevolg.** Bij een advies is geen meetgat mogelijk: het wordt geschreven door iemand
die zijn eigen scope kent, dus er is geen derde toestand "ongelabeld advies". De
migratie zet de kolom defensief: kolom erbij, bestaande rijen vullen, dan `not null`.
Bij het schrijven van het voorstel stonden er nul rijen en schreef geen enkele
applicatie naar de tabel.

**Herzien wanneer.** Als een tweede domein adviezen wegschrijft met een andere
segmentindeling. Dan is de vraag of `segment` daar dezelfde lijst kan gebruiken.

## 2026-08-04, de toets voor een laag-eigen beperking is of de agent hem ook zonder de laag zou voorstellen

**Vervangt punt 2 en punt 3 van het besluit hieronder over de projectieregel. Dat
besluit blijft staan met een correctienotitie.**

**Context.** Het eerdere besluit stelde dat uitsluitingen geen bron nodig hebben
omdat ze mechanica verwerpen die zonder de laag niet bestaat. De redenering klopt,
de regel was te breed: niet alles in `90-uitsluitingen.md` is laag-eigen. Een
weggeefactie kan een agent voorstellen zonder enige doctrine; een anti-garantie niet.
Daardoor stond het verbod op geconstrueerde schaarste als uitsluiting gelabeld, en
las het als removal-neutraal terwijl het dat niet is.

**Besluit.** De toets is één vraag: **zou de agent dit ook voorstellen zonder de
laag?** Dat antwoord bepaalt de categorie, en de categorie geldt voor grenzen en
uitsluitingen door elkaar.

| Categorie | Beperkt | Bron nodig | Verwijderen is |
|---|---|---|---|
| 1, projectie | gedrag dat er zonder de laag ook is | ja, en die is er | neutraal |
| 2, laag-eigen en removal-neutraal | alleen wat de laag introduceert | nee | neutraal |
| 3, laag-eigen en niet removal-neutraal | gedrag dat er zonder de laag ook is | ja, maar die is er niet | **versoepelt iets** |

**Categorie 1 en 2 sluiten elkaar niet uit; categorie 3 wel.** Een regel kan laag-eigen
zijn én een bron buiten de laag hebben, en dan worden beide genoteerd. Dat is strikt
informatiever: laag-eigen zegt dat verwijderen niets versoepelt, de externe bron zegt
dat het gedekt blijft mocht dezelfde tactiek langs een andere route binnenkomen.
Uitsluiting 2 en 6 zijn beide. Categorie 3 is de enige die iets over verwijderbaarheid
ontkent en dus de enige die exclusief is.

**Gevolg, en dat is de kern van deze correctie.** Categorie 3 ontbrak, en daar valt
precies één regel in: het verbod op geconstrueerde schaarste en tijdsdruk. Dat staat
nu als grens 9 met dat label, met de consequentie er letterlijk bij: verwijder de
laag en deze beperking verdwijnt terwijl hij zou moeten blijven.

Uitsluiting 3 blijft als leeg nummer staan met een verwijzing naar grens 9.
Hernummeren zou de verwijzingen naar de punten 4 tot en met 7 breken en de
vergelijkbaarheid met eerdere output kapotmaken, conform de root-`CLAUDE.md`,
sectie 5.

Herbeoordeling van alle zeven uitsluitingen tegen de toets: punt 1, 5 en 7 zijn
categorie 1 (wet, domeinscope, propositiekeuze van de klant), punt 2, 4 en 6 zijn
categorie 2, punt 3 is verplaatst. Van de negen grenzen zijn zeven categorie 1, is
grens 5 categorie 2 en grens 9 categorie 3.

**Alternatieven.** Categorie 3 niet benoemen en het verbod als uitsluiting laten
staan: afgevallen, dan claimt het label removal-neutraliteit die er niet is, en dat
is precies de decoratieve projectieregel die het eerdere besluit wilde voorkomen. Het
verbod laten vallen omdat er geen bron is: afgevallen, dan wordt een gat in de repo
opgelost door de beperking weg te halen.

**Herzien wanneer.** Zodra het juridisch kader outbound bestaat. Grens 9 verhuist dan
daarheen en wordt categorie 1, en dan staat er geen categorie 3 meer in de laag.

## 2026-08-04, de projectieregel geldt voor grenzen en niet voor uitsluitingen

**Context.** De verwijderbelofte van een laag rust op de projectieregel: een grens
ontstaat niet in de laag maar wijst naar een beperking die elders al geldt, dus
verwijderen heft geen beperking op. Die regel is alleen waar als hij per grens
klopt. Bij het narekenen bleek dat hij te breed was opgeschreven: hij gold in het
manifest ook voor uitsluitingen, en twee beperkingen hadden in deze repo geen
voorganger.

**Besluit.** Drie dingen.

1. **De projectieregel geldt voor grenzen.** Bij elke grens staat de bron, met een
   letterlijke aanhaling waar die bestaat, en er is een auditlijst met per grens
   een verdict. Zeven van de acht zijn projectie.
2. **Uitsluitingen zijn laag-eigen, en dat is geen tekort.** Een uitsluiting
   verwerpt mechanica die zonder de laag niet bestaat. Verwijderen haalt de
   doctrineregel en de verwerping in één keer weg, dus netto nul. Er hoort dus
   geen externe bron bij gezocht te worden, en dat zou ook misleidend zijn.
3. **Twee beperkingen zijn verplaatst of gemarkeerd.** Het verbod op
   geconstrueerde schaarste en tijdsdruk had geen bron en is van grens 1 naar
   uitsluiting 3 gegaan. Grens 5 (de bronnaam komt nergens naar buiten) heeft geen
   bron en staat gemarkeerd als laag-eigen, wel removal-neutraal, want zonder de
   laag verdwijnt `SOURCES.md` mee en is er geen naam meer om te beschermen.

**⚠️ Gecorrigeerd op 2026-08-04, na beoordeling.** Punt 2 hierboven was te breed en
punt 3 zette daardoor één regel op de verkeerde plek. De correctie staat als apart
besluit hieronder: "de toets voor een laag-eigen beperking is of de agent hem ook
zonder de laag zou voorstellen". Punt 1 en de rest van dit besluit blijven staan.
De oorspronkelijke formulering blijft hier onaangeroerd, want een besluit dat stil
wordt bijgesteld is niet meer te volgen.

**Alternatieven, en waarom ze afvielen.** Een bron aanwijzen die de beperking niet
werkelijk oplegt: afgevallen, en dit is de kern. Dan wordt de projectieregel
decoratief, en een decoratieve regel is erger dan een gemarkeerde uitzondering,
want hij wekt vertrouwen dat hij niet verdient. Voor elke bronloze beperking een
nieuw playbook aanleggen: afgevallen voor nu, want het verbod op verzonnen claims
hoort in het juridisch kader outbound en dat bestaat nog niet. Een playbook
aanleggen om een laag te kunnen verantwoorden, is de verkeerde volgorde.

**Gevolg.** Er staat nu een gat in de repo dat eerder onzichtbaar was: verdwijnt
deze laag, dan verbiedt niets een verzonnen deadline of capaciteitsgrens in
outbound. Dat is een gat in de repo en niet in de laag. Het hoort in
`domains/gtm/playbooks/juridisch-kader-outbound.md`, en zodra dat bestaat kan
grens 1 het weer als projectie opnemen. Tot die tijd draagt uitsluiting 3 het.

Daarnaast is de bron van grens 2 zwakker dan hij lijkt: de sectie
"Gevoeligheden" in het klantprofiel staat daar gelabeld als afgeleid en nog te
bevestigen. Wordt die sectie herschreven, dan moet grens 2 opnieuw beoordeeld
worden.

**Herzien wanneer.** Zodra het juridisch kader outbound bestaat, dan de vraag
welke laag-eigen beperkingen daarheen verhuizen. En bij het bevestigen van de
sectie "Gevoeligheden" in het klantprofiel.

## 2026-08-04, een geblokkeerd doctrinevoorstel wordt gemeld en niet stil weggefilterd

**Context.** De precedenceregel van de laag is een filter: een grens of
uitsluiting kan een doctrinevoorstel tegenhouden. Als dat filter stil werkt, is
niet te zien hoe vaak het vuurt.

**Besluit.** Elke blokkade wordt gemeld in de sectie "Wat ik niet kon vaststellen"
van de output: welk voorstel, welke grens of uitsluiting hem tegenhield, en wat er
in plaats daarvan is gedaan. In dezelfde geest als de meldplicht bij
tegenstrijdigheid tussen geheugenlagen in de root-`CLAUDE.md`, regels 55 tot 58.

**Alternatieven.** Alleen de uitkomst melden en niet het geblokkeerde voorstel:
afgevallen. Dan is de output netter en verdwijnt precies het signaal waarvoor de
melding bestaat.

**Gevolg.** Het aantal blokkades is een maat voor de aansluiting van de laag op
deze markt. Veel blokkades betekent dat de doctrine slecht past, en dat is de
bevinding waarop later besloten wordt hem te verwijderen. Een stil filter zou dat
weggooien en de laag onweerlegbaar maken. Blokkades gaan daarom mee in het
voorstel voor de aanbevelingentabel in fase C, naast de voorspelkwaliteit.

**Herzien wanneer.** Als blijkt dat vrijwel elk voorstel een blokkade oplevert. Dan
is de vraag niet of de melding moet blijven, maar of de laag hier thuishoort.

## 2026-08-04, de commerciële doctrine is een laag in het domein, de bedragen staan bij de klant

**Context.** Er kwam externe commerciële mechanica beschikbaar (aanbodontwerp,
sequentie, weggevers, kanaalkeuze, betaalstructuur, acquisitierekenwerk,
gespreksstructuur) die het besluitgedrag van de GTM-agent moet beïnvloeden. De
vraag was waar dat landt. Twee dingen liepen erin door elkaar: de methodiek, die
bij elke klant gelijk is, en de bedragen, kortingen en capaciteitsgrenzen, die
per klant verschillen en menselijke besluiten zijn.

**Besluit.** De doctrine staat in `domains/gtm/layers/commercial-doctrine/`, dus
op de domeinas, klantonafhankelijk. De activering, de aanbodcatalogus en alle
bedragen staan op de klantas, onder `clients/<klant>/`. Een nieuwe map `layers/`
naast `playbooks/`, `memory/` en `agents/`.

**Alternatieven, en waarom ze afvielen.**

- **In `playbooks/`.** Afgevallen op drie eigenschappen tegelijk. Een playbook
  geldt altijd, bij elke klant, en verandert zelden. Deze laag is extern van
  herkomst, ongetoetst met n=0, en per klant aan of uit. Erin zetten zou de laag
  bovendien de promotieregel laten overslaan: playbookniveau is het eindpunt van
  een promotie over twee sectoren, geen startpositie.
- **Volledig bij de klant.** Afgevallen, dan divergeert de methodiek per klant en
  is er geen gedeelde leercurve, precies wat het twee-assenbesluit van
  2026-07-29 voorkomt.
- **Methodiek en bedragen in één bestand.** Afgevallen. Dan is de laag niet los te
  trekken en niet herbruikbaar, en verlies je beide beloftes in één keer.

**Gevolg.** De laag is verwijderbaar in vijf stappen (`LAYER.md`, sectie 7) en de
methodiek is herbruikbaar voor een volgend klantproject zonder de bedragen mee te
nemen. Prijs is daarbij een scherpe grens en geen detail: het ICP van de eerste
klant leidt zijn ondergrens voor het aantal modellen af uit de eigen instapprijs,
dus een laag die aan de prijs raakt, raakt langs een omweg aan een
diskwalificatiecriterium.

**Herzien wanneer.** Als een tweede laag in dit domein ontstaat, dan de vraag of
`layers/` een eigen conventie of registratie nodig heeft. Met één laag is dat een
gok op hoe de tweede eruitziet, dezelfde redenering als bij het
orchestratorbesluit van 2026-07-29.

## 2026-08-04, verwijderbaarheid van een laag is een test en geen belofte, met twee benoemde uitzonderingen

**Context.** "Deze laag is verwijderbaar" is niet controleerbaar zolang niemand
kijkt of er verwijzingen naar binnen bestaan. Eén verwijzing uit een
domeinbestand maakt verwijderen tot een aanpassing van dat bestand, en dan is de
laag niet meer los te trekken.

**Besluit.** `infra/laag-check.sh`, met exitcode, in de stijl van
`seg-check.sh`. Twee beweringen:

1. **Onvoorwaardelijk:** geen enkel bestand onder `domains/` buiten de laag
   verwijst naar de laag.
2. **Precies één van buiten:** het activeringsblok in
   `clients/qrius/gtm/config.md`. Nul treffers faalt ook, want dan is de laag
   niet aan te zetten. Een tweede treffer in datzelfde bestand faalt, want dat is
   een plek die de verwijderprocedure niet opruimt.

**Twee uitzonderingen, en die staan in de uitvoer in plaats van weggefilterd.**
`memory/decisions.md`, want besluiten worden nooit verwijderd maar vervallen met
datum, dus deze verwijzing blijft per definitie achter. En het script zelf, dat
uitsluitend bestaat om deze laag te controleren en bij verwijdering meegaat (stap
3 van de procedure).

**Alternatieven.** De uitzonderingen stil wegfilteren: afgevallen. Een
uitzondering die je niet ziet, is een gat, en over een half jaar leest een
geslaagde check dan als een bewijs dat hij niet levert. Ze niet toestaan:
afgevallen, want de besluitenlog vastleggen is zelf een eis en die eis maakt de
verwijzing onvermijdelijk.

**Gevolg.** De check draait in twee negatieve tests aantoonbaar rood (een
verwijzing in een domeinbestand, en een tweede verwijzing in het
activeringsbestand) en groen op de opgeleverde toestand. Wie een verwijzing
toevoegt, moet hem in de verwijderprocedure opnemen of weghalen.

**Herzien wanneer.** Bij een tweede laag: dan wordt het patroon van de check
gedeeld en is de vraag of hij per laag of over lagen heen werkt.

## 2026-08-04, prijs wordt gesplitst: de techniek in het domein, elk bedrag bij de klant

**Context.** Het oorspronkelijke plan was één bestand over prijspresentatie in de
laag, met de scheiding "presenteren mag, bepalen niet". Bij het uitwerken hield
die scheiding geen stand. Een bedrag boven het doelbedrag ankeren is een
prijsbesluit. Een vooruitbetaalkorting is een prijsbesluit. Een aangekondigde
verhoging is een prijsbesluit. Alleen de betaalvorm is dat niet.

**Besluit.** Splitsen. In het domein komt `50-betaalstructuur.md` met de
techniek: betaalsplitsing, factuurritme afstemmen op het betaalritme van de
klant, en ankeren beschreven als mechanisme. Zonder bedragen, percentages of
looptijden. Naar `clients/<klant>/` gaan het ankerbedrag, de
vooruitbetaalkorting, de splitsingsverhouding, en de vraag of er een
prijsverhoging wordt aangekondigd.

De laag mag signaleren **dát** er geen anker of vooruitbetaalprikkel in de
structuur zit. Dat signaal gaat terug naar Ward. De laag zet er nooit zelf een.

**Alternatieven.** Eén bestand met een scopezin die prijsbepaling uitsluit:
afgevallen, te licht voor wat het moest tegenhouden. Prijspresentatie helemaal
weglaten: afgevallen, dan verdwijnt ook de betaalvorm, en dat is het enige deel
dat evident geen prijsbesluit is.

**Gevolg.** `domains/gtm/CLAUDE.md` sectie 1 blijft ongewijzigd gelden:
prijsbepaling hoort niet in dit domein. En het gat langs de omweg is dicht: het
ICP van de eerste klant leidt de ondergrens van dertig modellen af uit de
instapprijs, dus zonder deze splitsing kon de laag via de prijs een
diskwalificatiecriterium verschuiven. Dat kan nu niet meer.

**Herzien wanneer.** Als blijkt dat de betaalstructuur zonder enig bedrag
onbruikbaar abstract is. Dan is de vraag niet of de laag bedragen mag vaststellen,
maar of de klantcatalogus vollediger moet.

## 2026-08-04, dagvolume wordt vervangen door dekkingsdiscipline

**Context.** De bron achter de doctrine schrijft honderd primaire acties per dag
voor, als vaste dagelijkse norm. Die norm is gebouwd voor een markt die
praktisch oneindig is.

**Besluit.** Niet overnemen. In plaats daarvan dekkingsdiscipline: elk account
krijgt een volledige reeks contactmomenten (vijf op stand `standaard`, zeven op
`scherp`), en we meten dekking en reekscompletering in plaats van dagvolume.
Vastgelegd als uitsluiting 6 in `90-uitsluitingen.md`, expliciet als afwijking van
de bron en niet als interpretatie.

**Alternatieven.** De norm overnemen en naar beneden schalen: afgevallen. Dan
blijft dagvolume de eenheid, en dan is de vraag alleen nog welk getal, terwijl het
probleem de eenheid zelf is.

**Gevolg.** De doelgroep in het eerste segment is eindig, in de duizenden. Bij
honderd acties per dag is die markt in een kwartaal aangeraakt en daarna
onbruikbaar, en dat is niet terug te draaien: een verbrande lijst blijft verbrand
en de domeinreputatie gaat mee. Met dekking als eenheid is de vraag hoe compleet
een reeks is, niet hoe snel de lijst leegloopt.

**Dekking is geen route om principe 6 heen.**
`domains/gtm/playbooks/outbound-principes.md`, principe 6, blijft onverkort
gelden: volume verhogen is een aparte beslissing. Zodra de lijst groeit, wordt
"vijf tot zeven contactmomenten per account" zelf een volumeafspraak, en dan
geldt principe 6 daarop.

**Herzien wanneer.** Als de doelgroep aantoonbaar veel groter blijkt dan de
huidige orde van grootte, of als reekscompletering meetbaar niets voorspelt.

## 2026-08-04, zeven mechanieken uit de bron worden bewust niet gebruikt

**Context.** De bron reikt mechanieken aan die in hun eigen context werken en in
onze context schade doen, juridisch of aan geloofwaardigheid. Zonder vastgelegde
reden komen die terug, want ze zien uit als een gat in de doctrine.

**Besluit.** Zeven uitsluitingen, vastgelegd in `90-uitsluitingen.md` met per
punt de volledige reden. In het kort:

| # | Uitsluiting | Reden in één regel |
|---|---|---|
| 1 | loterijen, verlotingen en weggeefacties als instapaanbod | raakt de Wet op de kansspelen; hetzelfde aandachtspunt staat al in de productdocumentatie van de eerste klant bij win-acties |
| 2 | facturatie per 28 dagen voor dertien cycli per jaar | rekenkundig waar, en het kost je geloofwaardigheid bij de eerste factuurcontrole van een inkoopafdeling |
| 3 | gefabriceerde schaarste en tijdsdruk | schaarste mag alleen als hij feitelijk waar is; staat ook als grens, en hier omdat de bron het als techniek aanreikt |
| 4 | de anti-garantie | werkt bij individuele consumentenverkoop, niet in een inkoopproces met meerdere beslissers die juist om zekerheid vragen |
| 5 | proefperiode met boeteclausule | bevoegdheidsgrens: vereist juridische toetsing en een menselijk besluit, en dat kader bestaat nog niet |
| 6 | de volumenorm van honderd acties per dag | onze doelgroep is eindig; zie het besluit hierboven |
| 7 | schaarste of een limiet op datavergaring | waar een klant datavergaring bewust ongelimiteerd houdt, is dat een propositiekeuze en geen omissie om dicht te zetten |

**Alternatieven.** Ze gewoon niet opschrijven: afgevallen. Een uitsluiting zonder
reden is niet te onderscheiden van vergeten, en wordt dan "hersteld".

**Gevolg.** Verwerpen is omkeerbaar, maar alleen via een besluit hier. Punt 3 en
punt 7 hebben ook een grens in `99-grenzen.md`; die twee blijven staan als de
uitsluiting ooit vervalt, want een grens en een uitsluiting doen verschillend
werk.

**Herzien wanneer.** Per punt apart, en niet als set. Punt 5 wordt beoordeelbaar
zodra het juridisch kader voor outbound bestaat.

## 2026-08-04, de laag wordt afgerekend op voorspelkwaliteit en niet op commerciële uitkomst

**Context.** De verantwoording dat deze laag eerlijk verwijderbaar is, hing op
meetbaarheid: als hij niet werkt, moet dat blijken. Maar
`significantie-drempels.md` verbiedt een conversiepercentage onder twintig
waarnemingen en stelt vast dat harde conversies die drempels vrijwel nooit halen.
Bij een eindige doelgroep en n=0 is "verhoogt deze laag de conversie" daarmee
jaren onbeantwoordbaar, en tot die tijd zou de laag onweerlegbaar blijven staan.

**Besluit.** De vraag verschuift, de drempel niet. Gemeten wordt de
voorspelkwaliteit: per advies dat uit de laag komt, hield de voorspelde richting
stand. Na twintig beoordeelde adviezen is er n=20 op "produceert deze laag
voorspellingen die kloppen", en dat is in maanden haalbaar in plaats van jaren.

Drie harde voorwaarden:

1. **Dit vervangt en versoepelt de bestaande drempels niet.** Het is een nieuwe
   maatstaf ernaast. De drempels in `significantie-drempels.md` blijven
   ongewijzigd; dit besluit is de registratie die sectie 4 van dat playbook
   vereist, met datum en reden.
2. **Het is een zwakkere claim, en dat staat er letterlijk bij.** Voorspelkwaliteit
   zegt niets over opbrengst. Die vraag blijft bij het huidige volume
   onbeantwoordbaar, en doen alsof van niet zou de bewijslastregel schenden.
3. **Bij twintig beoordeelde adviezen volgt een kwalitatief oordeel, geen
   percentage.**

**Alternatieven.** De drempel verlagen zodat de conversievraag wel beantwoordbaar
wordt: afgevallen, en dit is de belangrijkste afweging in dit besluit. Die regel
is goed, en een drempel die wordt bijgesteld om een gewenste vraag te kunnen
beantwoorden, is geen drempel. De laag ongemeten laten: afgevallen, dan is
verwijderen nooit ergens op te baseren en blijft hij staan omdat hij er staat.

**Gevolg.** Uit te werken in fase C. Daarvoor moet de aanbevelingentabel
herkomst (laag en laagversie), intensiteit, segment en een veld voor het
standhouden van de voorspelling kunnen vastleggen. Die kolommen bestaan nog niet;
de tabel heeft ook geen `meta`-kolom, dus er is geen sluiproute. Gesloten lijsten
komen in kolommen met een check-constraint en worden bij ingest afgedwongen, niet
in jsonb.

**Herzien wanneer.** Zodra de outboundvolumes de segmentdrempel van twintig
verzonden structureel halen. Dan wordt de conversievraag beantwoordbaar en is
voorspelkwaliteit een aanvulling in plaats van een vervanging.

## 2026-08-04, `clients/_template/` is structuur en geen klantcontext

**Context.** De klantisolatieregel verbiedt het inlezen van twee mappen onder
`clients/` in één sessie, en staat er als de enige regel zonder uitzonderingen.
`clients/_template/` valt onder `clients/`, maar bevat geen klantdata: het zijn
lege sjablonen met placeholders. Bij de audit voor deze laag is de vraag
praktisch geworden, want een sjabloon opleveren vraagt om de bestaande
sjabloonconventie te kennen.

**Besluit.** `clients/_template/` is structuur en geen klantcontext. Het mag naast
één klantmap gelezen worden. Er kan niets lekken, want er staat niets in dat bij
een klant hoort.

**Alternatieven.** De regel letterlijk aanhouden en het sjabloon nooit lezen:
afgevallen, dan is de sjabloonconventie niet te volgen en divergeert elk nieuw
klantproject. Een algemene uitzonderingsclausule in de isolatieregel:
afgevallen, dat opent de regel voor interpretatie en juist de afwezigheid van
interpretatieruimte is de waarde ervan.

**Gevolg.** De regel houdt nul uitzonderingen op klantdata en krijgt één
verduidelijking over wat een klantmap is. Voorstel voor de formulering in
`CLAUDE.md` sectie 2 gaat apart ter beoordeling en wordt niet ongezien
toegevoegd.

**Herzien wanneer.** Als er ooit voorbeelddata in het sjabloon komt te staan. Op
dat moment wordt het wél klantcontext, ook als de klant verzonnen is, want dan
gaat iemand ernaar verwijzen als bewijs.

## 2026-07-30, rate limiting hoort aan de edge, niet in de applicatie

**Context.** De ingest-endpoint van de tracking is publiek en schrijft naar de
database. Er zat geen enkele begrenzing op. Gemeten vanaf één machine: 200
verzoeken in 0,73 seconde, alle 200 geaccepteerd, dus circa 275 per seconde
zonder tegenwerking. Een rij is ongeveer 600 bytes inclusief indexen, dus grofweg
600 MB per miljoen rijen; met 8 GB schijf is dat rond de dertien uur werk voor
één laptop.

**Besluit.** Rate limiting ligt bij Cloudflare, dat al vóór de site staat. **Niet
in de route handler en niet met een extra dienst erbij.**

**Alternatieven, en waarom ze afvielen.**

- **Een limiter in de route handler.** Afgevallen op mechaniek, niet op smaak: de
  state zit per serverless-instantie, verdwijnt bij een koude start en wordt niet
  gedeeld tussen instanties. Dat is geen strenge limiet maar een limiet die
  meeschaalt met het aantal instanties, dus precies het tegenovergestelde van wat
  je wil onder druk. Het ziet eruit als bescherming en is het niet, en dat is
  erger dan niets, want er wordt op vertrouwd.
- **Een gedeelde teller in een externe sleutelwaardedienst.** Werkt technisch,
  maar voegt een dienst, een dependency en een faalpad toe aan een pad dat nooit
  mag falen. Bij dit volume is dat overengineering.

**Gevolg.** Er staat in de applicatie bewust géén limiter, en dat is een keuze en
geen omissie. **Bouw hem daar niet alsnog in.** Loopt de limiet niet goed, dan is
de knop bij Cloudflare de plek, niet de code.

**Wat de applicatie wél doet**, en wat je niet met rate limiting moet verwarren:

- **`verification` op `meeting_booked`.** Dit is de eigenlijke bescherming van het
  enige getal dat telt. Rate limiting maakt vervuiling lastiger; verificatie maakt
  het cijfer betrouwbaar. Zie het besluit hieronder.
- **Een same-origin-filter.** Uitdrukkelijk een **drempel en geen muur**: `Origin`
  en `Sec-Fetch-Site` zijn met elke HTTP-client te vervalsen. Het weert het losse
  scriptje dat de endpoint vindt, niet iemand die het probeert. Zo staat het ook
  in de code gedocumenteerd, zodat er later niet op vertrouwd wordt.

**Herzien wanneer.** Als de Cloudflare-regel structureel echt verkeer raakt, of
als de site ooit achter iets anders dan Cloudflare komt te staan. In dat tweede
geval verhuist de limiet mee naar die laag, niet naar de applicatie.

## 2026-07-30, een door de browser gemelde boeking is geen bevestigde conversie

**Context.** `meeting_booked` is de enige harde conversie en wordt gemeld door de
browser van de bezoeker. Die browser is een publieke, aanpasbare omgeving:
iedereen die de ingest-URL kent kan een boeking melden die niet bestaat. Bij een
metriek waar de n klein is, is dat schadelijker dan een volle database. Twintig
verzonnen meldingen zijn genoeg om een verkeerde beslissing op te bouwen, en
achteraf zijn ze niet van echte te onderscheiden.

**Besluit.** `gtm_events.verification` met `onbevestigd`, `bevestigd` en
`afgewezen`. Elke boeking komt binnen als `onbevestigd`. Alleen `bevestigd` telt
mee in een conversiecijfer; dat staat in
`domains/gtm/playbooks/significantie-drempels.md`, zodat het een rekenregel is en
geen goede bedoeling.

**Het mechanisme dat vergeten onmogelijk maakt.** Een check-constraint eist dat
een `meeting_booked` een status heeft en dat elk ander event-type er géén heeft.
Zonder die constraint zou een rij zonder status stilzwijgend als conversie
meegeteld kunnen worden, en dat is precies het gat.

**Verificatie is een aparte stap, en zit bewust niet in de ingest.** Zou de
ingest natrekken, dan hangt het vastleggen van een boeking af van de
beschikbaarheid van de boekingsdienst, en verlies je een echte melding als die
dienst even niet antwoordt. Vastleggen en natrekken zijn twee dingen. De
koppeling met de boekingsdienst is daarmee geen blokkade voor deze scheiding.

**Alternatieven.** Onbevestigde meldingen weigeren bij ingest: afgevallen, dan
verlies je ook de echte. Ze verwijderen na afwijzing: afgevallen, want juist het
patroon van afgewezen meldingen is het signaal dat iemand aan het rommelen is.

**Gevolg.** Zolang er niets natrekt, staat elke boeking op `onbevestigd` en is het
conversiecijfer per definitie nul. Dat is de bedoeling: een leeg cijfer met een
wachtrij ernaast is eerlijker dan een cijfer dat niemand kan vertrouwen. In elke
rapportage hoort het aantal onbevestigde meldingen naast het conversiecijfer.

**Herzien wanneer.** Als er een koppeling is die automatisch natrekt, dan de
vraag of `onbevestigd` nog een zichtbare toestand hoeft te zijn of alleen een
tussenstand van seconden.

## 2026-07-30, `site_visit` telt sessies vanaf een aflopend venster van 30 minuten, met een breuk in de reeks

**Context.** `site_visit` was bedoeld als één rij per sessie, omdat de
kanaaldrempel in `significantie-drempels.md` in sessies per bron per week
rekent. De markering stond in `sessionStorage`, en dat is per tabblad. De eerste
productiemeting gaf vier rijen voor één sessie.

**Waarom dit een fix werd en geen voorbehoud.** De fout is niet uniform. Hij
groeit met hoe grondig iemand kijkt: wie na één pagina wegklikt levert één rij,
wie in vijf tabbladen rondkijkt levert vijf. De vertekening zit daarmee precies
op de betrokken bezoekers die je wilt onderscheiden, en dat is de groep waar de
hele meting om gaat. Een voetnoot bij een systematisch scheve meting is geen
oplossing, want elke afgeleide uitspraak blijft scheef.

**Besluit.** De sessiemarkering staat in `localStorage`, dus over tabbladen
heen, met een aflopend venster van **30 minuten inactiviteit**. Het venster
schuift mee bij elke paginaweergave, ook bij weergaven die geen event opleveren:
het meet stilte en geen totale duur. Dertig minuten omdat dat de gangbare
standaard is, zodat de cijfers vergelijkbaar blijven met wat een klant in een
andere analyticstool ziet.

**Alternatieven.** Een vaste sessieduur in plaats van een aflopend venster:
afgevallen, want dan wordt een bezoeker die drie kwartier doorleest op minuut 30
een tweede sessie. Een eigen bezoeker-identificatie: afgevallen, dat zou het
enige moment zijn waarop deze opzet een persistente identifier krijgt, en dat is
precies wat we niet doen.

**⚠️ Gevolg: er zit een breuk in de reeks.** De rijen van vóór dit besluit tellen
tabblad-sessies, de rijen erna tellen bezoekerssessies. De oude rijen worden
**niet** weggegooid en **niet** herrekend: herrekenen zou een getal opleveren dat
nooit gemeten is, en weggooien maakt het onmogelijk om later te zien wat er
gebeurd is.

**Elke analyse die over het omslagmoment heen kijkt, moet de breuk benoemen.**
Niet als voetnoot maar in de sectie "Wat ik niet kon vaststellen" van de output.
Dat volgt rechtstreeks uit de bewijslastregel: een reeks waarvan de eenheid
halverwege verandert, draagt geen conclusie over de hele reeks. Concreet:

- Vergelijk geen week van vóór het omslagmoment met een week erna.
- Reken geen trend over een periode die het moment omvat.
- Toets de kanaaldrempel van 30 sessies per bron per week alleen binnen een
  periode die geheel aan één kant van het moment valt.
- De rijen van vóór het moment zijn een **bovengrens** op het aantal sessies,
  nooit een ondergrens.

**Het omslagmoment.** De laatste rij van de oude soort is
`2026-07-30 09:08:35 UTC`; de fix is gemerged als `56fa65c2` en kort daarna
gedeployd. Tussen die twee momenten is geen enkele rij binnengekomen, dus de
grens is ondubbelzinnig zonder de exacte deployseconde. De query's staan in
`clients/qrius/gtm/config.md`. Het betreft vier rijen, dus in de praktijk is de
eenvoudigste route: negeer die vier bij elke trendvraag en zeg dat je dat doet.

**Kandidaat voor promotie.** De onderliggende regel, dat een wijziging van de
meeteenheid een breuk in de reeks oplevert die benoemd moet worden en niet mag
worden weggerekend, is niet GTM-specifiek. Hij staat nu als aanvulling in
`domains/gtm/playbooks/significantie-drempels.md`. Bij een tweede domein
opnieuw beoordelen; met één domein is er geen tweede onafhankelijke context, dus
de promotieregel is niet gehaald.

**Herzien wanneer.** Als de 30 minuten niet meer aansluiten bij hoe de doelgroep
de site gebruikt, of als er ooit een reden komt om sessies met een
bezoeker-identificatie te tellen. Dat tweede vraagt dan eerst een besluit over
persoonsgegevens.

## 2026-07-29, de GTM-datalaag krijgt een eigen Supabase-project: `Brandpulse GTM`

**Context.** `gtm_events`, `gtm_objections` en `agent_recommendations` moesten
ergens landen. De organisatie heeft vier bestaande projecten, waarvan één de
productiedatabase van het Qrius-platform is. De vraag was of de commerciële data
van Brandpulse daarin mag, in een eigen schema met eigen RLS, of in een apart
project.

**Besluit.** Een apart Supabase-project, `Brandpulse GTM`, ref
`syyhnsghnozaqctaavbl`, regio `eu-west-1`, 10 dollar per maand. Zie
`infra/brandpulse-gtm.md`.

**Alternatieven, en waarom ze afvielen.** Optie (b) was een schema `gtm` binnen
het bestaande Qrius-project, met eigen RLS. Afgevallen op drie gronden, in
volgorde van gewicht:

1. **Eigendom en overdracht, de doorslaggever.** `gtm_events` krijgt een
   `client`-kolom omdat er meer klanten bij komen. In optie (b) zou commerciële
   data over klant B, C en D in de productiedatabase van klant A staan. Wordt
   Qrius ooit verkocht, afgesplitst of overgedragen, dan gaat die data mee. Dat
   is niet met permissies te repareren en niet met een migratie terug te
   draaien. Tien dollar per maand weegt daar niet tegenop.
2. **Een eigen schema is geen vertrouwensgrens.** Zie hieronder; dit is de les
   die breder geldt dan deze keuze.
3. **Migratiehistorie.** De productiehistorie van het Qrius-project is gedrift
   en migraties moeten daar handmatig vooraf worden toegepast. Elke
   GTM-schemawijziging zou langs dat proces moeten, en een GTM-migratie zou
   omgekeerd de preview-replay van de productrepo kunnen breken op de
   `schema_migrations`-primary key. Een nieuw project begint met een schone
   historie.

Daarnaast, lichter meegewogen: contactpersonen en verbatims zijn
persoonsgegevens met een ander doel en een andere bewaartermijn dan platformdata
waarvoor Qrius verwerker is.

**De les die breder geldt.** Een apart schema biedt **geen** bescherming zolang
de service-role sleutel in gebruik is. RLS wordt door die rol genegeerd en
Supabase kent geen sleutel per schema. In het Qrius-project is die sleutel al in
gebruik, onder meer in de landing-app. Een schema geeft dus ordelijkheid, geen
grens. Scheiding die telt, loopt via een apart project met eigen sleutels. Deze
regel geldt bij elke toekomstige afweging in de trant van "zet het netjes in een
eigen schema", in welk domein dan ook.

**Over de naam.** Niet `Brandpulse Data`, wat het oorspronkelijke voorstel was.
Die naam laat alles toe en nodigt daarmee op termijn dezelfde vermenging uit die
hier wordt opgelost. `Brandpulse GTM` dwingt scope af. `agent_recommendations`
mag erin: de tabel is qua structuur domeinoverstijgend maar bevat voorlopig
alleen GTM-adviezen. Schrijft een tweede domein er ooit in, dan wordt de
projectnaam op dat moment heroverwogen, met een echt tweede geval in plaats van
een vermoeden. Dezelfde redenering als bij het diagnoseprincipe hieronder.

**Gevolg.** Twee databases om te beheren en twee sets omgevingsvariabelen,
bewust met verschillende namen zodat een verkeerd geconfigureerde omgeving niet
stilletjes naar de andere database schrijft. Joins tussen GTM-data en
Qrius-productdata zijn niet meer mogelijk in SQL; mocht dat ooit nodig zijn, dan
is dat een geaggregeerde export en geen join.

**Herzien wanneer.** Als een tweede domein in `agent_recommendations` gaat
schrijven, dan de projectnaam. De keuze voor een apart project zelf niet: die
wordt met elke extra klant sterker, niet zwakker.

**Nadere notitie bij het `domain`-constraint (2026-07-29).** De check-constraint
op `agent_recommendations.domain` staat op alleen `gtm`. Dat is **typefout-
bescherming, geen principiële domeinbeperking.** De kolom bestaat juist omdat er
een tweede domein verwacht wordt; zonder die verwachting zou de kolom er niet
zijn. Het constraint zorgt er alleen voor dat een waarde als `gmt` of `content `
wordt geweigerd in plaats van stil geaccepteerd, want een rij met een verkeerd
gespeld domein is onvindbaar en niet fout. Een domein toevoegen is dus een
migratie van één regel en geen discussie. Deze notitie staat er omdat het
constraint over een halfjaar anders leest als een architectuurstandpunt dat
niemand heeft ingenomen.

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

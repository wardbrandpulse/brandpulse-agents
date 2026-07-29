# Taxonomie, de canonieke waardelijst

Dit bestand is de bron. Drie dimensies, en ze gelden overal identiek: in UTM's,
in e-maillinks, in Notion, in Cal.com event types, in de database en in elke
rapportage.

Wijkt een systeem af, dan is dat systeem fout, niet dit bestand.

De regels **rond** canonieke waardelijsten (hoe je een waarde toevoegt, waarom
je nooit hernoemt, waar afdwinging hoort, wat er met ontbrekende labels gebeurt)
zijn niet GTM-specifiek en staan in de root-[`CLAUDE.md`](../../../CLAUDE.md),
sectie 5. Dit bestand bevat de **waarden** en wat er binnen GTM aanvullend
geldt.

---

## 1. De drie dimensies

### `segment`, in welke markt zit de ontvanger

| Waarde | Betekenis |
|---|---|
| `ebike` | e-bikefabrikanten, importeurs en merken |
| `retail` | non-food retail en merken die via retail verkopen |
| `food` | levensmiddelenproducenten en food-merken |
| `bureau` | bureaus en partners, dus indirecte kanalen |

`segment` beschrijft de **ontvanger**, niet de afzender en niet het product.

### `source`, waar komt de aanraking vandaan

| Waarde | Betekenis |
|---|---|
| `outbound` | actief door ons verstuurde mail |
| `linkedin` | LinkedIn, organisch en betaald |
| `google` | Google, organisch en betaald |
| `gs1` | via GS1, een resolver of een gescande code |
| `direct` | geen herleidbare bron, bezoeker kwam rechtstreeks |
| `referral` | doorverwijzing vanaf een andere site of persoon |

`direct` is geen vuilnisbak. Het betekent: er was geen bron, niet: de bron is
kwijtgeraakt. Zie sectie 4.

### `asset`, wat kreeg de ontvanger te zien

| Waarde | Betekenis |
|---|---|
| `magazine` | het magazine of een ander lang inhoudelijk stuk |
| `demo` | demo-aanvraag of demo-omgeving |
| `pricing` | de prijspagina |
| `landing` | een landingspagina zonder eigen asset |

`asset` mag leeg blijven als er geen asset in het spel was. Leeg is een geldige
waarde; een verzonnen waarde niet.

---

## 2. Een nieuwe waarde toevoegen

De regels hiervoor zijn niet GTM-specifiek en staan in de
root-[`CLAUDE.md`](../../../CLAUDE.md), sectie 5: eerst hier vastleggen, dan de
datalaag laten volgen, dan pas gebruiken, en nooit hernoemen.

Binnen GTM geldt aanvullend:

- **Toets het verwachte volume tegen de drempels.** Een nieuwe waarde met een
  verwachte n onder de drempel uit
  [`significantie-drempels.md`](significantie-drempels.md) levert een categorie
  op waar nooit een uitspraak over gedaan kan worden. Dat is een reden om hem
  niet te maken, of om hem samen te voegen met een bestaande.
- **Noteer datum en betekenis in één zin** bij de waarde in de tabellen
  hierboven.
- **De check-constraints van de datalaag** van dit domein dwingen exact deze
  lijsten af. Welke bron dat is, staat per project in
  `clients/<klant>/gtm/config.md`.

---

## 3. UTM-conventie

De dimensies overleven in de URL, maar niet allemaal in een UTM-parameter.
`utm_medium` houdt zijn **conventionele** betekenis en het segment krijgt een
eigen parameter.

| Parameter | Bevat | Waardenlijst |
|---|---|---|
| `utm_source` | `source` | gesloten, zie boven |
| `utm_medium` | het kanaaltype, conventioneel | gesloten, zie hieronder |
| `seg` | `segment` | gesloten, zie boven |
| `utm_content` | `asset` | gesloten, zie boven, mag ontbreken |
| `utm_campaign` | campagnenaam | vrij veld, kleine letters, koppeltekens, eindigt op `jjmm` |

**Waarom `utm_medium` niet het segment draagt.** Vrijwel elke analyticstool
gebruikt `utm_medium` om verkeer automatisch in kanaalgroepen te sorteren. Zet
je daar een segment in, dan valt die groepering stil om: zonder foutmelding, en
niet alleen voor ons, ook voor iedereen die er later naar kijkt en de conventie
niet kent. Dat is precies het soort stille breuk waar dit playbook tegen bedoeld
is.

Het afdwingen van gesloten lijsten hoort dan ook niet in de URL thuis maar bij
ingest: de route handler valideert en de check-constraint weigert. Zie de
root-[`CLAUDE.md`](../../../CLAUDE.md), sectie 5. Een URL is een voorstel, geen
garantie.

### Toegestane `utm_medium`-waarden

| Waarde | Wanneer |
|---|---|
| `email` | alles wat per mail verstuurd is |
| `social` | organische posts op sociale netwerken |
| `cpc` | betaald verkeer, ongeacht het platform |
| `organic` | onbetaalde zoekresultaten |
| `referral` | doorverwijzing vanaf een andere site of een resolver |

`utm_source` en `utm_medium` zijn niet inwisselbaar. De gebruikelijke
combinaties:

| `utm_source` | Gebruikelijke `utm_medium` |
|---|---|
| `outbound` | `email` |
| `linkedin` | `social`, of `cpc` bij betaald |
| `google` | `organic`, of `cpc` bij betaald |
| `gs1` | `referral` |
| `referral` | `referral` |
| `direct` | komt niet voor in een URL, zie sectie 4 |

### De `seg`-parameter

- Bewust **zonder** `utm_`-prefix, zodat analyticstools hem negeren en hij hun
  kanaalgroepering en rapportages niet vervuilt.
- Moet elke redirect overleven. Gaat hij onderweg verloren, dan komt het bezoek
  binnen als ongelabeld en is het segment definitief weg.
- Wordt bij het eerste bezoek vastgelegd, niet pas bij conversie. Anders is hij
  bij een latere terugkeer verdwenen.

Alles in kleine letters. Geen spaties, geen accenten, geen hoofdletters. Een
verschil in hoofdlettergebruik levert twee categorieën op die er in een
rapportage uitzien als één.

### Voorbeeld per segment

```
ebike
https://<site>/magazine?utm_source=outbound&utm_medium=email&seg=ebike&utm_campaign=batterijpaspoort-2609&utm_content=magazine

retail
https://<site>/prijzen?utm_source=linkedin&utm_medium=social&seg=retail&utm_campaign=dpp-uitleg-2609&utm_content=pricing

food
https://<site>/demo?utm_source=google&utm_medium=cpc&seg=food&utm_campaign=etikettering-2609&utm_content=demo

bureau
https://<site>/partners?utm_source=referral&utm_medium=referral&seg=bureau&utm_campaign=partnerprogramma-2609&utm_content=landing
```

De host is per klantproject anders en staat in
`clients/<klant>/gtm/config.md`, niet hier.

---

## 4. Ongelabeld verkeer

De algemene regel staat in de root-[`CLAUDE.md`](../../../CLAUDE.md), sectie 5:
ontbrekende labels heten ongelabeld, worden apart geteld en worden nooit over de
bekende waarden verdeeld.

Binnen GTM is er één val die het benoemen waard is.

**`direct` is geen vuilnisbak.** Het betekent: er was aantoonbaar geen bron. Een
bron die onderweg verloren is gegaan, bijvoorbeeld door een redirect die de
parameters liet vallen, is **ongelabeld** en niet `direct`. Die twee door elkaar
halen laat een meetprobleem eruitzien als een groeiend eigen merk, en dat is een
prettige conclusie om per ongeluk te trekken.

---

## 5. Waar de taxonomie moet landen

Overal waar een aanraking wordt vastgelegd, dus minimaal:

- links in uitgaande mail
- links in advertenties en posts
- de gebeurtenissenbron van het project
- het boekingsformulier van een afspraak, zodat een geboekte afspraak
  toewijsbaar blijft aan segment, bron en asset
- de plek waar deals en pijplijn worden bijgehouden

Elke plek waar een aanraking landt zonder de drie dimensies, is een plek waar de
keten breekt. Bij een gebroken keten valt niet de laatste stap uit, maar de
toewijzing van alles ervoor.

---

## 6. Aanvullende waardelijsten van de datalaag

Naast de drie dimensies kent de datalaag nog vier gesloten lijsten. Ze staan
hier omdat er per domein **één** bron voor waardelijsten is (root-`CLAUDE.md`,
sectie 5), niet verspreid over de plek waar ze toevallig gebruikt worden.
Dezelfde regels gelden: eerst hier, dan de datalaag, dan pas in gebruik, en
nooit hernoemen.

### `event_type`, wat er gebeurde

| Waarde | Betekenis |
|---|---|
| `email_sent` | mail verstuurd |
| `email_open` | mail geopend, zie principe 5 in [`outbound-principes.md`](outbound-principes.md): draagt geen conclusie |
| `email_click` | op een link in de mail geklikt |
| `email_reply` | antwoord ontvangen |
| `email_bounce` | mail niet bezorgd |
| `site_visit` | bezoek aan de site |
| `magazine_view` | magazine bekeken |
| `pricing_view` | prijspagina bekeken |
| `demo_request` | demo aangevraagd |
| `meeting_booked` | afspraak geboekt, de harde conversie |
| `stage_change` | verschuiving in de pijplijn |
| `deal_lost` | verloren |

`meeting_booked` is de enige harde conversie. Alle andere zijn tussenstappen en
worden nooit als conversie gerapporteerd.

### `objection_code`, waar de reply op vastliep

| Waarde | Waar het meestal op neerkomt |
|---|---|
| `te-vroeg` | de deadline voelt ver weg, of men gelooft in uitstel |
| `doet-leverancier-al` | een bestaande partij claimt dit te dekken |
| `geen-budget` | geen post op de begroting |
| `wat-is-dpp` | de categorie is onbekend |
| `intern-bouwen` | het lijkt op iets dat IT ook kan |
| `geen-eigenaar` | het valt tussen afdelingen in |
| `anders` | restcategorie |

Groeit `anders` boven een tiende van de replies, dan ontbreekt er een code. Dat
gaat vóór het beantwoorden van de bezwaren: een restcategorie die groeit,
verbergt precies het patroon dat je zoekt.

### `status`, waar een aanbeveling staat

`voorgesteld` · `geaccepteerd` · `afgewezen` · `uitgevoerd`

### `domain`, welk domein het advies gaf

Op dit moment alleen `gtm`. Dit is de enige lijst die niet GTM-specifiek is: hij
hoort bij de domeinoverstijgende aanbevelingentabel en staat hier voorlopig
omdat er één domein is. Komt er een tweede, dan verhuist deze lijst mee met de
heroverweging van de projectnaam. Zie `memory/decisions.md` (2026-07-29).

# Qrius, GTM-config

De enige plek in dit klantproject waar concrete bronnen, omgevingen en
verbindingen benoemd worden. Playbooks en instructies verwijzen hierheen en
noemen zelf nooit een tool. Zie de platformneutraliteitsregel in de
root-`CLAUDE.md`.

**Geen sleutels, tokens of wachtwoorden in dit bestand.**

- **Laatst bijgewerkt:** 2026-08-04
- **Status:** datalaag en tracking staan live op productie en er komen events
  binnen. Het ICP is vastgesteld (versie 2, n=0). Zie "Openstaand" voor wat er
  nog moet gebeuren vóór de eerste outbound.

---

## Databronnen

| Bron | Waarvoor | Aanduiding | Status |
|---|---|---|---|
| gebeurtenissen | de GTM-events (`gtm_events`) | Supabase-project `Brandpulse GTM`, ref `syyhnsghnozaqctaavbl` | bestaat |
| bezwaren | gecodeerde replies (`gtm_objections`) | zelfde project | bestaat |
| aanbevelingen | voorspelling en uitkomst (`agent_recommendations`, met `domain` naast `client`) | zelfde project | bestaat |
| accounts | motion per account (`gtm_accounts`) | zelfde project | bestaat, **nog leeg** |
| productdata Qrius | platformdata van Qrius-klanten | Supabase-project `QRious`, ref `rylmnfaaylnnnbiuywlq` (productie) | bestaat, **buiten scope voor GTM** |
| pijplijn | waar deals en stadia staan | `TODO` | |

**De twee databases worden niet vermengd.** `Brandpulse GTM` bevat commerciële
data van het bureau over meerdere klanten. Het Qrius-project bevat platformdata
van Qrius-klanten. Er wordt vanuit GTM niet naar het Qrius-project geschreven en
er worden geen joins tussen beide gelegd. De onderbouwing staat in
[`../../../memory/decisions.md`](../../../memory/decisions.md) (2026-07-29), de
details van het GTM-project in
[`../../../infra/brandpulse-gtm.md`](../../../infra/brandpulse-gtm.md).

### Connectie en omgevingsvariabelen

Apart van die van Qrius, en bewust met andere namen zodat een verkeerd
geconfigureerde omgeving niet stilletjes in de verkeerde database schrijft.

| Variabele | Wijst naar | Zichtbaarheid |
|---|---|---|
| `GTM_SUPABASE_URL` | `https://syyhnsghnozaqctaavbl.supabase.co` | server |
| `GTM_SUPABASE_SERVICE_ROLE_KEY` | dashboard, project `Brandpulse GTM` | **alleen** server, nooit in een browserbundel |

De bestaande `NEXT_PUBLIC_SUPABASE_*`-variabelen van QRius wijzen naar het
Qrius-project en blijven ongemoeid. Ze worden **niet** hergebruikt voor GTM.

Beide staan gezet op het Vercel-project `q-rius-website`. Bevestigd op
2026-07-30 doordat er events binnenkomen; te controleren met `GET /api/gtm`.

## Websites en analytics

- **Marketingsite:** de app `apps/website` in de repository
  `wardbrandpulse/QRius`. Dit is de site die de GTM-events moet gaan leveren.
- **Portaal en consumentenpagina:** `apps/portal` en `apps/landing` in dezelfde
  repository. Deze staan niet in scope voor GTM-tracking.
- **Hoofddomein:** **`https://www.qrius.id`**. Dat is de host die serveert.
  `qrius.id` geeft een **308 naar www**, uitgevoerd door Cloudflare vóór Vercel
  en vóór enige JavaScript, met de querystring intact (aan de edge gecontroleerd
  op 2026-07-30). **Gebruik www in elke outboundlink**, dan kost campagneverkeer
  geen extra hop. Zie ook de waarschuwing over hostconsistentie onderaan.
- **Bestaande webanalytics:** Vercel Web Analytics. Blijft staan zoals het
  staat, wordt niet gedupliceerd en niet vervangen. Er zit geen
  analytics-package in de app, dus het loopt via de Vercel-projectinstelling.
  `TODO`, bevestigen op welk Vercel-project dit aanstaat.
- **Waar de UTM's op landen:** elke route van de marketingsite. Er is geen
  aparte campagnelandingspagina; de parameters worden op iedere pagina gelezen.

### Tracking

Gebouwd in fase 1B stap 3. De code staat in `apps/website/src/lib/gtm/` en
`apps/website/src/app/api/gtm/`.

| Wat | Waarde |
|---|---|
| Bewaartermijn first touch | **90 dagen**, gerekend vanaf de eerste aanraking |
| Opslag | `localStorage`, sleutel `qrius-gtm-first-touch` |
| Sessievenster | **30 minuten inactiviteit**, aflopend |
| Sessiemarkering | `localStorage`, sleutel `qrius-gtm-last-seen` |
| Ingest | `POST /api/gtm` op de marketingsite, alleen same-origin |
| Diagnose | `GET /api/gtm` geeft `{"ok":true,"configured":…}`, blijft open |
| Rate limiting | **bij Cloudflare**, niet in de applicatie |
| Harde conversie | komt binnen als `onbevestigd`, moet worden nagetrokken |

**De bewaartermijn van 90 dagen** is gekozen op de lengte van de
oriëntatieperiode hier: een outboundmail, weken later een magazine, daarna pas
een boeking. Korter en de bron is weg voordat de deal in beeld komt; veel langer
en een verouderd label krijgt krediet voor een bezoek waar het niets mee te
maken had. Het venster is **vast, niet schuivend**: het verloopt 90 dagen na de
eerste aanraking en wordt bij een later bezoek niet verlengd. Een schuivend
venster zou van first touch stilletjes "eerste aanraking binnen 90 dagen van de
laatste activiteit" maken, en dat is een zwakkere claim.

Het getal staat ook in `RETENTION_DAYS` in `apps/website/src/lib/gtm/attribution.ts`.
Wijzig je het daar, wijzig het dan hier ook; twee getallen die uit elkaar lopen
zijn erger dan één verkeerd getal.

**Wat er wordt vastgelegd:** alleen campagnelabels (segment, source, medium,
asset, campagne) en twee tijdstempels. Geen bezoeker-identificatie, geen
willekeurig ID, geen fingerprint. Twee bezoekers die via dezelfde link
binnenkomen hebben een identiek record.

**Welke events:**

| Event | Wanneer | Status |
|---|---|---|
| `site_visit` | eerste paginaweergave van een **sessie**, zie definitie hieronder | actief |
| `pricing_view` | op `/get-qrius` | actief |
| `meeting_booked` | Cal.com meldt een geslaagde boeking, op `/demo` en `/voor-partners` | actief |
| `magazine_view` | zou op de magazinepagina komen | **niet aangesloten, die pagina bestaat niet** |

**Wat een sessie hier is.** Een reeks paginaweergaven met nooit meer dan **30
minuten stilte** ertussen. Het venster schuift mee bij elke paginaweergave, ook
bij de weergaven die geen event opleveren: het meet inactiviteit en geen totale
duur. De markering staat in `localStorage`, dus **over tabbladen heen**: vijf
tabbladen naast elkaar zijn één sessie.

Dertig minuten is de gangbare standaard, zodat de cijfers vergelijkbaar blijven
met wat een klant in een andere analyticstool ziet. Het getal staat in
`SESSION_TIMEOUT_MINUTES` in `apps/website/src/lib/gtm/attribution.ts`. Wijzig
je het daar, wijzig het hier ook.

Een andere browser of een ander apparaat is een eigen sessie. Er is geen
bezoeker-identificatie, dus dezelfde persoon op laptop en telefoon levert twee
sessies. Dat is een bewuste ondergrens aan wat we willen weten.

**⚠️ Breuk in de reeks op 2026-07-30.** Vóór die datum stond de markering in
`sessionStorage` en telde een rij een **tabblad**, niet een sessie. Eén sessie
gaf toen vier rijen. Die rijen blijven staan en worden niet herrekend.

**Omslagmoment: `2026-07-30 09:23:35 UTC`**, het moment waarop de
productiedeploy van `56fa65c2` klaarstond. De laatste rij van de oude soort
staat op `09:08:35.122`, dus er is geen enkele rij in het grijze gebied.

```sql
-- oude eenheid: tabblad-sessies, alleen als bovengrens bruikbaar
select * from gtm_events where occurred_at < '2026-07-30 09:23:35+00';
-- nieuwe eenheid: bezoekerssessies
select * from gtm_events where occurred_at >= '2026-07-30 09:23:35+00';
```

Let op de precisie van de grens: `09:08:35+00` betekent `09:08:35.000` en laat
de laatste oude rij (`.122`) er dus dóór. Gebruik de deploytijd hierboven, die
ligt ruim tussen de twee reeksen.

**Eenmalig effect bij de omslag.** De sleutel van de sessiemarkering veranderde
mee (`qrius-gtm-session` in `sessionStorage` werd `qrius-gtm-last-seen` in
`localStorage`). Bezoekers die op het omslagmoment midden in een sessie zaten,
kregen daardoor één keer een extra `site_visit`. In de data zichtbaar als een rij
om `09:29:51` met een `first_seen_at` van vóór de omslag. Eenmalig, niet
structureel.

- Vergelijk geen periode van vóór het moment met een periode erna.
- Rijen van vóór het moment zijn een **bovengrens** op het aantal sessies.
- Elke analyse die over het moment heen kijkt, benoemt de breuk in "Wat ik niet
  kon vaststellen".

Het gaat om vier rijen van de oude soort, dus praktisch is de eenvoudigste
route: negeer die vier bij elke trendvraag en zeg dat je dat doet.

De onderbouwing staat in
[`../../../memory/decisions.md`](../../../memory/decisions.md) (2026-07-30).

Paginaweergaven worden al door Vercel geteld en worden hier niet gedupliceerd.

## Verzenden

- **Verzenddomein (apart en opgewarmd):** `TODO: door Ward in te vullen`
- **Opgewarmd sinds:** `TODO`
- **Primair domein dat hier nooit voor gebruikt wordt:** `brandpulse.nl`
- **Verzendplatform:** `TODO`

Zie principe 2 in
[`outbound-principes.md`](../../../domains/gtm/playbooks/outbound-principes.md).
Zonder een ingevuld verzenddomein wordt er geen outbound verstuurd.

## Afspraken boeken

- **Boekingsplatform:** Cal.com, ingebed op de marketingsite.
- **Event types:** twee, allebei via een omgevingsvariabele geconfigureerd en
  dus hier nog niet vast te leggen:

  | Waar | Bedoeld voor | Aanduiding |
  |---|---|---|
  | demopagina | merken en producenten | `TODO`, het Cal.com-eventtype achter de demo-embed |
  | partnerpagina | bureaus en partners | `TODO`, het Cal.com-eventtype achter de partner-embed |

- **Harde conversie:** een geboekte afspraak via Cal.com. Dit is de **enige**
  harde conversie. Alle andere events zijn tussenstappen.
- **⚠️ Een gemelde boeking is nog geen conversie.** De site meldt de boeking uit
  de browser, en die komt binnen als `verification = 'onbevestigd'`. Alleen
  `bevestigd` telt mee in een conversiecijfer. Natrekken is een handmatige stap
  tegen de Cal.com-agenda; query 4c in
  [`../../../infra/brandpulse-gtm.md`](../../../infra/brandpulse-gtm.md) geeft de
  werklijst. `TODO`, afspreken hoe vaak die lijst wordt afgewerkt, want zolang
  er niets natrekt is het conversiecijfer per definitie nul.
  Een automatische koppeling met Cal.com zou dit kunnen overnemen, maar die is
  bewust geen voorwaarde: vastleggen en natrekken zijn twee stappen.
- **Dragen de boekingen de taxonomie?** In onze eigen rapportage wel. De site
  luistert op `bookingSuccessful` van de Cal-embed en schrijft een
  `meeting_booked`-event weg met de first-touch-attributie uit de browser, plus
  `meta.detail.surface` (`demo` of `partners`). De keten breekt daar dus niet
  meer. **In Cal.com zelf niet:** Cal weet nog steeds niets van segment, bron of
  asset, dus een export uit Cal blijft onverdeeld. Dat is alleen een probleem
  zodra iemand op Cal-cijfers gaat sturen.

## Taxonomiewaarden die voor dit project gelden

Een selectie uit de canonieke lijst in
[`taxonomie.md`](../../../domains/gtm/playbooks/taxonomie.md). Geen eigen lijst.

- **segment:** `ebike`, `retail`, `food`, `bureau`. `TODO`, bevestigen welke
  hiervan actief bewerkt worden.
- **source:** `outbound`, `linkedin`, `google`, `gs1`, `direct`, `referral`.
  `TODO`, bevestigen welke daadwerkelijk in gebruik zijn bij livegang.
- **asset:** `magazine`, `demo`, `pricing`, `landing`. `TODO`, bevestigen of er
  op de site een prijspagina en een magazine bestaan; zo niet, dan blijven die
  waarden ongebruikt tot ze er zijn.

## Lagen

Optionele methodieklagen uit `domains/gtm/layers/`, per laag aan of uit voor dit
klantproject. Dit is de enige plek waar dat vastligt: een laag die hier niet
staat, staat uit. Uit is de veilige stand en de default.

| Laag | `version` | `enabled` | `intensity` |
|---|---|---|---|
| `commercial-doctrine` | 1 | `false` | `standaard` |

**Bij oplevering staat de laag uit.** `intensity` is de stand die geldt zodra
`enabled` op `true` gaat, en heeft zolang `enabled` op `false` staat geen effect.
De standen zelf staan beschreven in het manifest van de laag.

**Een gevulde laag opent de verzendpoort niet.** Zie principe 2 in
[`outbound-principes.md`](../../../domains/gtm/playbooks/outbound-principes.md):
zonder ingevuld verzenddomein vertrekt er geen outbound. Verzenddomein,
opwarmdatum en verzendplatform staan in dit bestand onder "Verzenden" alle drie
op `TODO`.

### Klantspecifieke aanscherpingen bij deze laag

De laag zelf is klantonafhankelijk en bevat daarom geen Qrius-specifieke eisen of
vindplaatsen. Die staan hier, op de klantas. Bij een tegenstrijdigheid wint de
specifiekere laag en wordt de tegenstrijdigheid gemeld, conform de
root-[`CLAUDE.md`](../../../CLAUDE.md), regels 55 tot 58.

| Onderwerp | De eis of vindplaats voor dit project |
|---|---|
| Deadlines | "Deadlines alleen noemen als ze aan de bron geverifieerd zijn", [`../profiel.md`](../profiel.md), sectie "Gevoeligheden". Strenger dan de grens in de laag, en gaat dus voor |
| Toon | Het volledige toonkader staat in [`../profiel.md`](../profiel.md), secties "Tone of voice" en "Woordkeuze". De laag verhoogt de toon nooit daarboven |
| Datavergaring ongelimiteerd | `docs/pricing-and-plans-blueprint.md` in de productrepository `wardbrandpulse/QRius`, kernregel dat klanten niet worden afgestraft op datavergaring: scans, consumentenprofielen en resolver-calls zijn ongelimiteerd op elk pakket |
| Kansspelwetgeving bij win-acties | `docs/activatie-systeem.md` in dezelfde repository, sectie "Win-actie & kansspelwetgeving" |
| Bestaande prijsstructuur | `apps/website/src/lib/plans.ts` en `apps/portal/src/lib/plans/config.ts` in dezelfde repository. De code is de bron, `docs/pricing-and-plans-blueprint.md` loopt erachteraan. Niet wijzigen vanuit dit domein |

## Openstaand

1. Accounts registreren in `gtm_accounts` zodra er gesprekken lopen. De tabel
   staat er (2026-07-30), maar de ingest vult hem niet: registreren is een
   menselijke handeling. Query 8 in
   [`../../../infra/brandpulse-gtm.md`](../../../infra/brandpulse-gtm.md) laat
   zien welke accounts in de events staan en nog niet geregistreerd zijn. Loop
   die af vóórdat je een doorlooptijd of conversie per beweging rapporteert.
2. De speelgoedregel aan de bron verifiëren, of hem laten staan als ongebruikt.
   Zie [`memory/learnings.md`](memory/learnings.md).
3. `seg-check.sh` tegen productie draaien voor de overige 22 routes, op
   `www.qrius.id`. De vier redirects plus de www-redirect zijn op 2026-07-30 op
   de edge bevestigd, de rest alleen lokaal.
4. Twee juridische vragen bij het cookiebeleid, door een jurist te beantwoorden
   en niet door ons. Zie de aantekening hieronder: valt campagne-attributie
   onder de toestemmingsvrijstelling, en is de partij die de attributie
   uitvoert een derde ten opzichte van Qrius B.V.?
5. Verzenddomein kiezen en opwarmen voordat er outbound vertrekt.
6. Cal.com-eventtypes vastleggen in dit bestand.
7. Waar de pijplijn wordt bijgehouden.
8. Als er een magazine komt: `<GtmView event="magazine_view" />` op die pagina
   zetten. De component staat klaar, de pagina bestaat nog niet.

### ⚠️ Hostconsistentie, en waarom dat de attributie raakt

`localStorage` is **per origin**. `qrius.id` en `www.qrius.id` zijn twee
verschillende origins met elk hun eigen opslag. Dat de attributie vandaag
gewoon werkt, komt volledig doordat Cloudflare al het niet-www-verkeer met een
308 naar www stuurt, vóór er JavaScript draait. Er is dus in de praktijk één
origin.

**Die redirect is daarmee dragend voor de attributie, niet alleen voor SEO.**
Verdwijnt hij, of wordt de richting omgedraaid, dan splitst de opslag en verliest
iedereen die de andere host raakt zijn first touch. Stil, zonder foutmelding.
Wie ooit aan de domeinconfiguratie werkt, moet dit weten.

**Wat op 2026-07-30 niet consistent was.** De code hanteert `SITE_URL =
'https://qrius.id'`, dus zonder www, terwijl www serveert. Daardoor wijzen de
canonical-tags, `og:url`, de sitemap, `robots.txt` en een hardgecodeerde
LinkedIn-sharelink allemaal naar de host die permanent doorstuurt. Dat werkt,
maar elke link uit die bron kost een extra hop, en een hop is een plek waar
parameters kunnen sneuvelen.

**Opgelost op 2026-07-30.** `SITE_URL` staat op `https://www.qrius.id`, en de
afhankelijkheid is vastgelegd in `docs/domains.md` in de productrepo, inclusief
de waarschuwing en de drie stappen die bij een domeinwijziging horen. Daar is nu
ook zichtbaar welke host canoniek is; eerder noemde dat document beide zonder
onderscheid.

In dezelfde opruiming meegenomen: **zeven pagina's** zetten geen eigen
`alternates` en erfden `canonical: '/'` uit de layout, waardoor ze zich canoniek
verklaarden aan de homepage. Op productie was dat zichtbaar op `/over-ons`. Alle
zeven hebben nu hun eigen pad, inclusief de dynamische kennisbank-artikelen. De
homepage houdt de geërfde `'/'`, want daar is die juist. Ook de hardgecodeerde
LinkedIn-sharelink gebruikt nu `SITE_URL`, zodat er een plek minder is die kan
gaan afwijken.

**Geen risico bij Cal.com.** De boekingsmodule is een iframe op `cal.com` met een
slug uit een omgevingsvariabele. Er wordt niet van onze origin weg genavigeerd,
dus de opslag splitst daar niet. Zou er ooit een terugkeer-URL worden ingesteld,
dan moet die op de canonieke host staan.

### Aantekening bij het cookiebeleid

`/cookies` artikel 1 rekent local storage uitdrukkelijk tot "cookies", artikel 2
kent twee categorieën (functioneel en anoniem analytisch) en het artikel over
tracking stelt dat Qrius geen technieken gebruikt die surfgedrag volgen of
gegevens naar derden sturen.

De first-touch-opslag past binnen die belofte: alleen campagnelabels, geen
identificatie, eigen domein, geen cross-site volgen.

**Op 2026-07-30 beschreven in het beleid**, als artikel 5 (Campagne-attributie),
met de bewaartermijn van 90 dagen erin. Daarmee is de eerdere lacune gedicht:
opslag die nergens werd genoemd. De artikelen 5 tot en met 10 zijn daarvoor
opgeschoven naar 6 tot en met 11, dus een verwijzing naar een artikelnummer van
vóór die datum wijst naar de verkeerde tekst.

Twee vragen zijn daarmee **niet** beantwoord, en die zijn juridisch en niet
technisch:

1. **Toestemming.** Er is geen consentbanner op de site, dus het beleid gaat
   ervan uit dat deze opslag onder de toestemmingsvrijstelling valt. Artikel 4
   claimt "een geringe impact op je privacy" voor analytics en attributie erft
   die claim nu. Of een label dat 90 dagen meegaat daaronder valt, kunnen wij
   niet vaststellen.
2. **Derden.** Het beleid zegt dat het label niet met derden wordt gedeeld. De
   rijen komen terecht in een Supabase-project onder de organisatie van het
   bureau dat de attributie uitvoert, niet onder Qrius B.V. Of dat bureau een
   verwerker of een derde is, hangt af van de afspraak tussen beide partijen.
   De verwerkerslijst in het beleid noemt Supabase, Vercel en Stripe en niet het
   bureau zelf.

Beide punten staan in de openstaande lijst hierboven. Een jurist beslist, niet
een agent en niet de code.

`TODO: door Ward in te vullen`

# Qrius, GTM-config

De enige plek in dit klantproject waar concrete bronnen, omgevingen en
verbindingen benoemd worden. Playbooks en instructies verwijzen hierheen en
noemen zelf nooit een tool. Zie de platformneutraliteitsregel in de
root-`CLAUDE.md`.

**Geen sleutels, tokens of wachtwoorden in dit bestand.**

- **Laatst bijgewerkt:** 2026-07-30
- **Status:** datalaag en tracking staan live op productie en er komen events
  binnen. Twee openstaande punten, zie "Openstaand".

---

## Databronnen

| Bron | Waarvoor | Aanduiding | Status |
|---|---|---|---|
| gebeurtenissen | de GTM-events (`gtm_events`) | Supabase-project `Brandpulse GTM`, ref `syyhnsghnozaqctaavbl` | bestaat |
| bezwaren | gecodeerde replies (`gtm_objections`) | zelfde project | bestaat |
| aanbevelingen | voorspelling en uitkomst (`agent_recommendations`, met `domain` naast `client`) | zelfde project | bestaat |
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

`TODO: door Ward in te vullen`, beide variabelen zetten in het Vercel-project
van de marketingsite voordat de tracking uit stap 3 live gaat.

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
| Ingest | `POST /api/gtm` op de marketingsite |
| Diagnose | `GET /api/gtm` geeft `{"ok":true,"configured":…}` |

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

## Openstaand

1. Eén host canoniek maken, `SITE_URL` gelijktrekken en de keuze vastleggen in
   `docs/domains.md`. Zie de waarschuwing over hostconsistentie hierboven.
   **Vóór de eerste outbound**, want elke link in een mail draagt die host.
2. `seg-check.sh` tegen productie draaien voor de overige 22 routes, op
   `www.qrius.id`. De vier redirects plus de www-redirect zijn op 2026-07-30 op
   de edge bevestigd, de rest alleen lokaal.
3. Beslissen of het cookiebeleid een regel krijgt over first-touch-attributie.
   Artikel 5 zegt nu dat Qrius geen tracking gebruikt die surfgedrag volgt; dat
   klopt nog steeds (geen identificatie, geen derden, niet cross-site), maar
   campagne-attributie wordt er niet genoemd. Zie de aantekening hieronder.
4. Verzenddomein kiezen en opwarmen voordat er outbound vertrekt.
5. Cal.com-eventtypes vastleggen in dit bestand.
6. Waar de pijplijn wordt bijgehouden.
7. Als er een magazine komt: `<GtmView event="magazine_view" />` op die pagina
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

`TODO: door Ward te beslissen`, één host canoniek maken. Aanbeveling: `SITE_URL`
naar `https://www.qrius.id`, want www is al wat serveert en wat Cloudflare
afdwingt; een constante wijzigen is minder riskant dan de serverende host
omzetten. Leg de keuze vast in `docs/domains.md` in de productrepo, dat document
noemt nu beide hosts zonder te zeggen welke canoniek is.

**Buiten GTM-scope, wel gevonden:** zes van de veertien pagina's zetten geen
eigen `alternates`, dus ze erven `canonical: '/'` uit de layout en verklaren
zichzelf canoniek aan de homepage. Op productie gecontroleerd voor `/over-ons`:
die pagina geeft `<link rel="canonical" href="https://qrius.id">`. Dat is een
SEO-kwestie, geen trackingkwestie, maar het hoort bij dezelfde opruiming.

**Geen risico bij Cal.com.** De boekingsmodule is een iframe op `cal.com` met een
slug uit een omgevingsvariabele. Er wordt niet van onze origin weg genavigeerd,
dus de opslag splitst daar niet. Zou er ooit een terugkeer-URL worden ingesteld,
dan moet die op de canonieke host staan.

### Aantekening bij het cookiebeleid

`/cookies` artikel 1 rekent local storage uitdrukkelijk tot "cookies", artikel 2
kent twee categorieën (functioneel en anoniem analytisch) en artikel 5 stelt dat
Qrius geen tracking gebruikt die surfgedrag volgt of gegevens naar derden
stuurt.

De first-touch-opslag past binnen die belofte: alleen campagnelabels, geen
identificatie, eigen domein, geen derden, geen cross-site volgen. Ze wordt
alleen nergens genoemd, en 90 dagen bewaartermijn is niet gedeclareerd. Er is op
de site geen consentbanner om op aan te haken, dus die is er ook niet ingebouwd.

Of het beleid een zin krijgt, en of er een consentvraag voor moet komen, is een
juridische afweging. `TODO: door Ward te beslissen.`

`TODO: door Ward in te vullen`

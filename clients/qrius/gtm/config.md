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
- **Hoofddomein:** `https://qrius.id`
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
| Sessiemarkering | `sessionStorage`, sleutel `qrius-gtm-session` |
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
| `site_visit` | eerste paginaweergave per **browsercontext**, zie waarschuwing | actief |
| `pricing_view` | op `/get-qrius` | actief |
| `meeting_booked` | Cal.com meldt een geslaagde boeking, op `/demo` en `/voor-partners` | actief |
| `magazine_view` | zou op de magazinepagina komen | **niet aangesloten, die pagina bestaat niet** |

**⚠️ `site_visit` is niet één per bezoekerssessie.** De bedoeling was één rij per
sessie, omdat de drempel in
[`significantie-drempels.md`](../../../domains/gtm/playbooks/significantie-drempels.md)
in sessies per bron per week rekent. De sessiemarkering staat in
`sessionStorage`, en dat is per **tabblad**, niet per bezoeker. Iemand die de
site in drie tabbladen opent, levert drie rijen op.

Vastgesteld op 2026-07-30 in de eerste productietest: één beschreven sessie gaf
vier `site_visit`-rijen, waarvan twee op hetzelfde pad met een seconde ertussen.
De first-touch-opslag in `localStorage` bleef in al die gevallen intact (zelfde
`first_seen_at`), dus opslag werkte; het is het per-tabblad-karakter van
`sessionStorage`, geen storing.

**Gevolg voor rapportage:** een rij is op dit moment een tabblad-sessie en geen
bezoekerssessie. Tel `site_visit` daarom als bovengrens, en toets de
kanaaldrempel van 30 per bron per week met dat voorbehoud, tot dit is opgelost.

`TODO: door Ward te beslissen`, of de sessiemarkering naar `localStorage` gaat
met een aflopend venster (bijvoorbeeld 30 minuten inactiviteit), wat rijen per
bezoeker in plaats van per tabblad oplevert. Dat verandert de betekenis van de
kolom, dus het is een meetkeuze en geen bugfix.

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

1. Beslissen of `site_visit` per bezoeker gaat tellen in plaats van per
   tabblad. Zie de waarschuwing hierboven; dit raakt de kanaaldrempel.
2. `seg-check.sh` tegen productie draaien voor de overige 22 routes. De vier
   redirects zijn op 2026-07-30 op de edge bevestigd, de rest alleen lokaal.
3. Beslissen of het cookiebeleid een regel krijgt over first-touch-attributie.
   Artikel 5 zegt nu dat Qrius geen tracking gebruikt die surfgedrag volgt; dat
   klopt nog steeds (geen identificatie, geen derden, niet cross-site), maar
   campagne-attributie wordt er niet genoemd. Zie de aantekening hieronder.
4. Verzenddomein kiezen en opwarmen voordat er outbound vertrekt.
5. Cal.com-eventtypes vastleggen in dit bestand.
6. Waar de pijplijn wordt bijgehouden.
7. Als er een magazine komt: `<GtmView event="magazine_view" />` op die pagina
   zetten. De component staat klaar, de pagina bestaat nog niet.

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

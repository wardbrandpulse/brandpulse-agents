# Brandpulse GTM, de datalaag

De eigen commerciële database van het bureau. Bevat data **over** klanten, geen
data **van** klanten.

Waarom dit een eigen project is en niet een schema in de Qrius-database, staat
in [`../memory/decisions.md`](../memory/decisions.md) (2026-07-29). Het
migratieproces staat in [`migratie-proces.md`](migratie-proces.md).

- **Supabase-project:** `Brandpulse GTM`
- **Ref:** `syyhnsghnozaqctaavbl`
- **Regio:** `eu-west-1`
- **Organisatie:** `ward.brandpulse`
- **URL:** `https://syyhnsghnozaqctaavbl.supabase.co`
- **Aangemaakt:** 2026-07-29
- **Kosten:** 10 dollar per maand

---

## Waarom `infra/`

Deze map hoort bij geen van beide assen. Hij bevat geen methodiek (dat is
`domains/`) en geen klantcontext (dat is `clients/`), maar infrastructuur die
het bureau zelf bezit en die over klanten en domeinen heen wordt gedeeld. Dat
is een derde categorie, en die kreeg pas een eigen plek toen hij daadwerkelijk
bestond.

De platformneutraliteitsregel uit de root-[`CLAUDE.md`](../CLAUDE.md), sectie 6,
blijft gelden voor playbooks en instructies: die noemen geen tools. Dit bestand
is juist de plek waar de concrete omgeving wél benoemd wordt.

## Tabellen

Alle drie in `public`. De volledige definitie staat in
`supabase/migrations/20260729141206_gtm_datalaag.sql`; dat bestand is de bron,
niet de database.

| Tabel | Bevat | Sleutelkolommen |
|---|---|---|
| `gtm_events` | commerciële gebeurtenissen | `occurred_at`, `client`, `segment`, `source`, `asset`, `event_type` |
| `gtm_objections` | gecodeerde replies | `occurred_at`, `client`, `segment`, `objection_code`, `verbatim` |
| `gtm_accounts` | accounteigenschappen die niet per aanraking verschillen | `client`, `account`, `motion` |
| `agent_recommendations` | voorspelling en uitkomst per advies | `client`, `domain`, `segment`, `predicted_impact`, `status`, `actual_impact`, `prediction_verdict`, `source_layer` |
| `agent_blocked_proposals` | doctrinevoorstellen die door een grens zijn tegengehouden | `client`, `domain`, `proposal`, `blocked_by`, `alternative` |

Alle gesloten waardelijsten worden afgedwongen met check-constraints die exact
overeenkomen met [`taxonomie.md`](../domains/gtm/playbooks/taxonomie.md). Wijkt
de database daarvan af, dan is de database fout.

### Twee kolommen die uitleg verdienen

**`occurred_at` versus `ingested_at`.** Het eerste is het moment bij de bron,
het tweede het moment waarop wij het binnenkregen. Een bron kan achterlopen, en
zonder beide kolommen is die vertraging onzichtbaar. Rapportages gaan altijd
over `occurred_at`; `ingested_at` is er om te zien of de aanlevering hapert.

**`domain` naast `client` in `agent_recommendations`.** De feedbackloop is qua
structuur domeinoverstijgend. De check-constraint staat voorlopig op alleen
`gtm`, zodat een tweede domein een bewuste migratie vergt in plaats van een
stille rij met een typefout. Dat is typefoutbescherming en geen principiële
domeinbeperking; zie `memory/decisions.md`.

**`agent_recommendations.segment` mag juist NOOIT NULL zijn**, en dat is geen
inconsistentie met de regel hieronder. Bij een advies is er geen meetgat: de schrijver
kent zijn eigen scope. Voor een advies dat over alle segmenten gaat is er de expliciete
waarde `domeinbreed`, vastgelegd in
[`taxonomie.md`](../domains/gtm/playbooks/taxonomie.md), sectie 6. **Die waarde hoort
nooit in `gtm_events` of `gtm_objections`:** een aanraking heeft een segment of hij is
ongelabeld, en zou `domeinbreed` daar belanden, dan staat hij in elke
segmentrapportage naast de echte segmenten alsof hij er een van is.

**`segment` en `source` in `gtm_events` mogen NULL zijn.** `NULL` betekent **ongelabeld**: we
weten het niet. Dat is iets anders dan `source = 'direct'`, wat betekent dat er
aantoonbaar geen bron was. Ongelabelde rijen worden apart geteld en nooit
verdeeld over de bekende waarden. `meta.labelled` geeft in één boolean aan of
een rij gelabeld binnenkwam, zodat je daar op kunt filteren zonder drie kolommen
op `is null` te toetsen.

**`gtm_accounts.motion` mag juist NOOIT NULL zijn**, en dat is geen inconsistentie
met het bovenstaande. Bij een account dat nog geen oplossing heeft, is `nieuw` de
waarheid en niet een gok; `NULL` zou daar onbekendheid suggereren over iets wat
we wel weten. De default is dus `nieuw`. Er is bewust **geen foreign key** vanuit
`gtm_events.account`: de ingest mag nooit falen op een ontbrekende registratie.
Een account dat wel in de events staat en niet hier, is daardoor een zichtbaar
gat in plaats van een stille `nieuw`-telling. Query 8 zoekt ze op.

## Is de historie nog vanaf nul te repliceren

De regel in [`migratie-proces.md`](migratie-proces.md), sectie 2, eist dat elke
migratie idempotent is, en sectie 1 dat de repo de bron is. In de Qrius-repo wordt dat
door CI afgedwongen; hier door niemand. **Een regel die je nooit toetst is decoratief**,
dus hij wordt getoetst en de uitkomst staat hier met een datum.

| Laatst geverifieerd | Tot en met versie | Uitkomst |
|---|---|---|
| **2026-08-04** | `20260804105505_doctrinelaag_meetkoppeling` (vijf migraties) | geslaagd |

**⚠️ Wat er precies geverifieerd is: "repliceerbaar op een Supabase-equivalente
PostgreSQL", niet op willekeurige PostgreSQL.** De rollen `anon` en `authenticated`
zijn omgevingsbootstrap en moeten bestaan voordat de eerste migratie draait. Op een
kale PostgreSQL faalt de reeks zonder die twee rollen, en dat is geen fout in de
migraties maar de grens van deze claim.

**Wat er precies is getoetst**, op een tijdelijke lokale PostgreSQL 16 die daarna is
verwijderd:

- **Afspelen vanaf nul.** Alle vijf migraties in volgorde op een verse database, met
  afbreken bij de eerste fout. Alle vijf geslaagd.
- **Idempotentie van de hele historie.** Alle vijf een tweede keer, op dezelfde
  database. Alle vijf geslaagd, en het schema bleef identiek.
- **Gelijkheid met productie.** Kolommen, constraints en indexen op de drie
  betrokken tabellen kwamen getalsmatig overeen (44, 33, 18), en over alle vijf de
  tabellen kwamen **alle 41 constraintnamen exact overeen**. Tellingen kunnen toevallig
  kloppen; namen niet.
- **Idempotentie op productie zelf.** De laatste migratie is daarnaast een tweede keer
  tegen dit project gedraaid, met `execute_sql` en niet als migratie, zodat de historie
  niet vervuild raakt. Schema en rijaantallen bleven identiek en de historie bleef op
  vijf regels.

**Eén afhankelijkheid die bij afspelen bovenkomt.** De migraties doen
`revoke ... from anon, authenticated`, en die rollen levert Supabase. Op een vanilla
PostgreSQL moeten ze eerst worden aangemaakt. Dat is bootstrap van de omgeving en geen
onderdeel van een migratie, maar wie dit naspeelt moet het weten.

**Wanneer opnieuw:** bij elke nieuwe migratie. Het kost lokaal een paar minuten en
niets aan geld, dus er is geen reden om het te laten wachten tot iemand het zich
afvraagt. De werkwijze staat in [`migratie-proces.md`](migratie-proces.md), sectie 4.

Zonder deze datum is de vraag over een jaar weer "hebben we dit ooit getoetst", en dan
is het antwoord opnieuw nee. Mét die datum is de vraag "hoe oud is onze garantie", en
die is te beantwoorden.

## Toegang

**RLS staat aan op alle drie de tabellen, zonder policies.** Dat is
deny-by-default: `anon` en `authenticated` kunnen niets, ook niet lezen. De
tabelrechten zijn daarnaast expliciet ingetrokken voor beide rollen, zodat het
niet van RLS alleen afhangt.

Alle toegang loopt via de service role:

- **schrijven:** de route handler van de marketingsite, bij ingest;
- **lezen:** analyse via het dashboard of via een agent met de service-role
  sleutel.

### Rate limiting ligt bij Cloudflare, niet hier

De ingest-endpoint is publiek en er zit **geen limiter in de applicatie**. Dat is
een keuze en geen omissie: een limiter in een serverless route handler houdt zijn
state per instantie, verliest hem bij een koude start en schaalt mee met het
aantal instanties, dus hij lijkt op bescherming zonder het te zijn.

De begrenzing staat als regel bij Cloudflare, dat al vóór de site staat. Zie
[`../memory/decisions.md`](../memory/decisions.md) (2026-07-30). **Bouw hem niet
alsnog in de route handler in.**

#### De aanbevolen regel

Cloudflare-dashboard, zone `qrius.id`, Security rules (oudere dashboards:
Security → WAF → tab Rate limiting rules) → Create rule → Rate limiting rule.

| Veld | Waarde |
|---|---|
| Naam | `gtm-ingest` |
| Als (expressie) | `http.request.uri.path eq "/api/gtm" and http.request.method eq "POST"` |
| Tellen op | IP-adres (Business en hoger: *IP with NAT support*) |
| Aantal verzoeken | 20 |
| Periode | 1 minuut |
| Actie | Block |
| Duur | 10 minuten, of de kortste die het plan aanbiedt |

Waarom 20 per minuut: een echte bezoeker levert één `site_visit` per sessie van
dertig minuten, plus af en toe een `pricing_view` of `magazine_view` per pagina.
Ook wie snel doorklikt komt niet boven een handvol per minuut. De drempel ligt
dus ver boven normaal gebruik en de regel raakt alleen wie stapelt.

Alleen POST, zodat `GET /api/gtm` open blijft. Dat is de diagnose-endpoint die
`seg-check.sh` en een handmatige controle gebruiken.

**Geen Managed Challenge op deze regel.** Een `fetch()` uit een pagina kan geen
challenge oplossen, dus het werkt als een blokkade maar leest in de logs als iets
anders. Block is hetzelfde effect en wel navolgbaar.

**Voorwaarde:** de regel geldt alleen voor verkeer dat Cloudflare proxyt. Staat
het DNS-record voor `www` op DNS only, dan doet de regel niets. Controleer dat
eerst, want dat is een stille faalvorm.

Wat een treffer kost: een geweigerd verzoek is een verloren meetrij, geen stukke
pagina. De client-fetch is afgeschermd, dus de bezoeker merkt er niets van. Dat
maakt een valse treffer goedkoop, maar ook onzichtbaar. Wie wil weten of de
regel ooit vuurt, kijkt in Security → Events en filtert op service `ratelimit`.

Wat de applicatie wél doet, en wat je daar niet mee moet verwarren: een
same-origin-filter op de POST, uitdrukkelijk een drempel en geen muur, en
`verification` op `meeting_booked`, wat de eigenlijke bescherming van het enige
getal is dat telt.

Er zijn geen eindgebruikers op dit project en er is geen inlog. Komt die er ooit
wel, dan zijn policies vanaf dat moment verplicht en is deny-by-default niet
langer voldoende.

De beveiligingscontrole meldt hierover **vijf** regels `rls_enabled_no_policy` op
niveau INFO, één per tabel. Dat is de bedoelde toestand, geen openstaand punt. Het
aantal loopt mee met het aantal tabellen; bij drie tabellen waren het er drie.

### Een schema is geen vertrouwensgrens

Dit is de les uit het besluit om apart te gaan, en hij geldt breder dan deze
keuze: **zolang de service-role sleutel in gebruik is, biedt een apart schema
geen bescherming.** RLS wordt door die rol genegeerd en Supabase geeft geen
sleutel per schema. Scheiding die echt telt, loopt via een apart project met
eigen sleutels. Wie ooit voorstelt om iets gevoeligs "netjes in een eigen
schema" te zetten, moet eerst deze zin weerleggen.

## Omgevingsvariabelen

Apart van die van Qrius. Geen enkele variabelenaam wordt gedeeld, juist om te
voorkomen dat een verkeerd geconfigureerde omgeving stilletjes naar de andere
database schrijft.

| Variabele | Waarde | Waar |
|---|---|---|
| `GTM_SUPABASE_URL` | `https://syyhnsghnozaqctaavbl.supabase.co` | server |
| `GTM_SUPABASE_SERVICE_ROLE_KEY` | uit het Supabase-dashboard, project `Brandpulse GTM` | **alleen** server |

Bewust **geen** `NEXT_PUBLIC_`-prefix: deze waarden horen nooit in een
browserbundel. De ingest loopt via een route handler, niet vanuit de client.

De sleutel staat niet in deze repo en komt er ook niet in. Zie
[`migratie-proces.md`](migratie-proces.md), sectie 5.

## Controleren of er data binnenkomt

```sql
-- 1. Komt er iets binnen? Laatste events, nieuwste eerst.
select occurred_at, event_type, segment, source, asset,
       meta->>'path' as pad, (meta->>'labelled')::boolean as gelabeld
from gtm_events
order by occurred_at desc
limit 20;

-- 2. Komt seg in de praktijk aan? Aandeel gelabeld per dag.
--    Blijft dit op 0 staan terwijl er wel campagneverkeer loopt, dan gaat de
--    parameter onderweg verloren en is dat de eerste bevinding, niet het kanaal.
select date_trunc('day', occurred_at)::date as dag,
       count(*) as bezoeken,
       count(*) filter (where segment is not null) as met_segment,
       round(100.0 * count(*) filter (where segment is not null) / count(*)) as pct_gelabeld
from gtm_events
where event_type = 'site_visit' and occurred_at > now() - interval '14 days'
group by 1 order by 1 desc;

-- 3. Verdeling over segment en bron. NULL is een eigen regel en wordt niet
--    verdeeld over de bekende waarden.
select coalesce(segment, '(ongelabeld)') as segment,
       coalesce(source, '(ongelabeld)') as source,
       count(*) as n
from gtm_events
where occurred_at > now() - interval '7 days'
group by 1, 2 order by 3 desc;

-- 4. Harde conversies. LET OP: alleen 'bevestigd' telt als conversie. Een rij op
--    'onbevestigd' is een melding uit een browser die nog niet is nagetrokken.
select occurred_at, verification, segment, source, asset,
       meta->'detail'->>'surface' as vlak,
       meta->>'first_seen_at' as eerste_aanraking
from gtm_events
where event_type = 'meeting_booked'
order by occurred_at desc;

-- 4b. Het conversiecijfer met de wachtrij ernaast. Rapporteer deze twee altijd
--     samen: een cijfer zonder de wachtrij leest als een compleet beeld.
select count(*) filter (where verification = 'bevestigd')   as bevestigd,
       count(*) filter (where verification = 'onbevestigd') as wacht_op_natrekken,
       count(*) filter (where verification = 'afgewezen')   as afgewezen
from gtm_events where event_type = 'meeting_booked';

-- 4c. Wat er nagetrokken moet worden. Werk deze lijst af tegen de agenda van de
--     boekingsdienst, en zet daarna verification plus verified_at.
select id, occurred_at, segment, source, account, contact,
       meta->'detail'->>'surface' as vlak
from gtm_events
where event_type = 'meeting_booked' and verification = 'onbevestigd'
order by occurred_at;

--     Bevestigen:  update gtm_events set verification = 'bevestigd',
--                    verified_at = now() where id = '...';
--     Afwijzen:    zelfde, met 'afgewezen'. Nooit verwijderen: het patroon van
--                  afgewezen meldingen is het signaal dat iemand aan het
--                  rommelen is.

-- 5. Waar wijkt de laatste bron af van de first touch? Toont of de
--    first-touch-regel daadwerkelijk iets doet.
select segment, source as first_touch_source,
       meta->'visit'->>'source' as bron_van_dit_bezoek, count(*)
from gtm_events
where meta->'visit'->>'source' is not null
  and meta->'visit'->>'source' is distinct from source
group by 1, 2, 3 order by 4 desc;

-- 6. Vertraging tussen bron en aanlevering.
select event_type, count(*) as n, max(ingested_at - occurred_at) as grootste_vertraging
from gtm_events group by 1 order by 2 desc;

-- 7. Verdeling over motion. "geen account" en "niet geregistreerd" blijven
--    gescheiden: het eerste is niet van toepassing, het tweede is een gat.
--    Normaliseer aan beide zijden, want de uniciteit van een account is
--    case-insensitief terwijl de kolom de oorspronkelijke schrijfwijze bewaart.
select case
         when e.account is null then '(geen account)'
         when a.motion is null then '(niet geregistreerd)'
         else a.motion
       end as motion,
       count(*) as events
from gtm_events e
left join gtm_accounts a
  on a.client = e.client
 and lower(btrim(a.account)) = lower(btrim(e.account))
group by 1 order by 2 desc;

-- 8. Accounts die in de events voorkomen maar niet geregistreerd staan. Elke rij
--    hier is een account waarvan de motion onbekend is, en dus een account dat
--    in een doorlooptijdgemiddelde niet meegenomen mag worden.
select e.client, e.account, count(*) as events, min(e.occurred_at) as eerste
from gtm_events e
left join gtm_accounts a
  on a.client = e.client
 and lower(btrim(a.account)) = lower(btrim(e.account))
where e.account is not null and a.id is null
group by 1, 2 order by 3 desc;
```

Let bij query 3 op de drempel uit
[`significantie-drempels.md`](../domains/gtm/playbooks/significantie-drempels.md):
onder 30 sessies per bron per week is er niets over een kanaal te zeggen.

Snelle controle of een omgeving überhaupt is geconfigureerd, zonder iets prijs
te geven: `GET /api/gtm` op de site geeft `{"ok":true,"configured":true|false}`.
Staat daar `false`, dan ontbreken de omgevingsvariabelen en worden events
aangenomen en weggegooid.

## Overleeft `seg` de deploy

[`seg-check.sh`](seg-check.sh) loopt elke route af en meldt per route of de
campagneparameters behouden blijven.

```
./infra/seg-check.sh https://qrius.id
```

Draai dit **na elke wijziging aan routing, middleware of redirects**. Een route
die de parameters stript, laat campagneverkeer ongelabeld binnenkomen, en dat is
onzichtbaar tot je je afvraagt waarom een kanaal niets oplevert.

### Vastgesteld op 2026-07-30

**`seg` overleeft de Vercel-edge.** Handmatig getest op productie door Ward. De
vier redirects vuurden af en `seg=ebike` bleef in alle vier gevallen intact:

| Redirect | `seg` |
|---|---|
| `/over-qrius` naar `/over-ons` | behouden |
| `/voor-merkhouders` naar `/toepassingen` | behouden |
| `/voor-bureaus` naar `/voor-partners` | behouden |
| `/demo/` naar `/demo` (trailing slash) | behouden |

Dit is een vaststelling, geen aanname: het is op de echte edge gemeten, niet
alleen tegen een lokale build. Bevestigd in de data, zie hieronder.

**Wat hiermee nog niet is vastgesteld.** De overige 22 routes zijn alleen tegen
een lokale productiebuild getoetst, niet op de edge. Dat is zwakker bewijs: het
toetst `next.config.js`, de trailing-slash-normalisatie en het ontbreken van
middleware, maar niet de edgelaag. Draai `seg-check.sh` tegen productie om dat
gat te dichten.

**Bevestigd in de data.** Vier `site_visit`-rijen uit die sessie, alle vier met
`segment = ebike`, `source = outbound`, `medium = email`, en alle vier met
hetzelfde `first_seen_at`. Dat laatste is het bewijs dat de first-touch-regel
werkt: drie van de vier bezoeken kwamen binnen zonder `utm_source` in de URL en
kregen alsnog `outbound` in de kolommen, uit de opslag.

Op een preview met Vercel Deployment Protection geeft elke route een 302 naar
`sso-api`. Zet er dan een geldige share-token bij:

```
SHARE=<token> ./infra/seg-check.sh https://<preview>.vercel.app
```

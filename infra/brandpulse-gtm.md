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
| `agent_recommendations` | voorspelling en uitkomst per advies | `client`, `domain`, `predicted_impact`, `status`, `actual_impact` |

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

**`segment` en `source` mogen NULL zijn.** `NULL` betekent **ongelabeld**: we
weten het niet. Dat is iets anders dan `source = 'direct'`, wat betekent dat er
aantoonbaar geen bron was. Ongelabelde rijen worden apart geteld en nooit
verdeeld over de bekende waarden. `meta.labelled` geeft in één boolean aan of
een rij gelabeld binnenkwam, zodat je daar op kunt filteren zonder drie kolommen
op `is null` te toetsen.

## Toegang

**RLS staat aan op alle drie de tabellen, zonder policies.** Dat is
deny-by-default: `anon` en `authenticated` kunnen niets, ook niet lezen. De
tabelrechten zijn daarnaast expliciet ingetrokken voor beide rollen, zodat het
niet van RLS alleen afhangt.

Alle toegang loopt via de service role:

- **schrijven:** de route handler van de marketingsite, bij ingest;
- **lezen:** analyse via het dashboard of via een agent met de service-role
  sleutel.

Er zijn geen eindgebruikers op dit project en er is geen inlog. Komt die er ooit
wel, dan zijn policies vanaf dat moment verplicht en is deny-by-default niet
langer voldoende.

De beveiligingscontrole meldt hierover drie regels `rls_enabled_no_policy` op
niveau INFO. Dat is de bedoelde toestand, geen openstaand punt.

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

-- 4. Harde conversies, met de first touch die ze meekregen.
select occurred_at, segment, source, asset,
       meta->'detail'->>'surface' as vlak,
       meta->>'first_seen_at' as eerste_aanraking
from gtm_events
where event_type = 'meeting_booked'
order by occurred_at desc;

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

Op een preview met Vercel Deployment Protection geeft elke route een 302 naar
`sso-api`. Zet er dan een geldige share-token bij:

```
SHARE=<token> ./infra/seg-check.sh https://<preview>.vercel.app
```

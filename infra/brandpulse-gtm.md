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
stille rij met een typefout.

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
-- laatste events, nieuwste eerst
select occurred_at, ingested_at, client, segment, source, asset, event_type
from gtm_events
order by occurred_at desc
limit 20;

-- volume per dag en per bron, laatste twee weken
select date_trunc('day', occurred_at) as dag, source, count(*)
from gtm_events
where occurred_at > now() - interval '14 days'
group by 1, 2
order by 1 desc, 3 desc;

-- vertraging tussen bron en aanlevering
select event_type,
       count(*) as n,
       max(ingested_at - occurred_at) as grootste_vertraging
from gtm_events
group by 1
order by 2 desc;
```

Let bij de tweede query op de drempel uit
[`significantie-drempels.md`](../domains/gtm/playbooks/significantie-drempels.md):
onder 30 sessies per bron per week is er niets over een kanaal te zeggen.

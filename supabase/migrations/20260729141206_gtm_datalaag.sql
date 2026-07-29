-- Brandpulse GTM, datalaag fase 1B
--
-- Drie tabellen: gtm_events, gtm_objections, agent_recommendations.
--
-- De check-constraints op segment, source, asset, event_type, objection_code,
-- status en domain verwijzen naar de canonieke waardelijsten in
-- domains/gtm/playbooks/taxonomie.md. Wijkt dit bestand daarvan af, dan is dit
-- bestand fout. Een waarde toevoegen gaat altijd eerst daar, dan hier, en pas
-- daarna in gebruik. Zie CLAUDE.md sectie 5.
--
-- RLS staat aan zonder policies: dat is deny-by-default. Alle toegang loopt via
-- de service role (ingest en analyse). Er zijn geen eindgebruikers op dit
-- project. Zie infra/brandpulse-gtm.md.
--
-- Idempotent: dit bestand mag opnieuw worden toegepast zonder schade.

-- ── gtm_events ────────────────────────────────────────────────────────────

create table if not exists public.gtm_events (
  id           uuid primary key default gen_random_uuid(),

  -- Wanneer het event plaatsvond bij de bron. Bewust niet created_at: een bron
  -- kan achterlopen, en dan is de aanleverdatum niet de gebeurtenisdatum.
  occurred_at  timestamptz not null,
  -- Wanneer wij het binnenkregen. Het verschil met occurred_at is de vertraging
  -- van de bron; zonder deze kolom is die vertraging niet te zien.
  ingested_at  timestamptz not null default now(),

  client       text not null,
  segment      text not null,
  source       text not null,
  asset        text,

  account      text,
  contact      text,

  event_type   text not null,
  value        numeric,
  meta         jsonb not null default '{}'::jsonb,

  constraint gtm_events_segment_check check (
    segment in ('ebike', 'retail', 'food', 'bureau')
  ),
  constraint gtm_events_source_check check (
    source in ('outbound', 'linkedin', 'google', 'gs1', 'direct', 'referral')
  ),
  constraint gtm_events_asset_check check (
    asset is null or asset in ('magazine', 'demo', 'pricing', 'landing')
  ),
  constraint gtm_events_event_type_check check (
    event_type in (
      'email_sent', 'email_open', 'email_click', 'email_reply', 'email_bounce',
      'site_visit', 'magazine_view', 'pricing_view',
      'demo_request', 'meeting_booked', 'stage_change', 'deal_lost'
    )
  ),
  constraint gtm_events_client_niet_leeg check (length(btrim(client)) > 0)
);

comment on table  public.gtm_events is
  'Commerciele gebeurtenissen van Brandpulse, over klanten heen. Geen platformdata van klanten.';
comment on column public.gtm_events.occurred_at is
  'Tijdstip bij de bron. Niet de aanleverdatum, zie ingested_at.';
comment on column public.gtm_events.client is
  'Klantproject waar dit event bij hoort, komt overeen met de mapnaam onder clients/.';

create index if not exists gtm_events_occurred_at_idx on public.gtm_events (occurred_at desc);
create index if not exists gtm_events_client_idx      on public.gtm_events (client);
create index if not exists gtm_events_segment_idx     on public.gtm_events (segment);
create index if not exists gtm_events_source_idx      on public.gtm_events (source);
create index if not exists gtm_events_account_idx     on public.gtm_events (account) where account is not null;

-- Vrijwel elke vraag is "voor deze klant, in deze periode". Zonder deze index
-- valt zo'n query terug op de losse client-index plus een sort.
create index if not exists gtm_events_client_occurred_at_idx
  on public.gtm_events (client, occurred_at desc);

alter table public.gtm_events enable row level security;
revoke all on table public.gtm_events from anon, authenticated;

-- ── gtm_objections ────────────────────────────────────────────────────────

create table if not exists public.gtm_objections (
  id              uuid primary key default gen_random_uuid(),

  occurred_at     timestamptz not null,
  ingested_at     timestamptz not null default now(),

  client          text not null,
  segment         text not null,

  account         text,
  contact         text,

  objection_code  text not null,
  -- De letterlijke zinsnede. De code poetst de nuance weg en die is later nodig
  -- bij het herschrijven van de propositie.
  verbatim        text,

  constraint gtm_objections_segment_check check (
    segment in ('ebike', 'retail', 'food', 'bureau')
  ),
  constraint gtm_objections_code_check check (
    objection_code in (
      'te-vroeg', 'doet-leverancier-al', 'geen-budget',
      'wat-is-dpp', 'intern-bouwen', 'geen-eigenaar', 'anders'
    )
  ),
  constraint gtm_objections_client_niet_leeg check (length(btrim(client)) > 0)
);

comment on table public.gtm_objections is
  'Gecodeerde replies. Elke reply krijgt een code, ook een positieve.';
comment on column public.gtm_objections.verbatim is
  'Letterlijke zinsnede van de ontvanger. Persoonsgegeven, niet exporteren naar de sector- of playbooklaag.';

create index if not exists gtm_objections_occurred_at_idx on public.gtm_objections (occurred_at desc);
create index if not exists gtm_objections_client_idx      on public.gtm_objections (client);
create index if not exists gtm_objections_segment_idx     on public.gtm_objections (segment);
create index if not exists gtm_objections_code_idx        on public.gtm_objections (objection_code);
create index if not exists gtm_objections_account_idx     on public.gtm_objections (account) where account is not null;

alter table public.gtm_objections enable row level security;
revoke all on table public.gtm_objections from anon, authenticated;

-- ── agent_recommendations ─────────────────────────────────────────────────
--
-- De feedbackloop. Zonder deze tabel wordt het systeem alleen ouder, niet beter.
-- Geen gtm_-prefix: de loop is qua structuur domeinoverstijgend, vandaar de
-- domain-kolom naast client. Zie memory/decisions.md (2026-07-29).

create table if not exists public.agent_recommendations (
  id                uuid primary key default gen_random_uuid(),
  created_at        timestamptz not null default now(),

  client            text not null,
  domain            text not null,

  -- Waar het advies over ging, in een paar woorden.
  subject           text not null,
  recommendation    text not null,
  -- Verplicht. Zonder vastgelegde voorspelling is er achteraf geen leermoment.
  predicted_impact  text not null,

  status            text not null default 'voorgesteld',

  actual_impact     text,
  evaluated_at      timestamptz,

  constraint agent_recommendations_status_check check (
    status in ('voorgesteld', 'geaccepteerd', 'afgewezen', 'uitgevoerd')
  ),
  -- Een domein toevoegen is een bewuste stap, dus een migratie. Zie CLAUDE.md
  -- sectie 5: de datalaag loopt achter het bronbestand aan, nooit andersom.
  constraint agent_recommendations_domain_check check (
    domain in ('gtm')
  ),
  -- Een uitkomst zonder moment van beoordelen is niet navolgbaar.
  constraint agent_recommendations_uitkomst_check check (
    actual_impact is null or evaluated_at is not null
  ),
  constraint agent_recommendations_client_niet_leeg check (length(btrim(client)) > 0)
);

comment on table public.agent_recommendations is
  'Voorspelling en uitkomst per advies, over domeinen heen. De helft van de feedbackloop.';
comment on column public.agent_recommendations.predicted_impact is
  'Wat er meetbaar verandert, met richting, grootteorde en termijn. Verplicht.';

create index if not exists agent_recommendations_client_idx     on public.agent_recommendations (client);
create index if not exists agent_recommendations_domain_idx     on public.agent_recommendations (domain);
create index if not exists agent_recommendations_status_idx     on public.agent_recommendations (status);
create index if not exists agent_recommendations_created_at_idx on public.agent_recommendations (created_at desc);

-- Openstaande adviezen ophalen is de dagelijkse vraag aan deze tabel.
create index if not exists agent_recommendations_open_idx
  on public.agent_recommendations (client, domain, created_at desc)
  where status in ('voorgesteld', 'geaccepteerd');

alter table public.agent_recommendations enable row level security;
revoke all on table public.agent_recommendations from anon, authenticated;

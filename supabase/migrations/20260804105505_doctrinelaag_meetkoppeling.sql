-- Meetkoppeling voor de commerciele doctrinelaag.
--
-- Zonder deze kolommen is de laag niet te evalueren en dus niet eerlijk te
-- verwijderen. De onderbouwing staat in
-- domains/gtm/layers/commercial-doctrine/80-meetkoppeling.md.
--
-- Gemeten wordt de VOORSPELKWALITEIT en niet de commerciele uitkomst. Bij een
-- eindige doelgroep en een verbod op conversiepercentages onder twintig
-- waarnemingen is de opbrengstvraag jaren onbeantwoordbaar. Zie
-- memory/decisions.md (2026-08-04). De drempels in
-- domains/gtm/playbooks/significantie-drempels.md blijven ongewijzigd; dit is een
-- maatstaf ernaast en geen versoepeling.
--
-- De waarde 'domeinbreed' komt uit domains/gtm/playbooks/taxonomie.md, sectie 6,
-- en geldt UITSLUITEND in de aanbevelingentabellen. Nooit in gtm_events of
-- gtm_objections: een aanraking heeft een segment of hij is ongelabeld.
--
-- Idempotent: dit bestand mag opnieuw worden toegepast zonder schade.

-- ── agent_recommendations: herkomst, scope en verdict ──────────────────────

alter table public.agent_recommendations
  add column if not exists source_layer         text,
  add column if not exists source_layer_version integer,
  add column if not exists layer_intensity      text,
  add column if not exists segment              text,
  add column if not exists prediction_verdict   text;

comment on column public.agent_recommendations.source_layer is
  'Welke methodieklaag dit advies voortbracht. NULL = geen laag, dus een gewoon agentadvies.';
comment on column public.agent_recommendations.source_layer_version is
  'Versie van die laag. Een advies van versie 1 is niet hetzelfde advies als van versie 2.';
comment on column public.agent_recommendations.layer_intensity is
  'Stand van de laag: licht, standaard of scherp. Niet off, want op die stand produceert de laag niets.';
comment on column public.agent_recommendations.segment is
  'Taxonomiewaarde of domeinbreed. Nooit NULL: bij een advies is er geen meetgat, want de schrijver kent zijn eigen scope. domeinbreed hoort NOOIT in gtm_events.';
comment on column public.agent_recommendations.prediction_verdict is
  'Hield de voorspelde richting stand: gehouden, niet-gehouden of niet-vast-te-stellen. Alleen de eerste twee tellen mee in de n. Een oplopend aandeel niet-vast-te-stellen is zelf een bevinding: dan voorspelt de laag te vaag om weerlegbaar te zijn.';

-- segment wordt not null met een expliciete waarde voor domeinbreed. Dezelfde NULL
-- met twee betekenissen over twee tabellen is de ambiguiteit die later bijt, en
-- documenteren lost dat alleen op voor wie de documentatie leest.
--
-- Defensief in deze volgorde: kolom erbij, bestaande rijen vullen, dan not null.
-- Bij het toepassen stonden er nul rijen en schreef geen enkele applicatie naar
-- deze tabel; de backfill staat er voor het geval dat later anders is.
update public.agent_recommendations set segment = 'domeinbreed' where segment is null;

do $$
begin
  if exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'agent_recommendations'
      and column_name = 'segment' and is_nullable = 'YES'
  ) then
    alter table public.agent_recommendations alter column segment set not null;
  end if;
end $$;

do $$
begin
  -- Typefoutbescherming, geen principiele beperking. Zelfde bedoeling als het
  -- domain-constraint: een laagnaam met een typefout levert een onvindbare rij op
  -- in plaats van een foute.
  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_source_layer_check') then
    alter table public.agent_recommendations add constraint agent_recommendations_source_layer_check
      check (source_layer is null or source_layer in ('commercial-doctrine'));
  end if;

  -- Herkomst is alles of niets. Een laagnaam zonder versie is niet navolgbaar, en
  -- een versie zonder laagnaam hoort bij niets.
  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_herkomst_compleet') then
    alter table public.agent_recommendations add constraint agent_recommendations_herkomst_compleet
      check (
        (source_layer is null     and source_layer_version is null     and layer_intensity is null) or
        (source_layer is not null and source_layer_version is not null and layer_intensity is not null)
      );
  end if;

  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_intensity_check') then
    alter table public.agent_recommendations add constraint agent_recommendations_intensity_check
      check (layer_intensity is null or layer_intensity in ('licht', 'standaard', 'scherp'));
  end if;

  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_versie_positief') then
    alter table public.agent_recommendations add constraint agent_recommendations_versie_positief
      check (source_layer_version is null or source_layer_version > 0);
  end if;

  -- Vier taxonomiewaarden plus domeinbreed. Die laatste bestaat ALLEEN hier.
  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_segment_check') then
    alter table public.agent_recommendations add constraint agent_recommendations_segment_check
      check (segment in ('ebike', 'retail', 'food', 'bureau', 'domeinbreed'));
  end if;

  -- Beoordeeld betekent: er is een verdict. Zonder deze constraint kan een advies
  -- als geevalueerd gelden zonder dat er iets telbaars uit komt, en dan is de
  -- voorspelkwaliteit niet te berekenen.
  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_verdict_bij_evaluatie') then
    alter table public.agent_recommendations add constraint agent_recommendations_verdict_bij_evaluatie
      check (
        (evaluated_at is null     and prediction_verdict is null) or
        (evaluated_at is not null and prediction_verdict is not null)
      );
  end if;

  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_verdict_check') then
    alter table public.agent_recommendations add constraint agent_recommendations_verdict_check
      check (prediction_verdict is null
             or prediction_verdict in ('gehouden', 'niet-gehouden', 'niet-vast-te-stellen'));
  end if;
end $$;

-- De voorspelkwaliteit optellen is de dagelijkse vraag aan deze kolommen.
create index if not exists agent_recommendations_laag_verdict_idx
  on public.agent_recommendations (source_layer, prediction_verdict)
  where source_layer is not null;

-- ── agent_blocked_proposals: eigen tabel, want geen advies ─────────────────
--
-- Een geblokkeerd doctrinevoorstel heeft geen voorspelling en geen uitkomst, dus
-- het komt de feedbackloop nooit in. In agent_recommendations zouden
-- predicted_impact, status, actual_impact en evaluated_at alle vier niet van
-- toepassing zijn, zou de tabel haar eigen herzieningsgrond oproepen (voornamelijk
-- lege kolommen, zie memory/decisions.md 2026-07-29), en zou elke telling een
-- filter nodig hebben dat vergeten kan worden. De bestaande partiele index op
-- openstaande adviezen zou blokkades meenemen zonder dat iemand het merkt.
--
-- Geen gtm_-prefix en wel een domain-kolom, om dezelfde reden als bij
-- agent_recommendations: elke laag in elk domein kan een voorstel blokkeren.

create table if not exists public.agent_blocked_proposals (
  id                   uuid primary key default gen_random_uuid(),
  created_at           timestamptz not null default now(),

  client               text not null,
  domain               text not null,

  -- Een blokkade komt per definitie uit een laag, dus hier niet nullable.
  source_layer         text not null,
  source_layer_version integer not null,
  layer_intensity      text not null,

  segment              text not null,

  -- Wat de doctrine voorstelde.
  proposal             text not null,
  -- Welke grens of uitsluiting het tegenhield, als grens-9 of uitsluiting-4.
  -- Bewust GEEN gesloten lijst: die lijst staat binnen de laag en de laag is
  -- verwijderbaar. Een check-constraint erop zou een constraint achterlaten
  -- waarvan het bronbestand verdwenen is, en dat is een nieuwe manier om de
  -- verwijderbelofte te breken. Vrij veld met formatregel, zoals utm_campaign.
  blocked_by           text not null,
  -- Wat er in plaats daarvan is gedaan. Verplicht, ook als het antwoord "niets"
  -- is: anders is niet te zien of er een alternatief was of dat niemand het heeft
  -- opgeschreven.
  alternative          text not null,

  constraint agent_blocked_proposals_domain_check check (domain in ('gtm')),
  constraint agent_blocked_proposals_layer_check check (source_layer in ('commercial-doctrine')),
  constraint agent_blocked_proposals_intensity_check check (
    layer_intensity in ('licht', 'standaard', 'scherp')
  ),
  constraint agent_blocked_proposals_versie_positief check (source_layer_version > 0),
  constraint agent_blocked_proposals_segment_check check (
    segment in ('ebike', 'retail', 'food', 'bureau', 'domeinbreed')
  ),
  constraint agent_blocked_proposals_client_niet_leeg     check (length(btrim(client)) > 0),
  constraint agent_blocked_proposals_blocked_by_niet_leeg check (length(btrim(blocked_by)) > 0),
  constraint agent_blocked_proposals_proposal_niet_leeg   check (length(btrim(proposal)) > 0)
);

comment on table public.agent_blocked_proposals is
  'Doctrinevoorstellen die door een grens of uitsluiting zijn tegengehouden. Geen advies: geen voorspelling, geen uitkomst. Het aantal blokkades is een maat voor de aansluiting van de laag.';
comment on column public.agent_blocked_proposals.blocked_by is
  'Welke grens of uitsluiting het tegenhield, als grens-9 of uitsluiting-4. Vrij veld, want de lijst staat binnen een verwijderbare laag.';
comment on column public.agent_blocked_proposals.alternative is
  'Wat er in plaats daarvan is gedaan. Verplicht, ook als het antwoord "niets" is.';

create index if not exists agent_blocked_proposals_client_idx
  on public.agent_blocked_proposals (client, created_at desc);
create index if not exists agent_blocked_proposals_blocked_by_idx
  on public.agent_blocked_proposals (blocked_by);

alter table public.agent_blocked_proposals enable row level security;
revoke all on table public.agent_blocked_proposals from anon, authenticated;

-- ── gtm_events: laagcontext op de aanraking ────────────────────────────────
--
-- downsell_form staat hier bewust NIET bij: welke verlagingsvormen zijn toegestaan
-- is een open besluit in clients/qrius/gtm/aanbodcatalogus.md. Een gesloten lijst
-- nu vastleggen zet waarden in gebruik voordat het menselijke besluit er is, en dat
-- verbiedt CLAUDE.md sectie 5. Toevoegen als aparte migratie zodra dat besluit er
-- is.

alter table public.gtm_events
  add column if not exists layer_version     integer,
  add column if not exists layer_intensity   text,
  add column if not exists sequence_position integer,
  add column if not exists offer_variant     text;

comment on column public.gtm_events.layer_version is
  'Versie van de methodieklaag die deze aanraking voortbracht. NULL = geen laag.';
comment on column public.gtm_events.layer_intensity is
  'Stand van die laag: licht, standaard of scherp.';
comment on column public.gtm_events.sequence_position is
  'Positie in de contactreeks, vanaf 1. Bewust geen bovengrens: de intensiteitsschijf bepaalt het maximum en een wijziging daarvan hoort geen migratie te vragen.';
comment on column public.gtm_events.offer_variant is
  'Vrij veld, kleine letters en koppeltekens. Aanbodvarianten zijn klantspecifiek en kunnen dus geen canonieke domeinlijst zijn.';

do $$
begin
  if not exists (select 1 from pg_constraint where conname = 'gtm_events_layer_intensity_check') then
    alter table public.gtm_events add constraint gtm_events_layer_intensity_check
      check (layer_intensity is null or layer_intensity in ('licht', 'standaard', 'scherp'));
  end if;

  if not exists (select 1 from pg_constraint where conname = 'gtm_events_sequence_position_check') then
    alter table public.gtm_events add constraint gtm_events_sequence_position_check
      check (sequence_position is null or sequence_position >= 1);
  end if;

  if not exists (select 1 from pg_constraint where conname = 'gtm_events_layer_version_check') then
    alter table public.gtm_events add constraint gtm_events_layer_version_check
      check (layer_version is null or layer_version > 0);
  end if;
end $$;

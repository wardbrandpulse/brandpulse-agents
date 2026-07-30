-- Een door de browser gemelde boeking is geen bevestigde conversie.
--
-- Waarden uit domains/gtm/playbooks/taxonomie.md. De harde conversie wordt
-- gemeld door de browser van de bezoeker, en dat is een publieke, aanpasbare
-- omgeving: iedereen die de ingest-URL kent kan een boeking melden die niet
-- bestaat. Bij een kleine n zijn twintig verzonnen meldingen genoeg om een
-- verkeerde beslissing op te bouwen, en achteraf zijn ze niet van echte te
-- onderscheiden.
--
-- De verificatie zelf zit bewust NIET in de ingest. Zou de ingest verifieren,
-- dan hangt het vastleggen van een boeking af van de beschikbaarheid van de
-- boekingsdienst en verlies je de melding als die dienst even niet antwoordt.
-- Vastleggen en natrekken zijn twee stappen.
--
-- Idempotent.

alter table public.gtm_events
  add column if not exists verification text,
  add column if not exists verified_at  timestamptz;

comment on column public.gtm_events.verification is
  'Alleen voor meeting_booked: onbevestigd, bevestigd of afgewezen. Leeg bij elk ander event_type.';
comment on column public.gtm_events.verified_at is
  'Wanneer er is nagetrokken. Leeg zolang de status onbevestigd is.';

do $$
begin
  -- Gesloten waardelijst.
  if not exists (
    select 1 from pg_constraint where conname = 'gtm_events_verification_check'
  ) then
    alter table public.gtm_events add constraint gtm_events_verification_check
      check (verification is null
             or verification in ('onbevestigd', 'bevestigd', 'afgewezen'));
  end if;

  -- Het mechanisme dat vergeten onmogelijk maakt: een meeting_booked MOET een
  -- status hebben, en elk ander event_type mag er geen hebben. Zonder deze
  -- constraint zou een rij zonder status stilzwijgend als conversie kunnen
  -- worden meegeteld, en dat is precies het gat dat we dichten.
  if not exists (
    select 1 from pg_constraint where conname = 'gtm_events_verification_alleen_bij_boeking'
  ) then
    alter table public.gtm_events add constraint gtm_events_verification_alleen_bij_boeking
      check (
        (event_type =  'meeting_booked' and verification is not null) or
        (event_type <> 'meeting_booked' and verification is null)
      );
  end if;

  -- Een uitkomst zonder moment van natrekken is niet navolgbaar, en een
  -- onbevestigde melding kan geen verificatiemoment hebben.
  if not exists (
    select 1 from pg_constraint where conname = 'gtm_events_verified_at_check'
  ) then
    alter table public.gtm_events add constraint gtm_events_verified_at_check
      check (
        (verification is distinct from 'onbevestigd' and verification is not null
           and verified_at is not null)
        or (verification = 'onbevestigd' and verified_at is null)
        or (verification is null and verified_at is null)
      );
  end if;
end $$;

-- Onbevestigde boekingen opzoeken is de dagelijkse vraag aan deze kolom.
create index if not exists gtm_events_onbevestigde_boekingen_idx
  on public.gtm_events (occurred_at desc)
  where event_type = 'meeting_booked' and verification = 'onbevestigd';

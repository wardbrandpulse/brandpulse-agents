-- Ongelabeld moet representeerbaar zijn.
--
-- In 20260729141206 stonden segment en source op NOT NULL. Daarmee kan de
-- datalaag niet vastleggen wat de taxonomie wel kent: een aanraking zonder
-- labels. Bij het bouwen van de tracking kwam dat naar boven, want een bezoeker
-- die opslag blokkeert levert precies zo'n rij op, en die insert zou zijn
-- geweigerd.
--
-- De keuze is NULL en niet een extra waarde in de lijst. "onbekend" is
-- uitdrukkelijk geen taxonomiewaarde: zodra het er een wordt, verschijnt het in
-- rapportages naast de echte waarden alsof het er een van is. NULL valt
-- vanzelf buiten elke groepering op waarde en dwingt af dat het apart geteld
-- wordt.
--
-- NULL betekent nadrukkelijk niet hetzelfde als source = 'direct'. Direct wil
-- zeggen dat er aantoonbaar geen bron was; NULL wil zeggen dat wij het niet
-- weten. Die twee door elkaar halen laat een meetprobleem eruitzien als een
-- groeiend eigen merk.
--
-- gtm_objections.segment gaat om dezelfde reden mee: liever een lege kolom dan
-- een gegokt segment bij een reply waarvan de herkomst niet vaststaat.
--
-- Idempotent: drop not null op een al nullable kolom is een no-op.

alter table public.gtm_events    alter column segment drop not null;
alter table public.gtm_events    alter column source  drop not null;
alter table public.gtm_objections alter column segment drop not null;

comment on column public.gtm_events.segment is
  'Taxonomiewaarde of NULL. NULL = ongelabeld, apart tellen, nooit verdelen over de bekende waarden.';
comment on column public.gtm_events.source is
  'Taxonomiewaarde of NULL. NULL = ongelabeld. Niet verwarren met ''direct'', dat betekent aantoonbaar geen bron.';
comment on column public.gtm_objections.segment is
  'Taxonomiewaarde of NULL. NULL = ongelabeld; liever leeg dan een gegokt segment.';

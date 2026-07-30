-- Motion op accountniveau.
--
-- Waarden uit domains/gtm/playbooks/taxonomie.md, sectie 6. Motion is een
-- eigenschap van de partij en niet van de aanraking, dus het staat een keer per
-- account vast in plaats van per event. Anders wordt het bij elke rij opnieuw
-- geraden en drijven de rijen van hetzelfde account uit elkaar.
--
-- nieuw is de default en NULL bestaat hier niet. Dat wijkt af van segment en
-- source, waar NULL ongelabeld betekent: bij een account dat nog niets heeft is
-- nieuw geen gok maar de waarheid, en NULL zou onbekendheid suggereren over iets
-- wat we wel weten.
--
-- Bewust GEEN foreign key vanuit gtm_events.account: de ingest mag nooit falen
-- op een ontbrekende registratie. Een account dat in de events voorkomt maar
-- hier niet staat, is een zichtbaar gat en geen stille nieuw-telling.
--
-- Idempotent.

create table if not exists public.gtm_accounts (
  id          uuid primary key default gen_random_uuid(),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),

  client      text not null,
  account     text not null,

  motion      text not null default 'nieuw',

  -- Waar de motion op berust, in een paar woorden. Bij vervanging: welke
  -- oplossing er nu live staat. Zonder dit wordt de waarde over een half jaar
  -- niet meer navolgbaar.
  motion_bron text,

  constraint gtm_accounts_motion_check check (motion in ('nieuw', 'vervanging')),
  constraint gtm_accounts_client_niet_leeg  check (length(btrim(client)) > 0),
  constraint gtm_accounts_account_niet_leeg check (length(btrim(account)) > 0)
);

comment on table public.gtm_accounts is
  'Accounteigenschappen die niet per aanraking verschillen. Koppelen op (client, account).';
comment on column public.gtm_accounts.motion is
  'nieuw of vervanging. Nooit NULL: nieuw is de waarheid bij een account zonder oplossing, niet een gok.';
comment on column public.gtm_accounts.motion_bron is
  'Waarop de motion berust. Bij vervanging: welke oplossing er live staat.';

-- Een account bestaat een keer per klantproject. Case-insensitief en zonder
-- randspaties, zodat "Testmerk BV" en "testmerk bv" niet twee rijen worden. De
-- kolom bewaart wel de oorspronkelijke schrijfwijze; joins moeten daarom aan
-- beide zijden normaliseren. Deze index houdt de join vanuit gtm_events snel.
create unique index if not exists gtm_accounts_client_account_key
  on public.gtm_accounts (client, lower(btrim(account)));

create index if not exists gtm_accounts_motion_idx on public.gtm_accounts (motion);
create index if not exists gtm_accounts_client_idx on public.gtm_accounts (client);

-- updated_at bijhouden, zodat een gewijzigde motion navolgbaar is. Motion kan
-- veranderen: een prospect zonder oplossing van vandaag kan er volgend jaar een
-- van een concurrent hebben.
create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists gtm_accounts_updated_at on public.gtm_accounts;
create trigger gtm_accounts_updated_at
  before update on public.gtm_accounts
  for each row execute function public.set_updated_at();

alter table public.gtm_accounts enable row level security;
revoke all on table public.gtm_accounts from anon, authenticated;

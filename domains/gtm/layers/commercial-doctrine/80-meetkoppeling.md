# Meetkoppeling

> **Bewijslast: n=0.** Deze laag is externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).
>
> **Status: gebouwd en toegepast op 2026-08-04**, na akkoord van Ward. Het
> migratiebestand is
> [`20260804105505_doctrinelaag_meetkoppeling.sql`](../../../../supabase/migrations/20260804105505_doctrinelaag_meetkoppeling.sql).
> Dat bestand is de bron, niet de database.
>
> **De SQL in sectie 6 blijft hier staan als toelichting**, met de afweging per
> kolom erbij. Wijkt hij af van het migratiebestand, dan is dit bestand fout.

Zonder meetkoppeling is de laag niet te evalueren en dus niet eerlijk te
verwijderen. Dit bestand beschrijft wat er vastgelegd moet worden en waarom.

Actief op elke stand waarop de laag aan staat, net als grenzen en uitsluitingen.
Niet in de intensiteitsschijf: het is geen doctrine die een besluit beïnvloedt maar
de registratie eromheen.

---

## 1. Wat er gemeten wordt, en wat uitdrukkelijk niet

**Gemeten wordt de voorspelkwaliteit, niet de commerciële uitkomst.** Per advies
dat uit deze laag komt: hield de voorspelde richting stand.

Dat is een besluit van 2026-08-04 in
[`memory/decisions.md`](../../../../memory/decisions.md), en het is een
**zwakkere claim dan hij lijkt.** Hij zegt niets over opbrengst. De vraag "verhoogt
deze laag de conversie" blijft bij het huidige volume onbeantwoordbaar: bij een
eindige doelgroep en een verbod op conversiepercentages onder twintig waarnemingen
duurt dat jaren. Doen alsof van niet zou de bewijslastregel schenden.

De drempels in
[`significantie-drempels.md`](../../playbooks/significantie-drempels.md) blijven
ongewijzigd. Voorspelkwaliteit is een maatstaf **ernaast**, geen versoepeling.

### Het aandeel `niet-vast-te-stellen` is zelf een bevinding

Dit is niet een restcategorie die je wegstreept. **Een hoog aandeel
`niet-vast-te-stellen` betekent dat de laag voorspellingen produceert die niet te
weerleggen zijn, en dat is een gebrek in de laag.**

Het is ook de faalvorm die hier het meest waarschijnlijk optreedt. Niet dat de
doctrine ernaast zit, maar dat ze te vaag voorspelt om ernaast te kunnen zitten. Zou
die verhouding niet worden bijgehouden, dan kan de laag op onweerlegbaarheid
overleven, en dat is precies wat deze maatstaf moet uitsluiten.

Daarom hoort bij elke rapportage over de voorspelkwaliteit de verhouding erbij: hoeveel
beoordeeld, en hoeveel daarvan niet vast te stellen. Loopt dat aandeel op, dan is de
eerste bevinding niet de kwaliteit van de voorspellingen maar de formulering ervan.

### Een voorspelling die niet te weerleggen is, wordt niet weggeschreven

De regel die daaruit volgt, en hij geldt vooraf en niet achteraf:

> **Een voorspelling die bij het verwachte volume niet te weerleggen is, hoort niet
> weggeschreven te worden. Dan is het geen voorspelling maar een mening met een
> tijdstempel.**

Toets vóór het wegschrijven: bij welk aantal waarnemingen is deze uitspraak te
beslechten, en halen we dat aantal binnen de termijn waarop we hem willen evalueren?
Nee, dan wordt de uitspraak herformuleerd tot iets dat wél te beslechten is, of hij
gaat niet de tabel in.

Praktisch betekent dat bij kleine aantallen: **paarsgewijze vergelijkingen in plaats
van rangordeclaims.** "A komt vaker voor dan B" is met tien waarnemingen al zinvol;
"A is de meest voorkomende van zeven" niet.

## 2. Waarom een blokkade geen advies is, en dus een eigen tabel krijgt

Een geblokkeerd doctrinevoorstel moet worden vastgelegd (zie
[`LAYER.md`](LAYER.md), sectie 4). De vraag is waar.

**Het probleem.** `agent_recommendations.predicted_impact` staat op NOT NULL, en de
kolomtoelichting zegt waarom: "Verplicht. Zonder vastgelegde voorspelling is er
achteraf geen leermoment." Een geblokkeerd voorstel heeft geen voorspelling, want het
is nooit uitgevoerd.

**Twee uitwegen die afvallen.** Een placeholder in `predicted_impact` zetten is een
verplicht veld vullen met iets wat geen voorspelling is, en dat is precies de
ad-hocconventie die de root-`CLAUDE.md`, sectie 5, verbiedt. De constraint nullable
maken haalt het mechanisme weg dat vergeten onmogelijk maakt, en die constraint staat
er terecht.

**Er is een derde uitweg die serieus te nemen is**, en die verwerp ik op drie
gronden: een `kind`-kolom in `agent_recommendations` met een voorwaardelijke
constraint, zodat `predicted_impact` alleen verplicht is bij een advies.

Daar is een precedent voor in deze repo: `gtm_events_verification_alleen_bij_boeking`
doet exact dat, een kolom die verplicht is bij één event-type en verboden bij de
rest. Dus de vorm is hier eerder geaccepteerd.

Waarom het hier toch niet past:

1. **Het botst met waar de tabel voor is.** De tabelcommentaar luidt: "Voorspelling
   en uitkomst per advies, over domeinen heen. De helft van de feedbackloop." Een
   blokkade heeft geen voorspelling en geen uitkomst; hij komt de loop nooit in. Vier
   van de definiërende kolommen (`predicted_impact`, `status`, `actual_impact`,
   `evaluated_at`) zijn dan niet van toepassing op die rijen.
2. **De tabel benoemt deze faalvorm zelf als herzieningsgrond.** Het besluit van
   2026-07-29: "Herzien wanneer. Als blijkt dat de velden per domein zo verschillen
   dat de gedeelde tabel voornamelijk uit lege kolommen bestaat." Blokkades erin
   duwen roept precies dat op, en niet eens per domein maar per soort rij.
3. **Ze worden verschillend geteld, en een vergeten filter is stil.** Adviezen
   worden geteld voor de voorspelkwaliteit, blokkades voor de aansluiting. In één
   tabel heeft elke telling een `kind`-filter nodig. De bestaande partiële index
   `agent_recommendations_open_idx` op `status in ('voorgesteld','geaccepteerd')` zou
   blokkades meenemen zonder dat iemand het merkt. De stijl van deze repo is het
   verkeerde onmogelijk maken in plaats van documenteren; zie `motion` op
   accountniveau zonder `NULL`.

**Waarom het verificatieprecedent niet overdraagt.** `verification` is een eigenschap
van één event-type binnen één soort ding: elke rij in `gtm_events` is een aanraking,
en alleen een geboekte afspraak heeft een verificatiestatus nodig. Een blokkade en een
advies zijn twee verschillende soorten ding. Voorwaardelijke verplichting op een
attribuut is iets anders dan voorwaardelijke verplichting op de bestaansreden van de
tabel.

**Daarom een eigen tabel, `agent_blocked_proposals`.** Zonder `gtm_`-prefix en met
een `domain`-kolom, om dezelfde reden als bij `agent_recommendations`: de vorm is
domeinoverstijgend, want elke laag in elk domein kan een voorstel blokkeren. De
check-constraint op `domain` staat op alleen `gtm`, als typefoutbescherming en niet als
principiële beperking, precies zoals daar.

## 3. Wat er per kolom bij moet, en waarom

### `agent_recommendations`, vijf kolommen erbij

| Kolom | Type | Waarom |
|---|---|---|
| `source_layer` | text, nullable | welke laag het advies voortbracht. `NULL` = geen laag, dus een gewoon agentadvies |
| `source_layer_version` | integer, nullable | verplicht zodra `source_layer` gezet is. Een advies van versie 1 is niet hetzelfde advies als van versie 2 |
| `layer_intensity` | text, nullable | `licht`, `standaard` of `scherp`. Verplicht zodra `source_layer` gezet is. Niet `off`: op die stand produceert de laag niets |
| `segment` | text, **not null** | zodat een voorspelling tegen de segmentdrempel van twintig verzonden te leggen is. Nu niet mogelijk. Vier taxonomiewaarden plus `domeinbreed` |
| `prediction_verdict` | text, nullable | `gehouden`, `niet-gehouden` of `niet-vast-te-stellen`. Verplicht zodra `evaluated_at` gezet is |

**Waarom `prediction_verdict` geen boolean is.** Er zijn drie eerlijke uitkomsten, niet
twee. "Niet vast te stellen" is een echte toestand, en de bewijslastregel eist dat
die als zodanig gerapporteerd kan worden en niet als nul. Zelfde vorm als
`verification`, dat om dezelfde reden drie waarden heeft.

**Waarom `actual_impact` blijft bestaan naast het verdict.** De vrije tekst houdt de
nuance vast, het verdict maakt tellen mogelijk. Dezelfde verhouding als tussen
`objection_code` en `verbatim` in `gtm_objections`.

**Waarom `segment` niet nullable is, met een expliciete waarde erbij.** In
`gtm_events` betekent `segment = NULL` **ongelabeld**, dus "we weten het niet". Zou
`NULL` hier "niet segmentspecifiek" betekenen, dan heeft dezelfde `NULL` twee
betekenissen over twee tabellen, en dat is het soort ambiguïteit dat over een jaar
bijt. Documenteren lost dat alleen op voor wie de documentatie leest.

Daarom `not null`, met de waarde `domeinbreed` voor een advies dat over alle
segmenten gaat. Die waarde staat sinds 2026-08-04 in
[`taxonomie.md`](../../playbooks/taxonomie.md), sectie 6, dus in het bronbestand en
niet hier: `agent_recommendations` is domeinoverstijgend en die waarde bestaat dus
los van deze laag.

Er is bij een advies ook geen meetgat mogelijk, want het wordt geschreven door iemand
die zijn eigen scope kent. Er is geen derde toestand "ongelabeld advies". Zelfde
onderbouwing als bij `gtm_accounts.motion`, waar `NULL` om dezelfde reden niet
bestaat.

**⚠️ `domeinbreed` mag nooit in `gtm_events` of `gtm_objections` terechtkomen.** Een
aanraking heeft een segment of hij is ongelabeld. Zou de waarde in de eventlijst
belanden, dan verschijnt hij in elke segmentrapportage naast de echte segmenten alsof
hij er een van is. Dat staat als waarschuwing bij de waarde in `taxonomie.md`.

### `agent_blocked_proposals`, nieuwe tabel

| Kolom | Type | Waarom |
|---|---|---|
| `id`, `created_at` | uuid, timestamptz | zoals elders |
| `client`, `domain` | text, not null | zoals `agent_recommendations` |
| `source_layer`, `source_layer_version`, `layer_intensity` | text/integer/text, not null | een blokkade komt per definitie uit een laag, dus hier niet nullable |
| `segment` | text, **not null** | zelfde regel als hierboven: vier taxonomiewaarden plus `domeinbreed` |
| `proposal` | text, not null | wat de doctrine voorstelde |
| `blocked_by` | text, not null | welke grens of uitsluiting het tegenhield, als `grens-9` of `uitsluiting-4` |
| `alternative` | text, not null | wat er in plaats daarvan is gedaan. Verplicht, ook als het antwoord "niets" is |

**Waarom `blocked_by` een vrij veld is en geen gesloten lijst.** Dit is de enige plek
waar ik van de afdwingregel afwijk, en met reden. De lijst met grenzen en
uitsluitingen staat **binnen de laag**, en de laag is verwijderbaar. Een
check-constraint op die lijst zou een constraint achterlaten waarvan het bronbestand
verdwenen is, en dat is een nieuwe manier om de verwijderbelofte te breken.
Bovendien zou grens 10 dan een migratie vragen.

Precedent voor een vrij veld met een formatregel: `utm_campaign` in
[`taxonomie.md`](../../playbooks/taxonomie.md) is bewust vrij. Formatregel hier:
kleine letters, koppelteken, `<soort>-<nummer>`.

### `gtm_events`, drie kolommen erbij en twee uitgesteld

| Kolom | Type | Waarom nu |
|---|---|---|
| `layer_version` | integer, nullable | zodat een reeks aan een laagversie te koppelen is |
| `layer_intensity` | text, nullable | gesloten lijst, `licht`/`standaard`/`scherp` |
| `sequence_position` | integer, nullable | positie in de contactreeks. Check alleen `>= 1`, **geen bovengrens**: de intensiteitsschijf bepaalt het maximum, en een wijziging van de schijf hoort geen migratie te vragen |
| `offer_variant` | text, nullable | vrij veld, kleine letters en koppeltekens, want aanbodvarianten zijn klantspecifiek en kunnen dus geen canonieke domeinlijst zijn |

**Uitgesteld, met reden:**

- **`downsell_form`** (welke vorm bij een verlaging na een nee). De drie vormen staan
  in [`20-aanbodsequentie.md`](20-aanbodsequentie.md), dus binnen de laag, en dat geeft
  hetzelfde probleem als bij `blocked_by`. Zwaarder nog: **welke verlagingsvormen zijn
  toegestaan is een open vraag in de besluitenlijst van fase D.** Een gesloten lijst
  nu vastleggen zet waarden in gebruik voordat het menselijke besluit er is, en dat is
  precies wat de root-`CLAUDE.md`, sectie 5, verbiedt. Toevoegen zodra dat besluit er
  is, als aparte migratie van één regel.
- **Alles rond de verlaging zelf.** Er is nog geen verlaging, want er is nog geen
  aanbodsequentie buiten het doorlopende aanbod.

## 4. De eerste voorspelling die hierop wacht

Uit fase B volgt een toetsbare voorspelling met een herkomst, en die is het waard om
als eerste weg te schrijven.

**Waar hij uit volgt.** De positionering van de klant stelt dat onbekendheid met de
categorie het dominante probleem is. De doctrine stelt vast dat het
viercategorieënmodel uit de bron daar geen vakje voor heeft, omdat het de bekendheid
van de categorie als aanname heeft. Beide wijzen dezelfde kant op, en dat maakt het
een voorspelling in plaats van een observatie.

**De voorspelling, paarsgewijs geformuleerd:** `wat-is-dpp` komt vaker voor dan
`geen-budget`.

**Waarom niet "de meest voorkomende code".** Dat was de eerste formulering en hij is
onbruikbaar: een rangordeclaim over zeven categorieën is bij lage aantallen niet te
beslechten, dus hij zou in `niet-vast-te-stellen` landen en niets opleveren. Dat is
exact de faalvorm uit sectie 1. Een paarsgewijze vergelijking is met tien replies al
zinvol.

De keuze voor `geen-budget` als tegenhanger is niet willekeurig: dat is de code die je
zou verwachten als het probleem prijs was in plaats van begrip. De twee codes staan
dus voor de twee verklaringen die tegen elkaar in gaan, en dat maakt de vergelijking
informatief in beide richtingen.

Als rij, zodra de kolommen bestaan:

| Kolom | Waarde |
|---|---|
| `client` | de klant |
| `domain` | `gtm` |
| `subject` | verdeling van bezwaarcodes bij de eerste gecodeerde replies |
| `recommendation` | eerst de categorie uitleggen, dan differentiëren. Een eerste bericht dat met onderscheid begint, praat langs de meeste ontvangers heen |
| `predicted_impact` | `wat-is-dpp` komt vaker voor dan `geen-budget` in de gecodeerde replies van dit segment |
| `source_layer` | `commercial-doctrine` |
| `source_layer_version` | `1` |
| `layer_intensity` | `standaard` |
| `segment` | het eerst bewerkte segment, dus een taxonomiewaarde en niet `domeinbreed` |
| `status` | `voorgesteld` |

**Wat hem weerlegt:** `geen-budget` komt even vaak of vaker voor. Eén voorbehoud ligt
vooraf vast: groeit `anders` boven een tiende van de replies, dan ontbreekt er een code
en is de hele verdeling onbruikbaar. Dat gaat dan vóór de voorspelling, conform
[`taxonomie.md`](../../playbooks/taxonomie.md), sectie 6.

**Geen nieuwe drempel.**
[`significantie-drempels.md`](../../playbooks/significantie-drempels.md) kent drie
drempels en geen daarvan gaat over een verdeling over bezwaarcodes. Er komt er ook
geen bij: om een drempel te zetten voor zo'n vergelijking moet je weten welke n
volstaat, en dat weten we bij n=0 niet. Een getal nu vastleggen is gokken, en dat is
precies wat de bewijslastregel moet voorkomen.

**Dus: absolute aantallen, expliciet gelabeld als anekdotisch**, met beide codes en hun
aantal ernaast. De drempel wordt later gezet, mét informatie in plaats van ervoor.

## 5. De evaluatiedrempel van de laag

**Wanneer heeft de laag zich bewezen, en wanneer gaat hij eruit.**

- **Het moment:** twintig beoordeelde adviezen uit deze laag, dus
  `prediction_verdict in ('gehouden', 'niet-gehouden')`.
- **`niet-vast-te-stellen` telt niet mee in die twintig.** Data uit verschillende
  soorten uitkomst optellen om een drempel te halen beantwoordt een andere vraag dan
  de gestelde (root-`CLAUDE.md`, sectie 4).
- **De uitkomst is een kwalitatief oordeel, geen percentage.** Voorbereid met de ruwe
  aantallen: hoeveel gehouden, hoeveel niet, hoeveel niet vast te stellen, hoeveel
  blokkades en door welke grens.
- **Het oordeel is van Ward.** De laag levert de cijfers, niet de conclusie.

**Drie signalen die eruit halen rechtvaardigen:**

1. De voorspelde richting hield niet vaker stand dan hij faalde. Dan produceert de
   laag geen bruikbare voorspellingen.
2. **Het aandeel `niet-vast-te-stellen` loopt op.** Dan produceert de laag
   voorspellingen die niet te weerleggen zijn, en dat is geen neutrale uitkomst maar
   een gebrek. Dit is de faalvorm die hier het meest waarschijnlijk optreedt, en zonder
   dit signaal zou de laag op onweerlegbaarheid kunnen overleven. Zie sectie 1.
3. Het blokkadepatroon laat zien dat de laag structureel voorstelt wat onze grenzen
   verbieden. Dan past de doctrine niet op deze markt, en dat is een uitkomst en geen
   storing.

**Signaal 2 wordt eerst als formuleringsprobleem behandeld, niet meteen als grond om
te verwijderen.** Een voorspelling die niet te beslechten was, kan herformuleerd
worden. Blijft het aandeel oplopen ná herformulering, dan is het de laag en niet de
formulering.

**Wat deze drempel niet zegt:** of de laag geld heeft opgeleverd. Die vraag blijft
open, en de drempels waarmee hij te beantwoorden zou zijn, blijven staan zoals ze
staan.

## 6. De migratie

**Toegepast op 2026-08-04** in het `Brandpulse GTM`-project, als
`supabase/migrations/20260804105505_doctrinelaag_meetkoppeling.sql`. Idempotent.
Engelse identifiers, Nederlandse constraintwaarden, zoals in de vier eerdere
migraties.

**Geverifieerd na het toepassen**, en niet op het uitblijven van een foutmelding:
alle negen kolommen aanwezig met de bedoelde nullability, `segment` op `not null`,
alle achttien constraints aanwezig, alle drie de indexen aanwezig, RLS aan zonder
policies, en `anon` en `authenticated` kunnen niets lezen. De bestaande 48 rijen in
`gtm_events` bleven staan en de ingest kan er nog steeds in schrijven, want alle
nieuwe kolommen zijn nullable met constraints die `NULL` toestaan.

De beveiligingscontrole geeft vijf regels `rls_enabled_no_policy` op niveau INFO,
één per tabel. Dat is de bedoelde toestand en geen openstaand punt; zie
[`brandpulse-gtm.md`](../../../../infra/brandpulse-gtm.md).

```sql
-- Toegepast op 2026-08-04. Het migratiebestand is de bron; deze weergave is de
-- toelichting erbij.
--
-- Meetkoppeling voor de commerciele doctrinelaag. Zonder deze kolommen is de laag
-- niet te evalueren en dus niet eerlijk te verwijderen.
--
-- Gemeten wordt de voorspelkwaliteit en niet de commerciele uitkomst. Bij een
-- eindige doelgroep en een verbod op conversiepercentages onder twintig
-- waarnemingen is de opbrengstvraag jaren onbeantwoordbaar. Zie
-- memory/decisions.md (2026-08-04). De bestaande drempels blijven ongewijzigd.
--
-- Idempotent.

-- 1. Herkomst en verdict op de bestaande aanbevelingentabel.

alter table public.agent_recommendations
  add column if not exists source_layer         text,
  add column if not exists source_layer_version integer,
  add column if not exists layer_intensity      text,
  add column if not exists segment              text,
  add column if not exists prediction_verdict   text;

comment on column public.agent_recommendations.source_layer is
  'Welke methodieklaag dit advies voortbracht. NULL = geen laag.';
comment on column public.agent_recommendations.segment is
  'Taxonomiewaarde of domeinbreed. Nooit NULL: bij een advies is er geen meetgat, want de schrijver kent zijn eigen scope. domeinbreed hoort NOOIT in gtm_events.';
comment on column public.agent_recommendations.prediction_verdict is
  'Hield de voorspelde richting stand: gehouden, niet-gehouden of niet-vast-te-stellen. Alleen de eerste twee tellen mee in de n. Een oplopend aandeel niet-vast-te-stellen is zelf een bevinding: dan voorspelt de laag te vaag om weerlegbaar te zijn.';

-- segment is not null met een expliciete waarde voor domeinbreed. Dezelfde NULL met
-- twee betekenissen over twee tabellen is de ambiguiteit die later bijt. Zie
-- domains/gtm/playbooks/taxonomie.md, sectie 6.
--
-- Defensief in deze volgorde: kolom erbij, bestaande rijen vullen, dan not null. Bij
-- het schrijven van dit voorstel stonden er nul rijen en schreef geen enkele
-- applicatie naar deze tabel, dus de backfill raakt niets. Hij staat er voor het
-- geval dat bij toepassen anders is.
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
  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_source_layer_check') then
    alter table public.agent_recommendations add constraint agent_recommendations_source_layer_check
      check (source_layer is null or source_layer in ('commercial-doctrine'));
  end if;

  -- Herkomst is alles of niets. Een laagnaam zonder versie is niet navolgbaar, en
  -- een versie zonder laagnaam hoort bij niets.
  if not exists (select 1 from pg_constraint where conname = 'agent_recommendations_herkomst_compleet') then
    alter table public.agent_recommendations add constraint agent_recommendations_herkomst_compleet
      check (
        (source_layer is null     and source_layer_version is null and layer_intensity is null) or
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

-- 2. Geblokkeerde voorstellen: eigen tabel, geen advies.
--
-- Een blokkade heeft geen voorspelling en geen uitkomst, dus hij komt de
-- feedbackloop nooit in. In agent_recommendations zouden predicted_impact, status,
-- actual_impact en evaluated_at alle vier niet van toepassing zijn, en zou elke
-- telling een filter nodig hebben dat vergeten kan worden.

create table if not exists public.agent_blocked_proposals (
  id                   uuid primary key default gen_random_uuid(),
  created_at           timestamptz not null default now(),

  client               text not null,
  domain               text not null,

  -- Een blokkade komt per definitie uit een laag, dus hier niet nullable.
  source_layer         text not null,
  source_layer_version integer not null,
  layer_intensity      text not null,

  -- Zelfde regel als in agent_recommendations: not null, met domeinbreed als
  -- expliciete waarde. Een blokkade heeft altijd een scope.
  segment              text not null,

  proposal             text not null,
  -- Vrij veld met formatregel, als grens-9 of uitsluiting-4. Bewust GEEN gesloten
  -- lijst: de lijst met grenzen staat binnen de laag en de laag is verwijderbaar.
  -- Een constraint erop zou een constraint achterlaten zonder bronbestand.
  blocked_by           text not null,
  -- Verplicht, ook als het antwoord "niets" is. Anders is niet te zien of er een
  -- alternatief was of dat niemand het heeft opgeschreven.
  alternative          text not null,

  constraint agent_blocked_proposals_domain_check check (domain in ('gtm')),
  constraint agent_blocked_proposals_layer_check check (source_layer in ('commercial-doctrine')),
  constraint agent_blocked_proposals_intensity_check check (layer_intensity in ('licht', 'standaard', 'scherp')),
  constraint agent_blocked_proposals_versie_positief check (source_layer_version > 0),
  constraint agent_blocked_proposals_segment_check check (
    segment in ('ebike', 'retail', 'food', 'bureau', 'domeinbreed')
  ),
  constraint agent_blocked_proposals_client_niet_leeg check (length(btrim(client)) > 0),
  constraint agent_blocked_proposals_blocked_by_niet_leeg check (length(btrim(blocked_by)) > 0)
);

comment on table public.agent_blocked_proposals is
  'Doctrinevoorstellen die door een grens of uitsluiting zijn tegengehouden. Geen advies: geen voorspelling, geen uitkomst.';
comment on column public.agent_blocked_proposals.blocked_by is
  'Welke grens of uitsluiting het tegenhield, als grens-9 of uitsluiting-4. Vrij veld, want de lijst staat binnen een verwijderbare laag.';

create index if not exists agent_blocked_proposals_client_idx     on public.agent_blocked_proposals (client, created_at desc);
create index if not exists agent_blocked_proposals_blocked_by_idx on public.agent_blocked_proposals (blocked_by);

alter table public.agent_blocked_proposals enable row level security;
revoke all on table public.agent_blocked_proposals from anon, authenticated;

-- 3. Laagcontext op de events.
--
-- downsell_form staat hier bewust NIET bij: welke verlagingsvormen zijn toegestaan
-- is een open vraag in de besluitenlijst van fase D. Een gesloten lijst nu
-- vastleggen zet waarden in gebruik voor het menselijke besluit er is. Zie
-- CLAUDE.md sectie 5. Toevoegen als aparte migratie zodra dat besluit er is.

alter table public.gtm_events
  add column if not exists layer_version     integer,
  add column if not exists layer_intensity   text,
  add column if not exists sequence_position integer,
  add column if not exists offer_variant     text;

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
```

## 7. Wat er na deze migratie onomkeerbaar is

Een toegepaste migratie wordt nooit teruggedraaid
([`migratie-proces.md`](../../../../infra/migratie-proces.md), sectie 6). Verdwijnt de
laag, dan blijven deze kolommen en deze tabel staan.

**Dat is het enige onomkeerbare residu van de laag, het bestaat uit lege kolommen en
een lege tabel, en het verandert geen gedrag.** Het staat ook in
[`LAYER.md`](LAYER.md), sectie 7, zodat het later niet als een gebroken belofte
leest.

**Twee dingen die bij verwijdering wél moeten gebeuren**, en ze staan als stap 6 in de
verwijderprocedure:

1. **De twee check-constraints op `source_layer` droppen**, in
   `agent_recommendations` en `agent_blocked_proposals`. Die noemen de laag bij naam.
   Met een **nieuwe** migratie, niet door de oude aan te passen. De kolommen blijven:
   een lege kolom is gedragsneutraal, een constraint die naar een verdwenen laag
   verwijst is dat niet.
2. **Het migratiebestand blijft staan.** Dat is de reden dat
   `infra/laag-check.sh` `supabase/migrations/` als derde uitzondering kent, met die
   reden erbij in de uitvoer in plaats van stil weggefilterd.

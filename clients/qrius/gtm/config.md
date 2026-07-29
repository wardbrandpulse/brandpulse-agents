# Qrius, GTM-config

De enige plek in dit klantproject waar concrete bronnen, omgevingen en
verbindingen benoemd worden. Playbooks en instructies verwijzen hierheen en
noemen zelf nooit een tool. Zie de platformneutraliteitsregel in de
root-`CLAUDE.md`.

**Geen sleutels, tokens of wachtwoorden in dit bestand.**

- **Laatst bijgewerkt:** 2026-07-29
- **Status:** grotendeels open. De datalaag is nog niet gekozen, dat is fase 1B.

---

## Databronnen

| Bron | Waarvoor | Aanduiding | Status |
|---|---|---|---|
| gebeurtenissen | de GTM-events (`gtm_events`) | **nog niet gekozen** | besluit in fase 1B |
| bezwaren | gecodeerde replies (`gtm_objections`) | **nog niet gekozen** | besluit in fase 1B |
| aanbevelingen | voorspelling en uitkomst (`agent_recommendations`, gedeeld over domeinen, met `domain`-kolom) | **nog niet gekozen** | besluit in fase 1B |
| productdata Qrius | platformdata van Qrius-klanten | Supabase-project `rylmnfaaylnnnbiuywlq` (productie) | bestaat |
| pijplijn | waar deals en stadia staan | `TODO` | |

**Let op bij de productdatabron.** Dat project bevat productdata van
Qrius-klanten, niet de commerciële data van Brandpulse. Die twee horen niet
zonder meer bij elkaar: het is de kern van de keuze die in fase 1B voorligt. De
regel is dat GTM-data van Brandpulse niet vermengd raakt met platformdata van
derden.

## Websites en analytics

- **Marketingsite:** de app `apps/website` in de repository
  `wardbrandpulse/QRius`. Dit is de site die de GTM-events moet gaan leveren.
- **Portaal en consumentenpagina:** `apps/portal` en `apps/landing` in dezelfde
  repository. Deze staan niet in scope voor GTM-tracking.
- **Hoofddomein:** `TODO: door Ward in te vullen`
- **Bestaande webanalytics:** Vercel Web Analytics. Blijft staan zoals het
  staat, wordt niet gedupliceerd en niet vervangen. `TODO`, bevestigen op welk
  Vercel-project dit aanstaat.
- **Waar de UTM's op landen:** `TODO`, de eerste bestemmingspagina's per asset
  vastleggen zodra de site live is.

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
- **Dragen de boekingen de taxonomie?** Nee, nog niet. Dit moet geregeld worden,
  anders is een boeking niet toe te wijzen aan segment, bron en asset, en breekt
  de keten op precies het punt waar hij het meest waard is. Zie
  [`taxonomie.md`](../../../domains/gtm/playbooks/taxonomie.md), sectie 5.

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

1. Waar leven `gtm_events`, `gtm_objections` en `agent_recommendations`? Besluit
   in fase 1B.
2. Verzenddomein kiezen en opwarmen voordat er outbound vertrekt.
3. Cal.com-eventtypes vastleggen en de taxonomie meegeven aan de boeking.
4. Hoofddomein en bestemmingspagina's per asset vastleggen.
5. Waar de pijplijn wordt bijgehouden.

`TODO: door Ward in te vullen`

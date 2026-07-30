# Qrius, ICP

Versie 2, vastgesteld door Ward op 2026-07-30. Vervangt de werkhypothese van
2026-07-29.

- **Laatst bijgewerkt:** 2026-07-30
- **Status:** `klant`
- **Bewijs: n=0.** Nul gesprekken, nul verzonden reeksen, nul gewonnen deals.

**Wat "vastgesteld met n=0" betekent.** De criteria en het scoremodel staan vast
als werkafspraak: hier wordt vanaf nu op geselecteerd en geprioriteerd. Ze zijn
niet getoetst aan de markt. Er mag dus geen enkele kwantitatieve uitspraak op
gebaseerd worden, en de openstaande aannames staan als leringen met n=0 in
[`memory/learnings.md`](memory/learnings.md). Zie de bewijslastregel in de
root-[`CLAUDE.md`](../../../CLAUDE.md).

---

## 1. Diskwalificatie

Vijf criteria. **Eén "ja" is genoeg om te diskwalificeren.** Deze stap gaat vóór
het scoremodel: eerst uitsluiten, dan pas ordenen.

| # | Criterium, diskwalificeert bij "ja" | Waarom |
|---|---|---|
| **D1** | Geen eigen merk | Zonder eigen merk ligt de verantwoordelijkheid voor de productinformatie elders, en daarmee ook de aanschafbeslissing |
| **D2** | Geen fysiek product | Een productpaspoort hangt aan een fysiek artikel; zonder artikel is er niets om aan te hangen |
| **D3** | Onder 30 modellen (GTIN's) | Afgeleid van de Starter-prijs: onder dat aantal loopt het abonnement niet uit de kosten |
| **D4** | Brengt niet op de EU-markt | De verplichting die de urgentie levert, geldt dan niet |
| **D5** | Bouwt intern, met vastgelegd budget én team | "Vastgelegd" is het onderscheid: een intentie is geen diskwalificatie, een goedgekeurd project wel |

**D3 gaat om modellen**, dus GTIN's, niet om verkochte stuks. Een fabrikant met
drie modellen en een miljoen stuks valt af; een merk met tachtig modellen en
kleine oplages niet.

**De 30 in D3 is beredeneerd, niet waargenomen.** Hij komt uit de eigen
prijsstelling en zegt dus iets over wanneer het voor ons uit kan, niet over
wanneer een merk het nodig heeft. Dat is een aanname met een asymmetrisch risico:
ligt de grens te hoog, dan verdwijnen kopers uit de lijst zonder dat je het ooit
ziet. Zie de lering in [`memory/learnings.md`](memory/learnings.md), en
registreer het aantal modellen bij elk gesprek, ook bij een nee.

**Bij D5 zit het onderscheid in "vastgelegd".** "We overwegen het zelf te
bouwen" is bezwaar `intern-bouwen` en blijft in aanmerking komen. Een project met
budget en een toegewezen team is een gepasseerde beslissing.

### Expliciet géén diskwalificatie: al een DPP-oplossing live

Bedrijven die al een DPP-oplossing in productie hebben, worden **niet**
uitgesloten. Ze vormen een **aparte beweging** met eigen verwachtingen: de cyclus
is langer, want er ligt een bestaande keuze en meestal een contract onder.

**Ze worden apart geregistreerd**, zodat hun langere doorlooptijd de gemiddelden
van de reguliere beweging niet vervuilt. Dat is geen administratieve
netheidskwestie: één trage deal in een kleine n verschuift een gemiddelde genoeg
om er een verkeerde conclusie op te bouwen.

**Waar die registratie landt.** In `gtm_accounts.motion`, met de waarden `nieuw`
en `vervanging`. Gebouwd op 2026-07-30, na de vaststelling dat de scheiding
anders een belofte zonder mechaniek was.

Motion staat op **accountniveau** en niet per event: het is een eigenschap van de
partij, niet van de aanraking, en het wordt dus één keer vastgelegd in plaats van
per rij opnieuw geraden. Een event erft de motion via een koppeling op klant plus
account. `nieuw` is de default en `NULL` bestaat er niet: bij een account dat nog
niets heeft is `nieuw` de waarheid, geen gok.

**Registreren is een menselijke handeling.** De ingest legt geen accounts aan,
want tracking mag nooit falen op een ontbrekende registratie. Een account dat wel
in de events staat en niet in `gtm_accounts`, is daardoor een zichtbaar gat in
plaats van een stille `nieuw`-telling. Query 8 in
[`../../../infra/brandpulse-gtm.md`](../../../infra/brandpulse-gtm.md) zoekt ze
op; loop die af voordat je een doorlooptijd rapporteert.

Zie [`taxonomie.md`](../../../domains/gtm/playbooks/taxonomie.md), sectie 6.

---

## 2. Scoremodel

Drie assen, elk **1 tot 3**, **vermenigvuldigd**. Bereik 1 tot 27.

| As | 1 | 2 | 3 |
|---|---|---|---|
| **M1** Regelgevingsdruk | geen bekende verplichting in zicht | verplichting waarschijnlijk, geen bindende datum | vaste, bindende datum |
| **M2** Scanmotivatie | geen reden voor een consument om te scannen | denkbare reden, niet aangetoond | evidente reden, past bij het product |
| **M3** Bereikbaarheid | beslisser niet te vinden of niet te benaderen | bereikbaar via meerdere stappen | direct te identificeren en te benaderen |

De drie assen wegen nu **even zwaar**. Dat is een startaanname, geen meting:
herzien na de eerste tien gesprekken, en voor M3 al na drie klanten. Zie de
lering in [`memory/learnings.md`](memory/learnings.md).

**De score bepaalt de volgorde van bewerking, niet wie in aanmerking komt.** Wie
door de diskwalificatie heen komt, is prospect. De score zegt alleen wie eerst
aan de beurt is: een 4 wordt bewerkt, alleen later dan een 18.

Vermenigvuldigen en niet optellen, omdat een 1 op één as het geheel moet
platslaan. Een perfect passend product waarvan de beslisser onvindbaar is, is
geen goede eerste prospect; optellen zou dat wegpoetsen.

### ⚠️ M1: alleen het batterijpaspoort heeft een vaste datum

Dit is een harde beperking op wat er in outbound gezegd mag worden.

- **Het EU-batterijpaspoort** is de enige verplichting die als **vaste datum**
  genoemd mag worden. Dát hij als urgentiehaak wérkt, is nog onbevestigd; zie
  [`sectors/ebike.md`](../../../domains/gtm/memory/sectors/ebike.md).
- **ESPR-termijnen zijn indicatief.** Ze horen bij de gedelegeerde handelingen en
  er zijn **nog geen bindende nalevingsdata**. Ze mogen als richting worden
  benoemd, met dat voorbehoud er expliciet bij.
- **Niet aanscherpen in outbound.** Geen "per <datum> verplicht" waar het
  indicatief is, en geen formulering die strakker klinkt dan de bron. Een datum
  die verkeerd blijkt, kost meer geloofwaardigheid dan hij aan urgentie
  oplevert, en het raakt de gevoeligheid uit [`../profiel.md`](../profiel.md):
  Qrius helpt bij het voldoen aan verplichtingen en geeft geen juridische duiding.

Praktisch voor M1: alleen een geverifieerde bindende datum geeft een **3**, een
indicatieve ESPR-termijn geeft een **2**.

### ⚠️ De speelgoedregel is niet geverifieerd

Er is een aanname over een verplichting voor speelgoed. Die staat als **te
verifiëren** en wordt **niet gebruikt** tot dat is nagegaan: niet in de score,
niet in een lijstselectie, niet in outbound, niet in een gesprek. Tot die tijd is
speelgoed op M1 een `1`.

Dit staat in [`memory/learnings.md`](memory/learnings.md) onder "Openstaande
verificaties" en niet bij de leringen. Een lering is een aanname over hoe de
markt zich gedraagt en mag je voorzichtig gebruiken; dit is de vraag of een feit
klopt, en dat mag je niet gebruiken.

---

## 3. Wat hier bewust niet staat

Dit staat er zodat een lezer ziet dat het ontbreken een keuze is en geen
vergeetachtigheid.

- **Rollen en functietitels.** Nul gesprekken, dus elke titel zou een gok zijn.
  Wordt gevuld uit de eerste replies.
- **Omvang, geografie en aantal SKU's** buiten de ondergrens van 30 modellen.
  D3 is de enige harde grens die is vastgesteld.
- **Triggers** anders dan regelgeving. Welke gebeurtenissen in de praktijk
  aanzetten tot zoeken, moet uit gesprekken komen.
- **Het segment `bureau`.** Partners kopen niet voor zichzelf maar brengen
  klanten mee, dus de criteria hierboven passen er niet op.
  `TODO: door Ward in te vullen`, of `bureau` een eigen profiel krijgt.

---

## 4. Waar ze te vinden zijn

`TODO: door Ward in te vullen.` Per bron noteren hoeveel partijen hij oplevert en
hoe actueel hij is, zodat vooraf duidelijk is of de segmentdrempel van 20
verzonden haalbaar is.

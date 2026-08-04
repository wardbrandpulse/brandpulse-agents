# Qrius, aanbodcatalogus en openstaande commerciële besluiten

Wat er commercieel is vastgelegd, en wat er nog beslist moet worden. Dit bestand
bevat de bedragen, kortingen, garanties en grenzen die de methodiek zelf nooit mag
vaststellen.

- **Laatst bijgewerkt:** 2026-08-04
- **Status:** sjabloon. **Er is nog niets ingevuld, en dat is met opzet.**

> **Waarom hier niets is ingevuld.** Bedragen, kortingspercentages,
> betaalsplitsingen, capaciteitsgrenzen en garantietermijnen zijn menselijke
> besluiten met commerciële en juridische gevolgen. Een agent die ze verzint,
> levert een getal op dat er over een half jaar uitziet als een afspraak.
> Liever een leeg veld dan een verzonnen veld; zie de root-`CLAUDE.md`, sectie 9.
>
> Per veld staat daarom de **vraag** die beantwoord moet worden en **wie** erover
> gaat, niet een voorstel.

**Dit bestand hangt niet aan de methodieklaag die de vragen opriep.** Of er een
instapaanbod is, wat het ankerbedrag is en welke garantie levering kan nakomen, zijn
commerciële vragen die blijven bestaan ongeacht welke methodiek er wordt gebruikt.
Verdwijnt die laag, dan blijft dit bestand geldig en nodig.

---

## 0. Bestaande stand: beschrijving, geen besluit

> **Alles in deze sectie is een feit over wat er nu is.** Het is hier niet
> vastgesteld en het is geen uitkomst van een besluit uit dit bestand. Elk getal
> heeft een bron in de productrepository, en **de code is de bron**: de blueprint
> `docs/pricing-and-plans-blueprint.md` loopt erachteraan.
>
> **Niet wijzigen vanuit dit domein**, en niet lezen als een keuze die al gemaakt is
> voor de velden verderop.

| Feit | Stand | Bron |
|---|---|---|
| Vorm van het doorlopende aanbod | maandabonnement, of jaarabonnement | `apps/website/src/lib/plans.ts` |
| Jaarvoordeel | **20 procent** op twaalf maandtermijnen | `plans.ts`, `ANNUAL_DISCOUNT_LABEL` en de jaartarieven |
| Tiers | vier: drie self-service plus één op maat | `plans.ts` en `apps/portal/src/lib/plans/config.ts` |
| Enige bestaande kortingsvorm | het jaarvoordeel. Verder geen | idem |
| Zichtbare ondergrens bij de op-maat-tier | **8.500 per maand, 81.600 per jaar**, getoond als "vanaf" met een contactknop. De website toont voor die tier geen prijs en de blueprint noemt geen bedrag | `apps/portal/src/lib/plans/config.ts` |

**Waarom die twee getallen hier wél staan.** Wie de vooruitbetaalkorting vaststelt,
moet weten dat er al een jaarvoordeel van 20 procent bestaat, anders komt er een
korting naast een korting. En wie het ankerbedrag vaststelt, moet weten dat er al een
zichtbare ondergrens is. Een bekend feit weglaten uit een besluitdocument ruilt het
risico op een verzonnen getal voor het risico op een onwetend besluit, en dat tweede is
hier groter.

**Waarom ze in een eigen sectie staan.** Zodat niemand over een half jaar een
beschrijving voor een vastgesteld besluit aanziet. Alles hieronder met een `TODO` is
open; alles hierboven is stand van zaken.

---

## 1. Doorlopend aanbod

**Dit is de enige positie in de aanbodsequentie die bezet is.** Wat er is, staat in
sectie 0. Hieronder staat alleen wat er nog niet benut is.

**Wat er in deze positie nog niet benut is**, methodiek in
`domains/gtm/layers/`, bedragen hier:

| Techniek | Vraag | Eigenaar |
|---|---|---|
| Eenmalige waardetoevoeging bij directe ondertekening | wat, en wat kost dat ons | `TODO`, Ward en Robbert |
| Vrije maanden in ruil voor een langere looptijd | hoeveel maanden, bij welke looptijd | `TODO`, Ward en Robbert |
| Opstartbedrag dat bij een jaarcontract vervalt | welk bedrag, en vervalt het volledig | `TODO`, Ward en Robbert |
| Langere factuurcyclus | welke cyclus. **Niet** 28 dagen, zie de uitsluiting in de laag | `TODO`, Ward |

## 2. Instapaanbod

**Bestaat niet.** De eerste transactie is nu direct het doorlopende aanbod, koud
verkocht.

| Veld | Vraag die beantwoord moet worden | Eigenaar |
|---|---|---|
| Komt er een instapaanbod | ja of nee. Dit is besluit 1 hieronder en gaat vóór alle andere velden in deze sectie | `TODO`, Ward |
| Vorm | betaalde diagnose, nulmeting, lokaanbod, of iets anders | `TODO`, Ward |
| Bedrag | welk bedrag | `TODO`, Ward en Robbert |
| Terugverdientermijn | binnen hoeveel dagen moeten de acquisitiekosten terug zijn | `TODO`, Ward |
| Wat de klant houdt bij een nee | levert het iets op dat hij mag houden | `TODO`, Ward |

## 3. Uitbreiding

**Bestaat niet als apart aanbod.** Er is wel een upgradepad tussen de tiers en er zijn
losse modules, maar dat is groei binnen het doorlopende aanbod en geen aparte positie.

| Veld | Vraag | Eigenaar |
|---|---|---|
| Telt een eerder betaald bedrag mee bij een grotere stap | ja of nee, en volledig of deels | `TODO`, Ward en Robbert |
| Welke twee opties worden naast elkaar gelegd | in plaats van een ja-of-nee-vraag | `TODO`, Ward |

## 4. Verlaging na een nee

**Bestaat niet.** Er is op dit moment geen vastgestelde route na een afwijzing.

| Veld | Vraag | Eigenaar |
|---|---|---|
| Welke verlagingsvormen zijn toegestaan | betaalvorm aanpassen, omvang weghalen, proefvorm, of een combinatie. Dit is besluit 2 hieronder | `TODO`, Ward |
| Tot welke grens | wat is de bodem, in bedrag of in omvang | `TODO`, Ward en Robbert |
| Wie mag die grens naderen | alleen Ward, of ook iemand anders | `TODO`, Ward |

**Vastgelegde beperking:** de proefvorm met boeteclausule is uitgesloten zolang er geen
juridisch kader is. De gewone proefvorm niet. Zie de uitsluitingen in de laag.

## 5. Ankeren en vooruitbetaling

**Let op: er bestaat al een de facto ankerbedrag, en dat verandert de vraag.** Zie
sectie 0 voor het bedrag en de bron; het staat daar één keer, zodat de twee plekken
niet uit elkaar kunnen lopen.

**De vraag is daarmee niet "welk ankerbedrag" maar "welk ankerbedrag naast het bedrag
dat er al staat".** Een tweede anker dat lager is dan het zichtbare, ondermijnt het
zichtbare. Een tweede anker dat hoger is, vraagt uitleg waarom het portaal iets anders
zegt.

**En hetzelfde geldt voor de korting.** Er bestaat al een jaarvoordeel (sectie 0). Een
vooruitbetaalkorting komt daar naast te staan, niet in plaats daarvan, en de twee samen
bepalen wat er werkelijk van de lijstprijs af gaat. Het percentage staat één keer, in
sectie 0: twee getallen die uit elkaar lopen zijn erger dan één verkeerd getal.

| Veld | Vraag | Eigenaar |
|---|---|---|
| Ankerbedrag | welk bedrag, en hoe verhoudt het zich tot de zichtbare ondergrens uit sectie 0 | `TODO`, Ward en Robbert |
| Vooruitbetaalkorting | welk percentage of bedrag, waarop, en hoe het samenvalt met het bestaande jaarvoordeel uit sectie 0 | `TODO`, Ward en Robbert |
| Splitsingsverhouding | hoeveel vooraf en hoeveel gespreid, en waarom die verhouding | `TODO`, Ward en Robbert |
| Korting bij afkoop van een lopend betaalplan | welk percentage | `TODO`, Ward en Robbert |
| Wordt er een prijsverhoging aangekondigd | ja of nee, en per wanneer. **Alleen aankondigen als hij werkelijk doorgaat** | `TODO`, Ward |
| Vertrekbedrag voor de verkopende partij | het bedrag waar die zich comfortabel bij voelt | `TODO`, Ward |

## 6. Garanties

| Veld | Vraag | Eigenaar |
|---|---|---|
| Welke garantie kan levering werkelijk nakomen | en op welk **proceskenmerk**, niet op een uitkomst. Dit is besluit 4 hieronder | `TODO`, Ward, getoetst bij wie hem moet uitvoeren |
| Vorm | onvoorwaardelijk, voorwaardelijk of prestatiegebonden | `TODO`, Ward |
| Termijn | binnen welke termijn geldt hij | `TODO`, Ward |
| Wat er gebeurt als hij niet gehaald wordt | en of dat juridisch getoetst is | `TODO`, Ward plus juridische toetsing |

**Vastgelegde beperking:** nooit een garantie op een wettelijke uitkomst. Geen "u bent
compliant", geen belofte over hoe een controle afloopt. Zie
[`../profiel.md`](../profiel.md), sectie "Gevoeligheden", en de grens in de laag.

## 7. Capaciteit

| Veld | Vraag | Eigenaar |
|---|---|---|
| Echte capaciteitsgrens | hoeveel nieuwe klanten per maand kunnen er werkelijk aan boord, inclusief onboarding | `TODO`, Ward, getoetst bij levering |
| Waar de grens zit | mensen, onboardingtijd, of iets anders | `TODO`, Ward |
| Mag die grens genoemd worden in commercie | ja of nee | `TODO`, Ward |

**Waarom dit hier staat en niet in de methodiek.** Schaarste mag alleen genoemd worden
als hij feitelijk waar is. Zonder een vastgestelde capaciteitsgrens is elke uitspraak
over beschikbaarheid een verzonnen grens, en die is uitgesloten. Een lege regel hier
betekent dus: er wordt niets over capaciteit gezegd.

## 8. Weggever

| Veld | Vraag | Eigenaar |
|---|---|---|
| Welk smal probleem lost hij volledig op | één probleem, niet een breed probleem half | `TODO`, Ward |
| Vorm | gereedschap, informatie, dienst, monster, groep, video, of test of scan | `TODO`, Ward |
| Wat is de betrokken lead | welk gedrag geldt als koopintentie voor het kernaanbod | `TODO`, Ward |
| Wat de volgende stap is | één concrete stap | `TODO`, Ward |

---

## Openstaande besluiten

Vijf besluiten die vóór de eerste outbound genomen moeten zijn, in de volgorde waarin
ze elkaar beïnvloeden. **Geen van de vijf is hier beslist, en geen enkele mag door een
agent beslist worden.**

| # | Besluit | Waarom het niet kan wachten | Eigenaar |
|---|---|---|---|
| 1 | **Komt er een betaald instapaanbod, en zo ja welke vorm en welk bedrag?** | De eerste transactie is nu direct een doorlopende verplichting, koud verkocht. Dat vraagt van een vreemde in één stap het grootste commitment dat er is, zonder tussenstap waarop hij zich kan laten zien. Dit is het grootste gat in de sequentie | Ward, bedrag met Robbert |
| 2 | **Welke verlagingsvormen zijn toegestaan bij een nee, en tot welke grens?** | Zonder vastgestelde vormen wordt er ter plekke iets verzonnen, en dat is bijna altijd korting op hetzelfde. Blokkeert ook een kolom in de datalaag: de gesloten lijst kan niet worden vastgelegd voordat dit besluit er is | Ward, grens met Robbert |
| 3 | **Wat is het ankerbedrag en welke vooruitbetaalkorting hoort erbij?** | Er staat al een zichtbare ondergrens in het portaal en er bestaat al een jaarvoordeel, beide in sectie 0. Elk anker en elke korting verhoudt zich daartoe, of dat bedoeld is of niet | Ward en Robbert |
| 4 | **Welke garantie kan levering werkelijk nakomen, op welk proceskenmerk?** | Een garantie die levering niet kan nakomen is geen commercieel instrument maar een schuld. En zonder vastgestelde garantie is er geen risico-omkering mogelijk, wat de zwaarste hefboom is bij een onbekende categorie | Ward, getoetst bij levering |
| 5 | **Wat is de echte capaciteitsgrens, in nieuwe klanten per maand?** | Zonder dit getal is elke uitspraak over beschikbaarheid een verzonnen grens en dus uitgesloten. Het is ook de invoer voor de vraag hoeveel accounts er per periode in een contactreeks kunnen | Ward, getoetst bij levering |

### Drie besluiten die hier niet in staan, en waar ze wel staan

- **Het verzenddomein en de opwarming.** Staan in [`config.md`](config.md) onder
  "Verzenden", alle drie op `TODO`. Zonder ingevuld verzenddomein vertrekt er geen
  outbound, ongeacht wat er in dit bestand staat.
- **Het juridisch kader outbound.** Openstaand punt 10 in [`config.md`](config.md).
  Besluit 4 hierboven kan niet volledig zonder.
- **Wijzigingen in de bestaande prijsstructuur.** Die horen in de productrepository en
  worden niet vanuit dit domein genomen.

---

`TODO: door Ward in te vullen`

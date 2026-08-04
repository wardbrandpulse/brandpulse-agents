# Kanaaldoctrine

> **Bewijslast: n=0.** Externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).

Welke kanalen er zijn, in welke volgorde ze aan de beurt komen, en waarop de
inspanning gemeten wordt.

Actief op stand `licht` en hoger.

---

## 1. De vier kanalen

Er zijn er niet meer. Elke actie valt in precies één ervan.

| Kanaal | Wat het is |
|---|---|
| warm bereik | mensen die ons of de klant al kennen |
| koud bereik | mensen die ons niet kennen en niet om contact vroegen |
| eigen content | wat wij publiceren en wat gevonden wordt |
| betaalde media | wat wij kopen om gezien te worden |

Dat er precies vier zijn, is de bruikbare kant: een activiteit die in geen van de
vier past, is meestal geen kanaal maar een middel binnen een kanaal.

**Dit is niet dezelfde indeling als `source` in de taxonomie**, en dat moet zo
blijven. De taxonomie legt vast waar een aanraking vandaan kwam en heeft zes
`source`-waarden en vijf `utm_medium`-waarden, afgedwongen bij ingest. Deze vier
kanalen zijn een denkindeling voor de vraag waar de volgende inspanning heen gaat.
Vertaal ze bij het vastleggen naar de canonieke waarden uit
[`taxonomie.md`](../../playbooks/taxonomie.md); voeg er nooit een waarde aan toe
omdat deze indeling vier vakjes heeft.

## 2. Warm eerst, en uitputtend

Koud bereik begint pas als **beide** voorwaarden gehaald zijn:

1. Warm bereik is uitgeput, niet gedeeltelijk gedaan.
2. Het aanbod is bewezen, in de zin van de drempel uit
   [`significantie-drempels.md`](../../playbooks/significantie-drempels.md).

**Externe ordegrootte, onvalideerd:** warm bereik converteert een factor vijf tot
tien hoger dan koud. Dat getal komt uit de bron, is bij ons niet gemeten, en mag
dus geen rekengrondslag zijn. Het draagt één conclusie: de volgorde. Niet hoeveel
warm oplevert, niet wanneer je klaar bent, en zeker geen prognose.

Waarom die tweede voorwaarde er staat: koud bereik met een ongetoetst aanbod
gebruikt een eindige lijst om iets te leren dat warm bereik goedkoper had
opgeleverd. De lijst is daarna kleiner en het antwoord niet beter.

## 3. Dekkingsdiscipline in plaats van dagvolume

**Dit is de zwaarste afwijking van de bron in deze laag.** De bron schrijft honderd
primaire acties per dag voor, als vaste dagelijkse norm. Wij nemen dat niet over.

**Waarom niet.** Die norm veronderstelt een markt die praktisch oneindig is. Onze
doelgroep is eindig: in het eerste segment gaat het om Nederlandse merken met een
paspoortplicht, in de duizenden. Bij honderd acties per dag is die markt in een
kwartaal aangeraakt en daarna reageert hij niet meer. De schade is niet terug te
draaien: een verbrande lijst blijft verbrand, en de domeinreputatie gaat mee.

**Wat er in de plaats komt.** Dekking als eenheid:

| Stand | Contactmomenten per account |
|---|---|
| `standaard` | vijf |
| `scherp` | zeven |

En twee maten in plaats van dagvolume:

- **Dekking:** welk deel van de gekwalificeerde lijst een reeks heeft gekregen.
- **Reekscompletering:** welk deel van de begonnen reeksen is afgemaakt.

Een halve reeks bij tweemaal zoveel accounts is geen tweemaal zoveel bereik. Het is
tweemaal zoveel accounts die weten dat er iets was en niet weten wat.

Vastgelegd als afwijking mét reden in
[`90-uitsluitingen.md`](90-uitsluitingen.md), punt 6, en als besluit van
2026-08-04 in [`memory/decisions.md`](../../../../memory/decisions.md).

### Dekking is geen route om principe 6 heen

> Volume verhogen is nooit de eerste conclusie bij tegenvallende resultaten, en
> nooit een beslissing die en passant genomen wordt.
>
> [`outbound-principes.md`](../../playbooks/outbound-principes.md), principe 6

**Zodra de lijst groeit, is "vijf tot zeven contactmomenten per account" zelf een
volumeafspraak**, en dan geldt principe 6 daarop. Dekking verandert de eenheid
waarin je meet; het geeft geen vrijstelling voor de vraag of er meer verstuurd mag
worden.

Concreet betekent dat: het aantal accounts in de reeks omhoog brengen is een aparte
beslissing, die pas mag als de segmentdrempel van twintig verzonden gehaald is en de
uitkomst positief was, of als het expliciete doel is die drempel te halen. In dat
tweede geval is dat de conclusie, en die wordt opgeschreven.

## 4. Kanaalkeuze volgt uit de diagnose

Niet uit voorkeur, niet uit gewoonte, en niet uit welk kanaal het snelst te
starten is.

De route: eerst de rem bepalen ([`00-principes.md`](00-principes.md), principe 1,
of bij een kanaalvraag de ladder in
[`kanaal-diagnose.md`](../../playbooks/kanaal-diagnose.md)), en pas daarna het
kanaal. Zit de rem bij levering of retentie, dan is het antwoord geen kanaal.

## 5. Wat mag, staat elders

Deze laag bepaalt welk kanaal **werkt**. Of een kanaal **mag**, en onder welke
voorwaarden, staat in het juridisch kader outbound. Dat bestaat nog niet; zie
[`LAYER.md`](LAYER.md), sectie 5, en grens 3.

Twee dingen die daar niet mee weggaan en die nu al gelden:

- **De verzendpoort.** Zonder ingevuld verzenddomein vertrekt er geen outbound
  ([`outbound-principes.md`](../../playbooks/outbound-principes.md), principe 2).
  Een gevulde kanaaldoctrine opent die poort niet.
- **De taxonomie op elke link.** Elke uitgaande link draagt `segment`, `source` en
  waar van toepassing `asset`, conform principe 3 van dat playbook. Een
  contactmoment zonder taxonomie is een contactmoment dat je niet in de dekking
  terugvindt.

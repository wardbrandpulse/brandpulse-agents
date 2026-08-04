# Betaalstructuur

> **Bewijslast: n=0.** Externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).

**Dit bestand bevat geen enkel bedrag, geen percentage en geen looptijd.** Het
beschrijft de techniek. Elk getal staat in `clients/<klant>/` (grens 8).

Actief op stand `scherp`.

---

## Waarom dit bestand alleen de techniek bevat

Het onderscheid "presenteren mag, bepalen niet" houdt hier geen stand. Een bedrag
boven het doelbedrag ankeren is een prijsbesluit. Een vooruitbetaalkorting is een
prijsbesluit. Een aangekondigde verhoging is een prijsbesluit. Alleen de betaalvorm
is dat niet.

Daarom is de splitsing hard:

| In dit bestand | In `clients/<klant>/` |
|---|---|
| dat je ankert, en hoe een anker werkt | het ankerbedrag |
| dat een vooruitbetaalkorting het landingsmechanisme is | de hoogte van die korting |
| dat een scheve splitsing past bij aanloopkosten | de verhouding |
| dat factuurmomenten op het betaalritme afgestemd worden | de momenten |
| dat een aangekondigde verhoging echte schaarste is | of er een verhoging komt, en wanneer |

En de tweede reden, die zwaarder weegt: het ICP van de eerste klant leidt zijn
ondergrens voor het aantal modellen af uit de eigen instapprijs. Zonder deze
splitsing kon deze laag via de prijs een diskwalificatiecriterium verschuiven, en
dat verbiedt grens 6.

**Wat de laag wél mag: signaleren dat er iets ontbreekt.** Zit er geen anker in de
structuur, of geen prikkel om vooruit te betalen, dan is dat een bevinding en die
gaat terug naar Ward. De laag zet er nooit zelf een.

---

## 1. Ankeren

Een anker is het bedrag waartegen het streefbedrag zich verhoudt. **Het anker is het
gespreksbedrag, niet het streefbedrag.**

De beweging: anker boven het doelbedrag, en land via een vooruitbetaalkorting op het
bedrag dat je werkelijk wilde. De korting doet het landingswerk, zodat het
streefbedrag als uitkomst van een keuze voelt en niet als vraagprijs.

**Geef de verkopende partij een vertrekbedrag waar die zich comfortabel bij voelt,
en zet het anker daarboven.** Een verkoper die zijn eigen anker niet gelooft, laat
het in het gesprek vallen voordat de klant erom vraagt, en dan is het anker een
korting geworden zonder dat er iets voor is teruggekomen.

### Controleer eerst of er al een anker is

Vóór je voorstelt er een te maken: kijk of de bestaande structuur er al één heeft.
Een zichtbaar "vanaf"-bedrag is een anker, ook als het nooit als zodanig bedoeld
is, en ook als het op één plek staat en op een andere niet.

Een bestaand anker dat niemand als anker beschouwt, is bovendien niet afgestemd op
de gesprekken die eromheen gevoerd worden. Waar dat bij een klant het geval is,
staat bij het activeringsblok in `clients/<klant>/gtm/config.md`.

## 2. Betaalsplitsing

**Scheef, met meer vooraf dan de gelijke verdeling.** Reden: de aanloopkosten zitten
aan het begin. Een gelijke verdeling laat de leverancier het eerste deel
voorfinancieren terwijl daar juist het werk zit.

**Bij bezwaar op de vooruitbetaling: vraag wat men vandaag kan doen, en verreken de
rest in het maandbedrag.** Niet het totaal verlagen. Dat is dezelfde regel als bij
de verlaging na een nee: verander de betaalvorm, niet de prijs van hetzelfde. Zie
[`20-aanbodsequentie.md`](20-aanbodsequentie.md), sectie 3.

De vraag "wat kan er vandaag wel" is het hele instrument. Hij verplaatst het gesprek
van of naar hoeveel, en hij levert informatie op over waar de echte grens zit.

## 3. Korting voor volledige vooruitbetaling tijdens een lopend betaalplan

Een klant die al in termijnen betaalt, kan het restant in één keer afkopen tegen een
korting. Dit haalt administratie en inningsrisico weg en levert liquiditeit op.

De hoogte van die korting is een klantbesluit.

## 4. Factuurmomenten op het betaalritme van de klant

Stem de factuurdatum af op het moment waarop bij de klant geld binnenkomt. Dat
verlaagt mislukte inningen, en een mislukte inning is duurder dan hij lijkt: hij
kost administratie, hij is een aanleiding om de afweging opnieuw te maken, en bij
een terugkerend aanbod is dat precies het moment waarop iemand opzegt.

**Uitgesloten:** de cyclus zo kiezen dat er per jaar een extra factuur ontstaat. Zie
[`90-uitsluitingen.md`](90-uitsluitingen.md), punt 2. Een langere cyclus verlaagt
opzeggingen en mag; een cyclus van 28 dagen om op dertien facturen te komen niet.

## 5. Een aangekondigde prijsverhoging

Dit is de **enige** vorm van tijdsdruk die deze laag mag gebruiken, en hij mag alleen
onder één voorwaarde: **de verhoging gaat werkelijk door.**

Een aangekondigde verhoging die niet doorgaat, is een geconstrueerde deadline, en die
is uitgesloten ([`90-uitsluitingen.md`](90-uitsluitingen.md), punt 3). Het verschil
zit niet in de formulering maar in wat er daarna feitelijk gebeurt, en dat is
achteraf voor iedereen te zien.

Twee dingen die daarbij horen:

- **Of er een verhoging komt en per wanneer, is een klantbesluit.** De laag mag het
  niet voorstellen als drukmiddel bij een lopend gesprek.
- **De datum valt onder grens 1**, met dit verschil: dit is een datum die de klant
  zelf beheerst, dus hij is aan de bron te verifiëren zodra hij is vastgelegd. Is hij
  niet vastgelegd, dan bestaat hij niet en mag hij niet genoemd worden.

---

## Wat hier niet in staat

- **Het ankerbedrag, de vooruitbetaalkorting, de splitsingsverhouding en de vraag of
  er een verhoging wordt aangekondigd.** Vier open vragen voor de besluitenlijst in
  fase D, met Ward en Robbert als eigenaar.
- **Prijsbepaling.** [`domains/gtm/CLAUDE.md`](../../CLAUDE.md), sectie 1, plaatst
  die buiten dit domein, en deze laag verruimt dat niet.
- **De bestaande prijsstructuur van een klant.** Die wordt gelezen, niet gewijzigd,
  en de vindplaats staat in `clients/<klant>/gtm/config.md`.

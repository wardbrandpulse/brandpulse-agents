# Qrius, profiel

Domeinonafhankelijk. Wat hier staat blijft staan als er later een tweede domein
bij komt.

- **Aangemaakt:** 2026-07-29
- **Laatst bijgewerkt:** 2026-08-03
- **Actieve domeinen:** `gtm`
- **Relatie tot Brandpulse:** eigen SaaS-product van het bureau, geen externe
  opdrachtgever. Dat maakt Qrius de eerste klantcontext in deze repo, met
  dezelfde isolatieregels als elke andere.

> **Herkomst van de feiten hieronder.** Alles wat niet als `TODO` is gemarkeerd,
> is afgeleid uit de productrepository `wardbrandpulse/QRius` (stand
> 2026-07-29). Dat is een betrouwbare bron over het product, maar geen bron over
> de markt, de doelgroep of de commercie. Waar dat onderscheid ertoe doet, staat
> het erbij.

---

## Wat doet de klant

Qrius is een platform voor het digitale productpaspoort (DPP). Merken en
producenten beheren in een portaal hun productgegevens en compliance-informatie;
op het product komt een QR-code die een consument naar een publieke
productpagina brengt. De QR-codes zijn GS1 Digital Link, wat betekent dat
dezelfde code ook in de reguliere GS1-infrastructuur werkt.

Kern van de propositie: aankomende EU-verplichtingen rond productinformatie
maken een digitaal paspoort nodig; Qrius levert dat als product in plaats van
als project.

Naast het portaal en de consumentenpagina is er een marketingsite met een
demopagina en een partnerpagina, beide met een boekingsmodule voor een gesprek.

## Markt en sectoren

Het platform werkt sectorspecifiek: compliance-velden verschillen per sector en
worden per sector apart gedefinieerd. In het product bestaan onder meer
sectoren voor kleding en textiel, food, persoonlijke verzorging, huis en tuin,
bouw, zorg en mobiliteit, waaronder een aparte sector voor e-bikes.

Voor de GTM-taxonomie zijn de relevante `segment`-waarden:

| Taxonomiewaarde | Betekenis bij Qrius |
|---|---|
| `ebike` | e-bikemerken, importeurs en fabrikanten, eerste focus |
| `retail` | non-food merken en retail |
| `food` | levensmiddelenproducenten |
| `bureau` | partners en bureaus, het indirecte kanaal |

`TODO: door Ward in te vullen`, welke van deze vier op dit moment actief bewerkt
worden en in welke volgorde.

## Stakeholders

| Naam | Rol | Beslist over | Bereikbaar via |
|---|---|---|---|
| Ward Disco | Brandpulse, eigenaar en productverantwoordelijke | alles | w.disco@brandpulse.nl |
| `TODO` | | | |

`TODO: door Ward in te vullen`, wie er verder meekijkt of meebeslist, en wie
namens Qrius de gesprekken voert.

## Tone of voice

Vastgelegd in het Qrius-brandbook 1.0. Twee duidelijk verschillende registers,
en dat onderscheid is geen detail maar een regel in het product:

- **Zakelijk, richting merken en producenten.** Sober, wit-dominant, geen
  gradients, één huisletter (Poppins). Dit is het register van het portaal en
  van vrijwel alle GTM-communicatie richting merken.
- **Levendiger, richting consumenten.** Meer kleur en beeld toegestaan. Dit
  register is voor de pagina na een QR-scan en niet voor outbound.

Verder:

- Nederlands in klantcommunicatie.
- Primaire kleur is Qrius Paars (`#3f1e32`) op wit, met signaalkleuren als
  accent, nooit als grote vlakken.
- **Geen lange streepjes** (em dash, en dash) in enige tekst. Dat is een harde
  afspraak in de productrepository en geldt ook voor GTM-teksten. Gebruik een
  komma, een punt, een dubbele punt of haakjes.
- **Één uitzondering op de huisletter, vastgesteld 2026-08-03.** Het
  GTIN-bijschrift onder een geëxporteerde QR-code staat in Roboto Mono 400.
  Reden: dat is een functioneel label op de verpakking van een klant en geen
  Qrius-communicatie, en het moet leesbaar blijven op circa 1 mm cijferhoogte,
  waar een proportionele letter dichtloopt. Dit is de enige plek waar een tweede
  letter mag. Het is geen vrijbrief voor Roboto Mono in enige andere uiting, en
  dus ook niet in GTM-materiaal. Vastgelegd in `CLAUDE.md` van de
  productrepository; het brandbook zelf staat buiten die repo en heeft dezelfde
  regel nog nodig.

Wat er onder een QR-code komt te staan, is de **EAN/GTIN zoals opgeslagen, niet
meer en niet minder** (vastgesteld 2026-08-03). Geen `(01)`-prefix zoals de GS1
HRI-notatie voorschrijft, geen opvulling naar 14 cijfers, geen label ervoor. Dat
de QR-inhoud de op 14 gepadde variant bevat en het bijschrift niet, is bedoeld.
Relevant voor GTM zodra er beeldmateriaal met een QR-code in outbound of op de
site gebruikt wordt.

`TODO: door Ward in te vullen`, of er woorden zijn die Qrius bewust wel of niet
gebruikt in commerciële teksten. Het brandbook regelt de vorm, niet de
woordkeuze.

## Gevoeligheden

**Afgeleid uit het product, nog te bevestigen:**

- **Regelgeving niet als juridisch advies presenteren.** Qrius helpt bij het
  voldoen aan verplichtingen, maar bepaalt niet wat er juridisch van iemand
  wordt geëist. Het verschil tussen die twee moet in elke tekst overeind
  blijven.
- **Deadlines alleen noemen als ze aan de bron geverifieerd zijn.** Een datum
  die verkeerd blijkt, kost meer geloofwaardigheid dan hij aan urgentie
  oplevert. Zie de openstaande verificatie in
  `../../domains/gtm/memory/sectors/ebike.md`.
- **Geen toezeggingen over functionaliteit die nog niet in het product zit.**
  Het product markeert onderdelen expliciet als "binnenkort beschikbaar";
  diezelfde grens hoort in commerciële teksten te gelden.

`TODO: door Ward in te vullen`, concurrenten die niet bij naam genoemd worden,
klanten die niet als referentie gebruikt mogen worden, en onderwerpen die
intern gevoelig liggen.

## Bronnen en toegang

| Bron | Wat het oplevert | Stand |
|---|---|---|
| repository `wardbrandpulse/QRius` | product, sectoren, brandbook, marketingsite | 2026-07-29 |
| `TODO` | pijplijn en gesprekken | |
| `TODO` | bestaande verkoopmaterialen | |

Geen sleutels of wachtwoorden in dit bestand.

## Wat we nog niet weten

- Wie er binnen een doelgroepbedrijf beslist. Er zijn nog geen gesprekken
  vastgelegd.
- Of de propositie in het zakelijke register al getoetst is bij de doelgroep.
- Welke sectoren commercieel prioriteit hebben, los van wat het product
  ondersteunt.

`TODO: door Ward in te vullen`

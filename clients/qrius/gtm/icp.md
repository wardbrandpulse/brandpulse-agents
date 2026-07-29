# Qrius, ICP

Wie is een goede prospect, en net zo belangrijk: wie niet.

- **Laatst bijgewerkt:** 2026-07-29
- **Onderbouwing:** geen. Nul gesprekken vastgelegd, nul gewonnen deals
  geanalyseerd. **Dit hele bestand is een werkhypothese**, geen profiel.

> Alles hieronder is afgeleid uit het product en uit de gekozen taxonomie, niet
> uit waarnemingen bij de doelgroep. Gebruik het om een eerste lijst te bouwen,
> niet om een uitspraak te onderbouwen. Zodra er twintig verzonden mails per
> segment zijn (de drempel uit
> [`significantie-drempels.md`](../../../domains/gtm/playbooks/significantie-drempels.md)),
> wordt dit bestand herschreven op basis van wat er terugkwam.

---

## Bedrijfsprofiel

- **Sector(en):** `ebike` als eerste, daarna `retail` en `food`. `bureau` is een
  ander type prospect en heeft een eigen profiel nodig, zie onderaan.
- **Kenmerk dat er in elk geval toe doet:** de partij is
  verantwoordelijk voor productinformatie richting de eindklant, dus een merk,
  producent of importeur, en niet een partij die andermans producten
  doorverkoopt zonder eigen merknaam. `Afgeleid uit het product, niet getoetst.`
- **Omvang:** `TODO: door Ward in te vullen`. Er is geen enkele aanwijzing over
  welke bedrijfsomvang past. Groot genoeg om een compliance-vraagstuk te hebben,
  klein genoeg om niet zelf te bouwen, is een plausibele vorm maar geen bekend
  feit.
- **Geografie:** `TODO`. De relevante regelgeving is Europees; of het
  bewerkingsgebied Nederland, de Benelux of breder is, is een keuze en geen
  gegeven.
- **Aantal producten of SKU's:** `TODO`. Dit is waarschijnlijk relevant, omdat
  het aantal paspoorten met het assortiment meeschaalt.

## Rollen

Volledig ongetoetst. Ingevuld met wat aannemelijk is, expliciet als aanname.

| Rol | Functietitels | Waar ze op letten |
|---|---|---|
| Beslisser | `TODO` | |
| Beïnvloeder | `TODO` | |
| Gebruiker | `TODO`, aannemelijk: degene die productdata beheert | werklast, hoeveel handmatig werk erbij komt |
| Blokkeerder | `TODO`, aannemelijk: IT of de partij die zegt dat een bestaand systeem dit al doet | koppelingen, dubbele registratie |

De blokkeerder is hier expliciet benoemd omdat een van de vastgestelde
bezwaarcodes `doet-leverancier-al` is. Dat bezwaar komt zelden van de beslisser.

## Trigger

Wat maakt dat ze **nu** zoeken en niet volgend jaar. Concrete gebeurtenissen,
geen eigenschappen.

- Een naderende verplichting met een datum. Voor `ebike` is dat de aanname rond
  het batterijpaspoort, zie
  [`sectors/ebike.md`](../../../domains/gtm/memory/sectors/ebike.md). **Nog niet
  bevestigd en de datum is nog niet geverifieerd.**
- `TODO`, andere triggers: een klant of retailer die erom vraagt, een audit, een
  nieuwe productlijn, een exportmarkt met eigen eisen.

## Diskwalificatie

Wanneer iemand géén ICP is, ook al lijkt het erop.

- `TODO: door Ward in te vullen.` Deze sectie is nu leeg en dat is een
  probleem: zonder diskwalificatiecriteria groeit de lijst ten koste van de
  kwaliteit van de instroom, en is stap 2 van
  [`kanaal-diagnose.md`](../../../domains/gtm/playbooks/kanaal-diagnose.md)
  niet uit te voeren. Dit is het eerste veld dat gevuld moet worden, nog voor de
  positieve criteria.

## Waar ze te vinden zijn

`TODO: door Ward in te vullen.` Per bron noteren hoeveel partijen hij oplevert
en hoe actueel hij is, zodat vooraf duidelijk is of de segmentdrempel van 20
verzonden haalbaar is.

## Bewijs

Geen. n=0 gesprekken, n=0 verzonden, n=0 deals.

Conform de bewijslastregel in de root-`CLAUDE.md` mag er op basis van dit
bestand geen enkele kwantitatieve uitspraak worden gedaan over wie wel of niet
past.

## Aannames

| Aanname | Waarom we het vermoeden | Wat het bevestigt of weerlegt |
|---|---|---|
| Merken en producenten zijn de koper, niet retailers | het product legt de verantwoordelijkheid voor productinformatie bij de merkeigenaar | wie er in de gesprekken daadwerkelijk aan tafel zit |
| Een naderende deadline is de sterkste trigger | het is de enige harde datum die bekend is | of de deadline in replies genoemd wordt, of dat `te-vroeg` domineert |
| De blokkeerder zit bij IT of bij een bestaande leverancier | de bezwaarcode `doet-leverancier-al` bestaat niet voor niets | verdeling van bezwaarcodes na twintig replies |

## Apart: het segment `bureau`

Partners en bureaus zijn geen verkleinde versie van dit profiel maar een ander
type prospect: zij kopen niet voor zichzelf maar brengen klanten mee. Dit
bestand beschrijft ze nu niet.

`TODO: door Ward in te vullen`, of `bureau` een eigen ICP-beschrijving krijgt
of dat het kanaal voorlopig opportunistisch wordt behandeld.

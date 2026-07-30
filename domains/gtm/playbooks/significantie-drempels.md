# Significantiedrempels, wanneer wel en niet een uitspraak doen

Dit playbook bepaalt of een getal een conclusie mag dragen. Het geldt zodra er
een getal in de output staat.

De achterliggende regel staat in de root-`CLAUDE.md` (bewijslast). Hier staan de
drempels die binnen GTM gelden.

---

## 1. De drempels

| Soort uitspraak | Drempel | Eenheid |
|---|---|---|
| A/B-vergelijking tussen twee varianten | **100 clicks per variant** | clicks, per variant apart |
| Conclusie over een kanaal | **30 sessies per bron per week** | sessies, per `source`, per week |
| Outbound conclusie over een segment | **20 verzonden per segment** | verzonden mails, per `segment` |

Per variant, per bron, per segment. Niet in totaal. Twee varianten met samen 150
clicks halen de A/B-drempel niet als de verdeling 120 tegen 30 is: de tweede
variant haalt hem niet, dus de vergelijking mag niet.

### Aanvullende regels bij deze drempels

- **Niet optellen om een drempel te halen.** Twee segmenten samenvoegen tot 20
  verzonden beantwoordt de vraag "werkt dit bij deze twee samen", niet de
  gestelde vraag. Dat mag, maar dan verandert de conclusiezin mee.
- **Niet stapelen over weken.** De kanaaldrempel is per week omdat een kanaal
  per week beoordeeld wordt. Vier weken van 10 sessies is geen week van 40. Is
  de vraag over een langere periode, dan is de drempel evenredig hoger en wordt
  dat in de output benoemd.
- **De drempel wordt vóór het kijken vastgesteld**, niet erna. Achteraf de
  drempel kiezen die net gehaald wordt, is de drempel omzeilen.
- **De eenheid moet ergens gedefinieerd staan.** "30 sessies" betekent niets
  zolang niet vastligt wat een sessie is. Elk project legt die definitie vast in
  `clients/<klant>/<domein>/config.md`, met het getal erbij. Een drempel in een
  ongedefinieerde eenheid is geen drempel.
- **Verandert die definitie, dan zit er een breuk in de reeks.** Vergelijk geen
  periode van voor het omslagmoment met een periode erna, reken geen trend over
  dat moment heen, en toets de drempel alleen binnen een periode die geheel aan
  één kant valt. De breuk hoort in "Wat ik niet kon vaststellen", niet in een
  voetnoot. Rijen van vóór een omslag zijn vaak alleen bruikbaar als boven- of
  ondergrens; noteer welke van de twee.
- **Harde conversies halen deze drempels vrijwel nooit.** Geboekte afspraken en
  gewonnen deals komen in aantallen voor waar geen percentage over te berekenen
  valt. Rapporteer ze als absolute aantallen met de context erbij. Een
  conversiepercentage over minder dan 20 waarnemingen wordt niet berekend, ook
  niet als het rekenkundig kan.

---

## 2. Wat er gebeurt onder de drempel

Onder de drempel mag er nog steeds gerapporteerd worden, maar anders:

1. **Benoem wat opvalt**, in woorden. Wat is de waarneming, in welke richting.
2. **Label het expliciet als anekdotisch.** Letterlijk dat woord, in de output,
   bij die uitspraak. Niet in een voetnoot en niet één keer bovenaan.
3. **Geen percentages, geen ranglijst, geen "beter dan".** Geen grafiek die
   suggereert dat er een trend is.
4. **Geef de afstand tot de drempel** en de schatting wanneer die bij het
   huidige tempo gehaald wordt.

### De schatting berekenen

```
resterend      = drempel - huidige n
tempo          = gemiddelde n per week over de laatste volle weken
weken te gaan  = resterend / tempo, naar boven afgerond
```

Noem altijd de aanname erbij: dat het tempo gelijk blijft. Is het tempo nul of
dalend, dan is het antwoord "bij het huidige tempo wordt de drempel niet
gehaald", en dat is zelf de bevinding.

### Formulering onder de drempel

> Anekdotisch, n=8 verzonden in dit segment tegen een drempel van 20. Van de
> acht kwamen er twee terug met dezelfde vraag over de deadline. Dat is een
> signaal om in de gaten te houden, geen conclusie over het segment. Bij het
> huidige tempo van circa 4 verzonden per week is de drempel over 3 weken
> gehaald.

### Formulering boven de drempel

> n=142 clicks op variant A en n=118 op variant B, beide boven de drempel van
> 100. A ligt 31 procent hoger.

De n staat er ook boven de drempel bij. Altijd. Zie de bewijslastregel.

---

## 3. Wanneer een drempel niet genoeg is

Een gehaalde drempel is een minimum, geen bewijs. Een uitspraak wordt ook
afgezwakt of ingetrokken als:

- de twee varianten niet in dezelfde periode liepen, want dan verklaart de
  periode mogelijk het verschil;
- er halverwege iets anders veranderde (lijst, pagina, aanbod, prijs);
- het verschil kleiner is dan de ruis tussen twee eerdere metingen van hetzelfde;
- de meting zelf onbetrouwbaar is, bijvoorbeeld opens die door
  privacyproxies van mailclients worden opgeblazen, of een periode waarin de
  labeling gebroken was.

Bij twijfel over de meting gaat `kanaal-diagnose.md` stap 0 voor: eerst
vaststellen of de meting klopt, dan pas of het verschil klopt.

---

## 4. Drempels wijzigen

Deze getallen zijn werkafspraken, geen natuurwetten. Ze mogen verlaagd of
verhoogd worden, maar:

- niet per analyse en niet per campagne;
- alleen via `memory/decisions.md`, met datum en reden;
- nooit met terugwerkende kracht op een lopende analyse.

Een drempel die per geval wordt bijgesteld, is geen drempel.

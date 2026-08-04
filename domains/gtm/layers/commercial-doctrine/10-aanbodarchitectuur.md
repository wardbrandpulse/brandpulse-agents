# Aanbodarchitectuur

> **Bewijslast: n=0.** Externe, niet-gevalideerde kennis. Zie
> [`LAYER.md`](LAYER.md).

Hoe een aanbod in elkaar zit. Niet welk aanbod, en niet tegen welk bedrag: dat is
klantcontext (grens 8).

Actief op stand `standaard` en hoger.

---

## 1. De waardeformule, alle vier variabelen expliciet

```
                 droomuitkomst  ×  slaagkans
waarde  =  ------------------------------------------
                 doorlooptijd   ×  moeite
```

**Opdracht bij elk aanbod: score alle vier variabelen expliciet en benoem welke
het knelpunt is.** Niet drie van de vier, en niet "het aanbod is sterk". Zonder
alle vier is niet te zien waar de winst zit, en dan wordt er standaard aan de
droomuitkomst gewerkt omdat dat de makkelijkste is om over te praten.

| Variabele | De vraag | Vermenigvuldigt of deelt |
|---|---|---|
| droomuitkomst | wat wil de klant werkelijk bereiken, in zijn woorden | omhoog |
| slaagkans | hoe waarschijnlijk vindt **hij** dat hij dat haalt | omhoog |
| doorlooptijd | hoe lang tot het resultaat merkbaar is | omlaag |
| moeite | wat moet hij er zelf voor doen en laten | omlaag |

Twee dingen die vaak fout gaan:

- **Slaagkans is de perceptie van de koper, niet onze inschatting.** Wij kunnen
  99 procent zeker zijn en de koper 30. Alleen zijn getal telt.
- **Moeite is niet hetzelfde als prijs.** Een aanbod waarvoor de klant intern
  drie afdelingen moet meekrijgen, is duur in moeite ook als het goedkoop is in
  geld. Bij een categorie die tussen afdelingen in valt, is moeite vaak de echte
  noemer.

Bij een lage slaagkans in de perceptie van de koper is risico-omkering (sectie 4)
het instrument. Bij hoge moeite is het probleemontleding (sectie 2).

## 2. Probleemontleding

De bron van pakketinhoud **en** van bezwaarafhandeling, en dat is dezelfde
oefening in plaats van twee.

Lijst drie dingen uit, zo concreet dat er een handeling bij past:

1. **Alles wat de klant ná aankoop moet doen.** Elke stap, ook de stappen die
   wij normaal niet meerekenen omdat ze "vanzelf gaan".
2. **Alles wat hij moet laten.** Wat er stopt, verschuift of opnieuw moet worden
   afgesproken. Dit wordt bijna altijd vergeten en het is vaak de zwaarste post.
3. **Elke angst en elke aarzeling.** Wat er misgaat in zijn hoofd voordat hij ja
   zegt.

**Los elk item apart op.** Niet in één beweging en niet met één argument. Per item
is er precies één van drie uitkomsten: wij doen het, wij maken het kleiner, of het
blijft staan en dan is dat het antwoord op een bezwaar dat gaat komen.

Die derde uitkomst is de reden dat dit ook bezwaarafhandeling is: een bezwaar dat
je in deze oefening tegenkomt, komt later in een gesprek terug. Zie
[`70-gespreksstructuur.md`](70-gespreksstructuur.md).

## 3. Aanvullende waarde, en wanneer je die inzet

Aanvullende waarde is wat er bovenop het kernaanbod komt. Drie inzetmomenten, en
het moment doet het werk:

| Moment | Waarvoor | Kenmerk |
|---|---|---|
| achter de hand | voor één specifiek bezwaar | wordt pas genoemd als dat bezwaar valt |
| als afsluiter | bij zichtbare twijfel op het beslismoment | één stuk, niet een reeks |
| na de aankoop | als verrassing, om de start goed te laten voelen | nooit vooraf belooft |

**Nooit alles vooraf opsommen.** Een volledige lijst vooraf haalt de werking uit
alle drie: het achter-de-hand-stuk is dan al gebruikt zonder dat er een bezwaar
was, de afsluiter is niet meer nieuw, en de verrassing is een verwachting
geworden. Een lange lijst vooraf verlaagt bovendien de geloofwaardigheid van het
kernaanbod: als er zoveel bij moet, is het aanbod zelf blijkbaar niet genoeg.

Op stand `scherp` wordt de achter-de-hand-waarde harder ingezet. Dat betekent
eerder en gerichter, niet uitgebreider vooraf.

## 4. Risico-omkering: drie vormen, en waar ze op mogen rusten

Risico-omkering verplaatst risico van de koper naar ons. Het is het instrument bij
een lage slaagkans in de perceptie van de koper.

| Vorm | Wat het is |
|---|---|
| onvoorwaardelijk | wij nemen het risico zonder voorwaarden aan de kant van de klant |
| voorwaardelijk | wij nemen het risico als de klant aan een benoemde voorwaarde voldoet |
| prestatiegebonden | de vergoeding of voortzetting hangt aan een afgesproken uitkomst |

**Het vierde type uit de bron, de anti-garantie, is uitgesloten.** Zie
[`90-uitsluitingen.md`](90-uitsluitingen.md), punt 4.

### Waar een garantie op mag rusten

Dit is de kant van grens 2 die zegt wat er wél mag, en hij staat hier omdat een
grens verbiedt en doctrine invult.

- **Op proces of inspanning.** Wat wij doen, hoe snel, hoe vaak, met welke
  betrokkenheid.
- **Nooit op een wettelijke uitkomst.** Geen "u bent compliant", geen "u voldoet
  aan de verplichting", geen belofte over hoe een controle afloopt. Zie
  [`99-grenzen.md`](99-grenzen.md), grens 2.
- **Alleen als levering het kan nakomen.** Een garantie die levering niet waar kan
  maken is geen commercieel instrument maar een schuld. Toets hem vóór hij in een
  aanbod staat, bij de mensen die hem moeten uitvoeren.

**Termijnen, bedragen en voorwaarden van een garantie staan in
`clients/<klant>/`.** De laag beschrijft de vorm en mag melden dat er nog geen
garantie is vastgesteld. Hij stelt er geen vast (grens 8).

## 5. Naamgeving: resultaat, termijn, drager

Een aanbod heet naar wat het oplevert, niet naar wat het is.

```
<resultaat>  +  <termijn>  +  <drager>
```

- **Resultaat:** de uitkomst in de woorden van de koper.
- **Termijn:** wanneer die merkbaar is. Alleen een termijn die levering haalt.
- **Drager:** de vorm waarin het geleverd wordt.

Een naam die het formaat beschrijft in plaats van de uitkomst, verkoopt het
formaat. Dezelfde regel geldt voor weggevers, zie
[`30-weggever.md`](30-weggever.md), stap 6.

**Twee grenzen bij de naam.** De termijn is een belofte, dus hij valt onder
sectie 4 hierboven: alleen als levering hem kan nakomen. En de toon van de naam
valt onder het klantprofiel, niet onder deze laag (grens 4). Een naam die
overtreffende trappen over het eigen product gebruikt, haalt het plafond niet,
ongeacht hoe goed hij converteert.

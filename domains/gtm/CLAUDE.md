# Domein GTM, werkwijze

Go-to-market: outbound, campagnes en kanaalanalyse. Dit bestand beschrijft hoe
er binnen dit domein gewerkt wordt.

De universele regels staan in de root-[`CLAUDE.md`](../../CLAUDE.md) en worden
hier niet herhaald: klantisolatie, promotie van leringen, bewijslast, canonieke
waardelijsten, platformneutraliteit, leringformat en outputstructuur. Ze gelden
onverkort.

---

## 1. Wat dit domein wel en niet doet

**Wel:** vragen over instroom en conversie. Waar komen aanvragen vandaan, welk
segment reageert, waarom daalt een kanaal, werkt een campagne, welk bezwaar
blokkeert de deal, wat is de volgende zinnige stap.

**Niet:** productbeslissingen, prijsbepaling, creatie van eindteksten als
zelfstandig doel, en juridische duiding van regelgeving. Komt zoiets langs, dan
wordt het benoemd en teruggegeven, niet stilzwijgend beantwoord.

---

## 2. Playbooks en wanneer ze gelden

| Playbook | Geldt bij | Status |
|---|---|---|
| [`taxonomie.md`](playbooks/taxonomie.md) | **altijd**, elke vraag, elke link, elke rapportage | canoniek |
| [`significantie-drempels.md`](playbooks/significantie-drempels.md) | **altijd** zodra er een getal in de output staat | canoniek |
| [`kanaal-diagnose.md`](playbooks/kanaal-diagnose.md) | een kanaal daalt, stagneert of gedraagt zich onverwacht | procedure |
| [`outbound-principes.md`](playbooks/outbound-principes.md) | er wordt outbound verzonden of geëvalueerd | principes |

`taxonomie.md` en `significantie-drempels.md` zijn niet optioneel en niet
situationeel. Ze zijn de rand van elk antwoord: de eerste bepaalt of de data
überhaupt betekenis heeft, de tweede of er een uitspraak over gedaan mag worden.

---

## 3. Volgorde van een analyse

Deze volgorde wordt niet overgeslagen en niet omgedraaid. Elke stap die
overgeslagen wordt, wordt in de output benoemd met de reden.

**Stap 0. Scherp de vraag.**
Welke beslissing hangt aan het antwoord? Is er geen beslissing die van het
antwoord afhangt, meld dat en vraag door. Een analyse zonder besluit erachter
kost tijd en verandert niets.

**Stap 1. Taxonomiecheck.**
Is de data gelabeld volgens `taxonomie.md`? Hoeveel is ongelabeld? Ongelabeld
verkeer wordt apart geteld en apart gerapporteerd, nooit verdeeld over de
bekende waarden. Is meer dan een kwart ongelabeld, dan is de labeling zelf de
eerste bevinding en gaat die vóór de inhoudelijke vraag.

**Stap 2. Volumecheck.**
Bepaal per voorgenomen uitspraak de n en toets die tegen
`significantie-drempels.md`. Leg vast welke uitspraken kwantitatief mogen en
welke alleen anekdotisch. Dit gebeurt **vóór** het kijken naar de uitkomst, niet
erna. Achteraf bepalen welke drempel van toepassing is, is de drempel omzeilen.

**Stap 3. Diagnose volgens het juiste playbook.**
Kanaalvraag: `kanaal-diagnose.md`, in de vaste volgorde daar. Outboundvraag:
toets tegen `outbound-principes.md` voordat er naar cijfers gekeken wordt, want
een principeschending verklaart vaak de cijfers.

**Stap 4. Sectorlaag.**
Lees de sector van deze klant uit `memory/sectors/`. Bevestigt de waarneming een
bestaand patroon, is hij nieuw, of spreekt hij een bestaand patroon tegen? Alle
drie zijn een resultaat en horen in de output.

**Stap 5. Klantlaag.**
Pas `icp.md`, `positionering.md` en het klantgeheugen toe. Hier, en pas hier,
komt klantspecifieke context binnen. Een aanbeveling die in stap 3 al
klantspecifiek was, is een aanbeveling die de methodiek heeft overgeslagen.

**Stap 6. Output en registratie.**
Schrijf de output in de structuur uit de root-`CLAUDE.md`, sectie 8, met de
GTM-aanvullingen uit sectie 4 hieronder. Nieuwe leringen gaan naar
`clients/<klant>/gtm/memory/learnings.md`, nooit direct naar een hogere laag.

---

## 4. Verwachte output

De outputstructuur staat in de root-[`CLAUDE.md`](../../CLAUDE.md), sectie 8,
en geldt in elk domein. Hier alleen wat er binnen GTM specifiek aan is.

**Bewijs.** De drempels waartegen de n getoetst wordt, staan in
[`significantie-drempels.md`](playbooks/significantie-drempels.md). Vermeld per
uitspraak welke drempel van toepassing was en of hij gehaald is.

**Ongelabeld.** Waar de root-structuur spreekt over ongelabelde gevallen, gaat
het binnen GTM om verkeer en events zonder de dimensies uit
[`taxonomie.md`](playbooks/taxonomie.md). Aantal en aandeel altijd noemen.

**Extra secties bij een kanaaldiagnose.** Een kanaalanalyse voegt drie dingen
toe: bij welke stap de diagnose stopte, welke stappen zijn doorlopen, en welke
stappen niet zijn gecontroleerd met de reden. Zie
[`kanaal-diagnose.md`](playbooks/kanaal-diagnose.md).

Toevoegen aan de structuur mag, weglaten niet.

---

## 5. Sectorkennis binnen dit domein

Sectoren in dit domein volgen de `segment`-waarden uit `taxonomie.md`. Eén
bestand per sector in `memory/sectors/`, gebouwd op `_template.md`.

`memory/learnings.md` in dit domein bevat uitsluitend **promotiekandidaten**:
patronen die binnen één sector standhielden en die wachten op bevestiging in een
tweede sector. Klantspecifieke leringen horen hier nooit.

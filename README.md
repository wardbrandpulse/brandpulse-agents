# brandpulse-agents

Gedeeld werkgeheugen en vastgelegde werkwijze van de agents die Brandpulse
inzet. Twee assen, strikt gescheiden: **domein** is de methodiek, **klant** is de
context.

Begin bij [`CLAUDE.md`](CLAUDE.md). Daar staan de regels die overal gelden,
waaronder de klantisolatieregel en de promotieregel voor leringen.

## Structuur

```
CLAUDE.md                       universele regels, domeinonafhankelijk
README.md
memory/
  decisions.md                  architectuur- en methodiekbesluiten met datum
domains/
  gtm/                          go-to-market: outbound, campagne, kanaalanalyse
    CLAUDE.md                   werkwijze binnen dit domein
    agents/                     leeg in fase 1
    playbooks/                  methodiek, klantonafhankelijk
    memory/
      learnings.md              promotiekandidaten, cross-sector
      sectors/                  sectorkennis, geanonimiseerd
clients/
  _template/                    kopieer dit voor een nieuw klantproject
  qrius/                        eerste klantproject
    profiel.md                  domeinonafhankelijk
    gtm/                        alles wat met go-to-market te maken heeft
```

## Een nieuw klantproject toevoegen

1. Kopieer `clients/_template/` naar `clients/<naam>/`.
2. Verwijder de domeinsubmappen die niet van toepassing zijn.
3. Vul `profiel.md` en `<domein>/config.md`. Laat leeg wat je niet weet.
4. Klaar. Er verandert niets buiten deze map.

## Een nieuw domein toevoegen

1. Maak `domains/<naam>/` met `CLAUDE.md`, `playbooks/`, `memory/` en `agents/`.
2. Voeg per klant die in dit domein bediend wordt een submap
   `clients/<klant>/<naam>/` toe.
3. Leg het besluit vast in `memory/decisions.md`.
4. Raak de bestaande domeinen niet aan.

## Status

Fase 1A: repo-scaffold, geheugenlagen, taxonomie. Er zijn bewust nog geen
agents, geen routing en geen orchestrator. Zie `memory/decisions.md` voor de
besluiten daarachter.

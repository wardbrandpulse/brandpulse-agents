#!/usr/bin/env bash
#
# Controleert of de laag `commercial-doctrine` echt verwijderbaar is.
#
# Verwijderbaarheid is een belofte zolang niemand hem test. Dit script maakt er
# een controle van. Het test twee beweringen, en het faalt op elke andere
# verwijzing dan de twee die bij ontwerp zijn toegestaan.
#
#   ./infra/laag-check.sh
#
# BEWERING 1, onvoorwaardelijk
#   Geen enkel bestand onder domains/ buiten de laag verwijst naar de laag.
#   Alleen de laag verwijst naar buiten, nooit omgekeerd. Dit is de bewering die
#   de methodiek verwijderbaar houdt.
#
# BEWERING 2
#   De enige verwijzing van buiten is het activeringsblok in
#   clients/qrius/gtm/config.md. Precies een treffer. Nul treffers is ook fout,
#   want dan is de laag niet geactiveerd te krijgen. Een tweede treffer in dat
#   zelfde bestand is fout, want dan is er een verwijzing bijgekomen die de
#   verwijderprocedure niet opruimt.
#
# TWEE UITZONDERINGEN, bij ontwerp en niet verborgen
#   memory/decisions.md      Besluiten worden nooit verwijderd, ze vervallen met
#                            datum. Deze verwijzing blijft dus per definitie
#                            achter na verwijdering, en dat is de bedoeling.
#   infra/laag-check.sh      Dit script zelf. Het bestaat uitsluitend om deze
#                            laag te controleren en wordt bij verwijdering
#                            meeverwijderd (stap 3 van de verwijderprocedure).
#
#   Beide staan hieronder in de uitvoer, zodat ze zichtbaar zijn in plaats van
#   stil weggefilterd. Een uitzondering die je niet ziet, is een gat.
#
# Exitcode 0 = beide beweringen gehaald, 1 = minstens een probleem.

set -u

# Vanuit de repo-root werken, zodat het script ook uit een andere map werkt.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

LAAG_DIR="domains/gtm/layers/commercial-doctrine"
ACTIVERING="clients/qrius/gtm/config.md"
BESLUITEN="memory/decisions.md"
DIT_SCRIPT="infra/laag-check.sh"

# Waaraan je een verwijzing naar deze laag herkent: de slug en de Nederlandse
# naam, met en zonder trema. Bewust NIET op "layers/" alleen: dat is een
# verwijzing naar het laagmechanisme en niet naar deze laag, en die mag blijven
# staan als er ooit een tweede laag komt.
PATROON='commercial-doctrine|commerci(ë|e)le doctrine'

echo "Laagcheck: commercial-doctrine"
echo "Repo-root: $ROOT"
echo

# Alle treffers ophalen, buiten de laag zelf en buiten .git.
TREFFERS="$(grep -rInE "$PATROON" . \
  --exclude-dir=.git \
  | grep -v "^\./${LAAG_DIR}/" \
  || true)"

fail=0

toon() {
  # $1 = label, $2 = treffers (mag leeg zijn)
  printf '%s\n' "$1"
  if [ -z "$2" ]; then
    printf '  geen\n'
  else
    printf '%s\n' "$2" | sed 's|^\./|  |'
  fi
  printf '\n'
}

# ── Bewering 1 ────────────────────────────────────────────────────────────
DOMEIN="$(printf '%s\n' "$TREFFERS" | grep "^\./domains/" || true)"
toon "BEWERING 1  verwijzingen onder domains/ buiten de laag (verwacht: geen)" "$DOMEIN"
if [ -n "$DOMEIN" ]; then
  echo "  FOUT: een domeinbestand verwijst naar de laag. De laag is dan niet"
  echo "        te verwijderen zonder dat bestand aan te passen."
  echo
  fail=1
fi

# ── Bewering 2 ────────────────────────────────────────────────────────────
ACT="$(printf '%s\n' "$TREFFERS" | grep "^\./${ACTIVERING}:" || true)"
ACT_N="$(printf '%s' "$ACT" | grep -c . || true)"
toon "BEWERING 2  verwijzingen in ${ACTIVERING} (verwacht: precies 1)" "$ACT"
if [ "$ACT_N" -eq 0 ]; then
  echo "  FOUT: geen activeringsblok gevonden. Zonder die regel is de laag niet"
  echo "        aan te zetten en is de standtabel niet vindbaar."
  echo
  fail=1
elif [ "$ACT_N" -gt 1 ]; then
  echo "  FOUT: ${ACT_N} treffers in plaats van 1. Elke extra verwijzing is een"
  echo "        plek die de verwijderprocedure niet opruimt."
  echo
  fail=1
fi

# ── Uitzonderingen, zichtbaar en niet weggefilterd ────────────────────────
BESL="$(printf '%s\n' "$TREFFERS" | grep "^\./${BESLUITEN}:" || true)"
toon "TOEGESTAAN  ${BESLUITEN} (besluiten worden nooit verwijderd)" "$BESL"

ZELF="$(printf '%s\n' "$TREFFERS" | grep "^\./${DIT_SCRIPT}:" || true)"
ZELF_N="$(printf '%s' "$ZELF" | grep -c . || true)"
printf 'TOEGESTAAN  %s (dit script, %s treffers, wordt meeverwijderd)\n\n' \
  "$DIT_SCRIPT" "$ZELF_N"

# ── Alles wat hierbuiten valt ─────────────────────────────────────────────
REST="$(printf '%s\n' "$TREFFERS" \
  | grep -v "^\./domains/" \
  | grep -v "^\./${ACTIVERING}:" \
  | grep -v "^\./${BESLUITEN}:" \
  | grep -v "^\./${DIT_SCRIPT}:" \
  | grep -v '^$' \
  || true)"
toon "OVERIG      verwijzingen elders (verwacht: geen)" "$REST"
if [ -n "$REST" ]; then
  echo "  FOUT: verwijzing op een plek die de verwijderprocedure niet kent."
  echo "        Voeg hem toe aan de procedure of haal hem weg."
  echo
  fail=1
fi

# ── Bestaat de laag nog wel ───────────────────────────────────────────────
if [ ! -d "$LAAG_DIR" ]; then
  echo "OPMERKING: ${LAAG_DIR} bestaat niet. Is de laag verwijderd, dan hoort"
  echo "           alleen ${BESLUITEN} nog een treffer te geven."
  echo
fi

if [ "$fail" -eq 0 ]; then
  echo "RESULTAAT: beide beweringen gehaald. De laag is verwijderbaar met de"
  echo "           vijf stappen uit ${LAAG_DIR}/LAYER.md, sectie 7."
else
  echo "RESULTAAT: minstens een probleem, zie hierboven. Zolang dit faalt is"
  echo "           verwijderbaarheid een belofte en geen eigenschap."
fi
exit "$fail"

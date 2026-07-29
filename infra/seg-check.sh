#!/usr/bin/env bash
#
# Controleert per route of de campagneparameters een deploy overleven, met name
# `seg`. Draai dit tegen een echte omgeving, niet alleen lokaal: middleware,
# trailing-slash-normalisatie, canonical rewrites en edge-configuratie kunnen
# query-parameters strippen, en dat gebeurt zonder foutmelding.
#
#   ./seg-check.sh https://qrius.id
#   ./seg-check.sh https://<preview>.vercel.app          # zie opmerking hieronder
#
# Preview-deploys met Vercel Deployment Protection geven op elke route een 302
# naar vercel.com/sso-api. Zet er dan een geldige _vercel_share-token achter of
# draai het script tegen productie:
#
#   SHARE=xxxxx ./seg-check.sh https://<preview>.vercel.app
#
# Exitcode 0 = alles behouden, 1 = minstens een route stript de parameters.

set -u
BASE="${1:-http://127.0.0.1:3002}"
SHARE="${SHARE:-}"
Q='utm_source=outbound&utm_medium=email&seg=ebike&utm_campaign=test-2607&utm_content=magazine'
[ -n "$SHARE" ] && Q="${Q}&_vercel_share=${SHARE}"

# Elke publieke route, plus de geconfigureerde redirects uit next.config.js,
# plus twee trailing-slash-varianten, plus een onbekende route.
ROUTES=(
  / /barcode-naar-qr /cases /contact /cookies /demo /digitaal-productpaspoort
  /faq /get-qrius /kennisbank /kennisbank/wat-is-het-digitaal-productpaspoort
  /over-ons /platform /privacy /toepassingen /voor-consumenten /voor-merken
  /voor-partners /voorwaarden
  /over-qrius /voor-merkhouders /voor-bureaus /voor-bureaus/iets
  /demo/ /get-qrius/
  /bestaat-niet
)

printf '%-52s %-6s %-9s %s\n' ROUTE STATUS SEG DETAIL
printf '%-52s %-6s %-9s %s\n' '----------------------------------------------------' '------' '---------' '------'

fail=0
for r in "${ROUTES[@]}"; do
  hdr=$(curl -s -D - -o /dev/null "${BASE}${r}?${Q}")
  status=$(printf '%s' "$hdr" | awk 'NR==1{print $2}')
  loc=$(printf '%s' "$hdr" | tr -d '\r' | awk -F': ' 'tolower($1)=="location"{print $2}')

  if printf '%s' "$loc" | grep -q 'sso-api'; then
    printf '%-52s %-6s %-9s %s\n' "$r" "$status" "GEBLOKT" "Deployment Protection, zet SHARE="
    fail=1
  elif [ "$status" = "200" ]; then
    printf '%-52s %-6s %-9s %s\n' "$r" "$status" "BEHOUDEN" "geen redirect"
  elif [ "$status" = "404" ]; then
    printf '%-52s %-6s %-9s %s\n' "$r" "$status" "nvt" "404, geen stille redirect"
  elif [ -n "$loc" ]; then
    if printf '%s' "$loc" | grep -q 'seg=ebike'; then
      printf '%-52s %-6s %-9s %s\n' "$r" "$status" "BEHOUDEN" "-> $loc"
    else
      printf '%-52s %-6s %-9s %s\n' "$r" "$status" "GESTRIPT" "-> $loc"
      fail=1
    fi
  else
    printf '%-52s %-6s %-9s %s\n' "$r" "$status" "ONBEKEND" "geen Location-header"
    fail=1
  fi
done

echo
if [ "$fail" -eq 0 ]; then
  echo "RESULTAAT: seg overleeft op alle geteste routes."
else
  echo "RESULTAAT: minstens een route levert een probleem op, zie hierboven."
  echo "Een route die stript, is een route waar campagneverkeer ongelabeld binnenkomt."
fi
exit "$fail"

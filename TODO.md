# TODO

Openstaande punten, gegroepeerd op eigenaar, één regel per punt. De
onderbouwing staat in `memory/decisions.md`, in `infra/` en in
`clients/<klant>/<domein>/config.md`. Die bestanden zijn de bron; dit bestand is
alleen de aantekening dat een punt openstaat, met de plek waar het verhaal staat.

Afgeronde punten blijven staan als `[x]` met de datum erachter. Wegstrepen mag
niet: een punt dat spoorloos verdwijnt, wordt later opnieuw bedacht. Komt er een
punt bij dat een beslissing van Ward vraagt, dan wordt dat aan hem gemeld en niet
stil toegevoegd.

## Ward

- [ ] Cloudflare-instellingen doorgeven aan Dennis
      ([`infra/brandpulse-gtm.md`](infra/brandpulse-gtm.md))
- [ ] Naamkwestie `qrius.id` vs `qrius.io`: besluit nemen vóór het eerste
      drukwerk bij een klant
- [ ] PR #1115 in de productrepo (cookiebeleid, artikel 5 Campagne-attributie)
      mergen of sluiten. Zolang hij openstaat, beschrijft het gepubliceerde
      beleid de attributie niet
      ([`clients/qrius/gtm/config.md`](clients/qrius/gtm/config.md))

## Dennis

- [ ] Rate limiting rule op `qrius.id`, zone-instellingen in
      [`infra/brandpulse-gtm.md`](infra/brandpulse-gtm.md)
- [ ] Controleren of het DNS-record voor `www` op Proxied staat, anders doet de
      rate limiting rule niets
      ([`infra/brandpulse-gtm.md`](infra/brandpulse-gtm.md))

## Extern (jurist)

- [ ] Is Brandpulse verwerker voor Qrius B.V. voor de GTM-meetdata, en moet
      Brandpulse in de verwerkerslijst op `/cookies` en `/privacy`
      ([`clients/qrius/gtm/config.md`](clients/qrius/gtm/config.md))
- [ ] Valt een campagnelabel met een bewaartermijn van 90 dagen onder de
      toestemmingsvrijstelling, of is er een consentbanner nodig
      ([`clients/qrius/gtm/config.md`](clients/qrius/gtm/config.md))

## Claude Code, lage prioriteit

- [ ] `seg-check.sh` op `www.qrius.id` draaien voor de resterende 22 routes
      ([`infra/brandpulse-gtm.md`](infra/brandpulse-gtm.md))
- [ ] Speelgoedregel verifiëren voordat M1 voor die sector gebruikt wordt
      ([`clients/qrius/gtm/memory/learnings.md`](clients/qrius/gtm/memory/learnings.md))
- [ ] Regex-fix inhoudsopgave op `/cookies` en `/privacy`: de zijbalk strippet
      het artikelnummer met `/^Artikel \d+, /` (komma) terwijl de titels een
      dubbele punt gebruiken, dus hij matcht nooit. Staat nog open op `main`,
      raakt de GTM-tracking niet (productrepo, twee bestanden)

## Nog geen eigenaar

Deze staan in [`clients/qrius/gtm/config.md`](clients/qrius/gtm/config.md) onder
"Openstaand" zonder eigenaar. Toewijzen is een beslissing van Ward, dus ze staan
hier zonder naam in plaats van bij iemand die ze niet heeft aangenomen.

- [ ] Accounts registreren in `gtm_accounts` zodra er gesprekken lopen; de
      ingest vult die tabel niet
- [ ] Verzenddomein kiezen en opwarmen voordat er outbound vertrekt
- [ ] Cal.com-eventtypes vastleggen in `config.md`
- [ ] Vastleggen waar de pijplijn wordt bijgehouden
- [ ] `magazine_view` op de magazinepagina zetten zodra die pagina bestaat; de
      component staat klaar

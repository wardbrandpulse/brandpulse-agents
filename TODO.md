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
- [ ] Regex-fix inhoudsopgave op `/cookies` en `/privacy`, indien nog niet
      gedaan (onderbouwing staat niet in deze repo, zie de productrepo)

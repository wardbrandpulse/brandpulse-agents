# Migratie- en deployproces

Geldt voor elke database die deze repo bezit. Op dit moment is dat er één:
[`brandpulse-gtm.md`](brandpulse-gtm.md).

Dit bestand bestaat om een concrete reden. De aanleiding om de GTM-data in een
eigen project te zetten, was mede dat de migratiehistorie op de productiedatabase
van Qrius gedrift is: wat er in de repo staat en wat er in de database staat,
zijn daar uit elkaar gelopen. Een schone historie blijft alleen schoon als het
proces vastligt. Dus ligt het hier vast, vanaf de eerste migratie in plaats van
achteraf.

---

## 1. De repo is de bron, niet de database

- Elke schemawijziging begint als bestand in `supabase/migrations/`.
- De bestandsnaam is `JJJJMMDDUUMMSS_korte_naam.sql`, in snake_case.
- Een versieprefix wordt **nooit** hergebruikt. Twee bestanden met dezelfde
  versie breken het afspelen van de historie.
- Een toegepast migratiebestand wordt **nooit** aangepast. Een fout wordt
  gerepareerd met een nieuwe migratie erbovenop, niet door de geschiedenis te
  herschrijven.
- Wat in de database staat en niet in de repo, bestaat officieel niet. Wordt er
  toch rechtstreeks iets gewijzigd, dan is de eerstvolgende taak dat alsnog als
  migratie vastleggen.

## 2. Elke migratie is idempotent

`create table if not exists`, `create index if not exists`, en bij het wijzigen
van bestaande objecten een expliciete bestaanscontrole. Reden: een migratie die
half is toegepast en opnieuw wordt gedraaid, moet doorlopen in plaats van
afbreken. Zonder die eigenschap is elke gedeeltelijke mislukking handwerk, en
handwerk is precies hoe historie gaat driften.

## 3. Volgorde bij een wijziging

1. **Waardelijsten eerst.** Verandert er iets aan een gesloten lijst, dan gaat
   dat eerst naar `domains/<domein>/playbooks/`. De datalaag loopt daarachteraan,
   nooit andersom. Zie de root-[`CLAUDE.md`](../CLAUDE.md), sectie 5.
2. **Migratiebestand schrijven** in `supabase/migrations/`.
3. **Toepassen** op de database.
4. **Verifiëren** met een query die aantoont dat het er staat: tabel aanwezig,
   constraint aanwezig, index aanwezig. Niet vertrouwen op het uitblijven van
   een foutmelding.
5. **Beveiligingscontrole** draaien en de uitkomst lezen, niet alleen starten.
6. **Committen.** Het migratiebestand en de bijbehorende documentatiewijziging
   in dezelfde commit, zodat de repo op elk punt in de historie klopt.

Stap 3 en stap 6 horen bij elkaar. Toepassen zonder committen levert een
database op die voorloopt op de repo, en dat is de drift waar dit bestand tegen
bedoeld is.

## 4. Er zijn geen preview-omgevingen

Dit project heeft geen gekoppelde repository die per pull request een
preview-database opzet. Dat betekent twee dingen:

- Er is geen vangnet dat een migratie eerst elders afspeelt. Lees de SQL voor
  je hem toepast.
- Er is ook geen mechanisme dat stilletjes een andere historie opbouwt dan die
  in de repo. Dat is de winst van deze opzet, en die winst verdampt zodra iemand
  buiten dit proces om iets wijzigt.

## 5. Wat niet in de repo komt

Sleutels, tokens, connectiestrings met wachtwoord, en de inhoud van tabellen.
Wel: projectverwijzingen, tabelnamen, en de namen van de omgevingsvariabelen.
Zie de platformneutraliteitsregel in de root-`CLAUDE.md`, sectie 6.

## 6. Terugdraaien

Er zijn geen down-migraties. Een wijziging terugdraaien is een nieuwe migratie
die het tegenovergestelde doet, met een eigen versie en een eigen bestand.

Bij een gesloten waardelijst geldt daarbij de regel uit de root-`CLAUDE.md`:
een waarde die niet meer gebruikt wordt, wordt niet verwijderd maar gemarkeerd
als vervallen. Een waarde uit een check-constraint halen terwijl er rijen met
die waarde bestaan, breekt de tabel bij de eerstvolgende validatie.

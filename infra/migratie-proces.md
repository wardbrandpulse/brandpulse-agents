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
- **De versieprefix komt uit de database en niet uit je eigen klok.** Het
  toepassen stempelt zijn eigen tijdstempel; zie stap 3b hieronder.
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
   - **3b. Trek de bestandsnaam gelijk met de geregistreerde versie.** Het
     toepassen stempelt zijn eigen tijdstempel, niet die uit je bestandsnaam.
     Vraag na het toepassen de migratiehistorie van de database op en hernoem het
     bestand naar de versie die daar staat.

     Dit is vast gedrag en geen incident: het gebeurt bij elke migratie. Sla je
     het over, dan staat er in de repo een andere versie dan in de database, en
     dat is precies de drift waar dit bestand tegen bedoeld is.

     **Hernoemen mag hier omdat het bestand nog niet gecommit is.** Ná de commit
     geldt de regel uit sectie 1 en wordt een fout gerepareerd met een nieuwe
     migratie erbovenop, niet door de bestandsnaam alsnog te wijzigen. Dit is dus
     een stap vóór stap 6 en geen uitzondering op sectie 1.
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

- Er is geen **automatisch** vangnet dat een migratie eerst elders afspeelt. Lees
  de SQL voor je hem toepast.
- Er is ook geen mechanisme dat stilletjes een andere historie opbouwt dan die
  in de repo. Dat is de winst van deze opzet, en die winst verdampt zodra iemand
  buiten dit proces om iets wijzigt.

### Wel een handmatig vangnet, en dat draait bij elke nieuwe migratie

De idempotentie-eis uit sectie 2 en de bron-eis uit sectie 1 zijn niets waard als
niemand ze toetst. Er is geen CI die het doet, dus het is een stap in dit proces.

**Speel de hele historie af op een tijdelijke lokale database**, niet op een
gehost project. Dat kost niets, raakt geen enkele omgeving en duurt een paar
minuten. Twee rondes:

1. **Vanaf nul.** Alle migraties in volgorde op een verse database, met afbreken
   bij de eerste fout. Dit toetst of de historie nog repliceerbaar is.
2. **Nog een keer.** Dezelfde reeks op diezelfde database. Dit toetst
   idempotentie van het geheel, niet alleen van het nieuwste bestand.

Vergelijk daarna het resultaat met de echte database, en doe dat **op namen en niet
alleen op aantallen**: constraintnamen naast elkaar leggen. Tellingen kunnen
toevallig kloppen.

**Twee dingen om te weten voor je het naspeelt.** De rollen `anon` en
`authenticated` komen van Supabase en bestaan niet op een vanilla PostgreSQL; maak
ze eerst aan, als bootstrap van de omgeving en niet als onderdeel van een
migratie. En de lokale major-versie hoeft niet gelijk te zijn aan die van het
project; voor schemareplay is dat geen probleem, maar noteer welke versie je
gebruikte.

**Leg de uitkomst vast met een datum** in het bestand van de betrokken database,
zie [`brandpulse-gtm.md`](brandpulse-gtm.md). Zonder datum is de vraag over een
jaar weer of dit ooit getoetst is; mét datum is de vraag hoe oud de garantie is.

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

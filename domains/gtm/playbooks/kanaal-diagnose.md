# Kanaaldiagnose, de vaste volgorde

Bij een kanaal dat daalt, stagneert of zich onverwacht gedraagt. De volgorde is
vast en wordt niet omgedraaid.

**Volume, dan kwaliteit van instroom, dan landingspagina, dan aanbod.**

Voorafgegaan door stap 0: klopt de meting eigenlijk wel.

Reden voor een vaste volgorde: zonder volgorde springt iedereen meteen naar de
creative. Dat is de duurste hypothese om te toetsen, de traagste om te
weerleggen en zelden de oorzaak. De stappen hieronder staan op volgorde van
goedkoop en snel uitsluitbaar naar duur en traag.

---

## Stopregel

Verklaart een stap de daling, dan **stopt de diagnose daar**. Niet doorlopen
naar de volgende stap, niet alsnog naar de creative kijken, niet vier
aanbevelingen tegelijk doen. Eén oorzaak repareren en opnieuw meten is sneller
dan vier tegelijk veranderen en daarna niet weten welke het was.

Verklaart een stap de daling gedeeltelijk, dan wordt dat expliciet zo
opgeschreven ("verklaart naar schatting de helft") en gaat de diagnose door.

---

## Stap 0. Is de daling echt

**Wat je vaststelt:** meet je nog hetzelfde als vorige week.

Controleer, in deze volgorde:

- **Labeling.** Is het aandeel ongelabeld verkeer gestegen? Zo ja, dan is er
  waarschijnlijk geen kanaal gedaald maar een label weggevallen, en verschuift
  het volume alleen van de ene emmer naar de andere. Zie `taxonomie.md`,
  sectie 4.
- **Meting.** Is er een deploy, een cookiebanner-wijziging of een
  scriptwijziging geweest rond het moment van de daling? Een weggevallen
  meetscript ziet er exact uit als een ingestort kanaal.
- **Periode.** Vergelijk je gelijke periodes? Een week met een feestdag,
  een vakantieperiode of een korte maand levert een daling op die volgend
  jaar terugkomt.
- **Drempel.** Haalt het kanaal de kanaaldrempel uit
  `significantie-drempels.md` überhaupt? Onder 30 sessies per bron per week is
  "daling" geen vaststelling maar ruis.

**Uitkomst als het hier misgaat:** het meetprobleem repareren en pas daarna
opnieuw kijken. Geen inhoudelijke aanbevelingen doen op basis van gebroken data.

---

## Stap 1. Volume

**Wat je vaststelt:** komen er minder mensen binnen, of komen er evenveel
mensen binnen die zich anders gedragen.

- Aantal sessies per `source` per week, over minimaal vier weken, zodat een
  trend te onderscheiden is van één slechte week.
- Is de daling in één bron of over alle bronnen? Over alle bronnen tegelijk
  wijst vaker op stap 0 dan op een echt kanaalprobleem.
- Is er aan de invoerkant iets veranderd: minder verzonden, minder budget,
  minder posts, een campagne die is afgelopen, een advertentie die is
  afgekeurd?

**Als het hier misgaat:** het volume is de oorzaak en het antwoord ligt aan de
invoerkant. Niet aan de pagina, niet aan de tekst. Stop hier.

**Als het hier klopt:** het volume is gelijk gebleven, dus de daling zit in wat
er ná binnenkomst gebeurt. Ga door.

---

## Stap 2. Kwaliteit van de instroom

**Wat je vaststelt:** komen dezelfde mensen binnen als eerst.

- Verdeling over `segment` binnen deze bron: is die verschoven? Evenveel
  bezoekers uit een ander segment gedraagt zich als een daling, maar is een
  verschuiving.
- Verdeling over `asset`: klikken mensen op iets anders dan eerst?
- Gedragssignalen op het eerste contactpunt: haken ze direct af, of gaan ze
  door en stokt het verderop?
- Bij outbound: is de lijst veranderd? Een nieuwe lijst met een andere
  samenstelling is een andere instroom, ook al is het aantal gelijk.

**Als het hier misgaat:** de instroom is van samenstelling veranderd. De
aanbeveling gaat over targeting en lijstopbouw, niet over de pagina. Stop hier.

**Als het hier klopt:** dezelfde mensen komen binnen en haken alsnog af. Ga
door.

---

## Stap 3. Landingspagina

**Wat je vaststelt:** doet de pagina nog wat hij deed.

- Is de pagina veranderd sinds de daling? Datum van de laatste wijziging naast
  de datum van de knik leggen.
- Werkt hij technisch: laadtijd, mobiel, formulier, boekingsmodule. Een
  boekingsmodule die op mobiel niet laadt, geeft precies het patroon van
  "bezoek gelijk, conversie weg".
- Wordt de belofte uit de bron waargemaakt? Een link die een magazine belooft en
  op een algemene pagina landt, is een mismatch tussen bron en pagina, geen
  paginaprobleem op zich.
- Blijft de taxonomie behouden bij doorklikken en bij een boeking? Breekt hij
  hier, dan is de conversie er misschien wel maar niet zichtbaar.

**Als het hier misgaat:** repareren, en de meting per stap opnieuw opbouwen
voordat er conclusies over het kanaal volgen. Stop hier.

**Als het hier klopt:** de pagina werkt en sluit aan. Ga door.

---

## Stap 4. Aanbod

**Wat je vaststelt:** wil de bezoeker nog wat er aangeboden wordt.

Dit is de laatste stap omdat het de duurste is om te veranderen en de traagste
om te toetsen.

- Is het aanbod zelf gewijzigd: prijs, voorwaarden, wat je precies krijgt, de
  drempel om ja te zeggen?
- Is de urgentie veranderd? Een deadline die verder weg is komen te liggen of
  onduidelijk is geworden, haalt de reden weg om nu te reageren. Bij
  regelgedreven markten is dit een reële oorzaak en geen zwaktebod.
- Wat zeggen de bezwaren? Bezwaarcodes over dezelfde periode erbij pakken. Een
  verschuiving naar "te vroeg" wijst op urgentie; een verschuiving naar "doet
  leverancier al" wijst op de concurrerende oplossing; "wat is dit eigenlijk"
  wijst op de categorie en niet op het aanbod.
- Is er een alternatief bij gekomen, of is een bestaand alternatief
  goedkoper of makkelijker geworden?

**Als het hier misgaat:** dit is een propositievraag en geen campagnevraag. Hij
gaat terug naar `positionering.md` en naar Ward, niet naar een snelle
tekstwijziging.

---

## Pas hierna: creative

Zijn stap 0 tot en met 4 allemaal doorstaan, dan pas is de creative aan de
beurt: beeld, onderwerpregel, koptekst, opbouw.

En dan met de A/B-drempel uit `significantie-drempels.md`, dus minimaal 100
clicks per variant. Wordt die drempel niet gehaald, dan is creative testen op
dit volume geen zinnige besteding van tijd en is de eerlijke conclusie: hier
kunnen we op dit moment niets over vaststellen.

---

## Wat de output bevat

Naast het gewone outputformat uit `domains/gtm/CLAUDE.md`:

- bij welke stap de diagnose is gestopt en waarom;
- welke stappen zijn doorlopen en wat daar de meting was;
- welke stappen **niet** zijn gecontroleerd, met de reden (meestal: de vorige
  stap verklaarde het al).

Een diagnose zonder vermelding van de stap waar hij stopte, is niet
reproduceerbaar en dus niet bruikbaar als bewijs.

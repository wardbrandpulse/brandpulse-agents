# Outbound-principes

Vaste principes, klantonafhankelijk. Ze gelden bij elk outboundtraject, in elk
segment.

Dit zijn **structurele** principes: ze gaan over hoe de keten in elkaar zit en
wat er kapotgaat als je het anders doet. Het zijn geen performanceclaims. Een
uitspraak in de trant van "deze onderwerpregel werkt beter" hoort niet in dit
bestand maar in het klant- of sectorgeheugen, met een n erbij.

---

## 1. PDF's linken, niet bijvoegen

Een bijlage gaat mee als bijlage; een link gaat mee als klik.

**Waarom.** Twee redenen, en beide tellen even zwaar.

- Bijlagen verhogen de kans dat de mail door een spamfilter wordt tegengehouden
  of in een aparte map belandt. Dan is niet de PDF het probleem maar de hele
  mail.
- Een bijlage geeft geen signaal. Een link wel: de klik is de eerste meetbare
  interesse die er is. Bij een bijlage weet je alleen dat je iets verstuurd hebt.

De link draagt de volledige taxonomie mee (zie principe 3), anders is de klik
wel zichtbaar maar niet toewijsbaar.

---

## 2. Verzenden vanaf een apart, opgewarmd domein

Outbound gaat nooit vanaf het primaire bureaudomein of het primaire
klantdomein. Er is een apart verzenddomein dat is opgewarmd voordat er volume
overheen gaat.

**Waarom.** De reputatie van een verzenddomein is niet per campagne
terugdraaibaar. Gaat het mis, dan raakt dat ook de gewone mail: offertes,
facturen, antwoorden aan bestaande klanten. Dat risico staat niet in verhouding
tot de winst van één campagne.

Praktisch, en dit is minimum:

- opwarmen voordat er volume overheen gaat, oplopend in plaats van in één keer
  aan;
- authenticatie op orde voordat de eerste mail vertrekt;
- bouncepercentage bewaken **voordat** het volume verder omhoog gaat, niet
  erna. Een harde bounce betekent direct van de lijst af.

Welk domein dat per project is, staat in `clients/<klant>/gtm/config.md`.

---

## 3. Elke uitgaande link draagt de volledige taxonomie

Iedere link in iedere outboundmail bevat `segment`, `source` en, als er een
asset is, `asset`. Conform [`taxonomie.md`](taxonomie.md): `source` in
`utm_source`, het kanaaltype in `utm_medium` (bij outbound dus `email`), het
segment in `seg` en de asset in `utm_content`.

**Waarom.** Outbound is de enige bron waarbij je vooraf precies weet wie je
aanspreekt en waarom. Wordt dat niet meegegeven in de link, dan komt het bezoek
binnen als ongelabeld of als `direct`, en is die wetenschap definitief weg. Je
kunt hem later niet reconstrueren.

Dit is ook de reden dat de keten bij de boeking niet mag breken: een geboekte
afspraak zonder taxonomie maakt de hele voorafgaande reeks onverdeelbaar.

---

## 4. Bezwaren coderen bij elke reply

Elke reply krijgt een bezwaarcode, ook een positieve reply en ook een reply die
niet echt een bezwaar bevat. Naast de code wordt de letterlijke zinsnede
bewaard.

**Waarom.** Bezwaren zijn het enige rijke signaal dat outbound oplevert. Ze
komen in kleine aantallen binnen, ver onder elke drempel, dus ze tellen alleen
op als ze consistent gecodeerd zijn. Los onthouden ze niks; gecodeerd wordt na
twintig replies zichtbaar welk bezwaar het traject blokkeert.

De letterlijke zinsnede erbij, omdat de code de nuance wegpoetst en de nuance
later nodig is bij het herschrijven van de propositie.

De codelijst staat in [`taxonomie.md`](taxonomie.md), sectie 6, en geldt binnen
het hele domein. Nieuwe codes toevoegen gaat langs dezelfde route als nieuwe
taxonomiewaarden: eerst daar vastleggen, dan de datalaag, dan pas gebruiken.

---

## 5. Opens zijn geen signaal, replies wel

Openpercentages worden niet gebruikt als bewijs voor iets. Ze mogen genoteerd
worden, maar dragen geen conclusie.

**Waarom.** Privacybescherming in mailclients laadt afbeeldingen vooraf, ook als
de ontvanger de mail nooit ziet. Wat er gemeten wordt is deels de mailclient en
niet de mens. Het aandeel dat vertekend is, is niet bekend en verschilt per
ontvangerspopulatie, dus het is ook niet weg te rekenen.

Wat wel telt, in volgorde van sterkte: reply, klik, bounce. Een klik is een
handeling; een open is een aanname.

---

## 6. Volume verhogen is een aparte beslissing

Meer versturen is nooit de eerste conclusie bij tegenvallende resultaten, en
nooit een beslissing die en passant genomen wordt.

**Waarom.** Volume vermenigvuldigt wat er staat. Staat er iets dat niet werkt,
dan levert meer volume meer bewijs op dat het niet werkt, plus schade aan de
domeinreputatie en aan de lijst. Volume verhogen mag pas als de
segmentdrempel uit `significantie-drempels.md` gehaald is en de uitkomst
positief was, of als het expliciete doel is die drempel te halen. In dat tweede
geval is dat de conclusie: "we weten het nog niet, we sturen door om het te
weten te komen".

---

## Kandidaat-principes

Nog geen. Patronen die hierin thuis zouden kunnen komen, ontstaan eerst in
`clients/<klant>/gtm/memory/learnings.md` en klimmen via de promotieregel uit de
root-`CLAUDE.md`. Een principe belandt hier pas nadat het over twee sectoren
standhield.

;##### ------------------------------------------------------------------------
;##### 
;##### Konstanten.pbi
;##### 
;##### ------------------------------------------------------------------------

Structure Struktur_Spiel
  anzahl_spieler.b
  jahr.w
  spieler_am_zug.b
  restliches_land.l
  platzhalter.b[92]
EndStructure
Structure Struktur_Einheit
  name.s{16}
  angriff.l
  abwehr.l
  treffer_punkte_aktuell.l;sobald wert=0 einheit=tot
  schritte.l
  reichweite.l
  salven.l
  sold.l
  getoetet.l
  erfahrung.l
  titel.l
  spezial.l
  art.l ;1=held 0=normal
  bild.l
  wer_wird_angegriffen.b;welcher spieler
  treffer_punkte_maximal.l
  platzhalter.b[27]
EndStructure
Structure Struktur_Kriegsvorderung
  muehlen.l
  maerkte.l
  taler.l
  land.l
  sklaven.l
EndStructure
Structure Struktur_Spieler
  menschlich.b
  name.s{8}
  einwohner.l
  land.l
  taler.l
  korn.l
  geschlecht.b
  ruhm.b
  zufriedenheit.b
  landpreis.b
  kornpreis.b
  salzpreis.w
  bierpreis.w
  weinpreis.w
  waffenpreis.w
  maerkte.w
  muehlen.w
  kornspeicher.w
  lagerhaeuser.w
  schloss.b
  kathedrale.b
  lagerkapatitaet.l
  salz.l
  bier.l
  wein.l
  waffen.l
  steuern.b
  justiz.b
  asyl.b
  platzhalter1.b
  kornspeicherkapazitaet.l
  titel.w
  geburtenrate.w
  sterberate.w
  imigration.w
  emigration.w
  gewinne_mm.l;mühlen + märkte
  handelsbilanz.l
  gewinne_steuer.l
  gewinne_justiz.l
  ausgaben_militaer.l
  gewinne_zinsen.l
  gewinne_lagervermietung.l
  zauber.b
  erster_spielzug.b
  wohnort.b
  schloss_gebaut.b
  kathedrale_gebaut.b
  armeestaerke.l
  kornzuteilung.l
  ki_befoerderungsversuch.b
  platzhalter2.b[64]
  
  ;8 Einheiten -> geht nur von 0-7 ka warum
  Einheit.Struktur_Einheit[8]
  
  ;DIPLOMATIE
  ;hier ein speicherblock von 100 byte
  ;10 byte pro gegenspieler
  ;keine genaue aufteilung da die speicherverteilung von der aktion abhängt
  Diplomatie.b[100]
  Handelsvertrag.b[10];insgesammt 10 für jeden spieler; 0=nein 1=ja
  Friedensvertrag.w[10]
  Krieg_Gefuehrt.b[10]
  
  platzhalter3.b[60]
  
  Kriegsvorderung.Struktur_Kriegsvorderung[10]
  
  platzhalter4.b[600]
EndStructure
Structure Struktur_Zauber
  zauber.s
  genannt.s
EndStructure
Structure Struktur_Land
  name.s
  krieger.s
  vergeben.b
EndStructure
Structure Struktur_Vorraussetzung
  einwohner.l
  zufriedenheit.l
  land.l
  taler.l
  armee.l
  palast.l
  kathedrale.l
EndStructure
Structure Ereignisdaten
  
  Titel.s
  Text.s[3]
  Button.s
  Icon.i
  Window_Type.i
  
EndStructure

;wird sobald wie möglich ersetzt
Structure Krieg_Einheit
  spieler.b
  einheit.b
  angreifer.b
  mem.l
  x.l
  y.l
  schritte.b
EndStructure
Structure Kriegsforderung
  taler.l
  land.l
  sklaven.l
  muehlen.l
  maerkte.l
EndStructure

;Krieg
Structure AktionOutput
  CPU_Event.l
  Event_Gadget.l
  Schritte_Gesammt.b
  WindowX.l
  WindowY.l
  
EndStructure
Structure AktionInput
  spieler.l
  einheit.l
EndStructure
#Kaiser$="Kaiser V 0.80"
#Kaiser_Version=80<<24|10<<16|03<<8|02
;               V      YY     MM    TT
#spieler_size=2000;ergibt sich durch SizeOf(Struktur_Spieler)
#spiel_size=1000  ;ergibt sich durch SizeOf(Struktur_Spiel)

#TimeOut = 10 ; für waitwindowevent wegen später netzwerk

#img_button=19
#img_icon=86

Global ActiveGame
Global NextTurn

Global annale  = AllocateMemory(10000)
Global annale2 = AllocateMemory(10008)

Global krieg_speicher.i = AllocateMemory(100*(8*9+24))
Global Dim pheilenx(7)
Global Dim pheileny(7)
Global Dim pmanoeverx(7)
Global Dim pmanoevery(7)
Global Dim pangreifenx(7)
Global Dim pangreifeny(7)

Global Dim krieg_map.l(19,14)
Global Dim krieg_map_passierbar.l(19,14)
Global NewList Einheiten.Krieg_Einheit()
Global Dim Angreifer_Ort(4)

Global Dim spezial.s(105)
Global Dim eh_titel.s(3)
Global Dim ehicon.l(115,3)
Global miliz = AllocateMemory(100)

Global Dim muehle.point(9)
Global Dim markt.point(9)

Global Dim zauber.Struktur_Zauber(15)
Global Dim titel.s(10,1)
Global Dim land.Struktur_Land(9)

Global Dim Ereignis.Ereignisdaten(10)

Global Dim vorraussetzung.Struktur_Vorraussetzung(9)
Global Dim namen.s(9)

Global Dim spieler(9)
Global Dim Spielerdaten.struktur_spieler(9)
For x=0 To 9
  spieler(x)=@Spielerdaten(x)
Next

Global leer = AllocateMemory(#spieler_size)
Global spiel = AllocateMemory(#spiel_size)
Global mem1 = AllocateMemory(10*#spieler_size+#spiel_size+8)
Global mem2 = AllocateMemory(10*#spieler_size+#spiel_size+8)

Global *Game.Struktur_Spiel=spiel
Global MainWindow.i
Global MainImage.i
Global MainGadget.i

;##### Speichermap
;{
;  0 + 1 ;1=mensch 0=computer
;  1 +16 ;name
; 17 + 4 ;einwohner
; 21 + 4 ;land in ha
; 25 + 4 ;taler
; 29 + 4 ;korn
; 33 + 1 ;geschlecht 0=m 1=w
; 34 + 1 ;ruhm
; 35 + 1 ;zufriedenheit
; 36 + 1 ;landpreis
; 37 + 1 ;kornpreis
; 38 + 2 ;salzpreis
; 40 + 2 ;bierpreis
; 42 + 2 ;weinpreis
; 44 + 2 ;waffenpreis
; 46 + 2 ;märkte
; 48 + 2 ;kornmühlen
; 50 + 2 ;kornspeicher
; 52 + 2 ;lagerhäuser
; 54 + 1 ;schloss
; 55 + 1 ;kathedrale
; 56 + 4 ;lagerkapazität
; 60 + 4 ;salz
; 64 + 4 ;bier
; 68 + 4 ;wein
; 72 + 4 ;waffen
; 76 + 1 ;steuern
; 77 + 1 ;justiz
; 78 + 1 ;asyl
; 79 + 1 ;nicht vergeben
; 80 + 4 ;kornspeicherkapazität
; 84 + 2 ;titel
; 86 + 2 ;geburtenrate
; 88 + 2 ;sterberate
; 90 + 2 ;imigration
; 92 + 2 ;emigration
; 94 + 4 ;gewinne mühlen + mäkrte
; 98 + 4 ;handelsbilanz
;102 + 4 ;steuer
;106 + 4 ;justiz
;110 + 4 ;militär
;114 + 4 ;zinsen
;118 + 4 ;lagervermietung
;122 + 1 ;zauber
;123 + 1 ;erster spielzug
;124 + 1 ;land
;125 + 1 ;schloss gebuat
;126 + 1 ;kathedrale gebaut
;127 + 4 ;armeestärke
;131 + 4 ;kornzuteilung
;135 + 1 ;ki beförderungsversuch
;136 + 1 ;manöver abgehalten
;einheit
;200 +16;name
;216 + 4;angriff
;220 + 4;abwehr
;224 + 4;tp aktuell
;228 + 4;schritte
;232 + 4;reichweite
;236 + 4;salven
;240 + 4;sold
;244 + 4;getötet
;248 + 4;erfahrung
;252 + 4;titel
;256 + 4;spezial
;260 + 4;art 1=held 0=normal
;264 + 4;bild
;268 + 1;wen angreifen
;269 + 4;tp max
;einheit 8
;900

;{ diplomatie 1000
;1000 + 10 ;diplomatie player 0
;1010 + 10 ;diplomatie player 1
;1020 + 10 ;diplomatie player 2
;1030 + 10 ;diplomatie player 3
;1040 + 10 ;diplomatie player 4
;1050 + 10 ;diplomatie player 5
;1060 + 10 ;diplomatie player 6
;1070 + 10 ;diplomatie player 7
;1080 + 10 ;diplomatie player 8
;1090 + 10 ;diplomatie player 9
;1100 + 10 ;handelsvertrag
;1110 + 20 ;friedensvertrag
;1130 + 10 ;krieg geführt
;
;1200 + 200;kriegsvorderung
;}
;}


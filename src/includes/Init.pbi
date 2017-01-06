;##### ------------------------------------------------------------------------
;##### 
;##### Init.pbi
;##### 
;##### ------------------------------------------------------------------------

;#---------------------------------------------------------------------------------
;##### Grafik und Sound Initialisierung
;#---------------------------------------------------------------------------------

Global Dim icon(#img_icon)
Global Dim Wicon(#img_icon)
Global Dim button(#img_button)
Global Dim schloss(12)
Global Dim kathedrale(12)
Global korn1, korn2, krone, Map, info
Global krieger_verteilung, krieg_leer, krieg_voll
Global Dim Sounds(24)

Global Dim Fonts(20)

If InitSound() = 0
  MessageRequester("Soundkartenproblem","Die Soundkarte konnte nicht initialisiert werden !",#MB_ICONSTOP)
  End
EndIf

;#---------------------------------------------------------------------------------

;##### Zum Testen mit Angabe des Filenamens,
;##### Ansonsten ist Filename = Getcurrentdirectory()+"Data.pak"

;Filename.s = "D:\Projekt\MyEd\Data.pak"

Procedure.i Kaiser_LoadMedia(Filename.s = "")

  If Filename = ""
    Filename = GetCurrentDirectory()+"Data.pak"
  EndIf
  
  Protected Pack = OpenPack(Filename.s)
  
  If Pack
  
    For x=1 To #img_button
      Button(x) = CatchImage(#PB_Any,NextPackFile())
    Next x 
    For x=0 To #img_icon
      Icon(x) = CatchImage(#PB_Any,NextPackFile())
    Next x
    For x=0 To #img_icon
      WIcon(x) = CatchImage(#PB_Any,NextPackFile())
    Next x    
    Map     = CatchImage(#PB_Any,NextPackFile())
    info    = CatchImage(#PB_Any,NextPackFile())
    korn1   = CatchImage(#PB_Any,NextPackFile())
    korn2   = CatchImage(#PB_Any,NextPackFile())
    krone   = CatchImage(#PB_Any,NextPackFile())
  
    For x=0 To 12
      Schloss(x) = CatchImage(#PB_Any,NextPackFile())
    Next x
    For x=0 To 12
      Kathedrale(x) = CatchImage(#PB_Any,NextPackFile())
    Next x
    
    krieger_verteilung  = CatchImage(#PB_Any,NextPackFile())
    krieg_leer          = CatchImage(#PB_Any,NextPackFile())
    krieg_voll          = CatchImage(#PB_Any,NextPackFile())
    
    For x=1 To 24
      Sounds(x)=CatchSound(#PB_Any,NextPackFile())
    Next x
  ClosePack()
  Else
  
    MessageRequester("","Konnte MediaPack nicht laden !")
    End
    
  EndIf

EndProcedure
Procedure.i Kaiser_LoadFonts()
Fonts(0) = LoadFont(#PB_Any,"Comic Sans MS",9);,#PB_Font_Bold)
Fonts(10) = LoadFont(#PB_Any,"Comic Sans MS",9,#PB_Font_Bold)
Fonts(11) = LoadFont(#PB_Any,"Comic Sans MS",8,#PB_Font_Bold);für die kriegmap
Fonts(12) = LoadFont(#PB_Any,"Comic Sans MS",8);für die kriegmap
Fonts(13) = LoadFont(#PB_Any,"Comic Sans MS",7);für die kriegmap

SetGadgetFont(#PB_Default,FontID(Fonts(0)))
EndProcedure

;#---------------------------------------------------------------------------------

Kaiser_LoadMedia(Filename.s)
Kaiser_LoadFonts()


; anale und rekorde

If ReadFile(0,"rekorde")
  ReadData(0,annale2,Lof(0))
  CloseFile(0)
  UnpackMemory(annale2,annale)
EndIf

; positionen krieger manöver
; wird in der Window_Krieg_KampfVerteilung() gebraucht

Restore Positionen_Krieger_Heilen
For i=0 To 7 : Read.i pheilenx(i) : Read.i pheileny(i) : Next i
Restore Positionen_Krieger_Manoever
For i=0 To 7 : Read.i pmanoeverx(i) : Read.i pmanoevery(i) : Next i
Restore Positionen_Krieger_Angreifen
For i=0 To 7 : Read.i pangreifenx(i) : Read.i pangreifeny(i) : Next i

; Krieg Map
For x=0 To 19
  For y=0 To 14
    krieg_map(x,y)=54;alles auf grünfläche setzen
    ;ist eigentlich überflüssig da aus dem DataSection das map geladen wird
    ;sollte da ein fehler auftreten ist wenigstens alles grün :)
  Next
Next

; positionierung mühlen und märkte auf dem startscreen
Restore Positionen_Muehle
For i=1 To 6 : Read.i muehle(i)\x : Read.i muehle(i)\y : Next i
Restore Positionen_Markt
For i=1 To 7 : Read.i markt(i)\x : Read.i markt(i)\y : Next i

; zauber Spieler
Restore Zauber_Bezeichner
For i=0 To 11 : Read.s zauber(i)\zauber : Next i

; Titel Spieler
Restore Titel_Bezeichner
For i=0 To 10 : Read.s Titel(i,0) : Next i
For i=0 To 10 : Read.s Titel(i,1) : Next i

; Spezial Einheiten
spezial(0)="-"
spezial(1)="Lehrmeister"
spezial(2)="Heilkräfte"
spezial(3)="Finesse"
spezial(4)="Drachentöter"
spezial(5)="Drachenschild"
spezial(6)="Regeneration"
spezial(100)="Raserei"
spezial(101)="Vergiftete Klinge"
spezial(102)="Infektion"

; Titel Einheiten
Restore Titel_Einheiten_Bezeichner
For i=0 To 3 : Read.s eh_titel(i) : Next i

; Länder / Wohnorte
Restore Wohnort_Bezeichner
For i=0 To 9 : Read.s land(i)\name : Next i

; Vorraussetzung für die beförderung
Restore Victory
For i=0 To 9
  With vorraussetzung(i)
    Read.i \Einwohner : Read.i \zufriedenheit : Read.i \land : Read.i \taler
    Read.i \armee : Read.i \palast : Read.i \kathedrale
  EndWith
Next i

; Standartnamen für die Spieler
Restore Standard_Namen
For i=0 To 9 : Read.s namen(i) : Next i

; Ereignisverwaltung
Restore Ereignisse
For i=0 To 7
  With Ereignis(i)
    Read.s \Titel
    For x=0 To 2
      Read.s \Text[x]
      If \Text[x]
        \Window_Type+1
      EndIf
    Next x
    Read.s \Button : Read.i \Icon
  EndWith
Next i

; Zuordnung Bilder - Einheiten
ehicon(1,0)=4
ehicon(2,0)=5
ehicon(3,0)=6
ehicon(4,0)=7
ehicon(5,0)=8
ehicon(6,0)=9
ehicon(100,0)=42;wölfe
ehicon(101,0)=43;assesinen
ehicon(102,0)=44;wächter
ehicon(103,0)=45;kämpfer
ehicon(104,0)=46;bogenschützen
ehicon(105,0)=47;infantarie
ehicon(106,0)=48;kavallerie
ehicon(107,0)=49;artillerie
ehicon(108,0)=50;länder ritter
ehicon(109,0)=51;kreuzritter
ehicon(110,0)=62;vampir
ehicon(111,0)=85;miliz

; Standart Miliz
PokeS(miliz+ 0,"Miliz",16)
PokeL(miliz+16,1)
PokeL(miliz+20,1)
PokeL(miliz+24,2)
PokeL(miliz+28,1)
PokeL(miliz+32,1)
PokeL(miliz+36,0);salven
PokeL(miliz+40,0)
PokeL(miliz+44,0)
PokeL(miliz+48,0)
PokeL(miliz+52,0)
PokeL(miliz+56,0)
PokeL(miliz+60,0)
PokeL(miliz+64,111)
PokeB(miliz+68,-1)
PokeL(miliz+69,2)

; Speicherblöcke für Spieler und Spieldaten
For x=0 To 9 
  ;spieler(x)=AllocateMemory(#spieler_size)
  spieler(x)=@Spielerdaten(x)
Next

; IDE Options = PureBasic 4.40 (Windows - x86)
; CursorPosition = 47
; FirstLine = 27
; Folding = 0
; EnableXP
; CurrentDirectory = D:\Projekt\MyEd\
; CompileSourceDirectory
;##### ------------------------------------------------------------------------
;##### 
;##### Kaiser.pb Main-Programm
;##### 
;##### ------------------------------------------------------------------------

;##### ------------------------------------------------------------------------
;##### Vorbereitungen
;##### ------------------------------------------------------------------------

XIncludeFile "Make.pbi"

System_DefaultStartProgramm(".ksg","KaiserSaveGame","Kaiser Savegame",GetCurrentDirectory()+"kaiser.exe",GetCurrentDirectory()+"ksg.ico")

;##### ------------------------------------------------------------------------
;##### Main Window
;##### ------------------------------------------------------------------------

Procedure OpenMainWindow(LoadGame.s)
  
  Protected Flags.i = #PB_Window_ScreenCentered|#PB_Window_MinimizeGadget|#PB_Window_Invisible
  
  MainWindow = OpenWindow(#PB_Any,0,0,640,480,"Kaiser",Flags)
  
  MainImage = CreateImage(#PB_Any,640-25,480,32)
  
  CreateMenu(0,WindowID(MainWindow));{
  
  MenuTitle("Datei")
  MenuItem(0,"Neues Spiel")
  MenuBar()
  MenuItem(1,"Öffnen")
  MenuItem(2,"Speichern")
  MenuItem(3,"Speichern unter")
  MenuBar()
  MenuItem(4,"Analen")
  MenuItem(5,"Rekorde")
  MenuBar()
  MenuItem(6,"Beenden")
  
  MenuTitle("Aktionen")
  MenuItem(7,"Korn verteilen")
  MenuItem(8,"Land handeln")
  MenuItem(9,"Gebäude")
  MenuItem(10,"Handel mit Gütern")
  MenuItem(11,"Steuern festsetzen")
  OpenSubMenu("Diplomatie")
  MenuItem(12,"Entwicklungshilfe")
  MenuItem(13,"Abkommen")
  MenuItem(14,"Tribut fordern")
  MenuItem(15,"Sabotage")
  CloseSubMenu()
  OpenSubMenu("Miliär")
  MenuItem(16,"Inspizieren")
  MenuItem(17,"Rekrutieren")
  MenuItem(18,"Manöver abhalten")
  MenuItem(19,"Krieg führen")
  CloseSubMenu()
  MenuBar()
  MenuItem(20,"Demissionieren")
  
  MenuTitle("Informationen")
  MenuItem(21,"Demographische Daten")
  MenuItem(22,"Finanzhaushalt")
  MenuItem(23,"Karriereberatung")
  MenuItem(24,"Geheimdienst")
  MenuItem(25,"Internationaler Vergleich")
  OpenSubMenu("Statistiken")
  MenuItem(26,"Wirtschaft")
  MenuItem(27,"Militär")
  CloseSubMenu()
  
  MenuTitle("Einstellungen")
  MenuItem(28,"Geschichtsschreibung")
  MenuItem(29,"Krach und Geschrei")
  MenuItem(30,"Schalmeinklänge")
  OpenSubMenu("Berichte")
  MenuItem(31,"Klatsch und Tratsch")
  MenuItem(32,"Bevölkerungsentwicklung")
  MenuItem(33,"Staatshaushalt")
  MenuItem(34,"Handel mit Gütern")
  MenuItem(35,"Korn verteilen")
  MenuItem(36,"Land handeln")
  MenuItem(37,"Gebäude")
  CloseSubMenu()
  MenuItem(40,"Schriftart ändern")
  
  MenuTitle("Runde")
  MenuItem(38,"Beenden")
  
  MenuTitle("Hilfe")
  MenuItem(39,"Über...")
  ;}
  
  ResizeWindow(MainWindow,WindowX(MainWindow),WindowY(MainWindow),640,480+MenuHeight())
  
  ;{ Gadgets
  For x = 0 To 18
    ButtonImageGadget(x+1,0,x*25,25,25,ImageID(button(x+1)))
  Next x
  MainGadget = ImageGadget(#PB_Any,25, 0, 640-25, 480, ImageID(MainImage))
  ;}
  
  DisableMenu(1)
  
  ;##### Wurde mit SaveGame gestartet ?
  ;{
  If LoadGame    
    Load_Game(LoadGame)
    File.s = LoadGame
  Else
    File.s = ""
  EndIf
  ;}
  
  HideWindow(MainWindow,0)
  
  ;##### Begin MainLoop
  
  Repeat
    
    Event       = WaitWindowEvent(#TimeOut)
    EventMenu   = EventMenu()
    EventGadget = EventGadget()
    EventType   = EventType()
    
    Select Event
        
      Case 515;Doppelklick
        If ActiveGame
          If WindowMouseX(0)>246 And WindowMouseX(0)<502
            If WindowMouseY(0)>448 And WindowMouseY(0)<480
              Window_Inspizieren(PeekB(spiel+3))
            EndIf
          EndIf
        EndIf
      Case #PB_Event_Repaint
        RePaint(EventWindow())
      Case #PB_Event_Gadget
        ;{
        Select EventGadget
            
          Case 1;kornverteilung
            Window_Kornverteilen(PeekB(spiel+3))
          Case 2;landkauf
            Window_Landkauf(PeekB(spiel+3))
          Case 3;bauen
            Window_Bauwerke(PeekB(spiel+3))
          Case 4;verkaufen
            Window_Verkaufen(PeekB(spiel+3))
          Case 5;steuern
            Window_Steuern(PeekB(spiel+3))
          Case 6;spende
            spende.s=Window_Spende(PeekB(spiel+3))
            If spende
              For x=0 To PeekB(spiel)
                If spende=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              If PeekB(spieler(x)+1000+(PeekB(spiel+3)*10))=0
                spende2=Window_Spende2(PeekB(spiel+3),spende)
                If spende2=1
                  If Window_Spende3(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf spende2=2
                  If Window_Spende4(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                EndIf
              Else 
                Window_Diplomatie_Error()
              EndIf
            EndIf
          Case 7;diplomatie
            abkommen.s=Window_Abkommen(PeekB(spiel+3))
            If abkommen
              For x=0 To PeekB(spiel)
                If abkommen=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              If PeekB(spieler(x)+1000+(PeekB(spiel+3)*10))=0
                abkommen2=Window_Abkommen2(PeekB(spiel+3),abkommen)
                If abkommen2=1
                  abkommen3=Window_Abkommen3(PeekB(spiel+3),abkommen)
                  If abkommen3
                    PokeB(spieler(x)+1000+(spieler*10),1);dipl botschafft
                    PokeB(spieler(x)+1001+(spieler*10),5);3= fridensvertrag
                    PokeW(spieler(x)+1002+(spieler*10),abkommen3);dauer
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf abkommen2=2
                  PokeB(spieler(x)+1000+(spieler*10),1);dipl botschafft
                  PokeB(spieler(x)+1001+(spieler*10),4);4= handelsvertrag anbieten
                  Window_Diplomatie_OK()
                ElseIf abkommen2=3
                  PokeB(spieler(x)+1000+(spieler*10),1);dipl botschafft
                  PokeB(spieler(x)+1001+(spieler*10),5);5= handelsvertrag kündigen
                  PokeW(mem+1100+x,0)
                  Window_Diplomatie_OK()
                EndIf
              Else 
                Window_Diplomatie_Error()
              EndIf
            EndIf
            
          Case 8;erpressen
            spende.s=Window_Erpressen(PeekB(spiel+3))
            If spende
              For x=0 To PeekB(spiel)
                If spende=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              If PeekB(spieler(x)+1000+(PeekB(spiel+3)*10))=0
                spende2=Window_Erpressen2(PeekB(spiel+3),spende)
                If spende2=1
                  If Window_Erpressen3(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf spende2=2
                  If Window_Erpressen4(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf spende2=3
                  If Window_Erpressen5(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                EndIf
              Else 
                Window_Diplomatie_Error()
              EndIf
            EndIf
          Case 9;sabotage
          Case 10;truppeninspizieren
            Window_Inspizieren(PeekB(spiel+3))
          Case 11;rekrutieren
            Window_Rekrutieren(PeekB(spiel+3))
          Case 12;manöver
                 ;Window_Manoever(PeekB(spiel+3))
            Window_Krieg_KampfVerteilung(PeekB(spiel+3),-1)
          Case 13;krieg
            krieg.s=Window_Krieg(PeekB(spiel+3))
            If krieg
              For x=0 To PeekB(spiel)
                If krieg=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              ;If PeekB(mem+1130+x)=0
              ;Window_Krieg_Kampf(PeekB(spiel+3),x)
              res=Window_Krieg_KampfVerteilung(PeekB(spiel+3),x)
              PokeB(mem+1130+x,res)
              ;Else
              ;Window_Krieg_Nein()
              ;EndIf
            EndIf
          Case 14;demographische daten
            Window_Demograhpie(PeekB(spiel+3))
          Case 15;finanzen
            Window_Finanzen(PeekB(spiel+3))
          Case 16;karriere
            Window_Kariere(PeekB(spiel+3))
          Case 17;geheimdienst
            Window_Geheimdienst(PeekB(spiel+3))
          Case 18;vergleich
            Window_Vergleich(PeekB(spiel+3))
          Case 19;rundebeenden
            NextTurn()
        EndSelect
        ;}
      Case #PB_Event_Menu
        ;{      
        Select EventMenu
            
          Case 0;neues spiel
                ;{            
            file.s=""
            
            Window_NeuesSpiel()
            
            For x=0 To PeekB(spiel)
              Window_SetSpielerName(x)
            Next
            
            DisableMenu(0)
            NextTurn()
            ;}
          Case 1;öffnen
                ;{
            File = Load_Game(File)
            ;}
          Case 2;speichern
                ;{
            File.s = Save_Game(File)
            ;}
          Case 3;speichern unter
                ;{
            File.s = Save_Game()
            ;}
          Case 4;annalen
            Window_Annale()
            
          Case 5;rekorde
            Window_Rekorde()
            
          Case 6;beenden
            Programm_Beenden()
            
          Case 7;korn verteilen
            Window_Kornverteilen(PeekB(spiel+3))
            
          Case 8;land handeln
            Window_Landkauf(PeekB(spiel+3))
            
          Case 9;gebäude
            Window_Bauwerke(PeekB(spiel+3))
            
          Case 10;handel mit güter
            Window_Verkaufen(PeekB(spiel+3))
            
          Case 11;Steuern festsetzen
            Window_Steuern(PeekB(spiel+3))
            
          Case 12;Entwicklungshilfe
                 ;{
            spende.s=Window_Spende(PeekB(spiel+3))
            If spende
              For x=0 To PeekB(spiel)
                If spende=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              If PeekB(spieler(x)+1000+(PeekB(spiel+3)*10))=0
                spende2=Window_Spende2(PeekB(spiel+3),spende)
                If spende2=1
                  If Window_Spende3(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf spende2=2
                  If Window_Spende4(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                EndIf
              Else 
                Window_Diplomatie_Error()
              EndIf
            EndIf
            ;}          
          Case 13;Abkommen
                 ;{
            abkommen.s=Window_Abkommen(PeekB(spiel+3))
            If abkommen
              For x=0 To PeekB(spiel)
                If abkommen=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              If PeekB(spieler(x)+1000+(PeekB(spiel+3)*10))=0
                abkommen2=Window_Abkommen2(PeekB(spiel+3),abkommen)
                If abkommen2=1
                  abkommen3=Window_Abkommen3(PeekB(spiel+3),abkommen)
                  If abkommen3
                    PokeB(spieler(x)+1000+(spieler*10),1);dipl botschafft
                    PokeB(spieler(x)+1001+(spieler*10),5);3= fridensvertrag
                    PokeW(spieler(x)+1002+(spieler*10),abkommen3);dauer
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf abkommen2=2
                  PokeB(spieler(x)+1000+(spieler*10),1);dipl botschafft
                  PokeB(spieler(x)+1001+(spieler*10),4);4= handelsvertrag anbieten
                  Window_Diplomatie_OK()
                ElseIf abkommen2=3
                  PokeB(spieler(x)+1000+(spieler*10),1);dipl botschafft
                  PokeB(spieler(x)+1001+(spieler*10),5);5= handelsvertrag kündigen
                  PokeW(mem+1100+x,0)
                  Window_Diplomatie_OK()
                EndIf
              Else 
                Window_Diplomatie_Error()
              EndIf
            EndIf
            ;}
          Case 14;Tribut fordern
                 ;{
            spende.s=Window_Erpressen(PeekB(spiel+3))
            If spende
              For x=0 To PeekB(spiel)
                If spende=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              If PeekB(spieler(x)+1000+(PeekB(spiel+3)*10))=0
                spende2=Window_Erpressen2(PeekB(spiel+3),spende)
                If spende2=1
                  If Window_Erpressen3(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf spende2=2
                  If Window_Erpressen4(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                ElseIf spende2=3
                  If Window_Erpressen5(PeekB(spiel+3),spende)
                    Window_Diplomatie_OK()
                  EndIf
                EndIf
              Else 
                Window_Diplomatie_Error()
              EndIf
            EndIf
            ;}
          Case 15;sabotage
            
          Case 16;militär inspizieren
            Window_Inspizieren(PeekB(spiel+3))
            
          Case 17;rekrutieren
            Window_Rekrutieren(PeekB(spiel+3))
            
          Case 18;manöver abhalten
                 ;Window_Manoever(PeekB(spiel+3))
            Window_Krieg_KampfVerteilung(PeekB(spiel+3),-1)
            
          Case 19;krieg führen
                 ;{
            krieg.s=Window_Krieg(PeekB(spiel+3))
            If krieg
              For x=0 To PeekB(spiel)
                If krieg=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                  Break
                EndIf
              Next
              ;If PeekB(mem+1130+x)=0
              ;Window_Krieg_Kampf(PeekB(spiel+3),x)
              res=Window_Krieg_KampfVerteilung(PeekB(spiel+3),x)
              PokeB(mem+1130+x,res)
              ;Else
              ;Window_Krieg_Nein()
              ;EndIf
            EndIf
            ;}
          Case 20;demissionieren
            
          Case 21;Demographische daten
            Window_Demograhpie(PeekB(spiel+3))
            
          Case 22;finanzhaushalt
            Window_Finanzen(PeekB(spiel+3))
            
          Case 23;karriereberatung
            Window_Kariere(PeekB(spiel+3))
            
          Case 24;geheimdienst
            Window_Geheimdienst(PeekB(spiel+3))
            
          Case 25;internationaler vergleich
            Window_Vergleich(PeekB(spiel+3))
            
          Case 26;statistik wirtschaft
            
          Case 27;statistik militär
            
          Case 28 To 37;geschichtsschreibung
            SetMenuItemState(0,EventMenu,1-GetMenuItemState(0,EventMenu))
            
          Case 29;krach und geschrei
            
          Case 30;schalmeinklänge
            
          Case 31;klatsch und tratsch
            
          Case 32;bevölkerungsentwicklung
            
          Case 33;staatshaushalt
            
          Case 34;handel mit güter
            
          Case 35;korn verteilen
            
          Case 36;land handeln
            
          Case 37;gebäude
            
          Case 38;reunde beenden
            NextTurn()
            
          Case 39;über...
            Window_About()
            
          Case 40
            If GetGadgetFont(#PB_Default)=FontID(Fonts(0))
              SetGadgetFont(#PB_Default,#PB_Default)
            Else
              SetGadgetFont(#PB_Default,FontID(Fonts(0)))
            EndIf
            
        EndSelect
        ;} 
      Case #PB_Event_CloseWindow
        ;{
        Programm_Beenden()
        ;} 
    EndSelect
    
    If event=#PB_Event_Gadget Or event=#PB_Event_Menu Or nextturn=1
      ;{
      nextturn=0
      mem=spieler(PeekB(spiel+3))
      CalcNeueWerte(mem)
      Paint0()
      ;}
    EndIf
    
  ForEver
  
EndProcedure

;##### ------------------------------------------------------------------------
;##### 
;##### Begin Game
;##### 
;##### ------------------------------------------------------------------------

OpenMainWindow(ProgramParameter())

Programm_Beenden()

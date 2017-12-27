;##### ------------------------------------------------------------------------
;##### 
;##### Infos.pbi
;##### 
;##### ------------------------------------------------------------------------

;##### ------------------------------------------------------------------------
;##### Statistiken
;##### ------------------------------------------------------------------------

Procedure Window_Demograhpie(spieler)
  window=WinOpen(250,360,"Aktuelle Demographische Daten")
  
  mem=spieler(spieler)
  ;CreateGadgetList(WindowID(window))
  TextGadget(-1,50, 20,120,20,"Einwohnerzahl:")
  TextGadget(-1,50, 60,120,20,"Zufriedenheit:")
  TextGadget(-1,50,100,120,20,"Geburtenrate:")
  TextGadget(-1,50,140,120,20,"Sterberate:")
  TextGadget(-1,50,180,120,20,"Immigrationsrate:")
  TextGadget(-1,50,220,120,20,"Emigrationsrate:")
  
  TextGadget(-1,180, 20,50,20,Str(PeekL(mem+17)),#PB_Text_Right)
  TextGadget(-1,180, 60,50,20,Str(PeekB(mem+35))+" %",#PB_Text_Right)
  TextGadget(-1,180,100,50,20,StrF(PeekW(mem+86)/10,1)+" %",#PB_Text_Right)
  TextGadget(-1,180,140,50,20,StrF(PeekW(mem+88)/10,1)+" %",#PB_Text_Right)
  TextGadget(-1,180,180,50,20,StrF(PeekW(mem+90)/10,1)+" %",#PB_Text_Right)
  TextGadget(-1,180,220,50,20,StrF(PeekW(mem+92)/10,1)+" %",#PB_Text_Right)
  
  FrameGadget(-1,10,255,230,50,"Stimmung im Lande")
  
  button=ButtonGadget(-1,75,320,100,30,"Fertig")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(28),WindowOutput(window),10,10,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(29),WindowOutput(window),10,50,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(30),WindowOutput(window),10,90,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(31),WindowOutput(window),10,130,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(26),WindowOutput(window),10,170,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(32),WindowOutput(window),10,210,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Finanzen(spieler)
  window=WinOpen(420,310,"Staatshaushalt")
  
  mem=spieler(spieler)
  ;CreateGadgetList(WindowID(window))
  TextGadget(-1,50,10,320,40,"Eine Aufstellung der für das kommende Jahr zu erwartenden Einnahmen und Ausgaben:",#PB_Text_Center)
  FrameGadget(-1,10,50,400,150,"")
  TextGadget(-1,20, 60,270,20,"Gewinne der Märkte und Kornmühlen:")
  TextGadget(-1,20, 80,270,20,"Handelsbilanz:")
  TextGadget(-1,20,100,270,20,"Steuereinnahmen:")
  TextGadget(-1,20,120,270,20,"Justiz:")
  TextGadget(-1,20,140,270,20,"Militär:")
  TextGadget(-1,20,160,270,20,"Zinsen:")
  TextGadget(-1,20,180,270,20,"Lagervermietung:")
  TextGadget(-1,290, 60,110,20,Str(PeekL(mem+ 94))+" Taler",#PB_Text_Right)
  TextGadget(-1,290, 80,110,20,Str(PeekL(mem+ 98))+" Taler",#PB_Text_Right)
  TextGadget(-1,290,100,110,20,Str(PeekL(mem+102))+" Taler",#PB_Text_Right)
  TextGadget(-1,290,120,110,20,Str(PeekL(mem+106))+" Taler",#PB_Text_Right)
  TextGadget(-1,290,140,110,20,Str(PeekL(mem+110))+" Taler",#PB_Text_Right)
  TextGadget(-1,290,160,110,20,Str(PeekL(mem+114))+" Taler",#PB_Text_Right)
  TextGadget(-1,290,180,110,20,Str(PeekL(mem+118))+" Taler",#PB_Text_Right)
  gesammt=PeekL(mem+94)+PeekL(mem+98)+PeekL(mem+102)+PeekL(mem+106)+PeekL(mem+110)+PeekL(mem+114)+PeekL(mem+118)
  FrameGadget(-1,10,200,400,30,"")
  TextGadget(-1,20,210,270,20,"Gesammt:")
  TextGadget(-1,290,210,110,20,Str(gesammt)+" Taler",#PB_Text_Right)
  
  FrameGadget(-1,10,230,400,30,"")
  TextGadget(-1,20,240,270,20,"Neuer Stand in der Schatzkammer:")
  TextGadget(-1,290,240,110,20,Str(gesammt+PeekL(mem+25))+" Taler",#PB_Text_Right)
  button=ButtonGadget(-1,160,270,100,30,"Danke")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(24),WindowOutput(window), 10,10,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(24),WindowOutput(window),378,10,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Kariere(spieler)
  mem=spieler(spieler)
  ;{
  If vorraussetzung(PeekW(mem+84))\einwohner<=PeekL(mem+17)
    k+1
  EndIf
  If vorraussetzung(PeekW(mem+84))\zufriedenheit<=PeekB(mem+35)
    k+1
  EndIf
  If vorraussetzung(PeekW(mem+84))\land<=PeekL(mem+21)
    k+1
  EndIf
  If vorraussetzung(PeekW(mem+84))\taler<=PeekL(mem+25)
    k+1
  EndIf
  If vorraussetzung(PeekW(mem+84))\armee<=PeekL(mem+127)
    k+1
  EndIf
  If vorraussetzung(PeekW(mem+84))\palast<=PeekB(mem+54)
    k+1
  EndIf
  If vorraussetzung(PeekW(mem+84))\kathedrale<=PeekB(mem+55)
    k+1
  EndIf
  ;}
  If k=7
    ;{ möglicher aufstieg
    window=WinOpen(300,100,"Karriereberatung")
    
    mem=spieler(spieler)
    ;CreateGadgetList(WindowID(window))
    TextGadget(-1,50,10,240,40,"Die Beförderung zum "+UCase(titel(PeekW(spieler(spieler)+84)+1,PeekB(spieler(spieler)+33)))+" steht unmittelbar ins Haus!")
    button=ButtonGadget(-1,100,60,100,30,"Huah!")
    Repeat
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      
      Select Event
        Case #PB_Event_Repaint
          RePaint(EventWindow())
          DrawTransparentImage(icon(10),WindowOutput(window),10,10,32,32,0,0,32,32,$FF00FF)
          ;endcase
        Case #PB_Event_Gadget
          Select EventGadget
            Case button
              CloseWindow(window)
              ProcedureReturn 1
              ;endcase
          EndSelect
          ;endcase
      EndSelect
      
    ForEver
    ;}
  Else
    ;{ noch nicht alles erfüllt
    window=WinOpen(420,260,"Karriereberatung")
    
    mem=spieler(spieler)
    ;CreateGadgetList(WindowID(window))
    TextGadget(-1,50,10,360,50,"Bedauerlicherweise erfüllt Ihr noch nicht alle nötigen Vorraussetzungen für einen gesellschaftlichen Aufstieg, lediglich die hier markierten:")
    TextGadget(-1, 50, 70,100,20,"Einwohnerzahl:")
    TextGadget(-1, 50,110,100,20,"Zufriedenheit:")
    TextGadget(-1, 50,150,100,20,"Länderreien:")
    TextGadget(-1, 50,190,100,20,"Talerchen:")
    TextGadget(-1,260, 70,100,20,"Armeestärke:")
    TextGadget(-1,260,110,100,20,"Palast:")
    TextGadget(-1,260,150,100,20,"Kathedrale:")
    c1=CheckBoxGadget(-1,170, 70,20,20,"")
    c2=CheckBoxGadget(-1,170,110,20,20,"")
    c3=CheckBoxGadget(-1,170,150,20,20,"")
    c4=CheckBoxGadget(-1,170,190,20,20,"")
    c5=CheckBoxGadget(-1,380, 70,20,20,"")
    c6=CheckBoxGadget(-1,380,110,20,20,"")
    c7=CheckBoxGadget(-1,380,150,20,20,"")
    If vorraussetzung(PeekW(mem+84))\einwohner>PeekL(mem+17)
      SetGadgetState(c1,0)
    Else
      SetGadgetState(c1,1)
    EndIf
    If vorraussetzung(PeekW(mem+84))\zufriedenheit>PeekB(mem+35)
      SetGadgetState(c2,0)
    Else
      SetGadgetState(c2,1)
    EndIf
    If vorraussetzung(PeekW(mem+84))\land>PeekL(mem+21)
      SetGadgetState(c3,0)
    Else
      SetGadgetState(c3,1)
    EndIf
    If vorraussetzung(PeekW(mem+84))\taler>PeekL(mem+25)
      SetGadgetState(c4,0)
    Else
      SetGadgetState(c4,1)
    EndIf
    If vorraussetzung(PeekW(mem+84))\armee>PeekL(mem+127)
      SetGadgetState(c5,0)
    Else
      SetGadgetState(c5,1)
    EndIf
    If vorraussetzung(PeekW(mem+84))\palast>PeekB(mem+54)
      SetGadgetState(c6,0)
    Else
      SetGadgetState(c6,1)
    EndIf
    If vorraussetzung(PeekW(mem+84))\kathedrale>PeekB(mem+55)
      SetGadgetState(c7,0)
    Else
      SetGadgetState(c7,1)
    EndIf
    button=ButtonGadget(-1,160,220,100,30,"Wird schon...")
    Repeat
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      
      Select Event
        Case #PB_Event_Repaint
          RePaint(EventWindow())
          DrawTransparentImage(icon(10),WindowOutput(window), 10, 10,32,32,0,0,32,32,$FF00FF)
          DrawTransparentImage(icon(28),WindowOutput(window), 10, 60,32,32,0,0,32,32,$FF00FF)
          DrawTransparentImage(icon(29),WindowOutput(window), 10,100,32,32,0,0,32,32,$FF00FF)
          DrawTransparentImage(icon( 2),WindowOutput(window), 10,140,32,32,0,0,32,32,$FF00FF)
          DrawTransparentImage(icon(24),WindowOutput(window), 10,180,32,32,0,0,32,32,$FF00FF)
          DrawTransparentImage(icon(33),WindowOutput(window),220, 60,32,32,0,0,32,32,$FF00FF)
          DrawTransparentImage(icon(17),WindowOutput(window),220,100,32,32,0,0,32,32,$FF00FF)
          DrawTransparentImage(icon(18),WindowOutput(window),220,140,32,32,0,0,32,32,$FF00FF)
          
          ;endcase
        Case #PB_Event_Gadget
          Select EventGadget
            Case button
              CloseWindow(window)
              ProcedureReturn 1
              ;endcase
          EndSelect
          ;endcase
      EndSelect
      
    ForEver
    ;}
  EndIf
EndProcedure
Procedure Window_Vergleich(spieler)
  window=WinOpen(250,290,"Eure Leistung im internat. Vergleich")
  
  mem=spieler(spieler)
  r1=1
  r2=1
  r3=1
  r4=1
  r5=1
  r6=1
  For x=0 To PeekB(spiel)
    If PeekW(mem+82)<PeekW(spieler(x)+82)
      r1+1
    EndIf
    If PeekL(mem+17)<PeekL(spieler(x)+17)
      r2+1
    EndIf
    If PeekL(mem+21)<PeekL(spieler(x)+21)
      r3+1
    EndIf
    If PeekW(mem+46)+PeekW(mem+48)<PeekW(spieler(x)+46)+PeekW(spieler(x)+48)
      r4+1
    EndIf
    If PeekL(mem+127)<PeekL(spieler(x)+127)
      r5+1
    EndIf
    If PeekL(mem+25)<PeekL(spieler(x)+25)
      r6+1
    EndIf
  Next
  ;CreateGadgetList(WindowID(window))
  TextGadget(-1,60, 20,100,20,"Karriere:")
  TextGadget(-1,60, 60,100,20,"Bevölkerung:")
  TextGadget(-1,60,100,100,20,"Ländereien:")
  TextGadget(-1,60,140,100,20,"Ausbauten:")
  TextGadget(-1,60,180,100,20,"Armeestärke:")
  TextGadget(-1,60,220,100,20,"Schatzkammer:")
  TextGadget(-1,160, 20,60,20,Str(r1)+". Platz",#PB_Text_Right)
  TextGadget(-1,160, 60,60,20,Str(r2)+". Platz",#PB_Text_Right)
  TextGadget(-1,160,100,60,20,Str(r3)+". Platz",#PB_Text_Right)
  TextGadget(-1,160,140,60,20,Str(r4)+". Platz",#PB_Text_Right)
  TextGadget(-1,160,180,60,20,Str(r5)+". Platz",#PB_Text_Right)
  TextGadget(-1,160,220,60,20,Str(r6)+". Platz",#PB_Text_Right)
  button=ButtonGadget(-1,75,250,100,30,"Fertig")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(10),WindowOutput(window),20, 10,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(28),WindowOutput(window),20, 50,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon( 2),WindowOutput(window),20, 90,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(15),WindowOutput(window),20,130,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(33),WindowOutput(window),20,170,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(24),WindowOutput(window),20,210,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Wetter(spieler)
  window=WinOpen(340,130,"")
  
  mem=spieler(spieler)
  verdorben=5+Random(10)
  wetter=15+Random(35)+Random(35)
  PokeL(mem+29,PeekL(mem+29)*(100-verdorben)/100);korn
  PokeL(mem+29,PeekL(mem+29)+(PeekL(mem+21)*wetter/100));korn
  Select wetter
    Case 15 To 30
      text1.s="Die Ernte fiel einer Dürre zum Opfer. Nun droht vielleicht eine Hungersnot!"
      text2.s="Erschwerdend kommt noch hinzu, daß "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Oh!"
      icon1=36
      ;endcase
    Case 31 To 40
      text1.s="Die diesjährige Ernte fiel leider gehörig ins Wasser, Euer Glücklosigkeit!"
      text2.s="Erschwerdend kommt noch hinzu, daß "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Oh!"
      icon1=34
      ;endcase
    Case 41 To 59
      text1.s="Eine ganz und gar durchschnittliche Ernte in diesem Jahr, Euer Gnaden!"
      text2.s="Leider muss berichtet werden, dass "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Oh!"
      icon1=34
      ;endcase
    Case 60 To 69
      text1.s="Das war ein richtiges Wetter zum Helden zeugen, Euer Gnaden! Eine gute Ernte!"
      text2.s="Da fällt es kaum ins Gewicht, das "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Juhu!"
      icon1=35
      ;endcase
    Case 70 To 85
      text1.s="Das Kaiserwetter bescherte uns eine Rekordernte, Eure Wonne!"
      text2.s="Da fällt es kaum ins Gewicht, das "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Juhu!"
      icon1=35
      ;endcase
  EndSelect
  
  ;CreateGadgetList(WindowID(window))
  TextGadget(-1,50,10,260,40,text1)
  TextGadget(-1,50,50,260,40,text2)
  button=ButtonGadget(-1,120,100,100,20,text3)
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(icon1),WindowOutput(window),10,10,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(15),WindowOutput(window),10,50,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Geheimdienst(spieler)
  window=WinOpen(600,390,"Dossiers von heuer:")
  
  mem=spieler(spieler)
  FrameGadget(-1,5,35,290,80,"Persönliches:")
  txt1=TextGadget(-1,55,50,230,20,"")
  txt2=TextGadget(-1,55,70,130,20,"")
  TextGadget(-1,55,90,130,20,"Ruhm:")
  FrameGadget(-1,5,115,290,80,"Resourcen:")
  TextGadget(-1,55,130,130,20,"Einwohner:")
  TextGadget(-1,55,150,130,20,"Landbesitz ha:")
  TextGadget(-1,55,170,130,20,"Mühlen und Markte:")
  FrameGadget(-1,5,195,290,60,"Finanzen:")
  TextGadget(-1,55,210,130,20,"Letztes Einkommen:")
  TextGadget(-1,55,230,130,20,"Schatzkammer:")
  FrameGadget(-1,5,255,290,80,"Militär:")
  TextGadget(-1,55,270,130,20,"Armeestärke:")
  TextGadget(-1,55,290,130,20,"Leichte Artillerie:")
  TextGadget(-1,55,310,130,20,"Schwere Artillerie:")
  FrameGadget(-1,305,35,290,80,"Diplomatie:")
  TextGadget(-1,355,50,130,20,"Saboteure:")
  TextGadget(-1,355,70,130,20,"Handelsabkommen:")
  TextGadget(-1,355,90,130,20,"Friedensvertrag:")
  FrameGadget(-1,305,115,290,220,"Kriegsschulden:")
  TextGadget(-1,355,140,130,20,"Mühlen:")
  TextGadget(-1,355,180,130,20,"Märkte:")
  TextGadget(-1,355,220,130,20,"Taler:")
  TextGadget(-1,355,260,130,20,"Land ha:")
  TextGadget(-1,355,300,130,20,"Sklaven:")
  ks_1=TextGadget(-1,485,140,90,20,"",#PB_Text_Right)
  ks_2=TextGadget(-1,485,180,90,20,"",#PB_Text_Right)
  ks_3=TextGadget(-1,485,220,90,20,"",#PB_Text_Right)
  ks_4=TextGadget(-1,485,260,90,20,"",#PB_Text_Right)
  ks_5=TextGadget(-1,485,300,90,20,"",#PB_Text_Right)
  ;CreateGadgetList(WindowID(window))
  combo=ComboBoxGadget(-1,10,10,580,22)
  For x=0 To PeekB(spiel)
    If x<>spieler
      AddGadgetItem(combo,-1,titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16)+" von "+land(PeekB(spieler(x)+124))\name)
    EndIf
  Next
  SetGadgetState(combo,0)
  button=ButtonGadget(-1,200,340,200,40,"Fertig")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(10),WindowOutput(window),15,60,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(13),WindowOutput(window),15,140,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(24),WindowOutput(window),15,210,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(33),WindowOutput(window),15,280,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(38),WindowOutput(window),315,60,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(14),WindowOutput(window),315,135,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(15),WindowOutput(window),315,175,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(24),WindowOutput(window),315,215,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(13),WindowOutput(window),315,255,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(28),WindowOutput(window),315,295,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case combo
            For x=0 To PeekB(spiel)
              If GetGadgetText(combo)=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16)+" von "+land(PeekB(spieler(x)+124))\name
                SetGadgetText(txt1,GetGadgetText(combo))
                SetGadgetText(txt2,zauber(PeekB(spieler(x)+122))\zauber)
                SetGadgetText(ks_1,Str(PeekL(spieler(x)+1200+spieler*20+00)))
                SetGadgetText(ks_2,Str(PeekL(spieler(x)+1200+spieler*20+04)))
                SetGadgetText(ks_3,Str(PeekL(spieler(x)+1200+spieler*20+08)))
                SetGadgetText(ks_4,Str(PeekL(spieler(x)+1200+spieler*20+12)))
                SetGadgetText(ks_5,Str(PeekL(spieler(x)+1200+spieler*20+16)))
              EndIf
            Next
            
            ;endcase
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
EndProcedure

;##### ------------------------------------------------------------------------
;##### Infos
;##### ------------------------------------------------------------------------

Procedure Window_About()
  window=WinOpen(250,220,"Über Kaiser")
  
  mem=spieler(spieler)
  ;CreateGadgetList(WindowID(window))
  TextGadget(-1,50,20,190,40,#Kaiser$+FormatDate(" (%dd.%mm.%yyyy)",#PB_Compiler_Date)+#CRLF$+"by Thomas Hörmann")
  link1=HyperLinkGadget(-1,10,60,230,20,"http://www.nipsold.de/kaiser/",$FF0000,#PB_HyperLink_Underline)
  TextGadget(-1,10,100,230,50,"Bei diesem Spiel handelt es von dem Remake und der Weiterführung des Spiels Kaiser von Stefan Maday")
  link2=HyperLinkGadget(-1,10,150,230,20,"http://yadam.de/KAISER/kaiser.htm",$FF0000,#PB_HyperLink_Underline)
  button=ButtonGadget(-1,75,190,100,20,"Ok!")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(10),WindowOutput(window),10,20,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case link1
            RunProgram("http://www.nipsold.de/kaiser/")
            ;endcase
          Case link2
            RunProgram("http://yadam.de/KAISER/kaiser.htm")
            ;endcase
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Annale()
  window=WinOpen(550,330,"Halle des Ruhmes")
  
  mem=spieler(spieler)
  ;CreateGadgetList(WindowID(window))
  TextGadget(-1,200,20,150,20,"Die Zehn Top-Monarchen",#PB_Text_Center)
  TextGadget(-1, 50,50,230,20,"Name")
  TextGadget(-1,280,50,100,20,"Domäne")
  TextGadget(-1,380,50, 50,20,"Jahr",#PB_Text_Right)
  TextGadget(-1,430,50,100,20,"Punkte",#PB_Text_Right)
  FrameGadget(-1,10,65,530,220,"")
  For x=0 To 9
    TextGadget(-1, 20,80+x*20, 20,20,Str(x+1),#PB_Text_Right)
    TextGadget(-1, 50,80+x*20,230,20,PeekS(annale+x*100))
    TextGadget(-1,280,80+x*20,100,20,zauber(PeekL(annale+88+x*100))\zauber)
    TextGadget(-1,380,80+x*20, 50,20,Str(PeekL(annale+92+x*100)),#PB_Text_Right)
    TextGadget(-1,430,80+x*20,100,20,Str(PeekL(annale+96+x*100)),#PB_Text_Right)
  Next
  button=ButtonGadget(-1,225,300,100,20,"Wow!")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(10),WindowOutput(window),150,10,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(10),WindowOutput(window),368,10,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Rekorde()
  window=WinOpen(400,370,"Her Ginness sein Buch der Rekorde")
  
  mem=spieler(spieler)
  ;CreateGadgetList(WindowID(window))
  TextGadget(-1,60, 20,320,60,PeekS(annale+9000)+" konnte es gar nicht erwarten und benötigte zur Krönung lediglich "+Str(PeekL(annale+9096))+" Jahre!")
  TextGadget(-1,60, 80,320,60,PeekS(annale+9100)+" verfügte mit "+Str(PeekL(annale+9196))+" ha über die größte Landmenge aller Zeiten!")
  TextGadget(-1,60,140,320,60,PeekS(annale+9200)+" gebot über die unerreichte Zahl von "+Str(PeekL(annale+9296))+" Untertanen!")
  TextGadget(-1,60,200,320,60,"Sagenhafte "+Str(PeekL(annale+9396))+" Taler betrug die Barschaft von "+PeekS(annale+9300))
  TextGadget(-1,60,260,320,70,"Der stärkste Ritter unter der Sonne ward der blutrünstige "+PeekS(annale+9400)+". Der Halbgott erschlug "+Str(PeekL(annale+9496))+" Feind(e) und diente unter "+PeekS(annale+9500))
  button=ButtonGadget(-1,150,330,100,30,"Fertig")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        DrawTransparentImage(icon(10),WindowOutput(window),20, 20,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon( 2),WindowOutput(window),20, 80,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(28),WindowOutput(window),20,140,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon(24),WindowOutput(window),20,200,32,32,0,0,32,32,$FF00FF)
        DrawTransparentImage(icon( 3),WindowOutput(window),20,260,32,32,0,0,32,32,$FF00FF)
        ;endcase
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            ;endcase
        EndSelect
        ;endcase
    EndSelect
    
  ForEver
  
EndProcedure

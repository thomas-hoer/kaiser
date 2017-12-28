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
  TextGadget(#PB_Any,50, 20,120,20,"Einwohnerzahl:")
  TextGadget(#PB_Any,50, 60,120,20,"Zufriedenheit:")
  TextGadget(#PB_Any,50,100,120,20,"Geburtenrate:")
  TextGadget(#PB_Any,50,140,120,20,"Sterberate:")
  TextGadget(#PB_Any,50,180,120,20,"Immigrationsrate:")
  TextGadget(#PB_Any,50,220,120,20,"Emigrationsrate:")
  
  TextGadget(#PB_Any,180, 20,50,20,Str(PeekL(mem+17)),#PB_Text_Right)
  TextGadget(#PB_Any,180, 60,50,20,Str(PeekB(mem+35))+" %",#PB_Text_Right)
  TextGadget(#PB_Any,180,100,50,20,StrF(PeekW(mem+86)/10,1)+" %",#PB_Text_Right)
  TextGadget(#PB_Any,180,140,50,20,StrF(PeekW(mem+88)/10,1)+" %",#PB_Text_Right)
  TextGadget(#PB_Any,180,180,50,20,StrF(PeekW(mem+90)/10,1)+" %",#PB_Text_Right)
  TextGadget(#PB_Any,180,220,50,20,StrF(PeekW(mem+92)/10,1)+" %",#PB_Text_Right)
  
  FrameGadget(#PB_Any,10,255,230,50,"Stimmung im Lande")
  
  ImageGadget(#PB_Any,10,10,32,32,ImageID(icon(28)))
  ImageGadget(#PB_Any,10,50,32,32,ImageID(icon(29)))
  ImageGadget(#PB_Any,10,90,32,32,ImageID(icon(30)))
  ImageGadget(#PB_Any,10,130,32,32,ImageID(icon(31)))
  ImageGadget(#PB_Any,10,170,32,32,ImageID(icon(26)))
  ImageGadget(#PB_Any,10,210,32,32,ImageID(icon(32)))
  
  button=ButtonGadget(#PB_Any,75,320,100,30,"Fertig")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Finanzen(spieler)
  window=WinOpen(420,310,"Staatshaushalt")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,50,10,320,40,"Eine Aufstellung der für das kommende Jahr zu erwartenden Einnahmen und Ausgaben:",#PB_Text_Center)
  FrameGadget(#PB_Any,10,50,400,150,"")
  TextGadget(#PB_Any,20, 60,270,20,"Gewinne der Märkte und Kornmühlen:")
  TextGadget(#PB_Any,20, 80,270,20,"Handelsbilanz:")
  TextGadget(#PB_Any,20,100,270,20,"Steuereinnahmen:")
  TextGadget(#PB_Any,20,120,270,20,"Justiz:")
  TextGadget(#PB_Any,20,140,270,20,"Militär:")
  TextGadget(#PB_Any,20,160,270,20,"Zinsen:")
  TextGadget(#PB_Any,20,180,270,20,"Lagervermietung:")
  TextGadget(#PB_Any,290, 60,110,20,Str(PeekL(mem+ 94))+" Taler",#PB_Text_Right)
  TextGadget(#PB_Any,290, 80,110,20,Str(PeekL(mem+ 98))+" Taler",#PB_Text_Right)
  TextGadget(#PB_Any,290,100,110,20,Str(PeekL(mem+102))+" Taler",#PB_Text_Right)
  TextGadget(#PB_Any,290,120,110,20,Str(PeekL(mem+106))+" Taler",#PB_Text_Right)
  TextGadget(#PB_Any,290,140,110,20,Str(PeekL(mem+110))+" Taler",#PB_Text_Right)
  TextGadget(#PB_Any,290,160,110,20,Str(PeekL(mem+114))+" Taler",#PB_Text_Right)
  TextGadget(#PB_Any,290,180,110,20,Str(PeekL(mem+118))+" Taler",#PB_Text_Right)
  gesammt=PeekL(mem+94)+PeekL(mem+98)+PeekL(mem+102)+PeekL(mem+106)+PeekL(mem+110)+PeekL(mem+114)+PeekL(mem+118)
  FrameGadget(#PB_Any,10,200,400,30,"")
  TextGadget(#PB_Any,20,210,270,20,"Gesammt:")
  TextGadget(#PB_Any,290,210,110,20,Str(gesammt)+" Taler",#PB_Text_Right)
  
  FrameGadget(#PB_Any,10,230,400,30,"")
  TextGadget(#PB_Any,20,240,270,20,"Neuer Stand in der Schatzkammer:")
  TextGadget(#PB_Any,290,240,110,20,Str(gesammt+PeekL(mem+25))+" Taler",#PB_Text_Right)
  
  ImageGadget(#PB_Any,10,10,32,32,ImageID(icon(24)))
  ImageGadget(#PB_Any,378,10,32,32,ImageID(icon(24)))
  
  button=ButtonGadget(#PB_Any,160,270,100,30,"Danke")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
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
    TextGadget(#PB_Any,50,10,240,40,"Die Beförderung zum "+UCase(titel(PeekW(spieler(spieler)+84)+1,PeekB(spieler(spieler)+33)))+" steht unmittelbar ins Haus!")
    ImageGadget(#PB_Any,10,10,32,32,ImageID(icon(10)))
    
    button=ButtonGadget(#PB_Any,100,60,100,30,"Huah!")
    Repeat
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      
      Select Event
        Case #PB_Event_Gadget
          Select EventGadget
            Case button
              CloseWindow(window)
              ProcedureReturn 1
          EndSelect
      EndSelect
      
    ForEver
    ;}
  Else
    ;{ noch nicht alles erfüllt
    window=WinOpen(420,260,"Karriereberatung")
    
    mem=spieler(spieler)
    TextGadget(#PB_Any,50,10,360,50,"Bedauerlicherweise erfüllt Ihr noch nicht alle nötigen Vorraussetzungen für einen gesellschaftlichen Aufstieg, lediglich die hier markierten:")
    TextGadget(#PB_Any, 50, 70,100,20,"Einwohnerzahl:")
    TextGadget(#PB_Any, 50,110,100,20,"Zufriedenheit:")
    TextGadget(#PB_Any, 50,150,100,20,"Länderreien:")
    TextGadget(#PB_Any, 50,190,100,20,"Talerchen:")
    TextGadget(#PB_Any,260, 70,100,20,"Armeestärke:")
    TextGadget(#PB_Any,260,110,100,20,"Palast:")
    TextGadget(#PB_Any,260,150,100,20,"Kathedrale:")
    c1=CheckBoxGadget(#PB_Any,170, 70,20,20,"")
    c2=CheckBoxGadget(#PB_Any,170,110,20,20,"")
    c3=CheckBoxGadget(#PB_Any,170,150,20,20,"")
    c4=CheckBoxGadget(#PB_Any,170,190,20,20,"")
    c5=CheckBoxGadget(#PB_Any,380, 70,20,20,"")
    c6=CheckBoxGadget(#PB_Any,380,110,20,20,"")
    c7=CheckBoxGadget(#PB_Any,380,150,20,20,"")
    ImageGadget(#PB_Any, 10, 10,32,32,ImageID(icon(10)))
    ImageGadget(#PB_Any, 10, 60,32,32,ImageID(icon(28)))
    ImageGadget(#PB_Any, 10,100,32,32,ImageID(icon(29)))
    ImageGadget(#PB_Any, 10,140,32,32,ImageID(icon( 2)))
    ImageGadget(#PB_Any, 10,180,32,32,ImageID(icon(24)))
    ImageGadget(#PB_Any,220, 60,32,32,ImageID(icon(33)))
    ImageGadget(#PB_Any,220,100,32,32,ImageID(icon(17)))
    ImageGadget(#PB_Any,220,140,32,32,ImageID(icon(18)))

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
    button=ButtonGadget(#PB_Any,160,220,100,30,"Wird schon...")
    Repeat
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      
      Select Event
        Case #PB_Event_Gadget
          Select EventGadget
            Case button
              CloseWindow(window)
              ProcedureReturn 1
          EndSelect
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
  TextGadget(#PB_Any,60, 20,100,20,"Karriere:")
  TextGadget(#PB_Any,60, 60,100,20,"Bevölkerung:")
  TextGadget(#PB_Any,60,100,100,20,"Ländereien:")
  TextGadget(#PB_Any,60,140,100,20,"Ausbauten:")
  TextGadget(#PB_Any,60,180,100,20,"Armeestärke:")
  TextGadget(#PB_Any,60,220,100,20,"Schatzkammer:")
  TextGadget(#PB_Any,160, 20,60,20,Str(r1)+". Platz",#PB_Text_Right)
  TextGadget(#PB_Any,160, 60,60,20,Str(r2)+". Platz",#PB_Text_Right)
  TextGadget(#PB_Any,160,100,60,20,Str(r3)+". Platz",#PB_Text_Right)
  TextGadget(#PB_Any,160,140,60,20,Str(r4)+". Platz",#PB_Text_Right)
  TextGadget(#PB_Any,160,180,60,20,Str(r5)+". Platz",#PB_Text_Right)
  TextGadget(#PB_Any,160,220,60,20,Str(r6)+". Platz",#PB_Text_Right)
  ImageGadget(#PB_Any,20, 10,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any,20, 50,32,32,ImageID(icon(28)))
  ImageGadget(#PB_Any,20, 90,32,32,ImageID(icon( 2)))
  ImageGadget(#PB_Any,20,130,32,32,ImageID(icon(15)))
  ImageGadget(#PB_Any,20,170,32,32,ImageID(icon(33)))
  ImageGadget(#PB_Any,20,210,32,32,ImageID(icon(24)))
  button=ButtonGadget(#PB_Any,75,250,100,30,"Fertig")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
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
    Case 31 To 40
      text1.s="Die diesjährige Ernte fiel leider gehörig ins Wasser, Euer Glücklosigkeit!"
      text2.s="Erschwerdend kommt noch hinzu, daß "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Oh!"
      icon1=34
    Case 41 To 59
      text1.s="Eine ganz und gar durchschnittliche Ernte in diesem Jahr, Euer Gnaden!"
      text2.s="Leider muss berichtet werden, dass "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Oh!"
      icon1=34
    Case 60 To 69
      text1.s="Das war ein richtiges Wetter zum Helden zeugen, Euer Gnaden! Eine gute Ernte!"
      text2.s="Da fällt es kaum ins Gewicht, das "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Juhu!"
      icon1=35
    Case 70 To 85
      text1.s="Das Kaiserwetter bescherte uns eine Rekordernte, Eure Wonne!"
      text2.s="Da fällt es kaum ins Gewicht, das "+Str(verdorben)+"% Eurer Kornreserven verfault sind!"
      text3.s="Juhu!"
      icon1=35
  EndSelect
  
  ImageGadget(#PB_Any,10,10,32,32,ImageID(icon(icon1)))
  ImageGadget(#PB_Any,10,50,32,32,ImageID(icon(15)))
  TextGadget(#PB_Any,50,10,260,40,text1)
  TextGadget(#PB_Any,50,50,260,40,text2)
  button=ButtonGadget(#PB_Any,120,100,100,20,text3)
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Geheimdienst(spieler)
  window=WinOpen(600,390,"Dossiers von heuer:")
  
  mem=spieler(spieler)
  FrameGadget(#PB_Any,5,35,290,80,"Persönliches:")
  txt1=TextGadget(#PB_Any,55,50,230,20,"")
  txt2=TextGadget(#PB_Any,55,70,130,20,"")
  TextGadget(#PB_Any,55,90,130,20,"Ruhm:")
  FrameGadget(#PB_Any,5,115,290,80,"Resourcen:")
  TextGadget(#PB_Any,55,130,130,20,"Einwohner:")
  TextGadget(#PB_Any,55,150,130,20,"Landbesitz ha:")
  TextGadget(#PB_Any,55,170,130,20,"Mühlen und Markte:")
  FrameGadget(#PB_Any,5,195,290,60,"Finanzen:")
  TextGadget(#PB_Any,55,210,130,20,"Letztes Einkommen:")
  TextGadget(#PB_Any,55,230,130,20,"Schatzkammer:")
  FrameGadget(#PB_Any,5,255,290,80,"Militär:")
  TextGadget(#PB_Any,55,270,130,20,"Armeestärke:")
  TextGadget(#PB_Any,55,290,130,20,"Leichte Artillerie:")
  TextGadget(#PB_Any,55,310,130,20,"Schwere Artillerie:")
  FrameGadget(#PB_Any,305,35,290,80,"Diplomatie:")
  TextGadget(#PB_Any,355,50,130,20,"Saboteure:")
  TextGadget(#PB_Any,355,70,130,20,"Handelsabkommen:")
  TextGadget(#PB_Any,355,90,130,20,"Friedensvertrag:")
  FrameGadget(#PB_Any,305,115,290,220,"Kriegsschulden:")
  TextGadget(#PB_Any,355,140,130,20,"Mühlen:")
  TextGadget(#PB_Any,355,180,130,20,"Märkte:")
  TextGadget(#PB_Any,355,220,130,20,"Taler:")
  TextGadget(#PB_Any,355,260,130,20,"Land ha:")
  TextGadget(#PB_Any,355,300,130,20,"Sklaven:")
  ks_1=TextGadget(#PB_Any,485,140,90,20,"",#PB_Text_Right)
  ks_2=TextGadget(#PB_Any,485,180,90,20,"",#PB_Text_Right)
  ks_3=TextGadget(#PB_Any,485,220,90,20,"",#PB_Text_Right)
  ks_4=TextGadget(#PB_Any,485,260,90,20,"",#PB_Text_Right)
  ks_5=TextGadget(#PB_Any,485,300,90,20,"",#PB_Text_Right)
  ImageGadget(#PB_Any,15,60,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any,15,140,32,32,ImageID(icon(13)))
  ImageGadget(#PB_Any,15,210,32,32,ImageID(icon(24)))
  ImageGadget(#PB_Any,15,280,32,32,ImageID(icon(33)))
  ImageGadget(#PB_Any,315,60,32,32,ImageID(icon(38)))
  ImageGadget(#PB_Any,315,135,32,32,ImageID(icon(14)))
  ImageGadget(#PB_Any,315,175,32,32,ImageID(icon(15)))
  ImageGadget(#PB_Any,315,215,32,32,ImageID(icon(24)))
  ImageGadget(#PB_Any,315,255,32,32,ImageID(icon(13)))
  ImageGadget(#PB_Any,315,295,32,32,ImageID(icon(28)))
  
  combo=ComboBoxGadget(#PB_Any,10,10,580,22)
  For x=0 To PeekB(spiel)
    If x<>spieler
      AddGadgetItem(combo,-1,titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name)
    EndIf
  Next
  SetGadgetState(combo,0)
  button=ButtonGadget(#PB_Any,200,340,200,40,"Fertig")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case combo
            For x=0 To PeekB(spiel)
              If GetGadgetText(combo)=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                SetGadgetText(txt1,GetGadgetText(combo))
                SetGadgetText(txt2,zauber(PeekB(spieler(x)+122))\zauber)
                SetGadgetText(ks_1,Str(PeekL(spieler(x)+1200+spieler*20+00)))
                SetGadgetText(ks_2,Str(PeekL(spieler(x)+1200+spieler*20+04)))
                SetGadgetText(ks_3,Str(PeekL(spieler(x)+1200+spieler*20+08)))
                SetGadgetText(ks_4,Str(PeekL(spieler(x)+1200+spieler*20+12)))
                SetGadgetText(ks_5,Str(PeekL(spieler(x)+1200+spieler*20+16)))
              EndIf
            Next
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
EndProcedure

;##### ------------------------------------------------------------------------
;##### Infos
;##### ------------------------------------------------------------------------

Procedure Window_About()
  window=WinOpen(250,295,"Über Kaiser")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,50,20,190,40,#Kaiser$+FormatDate(" (%dd.%mm.%yyyy)",#PB_Compiler_Date)+#CRLF$+"by Thomas Hörmann")
  link1=HyperLinkGadget(#PB_Any,10,60,230,20,"https://nipsold.de/kaiser/",$FF0000,#PB_HyperLink_Underline)
  TextGadget(#PB_Any,10,100,230,35,"Dieses Spiel ist Open Source. Du findest den Quellcode unter")
  link2=HyperLinkGadget(#PB_Any,10,135,230,20,"https://github.com/thomas-hoer/kaiser",$FF0000,#PB_HyperLink_Underline)
  TextGadget(#PB_Any,10,175,230,50,"Bei diesem Spiel handelt es von dem Remake und der Weiterführung des Spiels Kaiser von Stefan Maday")
  link3=HyperLinkGadget(#PB_Any,10,225,230,20,"http://yadam.de/KAISER/kaiser.htm",$FF0000,#PB_HyperLink_Underline)
  button=ButtonGadget(#PB_Any,75,265,100,20,"Ok!")
  ImageGadget(#PB_Any,10,20,32,32,ImageID(icon(10)))
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case link1
            RunProgram("https://nipsold.de/kaiser/")
          Case link2
            RunProgram("https://github.com/thomas-hoer/kaiser")
          Case link3
            RunProgram("http://yadam.de/KAISER/kaiser.htm")
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Annale()
  window=WinOpen(550,330,"Halle des Ruhmes")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,200,20,150,20,"Die Zehn Top-Monarchen",#PB_Text_Center)
  TextGadget(#PB_Any, 50,50,230,20,"Name")
  TextGadget(#PB_Any,280,50,100,20,"Domäne")
  TextGadget(#PB_Any,380,50, 50,20,"Jahr",#PB_Text_Right)
  TextGadget(#PB_Any,430,50,100,20,"Punkte",#PB_Text_Right)
  FrameGadget(#PB_Any,10,65,530,220,"")
  For x=0 To 9
    TextGadget(#PB_Any, 20,80+x*20, 20,20,Str(x+1),#PB_Text_Right)
    TextGadget(#PB_Any, 50,80+x*20,230,20,PeekS(annale+x*100))
    TextGadget(#PB_Any,280,80+x*20,100,20,zauber(PeekL(annale+88+x*100))\zauber)
    TextGadget(#PB_Any,380,80+x*20, 50,20,Str(PeekL(annale+92+x*100)),#PB_Text_Right)
    TextGadget(#PB_Any,430,80+x*20,100,20,Str(PeekL(annale+96+x*100)),#PB_Text_Right)
  Next
  ImageGadget(#PB_Any,150,10,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any,368,10,32,32,ImageID(icon(10)))
  button=ButtonGadget(#PB_Any,225,300,100,20,"Wow!")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Rekorde()
  window=WinOpen(400,370,"Her Guinness sein Buch der Rekorde")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,60, 20,320,60,PeekS(annale+9000)+" konnte es gar nicht erwarten und benötigte zur Krönung lediglich "+Str(PeekL(annale+9096))+" Jahre!")
  TextGadget(#PB_Any,60, 80,320,60,PeekS(annale+9100)+" verfügte mit "+Str(PeekL(annale+9196))+" ha über die größte Landmenge aller Zeiten!")
  TextGadget(#PB_Any,60,140,320,60,PeekS(annale+9200)+" gebot über die unerreichte Zahl von "+Str(PeekL(annale+9296))+" Untertanen!")
  TextGadget(#PB_Any,60,200,320,60,"Sagenhafte "+Str(PeekL(annale+9396))+" Taler betrug die Barschaft von "+PeekS(annale+9300))
  TextGadget(#PB_Any,60,260,320,70,"Der stärkste Ritter unter der Sonne ward der blutrünstige "+PeekS(annale+9400)+". Der Halbgott erschlug "+Str(PeekL(annale+9496))+" Feind(e) und diente unter "+PeekS(annale+9500))
  ImageGadget(#PB_Any,20, 20,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any,20, 80,32,32,ImageID(icon( 2)))
  ImageGadget(#PB_Any,20,140,32,32,ImageID(icon(28)))
  ImageGadget(#PB_Any,20,200,32,32,ImageID(icon(14)))
  ImageGadget(#PB_Any,20,260,32,32,ImageID(icon( 3)))
  button=ButtonGadget(#PB_Any,150,330,100,30,"Fertig")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure

;Ereignise Einheiten

Procedure Window_Ereignis_Soeldner1(spieler)
  window=WinOpen(220,230,"Söldner")
  mem=spieler(spieler)
  name.s    ="Wölfe"
  angriff   =4
  abwehr    =3
  treffer   =3
  schritte  =2
  reichweite=1
  salven    =0
  sold      =20
  spezial   =100
  bild      =100
  TextGadget(#PB_Any,10,10,200,60,"Eine Einheit Söldner kam heuer von weit her in unser Land und bot Euch ihre Dienste an:")
  TextGadget(#PB_Any,50,70,120,40,name+#CRLF$+spezial(spezial),#PB_Text_Center)
  TextGadget(#PB_Any,10,110,60,15,"Angriff:")
  TextGadget(#PB_Any,10,125,60,15,"Abwehr:")
  TextGadget(#PB_Any,10,140,60,15,"Treffer:")
  TextGadget(#PB_Any,110,110,65,15,"Reichweite:")
  TextGadget(#PB_Any,110,125,60,15,"Schritte:")
  TextGadget(#PB_Any,110,140,30,15,"Sold:")
  TextGadget(#PB_Any,70,110,30,15,Str(angriff),#PB_Text_Right)
  TextGadget(#PB_Any,70,125,30,15,Str(abwehr),#PB_Text_Right)
  TextGadget(#PB_Any,70,140,30,15,Str(treffer),#PB_Text_Right)
  TextGadget(#PB_Any,175,110,25,15,Str(reichweite),#PB_Text_Right)
  TextGadget(#PB_Any,170,125,30,15,Str(schritte),#PB_Text_Right)
  TextGadget(#PB_Any,140,140,60,15,Str(sold),#PB_Text_Right)
  TextGadget(#PB_Any,10,160,200,40,"Wollt Ihr die Einheit Eurer glorreichen Armee hinzufügen?")
  ImageGadget(#PB_Any,10,70,32,32,ImageID(icon(ehicon(bild,0))))
  ImageGadget(#PB_Any,178,70,32,32,ImageID(icon(33)))
  button=ButtonGadget(#PB_Any,20,200,80,20,"Ja")
  abbrechen=ButtonGadget(#PB_Any,120,200,80,20,"Nein")
  PokeW(mem+46,PeekW(mem+46)+2)
  Repeat
    Event=WaitWindowEvent(20)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            AddEinheit(spieler,name,angriff,abwehr,treffer,schritte,reichweite,salven,sold,spezial,bild)
            CloseWindow(window)
            ProcedureReturn 1
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Ereignis_Soeldner2(spieler)
  window=WinOpen(220,230,"Söldner")
  mem=spieler(spieler)
  name.s    ="Assassinen"
  angriff   =6
  abwehr    =4
  treffer   =5
  schritte  =1
  reichweite=1
  salven    =0
  sold      =960
  spezial   =101
  bild      =101
  TextGadget(#PB_Any,10,10,200,60,"Eine Einheit Söldner kam heuer von weit her in unser Land und bot Euch ihre Dienste an:")
  TextGadget(#PB_Any,50,70,120,40,name+#CRLF$+spezial(spezial),#PB_Text_Center)
  TextGadget(#PB_Any,10,110,60,15,"Angriff:")
  TextGadget(#PB_Any,10,125,60,15,"Abwehr:")
  TextGadget(#PB_Any,10,140,60,15,"Treffer:")
  TextGadget(#PB_Any,110,110,65,15,"Reichweite:")
  TextGadget(#PB_Any,110,125,60,15,"Schritte:")
  TextGadget(#PB_Any,110,140,30,15,"Sold:")
  TextGadget(#PB_Any,70,110,30,15,Str(angriff),#PB_Text_Right)
  TextGadget(#PB_Any,70,125,30,15,Str(abwehr),#PB_Text_Right)
  TextGadget(#PB_Any,70,140,30,15,Str(treffer),#PB_Text_Right)
  TextGadget(#PB_Any,175,110,25,15,Str(reichweite),#PB_Text_Right)
  TextGadget(#PB_Any,170,125,30,15,Str(schritte),#PB_Text_Right)
  TextGadget(#PB_Any,140,140,60,15,Str(sold),#PB_Text_Right)
  TextGadget(#PB_Any,10,160,200,40,"Wollt Ihr die Einheit Eurer glorreichen Armee hinzufügen?")
  ImageGadget(#PB_Any,10,70,32,32,ImageID(icon(ehicon(bild,0))))
  ImageGadget(#PB_Any,178,70,32,32,ImageID(icon(33)))
  button=ButtonGadget(#PB_Any,20,200,80,20,"Ja")
  abbrechen=ButtonGadget(#PB_Any,120,200,80,20,"Nein")
  PokeW(mem+46,PeekW(mem+46)+2)
  Repeat
    Event=WaitWindowEvent(20)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            AddEinheit(spieler,name,angriff,abwehr,treffer,schritte,reichweite,salven,sold,spezial,bild)
            CloseWindow(window)
            ProcedureReturn 1
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Ereignis_Vampir(spieler)
  window=WinOpen(220,230,"Söldner")
  mem=spieler(spieler)
  name.s    ="Vampire"
  angriff   =7
  abwehr    =5
  treffer   =7
  schritte  =2
  reichweite=1
  salven    =0
  sold      =0
  spezial   =102
  bild      =110
  TextGadget(#PB_Any,10,10,200,60,"Eine Schar seltsamer Fremder kam heuer aus dem Osten in unser Land, um Euch zu dienen!")
  TextGadget(#PB_Any,50,70,120,40,name+#CRLF$+spezial(spezial),#PB_Text_Center)
  TextGadget(#PB_Any,10,110,60,15,"Angriff:")
  TextGadget(#PB_Any,10,125,60,15,"Abwehr:")
  TextGadget(#PB_Any,10,140,60,15,"Treffer:")
  TextGadget(#PB_Any,110,110,65,15,"Reichweite:")
  TextGadget(#PB_Any,110,125,60,15,"Schritte:")
  TextGadget(#PB_Any,110,140,30,15,"Sold:")
  TextGadget(#PB_Any,70,110,30,15,Str(angriff),#PB_Text_Right)
  TextGadget(#PB_Any,70,125,30,15,Str(abwehr),#PB_Text_Right)
  TextGadget(#PB_Any,70,140,30,15,Str(treffer),#PB_Text_Right)
  TextGadget(#PB_Any,175,110,25,15,Str(reichweite),#PB_Text_Right)
  TextGadget(#PB_Any,170,125,30,15,Str(schritte),#PB_Text_Right)
  TextGadget(#PB_Any,140,140,60,15,Str(sold),#PB_Text_Right)
  TextGadget(#PB_Any,10,160,200,40,"Eure Untertanen sind entsetzt ob des Anblicks dieser Gestalten")
  ImageGadget(#PB_Any,10,70,32,32,ImageID(ehicon(bild,0)))
  ImageGadget(#PB_Any,178,70,32,32,ImageID(icon(33)))
  button=ButtonGadget(#PB_Any,70,200,80,20,"Fein")
  PokeW(mem+46,PeekW(mem+46)+2)
  Repeat
    Event=WaitWindowEvent(20)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            AddEinheit(spieler,name,angriff,abwehr,treffer,schritte,reichweite,salven,sold,spezial,bild)
            CloseWindow(window)
            ProcedureReturn 1
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure

;Ereignis Verwaltung

Procedure.i Zufallsereignis(Spieler)
  
  Protected mem=spieler(spieler)
  Protected Ereignis.i = -1
  
  RandomSeed(Date())
  
  Zufall = Random(100)
  
  If Random(100) > 50
    
    Select Zufall
        
      Case 0 To 10
        Ereignis=0
        Spielerdaten(Spieler)\Maerkte + 2
        
      Case 10 To 20
        Ereignis=1
        land=Random(Spielerdaten(Spieler)\Titel*500)+Random(200)+Random(500)+Random(500)
        Spielerdaten(Spieler)\Land + Land
        *Game\restliches_land - Land
        
      Case 20 To 30
        Ereignis=2    
        taler=Random(Spielerdaten(Spieler)\Titel*1000)+Random(400)+Random(1000)+Random(1000)
        Spielerdaten(Spieler)\Taler + Taler
        
      Case 30 To 40
        Ereignis=3
        Spielerdaten(Spieler)\Geburtenrate = Spielerdaten(Spieler)\Geburtenrate * 2
        
      Case 40 To 50
        Ereignis=4
        Rate = (Spielerdaten(Spieler)\Sterberate *2) + 100
        If Rate>500
          Spielerdaten(Spieler)\Sterberate = 500
        Else
          Spielerdaten(Spieler)\Sterberate = Rate
        EndIf
        
      Case 50 To 60
        If Spielerdaten(Spieler)\Maerkte>1
          Ereignis=5     
          Spielerdaten(Spieler)\Maerkte - 1
        Else
          ProcedureReturn #True
        EndIf
        
      Case 60 To 70
        If Spielerdaten(Spieler)\Muehlen>0
          Ereignis=6
          Spielerdaten(Spieler)\Muehlen - 1
        Else
          ProcedureReturn #True
        EndIf        
        
      Case 70 To 80
        Ereignis=7
        Rate = (Spielerdaten(Spieler)\Sterberate *2) + 100
        If Rate>500
          Spielerdaten(Spieler)\Sterberate = 500
        Else
          Spielerdaten(Spieler)\Sterberate = Rate
        EndIf        
        If Spielerdaten(Spieler)\Maerkte > 1
          Spielerdaten(Spieler)\Maerkte - 2
        EndIf
        If Spielerdaten(Spieler)\Muehlen > 0
          Spielerdaten(Spieler)\Muehlen - 1
        EndIf        
        
    EndSelect
    
    Zufall=Random(1000)
    
    If Zufall>=100
      
      Zufall=Random(100)
      
      Select Zufall
          
        Case 0 To 49
          Window_Ereignis_Soeldner1(spieler)
          
        Case 50 To 99
          Window_Ereignis_Soeldner2(spieler)
          
      EndSelect
      
    EndIf
    
  Else
    
    If PeekB(spieler(spieler)+122)=11
      Window_Ereignis_Vampir(spieler)
    EndIf
    
  EndIf
  
  If Ereignis >-1
    
    
    ;ImageGadget(#PB_Any,10,10,32,32,ImageID(Icon(Ereignis(Ereignis)\Icon)))
    Select Ereignis(Ereignis)\Window_Type
      Case 1
        Win = WinOpen(300,100,Ereignis(Ereignis)\Titel)
        TextGadget(#PB_Any,50,10,240,60,Ereignis(Ereignis)\Text[0])
        
        Button = ButtonGadget(#PB_Any,100,70,100,20,Ereignis(Ereignis)\Button)
      Case 2
        Win = WinOpen(300,160,Ereignis(Ereignis)\Titel)
        TextGadget(#PB_Any,50,10,240,60,Ereignis(Ereignis)\Text[0])
        TextGadget(#PB_Any,10,70,280,60,Ereignis(Ereignis)\Text[1])
        
        Button = ButtonGadget(#PB_Any,100,130,100,20,Ereignis(Ereignis)\Button)
      Case 3
        Win = WinOpen(300,220,Ereignis(Ereignis)\Titel)
        TextGadget(#PB_Any,50,10,240,60,Ereignis(Ereignis)\Text[0])
        TextGadget(#PB_Any,10,70,280,60,Ereignis(Ereignis)\Text[1])
        TextGadget(#PB_Any,10,130,280,60,Ereignis(Ereignis)\Text[2])
        
        Button = ButtonGadget(#PB_Any,100,190,100,20,Ereignis(Ereignis)\Button)
    EndSelect
    
    ImageGadget(#PB_Any,10,10,32,32,ImageID(icon(Ereignis(Ereignis)\Icon)))
    Repeat
      
      Event = WaitWindowEvent(2)
      
      If Event = #PB_Event_Gadget
        If EventGadget() = Button
          CloseWindow(Win)
          ProcedureReturn #True
        EndIf
      EndIf
      
    ForEver
    
  EndIf
  
EndProcedure
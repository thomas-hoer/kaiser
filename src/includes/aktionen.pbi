;##### ------------------------------------------------------------------------
;##### 
;##### Aktionen.pbi
;##### 
;##### ------------------------------------------------------------------------

Declare Window_Begruesung(Spiel)

Procedure.s Load_Game(Filename.s = "")
  
  If Filename = ""
    
    Filename = GetCurrentDirectory()
    
  EndIf
  
  Filename.s = OpenFileRequester("Lade Kaiser Savegame",Filename,"Kaiser Savegames (*.ksg)|*.ksg|Alle Datein|*.*",0)
  
  If Filename.s
    
    readfile=ReadFile(-1,Filename)
    
    If readfile
      If ReadLong(readfile)&$FF000000<>#Kaiser_Version&$FF000000
        MessageRequester("Fehler","Konnte Datei "+GetFilePart(Filename)+" nicht Laden")
      Else
        ReadData(readfile,mem1,Lof(readfile)-8)
        If UncompressMemory(mem1,Lof(readfile)-8,mem2,MemorySize(mem2))
          For x=0 To 9
            CopyMemory(mem2+(x*#spieler_size),spieler(x),#spieler_size)
          Next
          CopyMemory(mem2+10*#spieler_size,spiel,#spieler_size)
        EndIf
        Window_Begruesung(PeekB(spiel+3))
        DisableMenu(0)
      EndIf
      CloseFile(readfile)
    Else
      MessageRequester("Fehler","Konnte Datei "+Filename+" nicht Öffnen")
    EndIf
    
  EndIf
  
  ProcedureReturn Filename.s
  
EndProcedure
Procedure.s Save_Game(Filename.s = "")
  
  If Filename = ""
    
    Filename = GetCurrentDirectory()
    
  EndIf
  
  If Filename=""
    Filename=SaveFileRequester("Speichere Kaiser Savegame",Filename,"Kaiser Savegames (*.ksg)|*.ksg|Alle Datein|*.*",0)
    If Filename And ReadFile(0,Filename)
      If MessageRequester("Warnung","Die Datei existiert bereits, soll sie Überschrieben werden?",#PB_MessageRequester_YesNo)=#PB_MessageRequester_No
        Filename=""
      EndIf
    EndIf
  EndIf
  
  If Filename
    If GetExtensionPart(Filename)<>"ksg"
      Filename+".ksg"
    EndIf
    ;mem1=AllocateMemory(10*#spieler_size+#spiel_size)
    ;mem2=AllocateMemory(10*#spieler_size+#spiel_size+8)
    For x=0 To 9
      CopyMemory(spieler(x),mem1+(x*#spieler_size),#spieler_size)
    Next
    CopyMemory(spiel,mem1+10*#spieler_size,#spiel_size)
    CreateFile(0,Filename)
    WriteLong(0,#Kaiser_Version)
    len=CompressMemory(mem1,10*#spieler_size+#spiel_size,mem2,MemorySize(mem2))
    WriteData(0,mem2,len)
    CloseFile(0)
    ;FreeMemory(mem1)
    ;FreeMemory(mem2)
  EndIf
  
  ProcedureReturn Filename.s
  
EndProcedure

Procedure Window_Kornverteilen(spieler)
  window=WinOpen(450,280,"Kornverteilung")
  
  mem=spieler(spieler)
  FrameGadget(-1,10,10,90,260,"Verkauf")
  b11=ButtonGadget(-1,20, 30,70,30,"-100000")
  b12=ButtonGadget(-1,20, 70,70,30,"-10000")
  b13=ButtonGadget(-1,20,110,70,30,"-1000")
  b14=ButtonGadget(-1,20,150,70,30,"-100")
  ;b15=ButtonGadget(-1,20,190,70,30,">benötigt")
  ;b16=ButtonGadget(-1,20,230,70,30,">maximum")
  FrameGadget(-1,350,10,90,260,"Verkauf")
  b21=ButtonGadget(-1,360, 30,70,30,"+100000")
  b22=ButtonGadget(-1,360, 70,70,30,"+10000")
  b23=ButtonGadget(-1,360,110,70,30,"+1000")
  b24=ButtonGadget(-1,360,150,70,30,"+100")
  ;b25=ButtonGadget(-1,360,190,70,30,">benötigt")
  ;b26=ButtonGadget(-1,360,230,70,30,">maximum")
  FrameGadget(-1,210,10,130,60,"")
  TextGadget(-1,220,20,60,15,"Einwohner:")
  TextGadget(-1,220,35,60,15,"Kapazität:")
  TextGadget(-1,220,50,60,15,"Kornmenge:")
  TextGadget(-1,280,20,50,15,Str(PeekL(mem+17)),#PB_Text_Right)
  TextGadget(-1,280,35,50,15,Str(PeekL(mem+80)),#PB_Text_Right)
  kornmenge=TextGadget(-1,280,50,50,15,Str(PeekL(mem+29)),#PB_Text_Right)
  
  FrameGadget(-1,210,70,130,80,"")
  b31=ButtonGadget(-1,220,085,60,15,"Minimum")
  b32=ButtonGadget(-1,220,105,60,15,"Benötigt")
  b33=ButtonGadget(-1,220,125,60,15,"Maximum")
  TextGadget(-1,280,085,50,15,Str(PeekL(mem+17)*0.5),#PB_Text_Right)
  TextGadget(-1,280,105,50,15,Str(PeekL(mem+17)*5),#PB_Text_Right)
  TextGadget(-1,280,125,50,15,Str(PeekL(mem+17)*5.3),#PB_Text_Right)
  
  FrameGadget(-1,210,150,130,45,"")
  TextGadget(-1,220,160,60,15,"Taler:")
  TextGadget(-1,220,175,70,15,"Preis a gros")
  taler=TextGadget(-1,280,160,50,15,Str(PeekL(mem+25)),#PB_Text_Right)
  TextGadget(-1,290,175,40,15,Str(PeekB(mem+37)),#PB_Text_Right)
  
  FrameGadget(-1,110,205,230,40,"Kornzuteilung an die Bevölkerung")
  track=TrackBarGadget(-1,120,220,150,20,PeekL(mem+17)*0.5,PeekL(mem+17)*5.3)
  zuteilung=TextGadget(-1,280,220,50,15,Str(PeekL(mem+131)),#PB_Text_Right)
  SetGadgetState(track,PeekL(mem+131))
  
  kornverteilung = CanvasGadget(-1,110,20,89,178)
  If PeekL(mem+17)
    fill=PeekL(mem+29)*178/(PeekL(mem+17)*5)
  Else
    fill=Random(178)
  EndIf
  If fill>178
    fill=178
  ElseIf fill<0
    fill=0
  EndIf
  StartDrawing(CanvasOutput(kornverteilung))
  DrawImage(ImageID(korn1),0,0)
  ClipOutput(0,178-fill,89,fill)
  DrawImage(ImageID(korn2),0,0)
  StopDrawing()
  
  If PeekL(mem+29)<GetGadgetState(track)
    SetGadgetState(track,PeekL(mem+29))
    SetGadgetText(zuteilung,Str(PeekL(mem+29)))
  EndIf
  If PeekL(mem+29)<PeekL(mem+17)*5
    DisableGadget(b32,1)
  Else
    DisableGadget(b32,0)
  EndIf
  If PeekL(mem+29)<PeekL(mem+17)*5.3
    DisableGadget(b33,1)
  Else
    DisableGadget(b33,0)
  EndIf
  
  button=ButtonGadget(-1,210,250,130,20,"Fertig")
  If PeekL(mem+17)
    fill=PeekL(mem+29)*178/(PeekL(mem+17)*5)
  Else
    fill=Random(178)
  EndIf
  If fill>178
    fill=178
  ElseIf fill<0
    fill=0
  EndIf
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case b11,b12,b13,b14,b15,b21,b22,b23,b24,b25
            PlaySound(sounds(10))
        EndSelect
        Select EventGadget
          Case b11
            If PeekL(mem+29)>=100000+PeekL(mem+17)*0.5
              PokeL(mem+29,PeekL(mem+29)-100000)
              PokeL(mem+25,PeekL(mem+25)+(PeekB(mem+37)*1000/2))
            EndIf
          Case b12
            If PeekL(mem+29)>=10000+PeekL(mem+17)*0.5
              PokeL(mem+29,PeekL(mem+29)-10000)
              PokeL(mem+25,PeekL(mem+25)+(PeekB(mem+37)*100/2))
            EndIf
          Case b13
            If PeekL(mem+29)>=1000+PeekL(mem+17)*0.5
              PokeL(mem+29,PeekL(mem+29)-1000)
              PokeL(mem+25,PeekL(mem+25)+(PeekB(mem+37)*10/2))
            EndIf
          Case b14
            If PeekL(mem+29)>=100+PeekL(mem+17)*0.5
              PokeL(mem+29,PeekL(mem+29)-100)
              PokeL(mem+25,PeekL(mem+25)+(PeekB(mem+37)*1/2))
            EndIf
          Case b21
            If PeekL(mem+80)>=PeekL(mem+29)+100000 And PeekL(mem+25)-(PeekB(mem+37)*1000)>-(PeekL(mem+17)*10)
              PokeL(mem+29,PeekL(mem+29)+100000)
              PokeL(mem+25,PeekL(mem+25)-(PeekB(mem+37)*1000))
            EndIf
          Case b22
            If PeekL(mem+80)>=PeekL(mem+29)+10000 And PeekL(mem+25)-(PeekB(mem+37)*100)>-(PeekL(mem+17)*10)
              PokeL(mem+29,PeekL(mem+29)+10000)
              PokeL(mem+25,PeekL(mem+25)-(PeekB(mem+37)*100))
            EndIf
          Case b23
            If PeekL(mem+80)>=PeekL(mem+29)+1000 And PeekL(mem+25)-(PeekB(mem+37)*10)>-(PeekL(mem+17)*10)
              PokeL(mem+29,PeekL(mem+29)+1000)
              PokeL(mem+25,PeekL(mem+25)-(PeekB(mem+37)*10))
            EndIf
          Case b24
            If PeekL(mem+80)>=PeekL(mem+29)+100 And PeekL(mem+25)-(PeekB(mem+37)*1)>-(PeekL(mem+17)*10)
              PokeL(mem+29,PeekL(mem+29)+100)
              PokeL(mem+25,PeekL(mem+25)-(PeekB(mem+37)*1))
            EndIf
          Case b31
            SetGadgetState(track,PeekL(mem+17)*0.5)
          Case b32
            SetGadgetState(track,PeekL(mem+17)*5)
          Case b33
            SetGadgetState(track,PeekL(mem+17)*5.3)
          Case button
            PokeL(mem+131,GetGadgetState(track))
            If GetGadgetState(track)<PeekL(mem+17)*5
              geburt=10
              sterbe=1000-(GetGadgetState(track)*1000/(PeekL(mem+17)*5))
            ElseIf GetGadgetState(track)>PeekL(mem+17)*5
              sterbe=10
              geburt=10+((GetGadgetState(track)-PeekL(mem+17)*5)*100/PeekL(mem+17)*5)
            Else
              geburt=10
              sterbe=10
            EndIf
            PokeW(mem+86,geburt)
            PokeW(mem+88,sterbe)
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
        If PeekL(mem+29)<PeekL(mem+17)*5
          DisableGadget(b32,1)
        Else
          DisableGadget(b32,0)
        EndIf
        If PeekL(mem+29)<PeekL(mem+17)*5.3
          DisableGadget(b33,1)
        Else
          DisableGadget(b33,0)
        EndIf
        SetGadgetText(kornmenge,Str(PeekL(mem+29)))
        SetGadgetText(taler,Str(PeekL(mem+25)))
        SetGadgetText(zuteilung,Str(GetGadgetState(track)))
        If PeekL(mem+29)<GetGadgetState(track)
          SetGadgetState(track,PeekL(mem+29))
          SetGadgetText(zuteilung,Str(PeekL(mem+29)))
        EndIf
        If PeekL(mem+17)
          fill=PeekL(mem+29)*178/(PeekL(mem+17)*5)
        Else
          fill=Random(178)
        EndIf
        If fill>178
          fill=178
        ElseIf fill<0
          fill=0
        EndIf
        StartDrawing(CanvasOutput(kornverteilung))
        DrawImage(ImageID(korn1),0,0)
        ClipOutput(0,178-fill,89,fill)
        DrawImage(ImageID(korn2),0,0)
        StopDrawing()
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Landkauf(spieler)
  window=WinOpen(380,240,"An- und Verkauf von Land")
  
  mem=spieler(spieler)
  
  FrameGadget(-1,10,10,90,220,"Verkauf")
  b11=ButtonGadget(-1,20, 30,70,30,"-10000")
  b12=ButtonGadget(-1,20, 70,70,30,"-1000")
  b13=ButtonGadget(-1,20,110,70,30,"-100")
  b14=ButtonGadget(-1,20,150,70,30,"-10")
  b15=ButtonGadget(-1,20,190,70,30,"-1")
  FrameGadget(-1,280,10,90,220,"Ankauf")
  b21=ButtonGadget(-1,290, 30,70,30,"+10000")
  b22=ButtonGadget(-1,290, 70,70,30,"+1000")
  b23=ButtonGadget(-1,290,110,70,30,"+100")
  b24=ButtonGadget(-1,290,150,70,30,"+10")
  b25=ButtonGadget(-1,290,190,70,30,"+1")
  FrameGadget(-1,110,60,160,90,"")
  TextGadget(-1,120, 70,80,20,"Taler:")
  TextGadget(-1,120, 90,80,20,"Land ha:")
  TextGadget(-1,120,110,80,20,"verfügbar:")
  TextGadget(-1,120,130,80,20,"Preis a 10ha:")
  taler=     TextGadget(-1,200, 70,60,20,Str(PeekL(mem+25)),#PB_Text_Right)
  land=      TextGadget(-1,200, 90,60,20,Str(PeekL(mem+21)),#PB_Text_Right)
  verfuegbar=TextGadget(-1,200,110,60,20,Str(PeekL(spiel+4)),#PB_Text_Right)
  TextGadget(-1,200,130,60,20,Str(PeekB(mem+36)),#PB_Text_Right)
  button=ButtonGadget(-1,140,190,100,30,"Fertig")
  ImageGadget(-1,110,20,32,32,ImageID(icon(13)))
  ImageGadget(-1,142,20,32,32,ImageID(icon(13)))
  ImageGadget(-1,174,20,32,32,ImageID(icon(13)))
  ImageGadget(-1,206,20,32,32,ImageID(icon(13)))
  ImageGadget(-1,238,20,32,32,ImageID(icon(13)))
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case b11,b12,b13,b14,b15,b21,b22,b23,b24,b25
            PlaySound(sounds(10))
        EndSelect
        Select EventGadget
          Case b11
            If PeekL(mem+21)>=12000
              PokeL(spiel+4,PeekL(spiel+4)+10000)
              PokeL(mem+21, PeekL(mem+21) -10000)
              PokeL(mem+25, PeekL(mem+25)+(1000*(PeekB(mem+36)-1)))
            EndIf
          Case b12
            If PeekL(mem+21)>=3000
              PokeL(spiel+4,PeekL(spiel+4)+1000)
              PokeL(mem+21, PeekL(mem+21) -1000)
              PokeL(mem+25, PeekL(mem+25)+(100*(PeekB(mem+36)-1)))
            EndIf
          Case b13
            If PeekL(mem+21)>=2100
              PokeL(spiel+4,PeekL(spiel+4)+100)
              PokeL(mem+21, PeekL(mem+21) -100)
              PokeL(mem+25, PeekL(mem+25)+(10*(PeekB(mem+36)-1)))
            EndIf
          Case b14
            If PeekL(mem+21)>=2010
              PokeL(spiel+4,PeekL(spiel+4)+10)
              PokeL(mem+21, PeekL(mem+21) -10)
              PokeL(mem+25, PeekL(mem+25)+(1*(PeekB(mem+36)-1)))
            EndIf
          Case b15
            If PeekL(mem+21)>=2001
              PokeL(spiel+4,PeekL(spiel+4)+1)
              PokeL(mem+21, PeekL(mem+21) -1)
              PokeL(mem+25, PeekL(mem+25)+Round(0.1*(PeekB(mem+36)-1),#PB_Round_Down))
            EndIf
          Case b21
            If PeekL(spiel+4)>10000  And PeekL(mem+25)-(1000*(PeekB(mem+36)))>-(PeekL(mem+17)*10)
              PokeL(spiel+4,PeekL(spiel+4)-10000)
              PokeL(mem+21, PeekL(mem+21) +10000)
              PokeL(mem+25, PeekL(mem+25)-(1000*(PeekB(mem+36))))
            EndIf
          Case b22
            If PeekL(spiel+4)>1000  And PeekL(mem+25)-(100*(PeekB(mem+36)))>-(PeekL(mem+17)*10)
              PokeL(spiel+4,PeekL(spiel+4)-1000)
              PokeL(mem+21, PeekL(mem+21) +1000)
              PokeL(mem+25, PeekL(mem+25)-(100*(PeekB(mem+36))))
            EndIf
          Case b23
            If PeekL(spiel+4)>100  And PeekL(mem+25)-(10*(PeekB(mem+36)))>-(PeekL(mem+17)*10)
              PokeL(spiel+4,PeekL(spiel+4)-100)
              PokeL(mem+21, PeekL(mem+21) +100)
              PokeL(mem+25, PeekL(mem+25)-(10*(PeekB(mem+36))))
            EndIf
          Case b24
            If PeekL(spiel+4)>10  And PeekL(mem+25)-(1*(PeekB(mem+36)))>-(PeekL(mem+17)*10)
              PokeL(spiel+4,PeekL(spiel+4)-10)
              PokeL(mem+21, PeekL(mem+21) +10)
              PokeL(mem+25, PeekL(mem+25)-(1*(PeekB(mem+36))))
            EndIf
          Case b25
            If PeekL(spiel+4)>10  And PeekL(mem+25)-Round(0.1*(PeekB(mem+36)),#PB_Round_Up)>-(PeekL(mem+17)*10)
              PokeL(spiel+4,PeekL(spiel+4)-1)
              PokeL(mem+21, PeekL(mem+21) +1)
              PokeL(mem+25, PeekL(mem+25)-Round(0.1*(PeekB(mem+36)),#PB_Round_Up))
            EndIf
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
        SetGadgetText(taler,Str(PeekL(mem+25)))
        SetGadgetText(land,Str(PeekL(mem+21)))
        SetGadgetText(verfuegbar,Str(PeekL(spiel+4)))
        
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Bauwerke(spieler)
  window=WinOpen(450,350,"Kauf von Bauwerken")
  
  mem=spieler(spieler)
  FrameGadget(-1,20,20,130,100,"Marktplatz")
  TextGadget(-1,70,40,60,20,"1000 Taler")
  TextGadget(-1,70,60,40,20,"Besitz:")
  markt=TextGadget(-1,110,60,30,20,Str(PeekW(mem+46)),#PB_Text_Right)
  markt2=ButtonGadget(-1,30,80,110,30,"Kauf mich!")
  
  FrameGadget(-1,160,20,130,100,"Kornmühle")
  TextGadget(-1,210,40,60,20,"2000 Taler")
  TextGadget(-1,210,60,40,20,"Besitz:")
  muehle=TextGadget(-1,250,60,30,20,Str(PeekW(mem+48)),#PB_Text_Right)
  muehle2=ButtonGadget(-1,170,80,110,30,"Kauf mich!")
  
  FrameGadget(-1,300,20,130,100,"Kornspeicher")
  TextGadget(-1,350,40,60,20,"2500 Taler")
  TextGadget(-1,350,60,40,20,"Besitz:")
  speicher=TextGadget(-1,390,60,30,20,Str(PeekW(mem+50)),#PB_Text_Right)
  speicher2=ButtonGadget(-1,310,80,110,30,"Kauf mich!")
  
  FrameGadget(-1,20,140,130,100,"Palast (Teil)")
  TextGadget(-1,70,160,60,20,"5000 Taler")
  TextGadget(-1,70,180,40,20,"Besitz:")
  palast=TextGadget(-1,110,180,30,20,Str(PeekB(mem+54)),#PB_Text_Right)
  palast2=ButtonGadget(-1,30,200,110,30,"Kauf mich!")
  
  FrameGadget(-1,160,140,130,100,"Kathedrale (Teil)")
  TextGadget(-1,210,160,60,20,"9000 Taler")
  TextGadget(-1,210,180,40,20,"Besitz:")
  kathedrale=TextGadget(-1,250,180,30,20,Str(PeekB(mem+55)),#PB_Text_Right)
  kathedrale2=ButtonGadget(-1,170,200,110,30,"Kauf mich!")
  
  FrameGadget(-1,300,140,130,100,"Lagerhalle")
  TextGadget(-1,350,160,60,20,"4000 Taler")
  TextGadget(-1,350,180,40,20,"Besitz:")
  lager=TextGadget(-1,390,180,30,20,Str(PeekW(mem+52)),#PB_Text_Right)
  lager2=ButtonGadget(-1,310,200,110,30,"Kauf mich!")
  
  FrameGadget(-1,20,250,410,50,"Kapital")
  TextGadget(-1,30,270,60,20,"Taler:")
  taler=TextGadget(-1,90,270,50,20,Str(PeekL(mem+25)),#PB_Text_Right)
  TextGadget(-1,150,270,60,20,"Bauland ha:")
  land=TextGadget(-1,210,270,60,20,Str(PeekL(mem+21)),#PB_Text_Right)
  ImageGadget(-1, 30, 40,32,32,ImageID(icon(14)))
  ImageGadget(-1,170, 40,32,32,ImageID(icon(15)))
  ImageGadget(-1,310, 40,32,32,ImageID(icon(16)))
  ImageGadget(-1, 30,160,32,32,ImageID(icon(17)))
  ImageGadget(-1,170,160,32,32,ImageID(icon(18)))
  ImageGadget(-1,310,160,32,32,ImageID(icon(19)))
  
  button=ButtonGadget(-1,170,310,110,30,"Fertig")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case markt2,muehle2,speicher2,lager2,palast2,kathedrale2
            PlaySound(sounds(10))
        EndSelect
        
        Select EventGadget
          Case markt2
            If PeekW(mem+46)<PeekL(mem+21)/1000 And PeekL(mem+25)-1000>-(PeekL(mem+17)*10)
              PokeW(mem+46,PeekW(mem+46)+1)
              PokeL(mem+25,PeekL(mem+25)-1000)
            EndIf
          Case muehle2
            If PeekW(mem+48)<PeekL(mem+21)/1000 And PeekL(mem+25)-2000>-(PeekL(mem+17)*10)
              PokeW(mem+48,PeekW(mem+48)+1)
              PokeL(mem+25,PeekL(mem+25)-2000)
              PokeL(mem+80,PeekL(mem+80)+2000)
            EndIf
          Case speicher2
            If PeekW(mem+50)<PeekL(mem+21)/1000 And PeekL(mem+25)-2500>-(PeekL(mem+17)*10)
              PokeW(mem+50,PeekW(mem+50)+1)
              PokeL(mem+25,PeekL(mem+25)-2500)
              PokeL(mem+80,PeekL(mem+80)+10000)
            EndIf
          Case lager2
            If PeekW(mem+52)<PeekL(mem+21)/1000 And PeekL(mem+25)-4000>-(PeekL(mem+17)*10)
              PokeW(mem+52,PeekW(mem+52)+1)
              PokeL(mem+25,PeekL(mem+25)-4000)
              PokeL(mem+56,PeekL(mem+56)+1000)
            EndIf
          Case palast2
            If PeekB(mem+54)<12 And PeekB(mem+125)=0 And PeekL(mem+25)-5000>-(PeekL(mem+17)*10)
              PokeB(mem+125,1)
              PokeB(mem+54,PeekB(mem+54)+1)
              PokeL(mem+25,PeekL(mem+25)-5000)
            EndIf
          Case kathedrale2
            If PeekB(mem+55)<12 And PeekW(mem+84)=9 And PeekB(mem+126)=0 And PeekL(mem+25)-9000>-(PeekL(mem+17)*10)
              PokeB(mem+126,1)
              PokeB(mem+55,PeekB(mem+55)+1)
              PokeL(mem+25,PeekL(mem+25)-9000)
            EndIf
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
        SetGadgetText(markt,Str(PeekW(mem+46)))
        SetGadgetText(muehle,Str(PeekW(mem+48)))
        SetGadgetText(speicher,Str(PeekW(mem+50)))
        SetGadgetText(lager,Str(PeekW(mem+52)))
        SetGadgetText(palast,Str(PeekB(mem+54)))
        SetGadgetText(kathedrale,Str(PeekB(mem+55)))
        SetGadgetText(taler,Str(PeekL(mem+25)))
        SetGadgetText(land,Str(PeekL(mem+21)))
        
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Verkaufen(spieler)
  window=WinOpen(450,320,"Güter verkaufen")
  
  mem=spieler(spieler)
  TextGadget(-1,120,20,60,20,"Preis",#PB_Text_Right)
  TextGadget(-1,180,20,60,20,"Last",#PB_Text_Right)
  TextGadget(-1,380,20,60,20,"Verkaufen",#PB_Text_Right)
  
  TextGadget(-1,60, 60,60,20,"Salz:")
  TextGadget(-1,60,100,60,20,"Bier:")
  TextGadget(-1,60,140,60,20,"Wein:")
  TextGadget(-1,60,180,60,20,"Waffen:")
  
  TextGadget(-1,120, 60,60,20,Str(PeekW(mem+38)),#PB_Text_Right)
  TextGadget(-1,120,100,60,20,Str(PeekW(mem+40)),#PB_Text_Right)
  TextGadget(-1,120,140,60,20,Str(PeekW(mem+42)),#PB_Text_Right)
  TextGadget(-1,120,180,60,20,Str(PeekW(mem+44)),#PB_Text_Right)
  
  l1=TextGadget(-1,180, 60,60,20,Str(PeekL(mem+60)),#PB_Text_Right)
  l2=TextGadget(-1,180,100,60,20,Str(PeekL(mem+64)),#PB_Text_Right)
  l3=TextGadget(-1,180,140,60,20,Str(PeekL(mem+68)),#PB_Text_Right)
  l4=TextGadget(-1,180,180,60,20,Str(PeekL(mem+72)),#PB_Text_Right)
  
  t1=TrackBarGadget(-1,260, 60,100,20,0,PeekL(mem+60))
  t2=TrackBarGadget(-1,260,100,100,20,0,PeekL(mem+64))
  t3=TrackBarGadget(-1,260,140,100,20,0,PeekL(mem+68))
  t4=TrackBarGadget(-1,260,180,100,20,0,PeekL(mem+72))
  
  v1=TextGadget(-1,380, 60,60,20,"0",#PB_Text_Right)
  v2=TextGadget(-1,380,100,60,20,"0",#PB_Text_Right)
  v3=TextGadget(-1,380,140,60,20,"0",#PB_Text_Right)
  v4=TextGadget(-1,380,180,60,20,"0",#PB_Text_Right)
  
  FrameGadget(-1,40,220,360,40,"")
  TextGadget(-1, 50,235,130,20,"Freie Lagerkapazität:")
  lager=TextGadget(-1,180,235,60,20,Str(PeekL(mem+56)),#PB_Text_Right)
  TextGadget(-1,260,235,60,20,"Taler:")
  taler=TextGadget(-1,320,235,60,20,Str(PeekL(mem+25)),#PB_Text_Right)
  button=ButtonGadget(-1,175,270,100,30,"So soll es sein!")
  
  ImageGadget(-1,20, 50,32,32,ImageID(icon(20)))
  ImageGadget(-1,20, 90,32,32,ImageID(icon(21)))
  ImageGadget(-1,20,130,32,32,ImageID(icon(22)))
  ImageGadget(-1,20,170,32,32,ImageID(icon(23)))
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case t1
            verkauf=GetGadgetState(t1)-Val(GetGadgetText(v1))
            PokeL(mem+56,PeekL(mem+56)+verkauf)
            PokeL(mem+25,PeekL(mem+25)+(verkauf*PeekW(mem+38)))
            PokeL(mem+60,PeekL(mem+60)-verkauf)
          Case t2
            verkauf=GetGadgetState(t2)-Val(GetGadgetText(v2))
            PokeL(mem+56,PeekL(mem+56)+verkauf)
            PokeL(mem+25,PeekL(mem+25)+(verkauf*PeekW(mem+40)))
            PokeL(mem+64,PeekL(mem+64)-verkauf)
          Case t3
            verkauf=GetGadgetState(t3)-Val(GetGadgetText(v3))
            PokeL(mem+56,PeekL(mem+56)+verkauf)
            PokeL(mem+25,PeekL(mem+25)+(verkauf*PeekW(mem+42)))
            PokeL(mem+68,PeekL(mem+68)-verkauf)
          Case t4
            verkauf=GetGadgetState(t4)-Val(GetGadgetText(v4))
            PokeL(mem+56,PeekL(mem+56)+verkauf)
            PokeL(mem+25,PeekL(mem+25)+(verkauf*PeekW(mem+44)))
            PokeL(mem+72,PeekL(mem+72)-verkauf)
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
        SetGadgetText(v1,Str(GetGadgetState(t1)))
        SetGadgetText(l1,Str(GetGadgetAttribute(t1,#PB_TrackBar_Maximum)-GetGadgetState(t1)))
        SetGadgetText(v2,Str(GetGadgetState(t2)))
        SetGadgetText(l2,Str(GetGadgetAttribute(t2,#PB_TrackBar_Maximum)-GetGadgetState(t2)))
        SetGadgetText(v3,Str(GetGadgetState(t3)))
        SetGadgetText(l3,Str(GetGadgetAttribute(t3,#PB_TrackBar_Maximum)-GetGadgetState(t3)))
        SetGadgetText(v4,Str(GetGadgetState(t4)))
        SetGadgetText(l4,Str(GetGadgetAttribute(t4,#PB_TrackBar_Maximum)-GetGadgetState(t4)))
        SetGadgetText(taler,Str(PeekL(mem+25)))
        SetGadgetText(lager,Str(PeekL(mem+56)))
        
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Steuern(spieler)
  window=WinOpen(330,210,"Steuern und Justiz")
  
  mem=spieler(spieler)
  TextGadget(-1,140,10,60,20,"lasch")
  TextGadget(-1,200,10,60,20,"gierig",#PB_Text_Right)
  TextGadget(-1,140,140,60,20,"gnädig")
  TextGadget(-1,200,140,60,20,"brutal",#PB_Text_Right)
  
  TextGadget(-1,60,40,60,20,"Steuern:")
  TextGadget(-1,60,80,60,20,"Justiz:")
  TextGadget(-1,60,120,60,20,"Asylrecht:")
  
  t1=TrackBarGadget(-1,140,40,120,20,0,100)
  t2=TrackBarGadget(-1,140,80,120,20,0,100)
  t3=TrackBarGadget(-1,140,120,120,20,0,100)
  
  a1=TextGadget(-1,260, 40,40,20,Str(PeekB(mem+76))+" %",#PB_Text_Right)
  a2=TextGadget(-1,260, 80,40,20,Str(PeekB(mem+77))+" %",#PB_Text_Right)
  a3=TextGadget(-1,260,120,40,20,Str(PeekB(mem+78))+" %",#PB_Text_Right)
  
  SetGadgetState(t1,PeekB(mem+76))
  SetGadgetState(t2,PeekB(mem+77))
  SetGadgetState(t3,PeekB(mem+78))
  button=ButtonGadget(-1,115,170,100,30,"Fertig")
  
  ImageGadget(-1,20, 30,32,32,ImageID(icon(24)))
  ImageGadget(-1,20, 70,32,32,ImageID(icon(25)))
  ImageGadget(-1,20,110,32,32,ImageID(icon(26)))
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case t1
            PokeB(mem+76,GetGadgetState(t1))
            SetGadgetText(a1,Str(GetGadgetState(t1))+" %")
          Case t2
            PokeB(mem+77,GetGadgetState(t2))
            SetGadgetText(a2,Str(GetGadgetState(t2))+" %")
          Case t3
            PokeB(mem+78,GetGadgetState(t3))
            SetGadgetText(a3,Str(GetGadgetState(t3))+" %")
          Case button
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure

Procedure.i Programm_Beenden()
  
  If MessageRequester("Beenden","Wollt Ihr das Spiel wirklich beenden?",#PB_MessageRequester_YesNo) = #PB_MessageRequester_Yes
    
    ;##### Hier sollte nochmal Spielstand speichern kommen
    ;##### Im Netzwerk vom Server abmelden wenn Client
    ;##### Resourcen freigeben
    ;##### Vielleicht noch ein "Auf Wiedersehen" Blabla ...
    ;##### und anderes was mir grad nicht einfaellt ;)
    
    
    End
    
  EndIf
EndProcedure

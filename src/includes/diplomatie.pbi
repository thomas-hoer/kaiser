;##### ------------------------------------------------------------------------
;##### 
;##### Diplomatie.pbi
;##### 
;##### ------------------------------------------------------------------------

Procedure Window_Diplomatie_Error()
  window=WinOpen(300,120,"Post ist schon weg!")
  
  mem=spieler(spieler)
  TextGadget(-1,50,10,240,70,"Leider könnt Ihr diesem Mitstreiter zur Zeit keine Nachricht oder Pakete zukommen lassen. Wartet bitte bis zur nächsten Runde!")
  ImageGadget(-1,10,20,32,32,ImageID(icon(38)))
  button=ButtonGadget(-1,100,90,100,20,"Ach so!")
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
Procedure Window_Diplomatie_OK()
  window=WinOpen(250,100,"Ab geht die Post!")
  
  mem=spieler(spieler)
  TextGadget(-1,50,10,190,50,"Ein Kurier begibt sich stehenden Fusses auf den langen Weg, um die Nachricht zu überbringen.")
  ImageGadget(-1,10,20,32,32,ImageID(icon(38)))
  button=ButtonGadget(-1,75,70,100,20,"Jo!")
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

Procedure.s Window_Spende(spieler)
  window=WinOpen(300,240,"Spendenaktion")
  
  mem=spieler(spieler)
  TextGadget(-1,50,10,200,40,"Wählet bitte den Empfänger Eurer großzügigen Spende:",#PB_Text_Center)
  combo=ComboBoxGadget(-1,10,70,280,22)
  For x=0 To PeekB(spiel)
    If x<>spieler
      AddGadgetItem(combo,-1,titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name)
    EndIf
  Next
  SetGadgetState(combo,0)
  ImageGadget(-1,10,10,32,32,ImageID(icon(27)))
  ImageGadget(-1,258,10,32,32,ImageID(icon(27)))
  button=ButtonGadget(-1,25,200,100,30,"Weiter")
  abbrechen=ButtonGadget(-1,175,200,100,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            ziel.s=GetGadgetText(combo)
            CloseWindow(window)
            ProcedureReturn ziel
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn ""
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Spende2(spieler,name.s)
  window=WinOpen(250,250,"Brot für die Welt!")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,230,20,"Was möchtet Ihr",#PB_Text_Center)
  TextGadget(-1,10,30,230,20,name,#PB_Text_Center)
  TextGadget(-1,10,50,230,20,"zukommen lassen?",#PB_Text_Center)
  t1=TextGadget(-1,70, 90,100,20,"Taler")
  t2=TextGadget(-1,70,130,100,20,"Länderreien")
  t3=TextGadget(-1,70,170,100,20,"Truppen")
  o1=OptionGadget(-1,190, 90,20,20,"")
  o2=OptionGadget(-1,190,130,20,20,"")
  o3=OptionGadget(-1,190,170,20,20,"")
  ImageGadget(-1,30,80,32,32,ImageID(icon(24)))
  ImageGadget(-1,30,120,32,32,ImageID(icon(13)))
  ImageGadget(-1,30,160,32,32,ImageID(icon(3)))
  button=ButtonGadget(-1,20,210,80,30,"Fertig")
  abbrechen=ButtonGadget(-1,150,210,80,30,"Abbrechen")
  If (PeekL(mem+264) And PeekL(mem+260)=0) Or (PeekL(mem+364) And PeekL(mem+360)=0) Or (PeekL(mem+464) And PeekL(mem+460)=0) Or (PeekL(mem+564) And PeekL(mem+560)=0) Or (PeekL(mem+664) And PeekL(mem+660)=0) Or (PeekL(mem+764) And PeekL(mem+760)=0) Or (PeekL(mem+864) And PeekL(mem+860)=0) Or (PeekL(mem+964) And PeekL(mem+960)=0)
    SetGadgetState(o3,1)
    DisableGadget(t3,1)
    DisableGadget(o3,1)
  Else
    DisableGadget(t3,1)
    DisableGadget(o3,1)
  EndIf
  If PeekL(mem+21)<=2100
    DisableGadget(t2,1)
    DisableGadget(o2,1)
  Else
    SetGadgetState(o2,1)
  EndIf
  If PeekL(mem+25)<=100
    DisableGadget(t1,1)
    DisableGadget(o1,1)
  Else
    SetGadgetState(o1,1)
  EndIf
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            If GetGadgetState(o1)
              x=1
            ElseIf GetGadgetState(o2)
              x=2
            ElseIf GetGadgetState(o3)
              x=3
            EndIf
            CloseWindow(window)
            ProcedureReturn x
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Spende3(spieler,name.s)
  window=WinOpen(300,130,"Talertransfer")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,280,20,"Bitte gewünschten Talerbetrag eingeben:")
  track=TrackBarGadget(-1,60,50,150,20,100,PeekL(mem+25))
  text=TextGadget(-1,210,50,60,20,"100",#PB_Text_Right)
  ImageGadget(-1,20,40,32,32,ImageID(icon(24)))
  button=ButtonGadget(-1,50,90,90,30,"Fertig")
  abbrechen=ButtonGadget(-1,160,90,90,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case track
            SetGadgetText(text,Str(GetGadgetState(track)))
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
          Case button
            For x=0 To PeekB(spiel)
              If name=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                PokeL(spieler(spieler)+25,PeekL(spieler(spieler)+25)-GetGadgetState(track))
                PokeB(spieler(x)+1000+(spieler*10),1)
                PokeB(spieler(x)+1001+(spieler*10),1)
                PokeL(spieler(x)+1002+(spieler*10),GetGadgetState(track))
              EndIf
            Next
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Spende4(spieler,name.s)
  window=WinOpen(300,130,"Landverschiebung")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,280,20,"Bitte die Landgröße in Hektar angeben:")
  track=TrackBarGadget(-1,60,50,150,20,100,PeekL(mem+21)-2000)
  text=TextGadget(-1,210,50,60,20,"100",#PB_Text_Right)
  ImageGadget(-1,20,40,32,32,ImageID(icon(2)))
  button=ButtonGadget(-1,50,90,90,30,"Fertig")
  abbrechen=ButtonGadget(-1,160,90,90,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case track
            SetGadgetText(text,Str(GetGadgetState(track)))
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
          Case button
            For x=0 To PeekB(spiel)
              If name=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                PokeL(spieler(spieler)+21,PeekL(spieler(spieler)+21)-GetGadgetState(track))
                PokeB(spieler(x)+1000+(spieler*10),1)
                PokeB(spieler(x)+1001+(spieler*10),2)
                PokeL(spieler(x)+1002+(spieler*10),GetGadgetState(track))
              EndIf
            Next
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Spende_4(spieler,spende)
  window=WinOpen(300,200,"Eine edle Spende!")
  
  mem=spieler(spieler)
  TextGadget(-1,20, 50,260,15,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Text_Center)
  TextGadget(-1,20, 65,260,15,"überließ Euch heuer",#PB_Text_Center)
  TextGadget(-1,20, 85,260,20,Str(spende)+"ha fruchtbarsten Bodens",#PB_Text_Center)
  TextGadget(-1,20,105,260,55,"zur freien Verfügung."+#CRLF$+"Möge Eure unterentwickelte Nation von diesem bescheidenen Almosen profitieren!",#PB_Text_Center)
  ImageGadget(-1,134,10,32,32,ImageID(icon(27)))
  button=ButtonGadget(-1,100,170,100,20,"Oh danke!")
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

Procedure Window_Spende_3(spieler,spende)
  window=WinOpen(300,200,"Eine edle Spende!")
  
  mem=spieler(spieler)
  TextGadget(-1,20, 50,260,15,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Text_Center)
  TextGadget(-1,20, 65,260,15,"überließ Euch heuer",#PB_Text_Center)
  TextGadget(-1,20, 85,260,20,Str(spende)+" Taler",#PB_Text_Center)
  TextGadget(-1,20,105,260,55,"zur freien Verfügung."+#CRLF$+"Möge Eure unterentwickelte Nation von diesem bescheidenen Almosen profitieren!",#PB_Text_Center)
  ImageGadget(-1,134,10,32,32,ImageID(icon(27)))
  button=ButtonGadget(-1,100,170,100,20,"Oh danke!")
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
Procedure.s Window_Abkommen(spieler)
  window=WinOpen(300,240,"Abkommen!")
  
  mem=spieler(spieler)
  TextGadget(-1,50,10,200,40,"Wählet bitte den Adressaten Eurer diplomatischen Bemühungen:",#PB_Text_Center)
  combo=ComboBoxGadget(-1,10,70,280,22)
  For x=0 To PeekB(spiel)
    If x<>spieler
      AddGadgetItem(combo,-1,titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name)
    EndIf
  Next
  SetGadgetState(combo,0)
  ImageGadget(-1,10,10,32,32,ImageID(icon(27)))
  ImageGadget(-1,258,10,32,32,ImageID(icon(27)))
  button=ButtonGadget(-1,25,200,100,30,"Weiter")
  abbrechen=ButtonGadget(-1,175,200,100,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            ziel.s=GetGadgetText(combo)
            CloseWindow(window)
            ProcedureReturn ziel
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn ""
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Abkommen2(spieler,name.s)
  window=WinOpen(300,250,"Wo die Liebe hinfällt")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,230,20,"Wählet die Art des Abkommens, das Ihr")
  TextGadget(-1,10,30,230,20,name)
  TextGadget(-1,10,50,230,20,"vorzuschlagen gedenket:")
  t1=TextGadget(-1,70, 90,150,20,"Friedensvertrag vorschlagen")
  t2=TextGadget(-1,70,130,150,20,"Handelsvertrag vorschlagen")
  t3=TextGadget(-1,70,170,150,20,"Handelsvertrag kündigen")
  o1=OptionGadget(-1,240, 90,20,20,"")
  o2=OptionGadget(-1,240,130,20,20,"")
  o3=OptionGadget(-1,240,170,20,20,"")
  ImageGadget(-1,30,80,32,32,ImageID(icon( 1)))
  ImageGadget(-1,30,120,32,32,ImageID(icon(39)))
  ImageGadget(-1,30,160,32,32,ImageID(icon(40)))
  button=ButtonGadget(-1,45,210,80,30,"Fertig")
  abbrechen=ButtonGadget(-1,175,210,80,30,"Abbrechen")
  For x=0 To PeekB(spiel)
    If name=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
      Break
    EndIf
  Next
  If PeekB(mem+1100+(x))
    DisableGadget(t2,1)
    DisableGadget(o2,1)
    SetGadgetState(o3,1)
  Else
    DisableGadget(t3,1)
    DisableGadget(o3,1)
    SetGadgetState(o2,1)
  EndIf
  If PeekW(mem+1110+(x*2))
    DisableGadget(t1,1)
    DisableGadget(o1,1)
  Else
    SetGadgetState(o1,1)
  EndIf
  
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            If GetGadgetState(o1)
              x=1
            ElseIf GetGadgetState(o2)
              x=2
            ElseIf GetGadgetState(o3)
              x=3
            EndIf
            CloseWindow(window)
            ProcedureReturn x
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Abkommen3(spieler,name.s)
  window=WinOpen(300,130,"... bis nach Äonen selbst der Tod die Zeit besiegt ...")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,280,20,"Bitte die gewünschte Zeitdauer in Jahren eingeben:")
  track=TrackBarGadget(-1,60,50,150,20,5,50)
  text=TextGadget(-1,210,50,60,20,"5",#PB_Text_Right)
  ImageGadget(-1,20,40,32,32,ImageID(icon(41)))
  button=ButtonGadget(-1,50,90,90,30,"Fertig")
  abbrechen=ButtonGadget(-1,160,90,90,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case track
            SetGadgetText(text,Str(GetGadgetState(track)))
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
          Case button
            x=GetGadgetState(track)
            CloseWindow(window)
            ProcedureReturn x
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Abkommen_3(spieler,friede);angebot friedensvertrag
  window=WinOpen(300,200,"Ein Friedensangebot")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,60,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"schlug heuer ein Friedensabkommen zwischen Euer beider Nationen vor.")
  TextGadget(-1,50, 70,240,60,"Es soll auf "+Str(friede)+" Jahre bestehen bleiben und kann während dieser Zeit von keiner Seite nicht wiederrufen werden!")
  TextGadget(-1,50,130,240,15,"Schlagt Ihr ein?")
  ImageGadget(-1,10,20,32,32,ImageID(icon(38)))
  ImageGadget(-1,10,80,32,32,ImageID(icon(1)))
  button=ButtonGadget(-1,70,160,70,30,"Ja")
  abbrechen=ButtonGadget(-1,160,160,70,30,"Nein")
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
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Abkommen_4(spieler);angebot handelsvertrag
  window=WinOpen(300,140,"Ein Angebot")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,80,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"schlug heuer ein Abkommen zum regen Handel zwischen beiden Nationen zum beiderseitigen Vorteil vor!"+#CRLF$+"Ist Euch diese Vorstellung genehm?")
  ImageGadget(-1,10,20,32,32,ImageID(icon(1)))
  ImageGadget(-1,10,60,32,32,ImageID(icon(38)))
  
  button=ButtonGadget(-1,70,100,70,30,"Ja")
  abbrechen=ButtonGadget(-1,160,100,70,30,"Nein")
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
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Abkommen_5(spieler);handelsvertrag gekündigt
  window=WinOpen(300,100,"Eine Message:")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,60,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"bricht hiermit alle Handelsbeziehungen zu Euch mit sofortiger Wirkung ab!")
  button=ButtonGadget(-1,100,70,100,20,"Na gut!")
  ImageGadget(-1,10,20,32,32,ImageID(icon(33)))
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
Procedure Window_Abkommen_3_1(spieler,friede);friedensvertrag angenommen
  window=WinOpen(300,200,"Pax")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,150,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"willigte mit Freuden in Euren herzlichen Vorschlag zur Verbrüderung beider Länder ein und unterzeichnete heuer den ersehnten Friedensvertrag!"+#CRLF$+#CRLF$+"Der Vertrag verhindert kriegerische Handlungen zwischen beiden Staaten bis in das Jahr des Herrn "+Str(PeekW(spiel+1)+friede))
  ImageGadget(-1,10,10,32,32,ImageID(icon(1)))
  ImageGadget(-1,10,50,32,32,ImageID(icon(38)))
  button=ButtonGadget(-1,100,170,100,20,"Brav!")
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
Procedure Window_Abkommen_3_2(spieler);friedensvertrag abgelehnt
  window=WinOpen(300,120,"Eine Message:")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,70,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"lehnte heuer Euer die Unterzeichnung eines Friedensvertrages mit Eurer Nation gelangweilt ab!")
  ImageGadget(-1,10,10,32,32,ImageID(icon(38)))
  ImageGadget(-1,10,50,32,32,ImageID(icon(33)))
  button=ButtonGadget(-1,100,90,100,20,"Danke")
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
Procedure Window_Abkommen_4_1(spieler);handelsvertrag angenommen
  window=WinOpen(300,140,"Eine Message:")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,90,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"begrüßte heuer Eure Initiative für eine wirtschaftliche Zusammenarbeit Euer beider Länder und willigte in das neue Handelsabkommen mit Freuden ein!")
  button=ButtonGadget(-1,100,110,100,20,"Prima")
  ImageGadget(-1,10,10,32,32,ImageID(icon(39)))
  ImageGadget(-1,10,50,32,32,ImageID(icon(1)))
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
Procedure Window_Abkommen_4_2(spieler);handelsvertrag abgelehnt
  window=WinOpen(300,120,"Eine Message:")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,70,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"lehnte heuer Euer Angebot, eifrigen Handel zwischen Euer beider Länder zuzulassen, mit Nachdruck ab!")
  ImageGadget(-1,10,10,32,32,ImageID(icon(39)))
  ImageGadget(-1,10,50,32,32,ImageID(icon(33)))
  button=ButtonGadget(-1,100,90,100,20,"Denn nicht!")
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
Procedure.s Window_Erpressen(spieler)
  window=WinOpen(300,240,"Tributforderung")
  
  mem=spieler(spieler)
  TextGadget(-1,50,10,200,40,"Welchen Eurer Nebenbuhler möchtet ihr gerne erpressen?",#PB_Text_Center)
  combo=ComboBoxGadget(-1,10,70,280,22)
  For x=0 To PeekB(spiel)
    If x<>spieler
      AddGadgetItem(combo,-1,titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name)
    EndIf
  Next
  SetGadgetState(combo,0)
  ImageGadget(-1,10,10,32,32,ImageID(icon(33)))
  ImageGadget(-1,258,10,32,32,ImageID(icon(33)))
  button=ButtonGadget(-1,25,200,100,30,"Weiter")
  abbrechen=ButtonGadget(-1,175,200,100,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            ziel.s=GetGadgetText(combo)
            CloseWindow(window)
            ProcedureReturn ziel
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn ""
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen2(spieler,name.s)
  window=WinOpen(250,250,"Tribut!")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,230,20,"Wählt die Art des Tributes, den Ihr",#PB_Text_Center)
  TextGadget(-1,10,30,230,20,name,#PB_Text_Center)
  TextGadget(-1,10,50,230,20,"abzuverlangen gedenkt:",#PB_Text_Center)
  t1=TextGadget(-1,70, 90,100,20,"Taler")
  t2=TextGadget(-1,70,130,100,20,"Länderreien")
  t3=TextGadget(-1,70,170,100,20,"Sklaven")
  o1=OptionGadget(-1,190, 90,20,20,"")
  o2=OptionGadget(-1,190,130,20,20,"")
  o3=OptionGadget(-1,190,170,20,20,"")
  ImageGadget(-1,30,80,32,32,ImageID(icon(24)))
  ImageGadget(-1,30,120,32,32,ImageID(icon(13)))
  ImageGadget(-1,30,160,32,32,ImageID(icon(28)))
  button=ButtonGadget(-1,20,210,80,30,"Fertig")
  abbrechen=ButtonGadget(-1,150,210,80,30,"Abbrechen")
  SetGadgetState(o1,1)
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            If GetGadgetState(o1)
              x=1
            ElseIf GetGadgetState(o2)
              x=2
            ElseIf GetGadgetState(o3)
              x=3
            EndIf
            CloseWindow(window)
            ProcedureReturn x
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen3(spieler,name.s)
  window=WinOpen(300,130,"Talertransfer")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,280,20,"Bitte gewünschten Talerbetrag eingeben:")
  track=TrackBarGadget(-1,60,50,150,20,100,100000)
  text=TextGadget(-1,210,50,60,20,"100",#PB_Text_Right)
  ImageGadget(-1,20,40,32,32,ImageID(icon(24)))
  button=ButtonGadget(-1,50,90,90,30,"Fertig")
  abbrechen=ButtonGadget(-1,160,90,90,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case track
            SetGadgetText(text,Str(GetGadgetState(track)))
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
          Case button
            For x=0 To PeekB(spiel)
              If name=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                PokeB(spieler(x)+1000+(spieler*10),1)
                PokeB(spieler(x)+1001+(spieler*10),10)
                PokeL(spieler(x)+1002+(spieler*10),GetGadgetState(track))
              EndIf
            Next
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen4(spieler,name.s)
  window=WinOpen(300,130,"Landverschiebung")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,280,20,"Bitte die Landgröße in Hektar angeben:")
  track=TrackBarGadget(-1,60,50,150,20,100,50000)
  text=TextGadget(-1,210,50,60,20,"100",#PB_Text_Right)
  ImageGadget(-1,20,40,32,32,ImageID(icon(2)))
  button=ButtonGadget(-1,50,90,90,30,"Fertig")
  abbrechen=ButtonGadget(-1,160,90,90,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case track
            SetGadgetText(text,Str(GetGadgetState(track)))
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
          Case button
            For x=0 To PeekB(spiel)
              If name=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                PokeB(spieler(x)+1000+(spieler*10),1)
                PokeB(spieler(x)+1001+(spieler*10),11)
                PokeL(spieler(x)+1002+(spieler*10),GetGadgetState(track))
              EndIf
            Next
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen5(spieler,name.s)
  window=WinOpen(300,130,"Sklaven")
  
  mem=spieler(spieler)
  TextGadget(-1,10,10,280,20,"Bitte Anzahl der Sklaven eingeben:")
  track=TrackBarGadget(-1,60,50,150,20,100,5000)
  text=TextGadget(-1,210,50,60,20,"100",#PB_Text_Right)
  ImageGadget(-1,20,40,32,32,ImageID(icon(28)))
  button=ButtonGadget(-1,50,90,90,30,"Fertig")
  abbrechen=ButtonGadget(-1,160,90,90,30,"Abbrechen")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case track
            SetGadgetText(text,Str(GetGadgetState(track)))
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
          Case button
            For x=0 To PeekB(spiel)
              If name=titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name
                PokeB(spieler(x)+1000+(spieler*10),1)
                PokeB(spieler(x)+1001+(spieler*10),12)
                PokeL(spieler(x)+1002+(spieler*10),GetGadgetState(track))
              EndIf
            Next
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen_3(spieler,erpressen);erpressen taler
  window=WinOpen(300,210,"Erpressung!")
  
  mem=spieler(spieler)
  TextGadget(-1,10, 50,280,20,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"schlug heuer ein Friedensabkommen zwischen Euer beider Nationen vor.",#PB_Text_Center)
  TextGadget(-1,10, 70,280,110,"fordert Euch hiermit auf,"+#CRLF$+Str(erpressen)+" Taler"+#CRLF$+"als Tribut zu zollen."+#CRLF$+"Jegliche Weigerung würde unweigerlich zum Kriege zwischen beiden Nationen führen! Gebt Ihr dieser infamen Nötigung nach?",#PB_Text_Center)
  ImageGadget(-1,136,10,32,32,ImageID(icon(33)))
  button=ButtonGadget(-1,70,180,70,20,"Ja")
  abbrechen=ButtonGadget(-1,160,180,70,20,"Niemals")
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
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen_4(spieler,erpressen);erpressen land
  window=WinOpen(300,210,"Erpressung!")
  
  mem=spieler(spieler)
  TextGadget(-1,10, 50,280,20,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"schlug heuer ein Friedensabkommen zwischen Euer beider Nationen vor.",#PB_Text_Center)
  TextGadget(-1,10, 70,280,110,"fordert Euch hiermit auf,"+#CRLF$+Str(erpressen)+" ha Land"+#CRLF$+"als Tribut zu zollen."+#CRLF$+"Jegliche Weigerung würde unweigerlich zum Kriege zwischen beiden Nationen führen! Gebt Ihr dieser infamen Nötigung nach?",#PB_Text_Center)
  ImageGadget(-1,136,10,32,32,ImageID(icon(33)))
  button=ButtonGadget(-1,70,180,70,20,"Ja")
  abbrechen=ButtonGadget(-1,160,180,70,20,"Niemals")
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
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen_5(spieler,erpressen);erpressen sklafen
  window=WinOpen(300,210,"Erpressung!")
  
  mem=spieler(spieler)
  TextGadget(-1,10, 50,280,20,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"schlug heuer ein Friedensabkommen zwischen Euer beider Nationen vor.",#PB_Text_Center)
  TextGadget(-1,10, 70,280,110,"fordert Euch hiermit auf,"+#CRLF$+Str(erpressen)+" Sklaven"+#CRLF$+"als Tribut zu zollen."+#CRLF$+"Jegliche Weigerung würde unweigerlich zum Kriege zwischen beiden Nationen führen! Gebt Ihr dieser infamen Nötigung nach?",#PB_Text_Center)
  ImageGadget(-1,136,10,32,32,ImageID(icon(33)))
  button=ButtonGadget(-1,70,180,70,20,"Ja")
  abbrechen=ButtonGadget(-1,160,180,70,20,"Niemals")
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
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 0
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Erpressen_3_0();nicht genug taler
  window=WinOpen(300,100,"Doch kein Tribut!")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,60,"Leider muss Berichtet werden, dass Ihr nicht genug Taler in eurer Schatzkammer habt um den Tribut zu zahlen.")
  ImageGadget(-1,10,20,32,32,ImageID(icon(24)))
  button=ButtonGadget(-1,100,70,100,20,"Oh!")
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
Procedure Window_Erpressen_4_0();nicht genug land
  window=WinOpen(300,100,"Doch kein Tribut!")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,60,"Leider muss Berichtet werden, dass Ihr gar nicht genug Länderreien besitzt um den Tribut zu leisten.")
  ImageGadget(-1,10,20,32,32,ImageID(icon(2)))
  button=ButtonGadget(-1,100,70,100,20,"Oh!")
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
Procedure Window_Erpressen_5_0();nicht genug sklafen
  window=WinOpen(300,100,"Doch kein Tribut!")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,60,"Leider muss Berichtet werden, dass Ihr gar nicht genug Untertanen regiert um den Tribut zu leisten.")
  ImageGadget(-1,10,20,32,32,ImageID(icon(28)))
  button=ButtonGadget(-1,100,70,100,20,"Oh!")
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
Procedure Window_Erpressen_0_1(spieler);forderung eingeganen
  window=WinOpen(300,100,"Tribut erhalten!")
  
  mem=spieler(spieler)
  TextGadget(-1,50, 10,240,60,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$+"ging zähneknischend auf Eure Tributforderungen ein!")
  ImageGadget(-1,10,20,32,32,ImageID(icon(38)))
  button=ButtonGadget(-1,100,70,100,20,"Brav!")
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
Procedure Window_Erpressen_0_2(spieler);forderung abgelehnt
  
  window=WinOpen(300,110,"Tribut nicht erhalten!")
  ImageGadget(-1,10,20,32,32,ImageID(icon(38)))
  mem=spieler(spieler)
  
  T.s = titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "
  T   + PeekS(spieler(spieler)+1,16)+" von "+land(PeekB(spieler(spieler)+124))\name+#CRLF$
  T   + "erdreistete sich, Eure Tributforderungen abzulehnen, wohlwissend um die möglichen Konsequenzen!"
  
  TextGadget(#PB_Any,50, 10,240,70,T)
  button = ButtonGadget(#PB_Any,100,80,100,20,"Mutig!")
  
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

;##### ------------------------------------------------------------------------
;##### 
;##### Neues Spiel.pbi
;##### 
;##### ------------------------------------------------------------------------

Procedure Window_NeuesSpiel()
  window=WinOpen(200,260,"Neues Spiel")
  
  TextGadget(#PB_Any,20,20,160,60,"Bitte die Anzahl der Menschlichen Spieler einstellen:")
  track1=TrackBarGadget(#PB_Any,20,80,140,20,1,10,#PB_TrackBar_Ticks)
  text1=TextGadget(#PB_Any,160,80,60,20,"1")
  TextGadget(#PB_Any,20,120,160,60,"Bitte die Anzahl der gewünschten Computerspieler einstellen:")
  track2=TrackBarGadget(#PB_Any,20,180,140,20,1,9,#PB_TrackBar_Ticks)
  text2=TextGadget(#PB_Any,160,180,60,20,"1")
  button=ButtonGadget(#PB_Any,50,220,100,20,"Weiter")
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case track1
            SetGadgetText(text1,Str(GetGadgetState(track1)))
            SetGadgetAttribute(track2,#PB_TrackBar_Maximum,10-GetGadgetState(track1))
            If GetGadgetState(track1)>1
              SetGadgetAttribute(track2,#PB_TrackBar_Minimum,0)
            Else
              SetGadgetAttribute(track2,#PB_TrackBar_Minimum,1)
            EndIf
            If track>GetGadgetState(track2)
              SetGadgetState(track2,track)
              SetGadgetText(text2,Str(GetGadgetState(track2)))
            EndIf
            If Val(GetGadgetText(text2))>GetGadgetAttribute(track2,#PB_TrackBar_Maximum)
              SetGadgetState(track2,GetGadgetAttribute(track2,#PB_TrackBar_Maximum))
              SetGadgetText(text2,Str(GetGadgetState(track2)))
            EndIf
            If Val(GetGadgetText(text2))<GetGadgetAttribute(track2,#PB_TrackBar_Minimum)
              SetGadgetState(track2,GetGadgetAttribute(track2,#PB_TrackBar_Minimum))
              SetGadgetText(text2,Str(GetGadgetState(track2)))
            EndIf
          Case track2
            track=GetGadgetState(track2)
            SetGadgetText(text2,Str(GetGadgetState(track2)))
          Case button
            For x=0 To 9
              land(x)\vergeben=0
              ;spieler(x)=ReAllocateMemory(spieler(x),#spieler_size)
              CopyMemory(leer,spieler(x),#spieler_size)
              mem=spieler(x)
              PokeS(spieler(x)+1,namen(x),16,#PB_Ascii)
              PokeL(spieler(x)+17,1000);einwohner
              PokeL(spieler(x)+21,10000);land
              PokeL(spieler(x)+25,1000) ;taler
              PokeL(spieler(x)+29,5000) ;korn
              PokeB(spieler(x)+34,20)   ;korn
              PokeW(spieler(x)+50,1)    ;kornspeicher
              PokeL(spieler(x)+80,12000);kornspeicherkapazität
              PokeB(spieler(x)+76,10)   ;steuern
              PokeB(spieler(x)+77,8)    ;justiz
              PokeB(spieler(x)+78,98)   ;asyl
              PokeW(mem+86,10)          ;geburtenrate
              PokeW(mem+88,10)          ;sterberate
              PokeW(mem+90,1)           ;immigration
              PokeW(mem+92,10)          ;emigration
              
            Next
            ;spiel=ReAllocateMemory(spiel,#spiel_size)
            PokeB(spiel,GetGadgetState(track1)+GetGadgetState(track2)-1)
            PokeW(spiel+1,1400)
            PokeB(spiel+3,-1)
            PokeL(spiel+4,(PeekB(spiel)+1)*90000)
            For x=0 To GetGadgetState(track1)-1
              PokeB(spieler(x),1)
            Next
            
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
        
    EndSelect
    
    
  ForEver
EndProcedure
Procedure Window_SetSpielerName(x)
  If PeekB(spieler(x))=1
    ;{
    window=WinOpen(200,240,"Spielerdaten")
    
    TextGadget(#PB_Any,20,10,160,20,"Spieler "+Str(x+1))
    string=StringGadget(#PB_Any,20,30,160,20,PeekS(spieler(x)+1,16,#PB_Ascii))
    TextGadget(#PB_Any,20,60,160,20,"Land:")
    combo=ComboBoxGadget(#PB_Any,20,80,160,22)
    For y=0 To 9
      If land(y)\vergeben=0
        AddGadgetItem(combo,0,land(y)\name)
      EndIf
    Next
    FrameGadget(#PB_Any,20,120,160,70,"Hormone")
    option1=OptionGadget(#PB_Any,40,140,120,20,"eher männlich")
    option2=OptionGadget(#PB_Any,40,160,120,20,"eher weiblich")
    button=ButtonGadget(#PB_Any,50,200,100,20,"Fertig")
    SetGadgetState(option1,1)
    SetGadgetState(combo,0)
    Repeat
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      
      Select Event
        Case #PB_Event_Gadget
          Select EventGadget
            Case button
              PokeS(spieler(x)+1,GetGadgetText(string),16,#PB_Ascii)
              For y=0 To 9
                If GetGadgetText(combo)=land(y)\name
                  land(y)\vergeben=1
                  PokeB(spieler(x)+124,y)
                  Break
                EndIf
              Next
              PokeB(spieler(x)+33,GetGadgetState(option2))
              CloseWindow(window)
              ProcedureReturn 1
          EndSelect
      EndSelect
    ForEver
    ;}
  Else;computerspieler
    
    For y=0 To 9
      If land(y)\vergeben=0
        land(y)\vergeben=1
        PokeB(spieler(x)+124,y)
        Break
      EndIf
    Next
    
  EndIf
EndProcedure
;botschafften am anfang
Procedure Window_Begruesung(spieler)
  PlaySound(sounds(9))
  window=WinOpen(270,250,"Sic transit gloria mundi...")
  
  TextGadget(#PB_Any,20,20,230,20,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Text_Center)
  TextGadget(#PB_Any,10,50,240,20,"Willkommen im Jahre des Herrn "+Str(PeekW(spiel+1))+",",#PB_Text_Center)
  TextGadget(#PB_Any,20,80,230,20,"Oh Herrlicher!",#PB_Text_Center)
  TextGadget(#PB_Any,20,150,230,20,"Erwartet nun die Berichte Eurer",#PB_Text_Center)
  TextGadget(#PB_Any,20,180,230,20,"Berater, teuerster Herrscher!",#PB_Text_Center)
  ImageGadget(#PB_Any,125-6,100,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any,20,200,32,32,ImageID(icon(11)))
  ImageGadget(#PB_Any,270-52,200,32,32,ImageID(icon(11)))
  button=ButtonGadget(#PB_Any,85,210,100,20,"Nun gut")
  SetWindowTitle(MainWindow,"Kaiser - "+titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name)
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
Procedure Window_Hochzeitsgeschenk(spieler)
  window=WinOpen(310,130,"Hochzeitsgeschenke")
  ImageGadget(#PB_Any,20,20,32,32,ImageID(icon(1)))
  ImageGadget(#PB_Any,20,55,32,32,ImageID(icon(2)))
  mem=spieler(spieler)
  ; CHEATING !!!!!
  ; PokeL(mem+21,PeekL(mem+21)+150000)
  ; PokeL(mem+25,PeekL(mem+25)+1500000)
  ; PokeL(mem+17,PeekL(mem+17)+9000)
  ; PokeB(mem+54,12)
  ; PokeB(mem+55,12)
  ; PokeW(mem+84,9)
  
  Select Random(3)
    Case 0
      text1.s="Heirat mit der Tochter eines reichen Großgrundbesitzers."
      text2.s="Ihre Mitgift lautet 1500 ha Land und 2000 Taler Bares."
      text3.s="Merci!"
      icon1=2
      icon2=24
      PokeL(mem+21,PeekL(mem+21)+1500)
      PokeL(mem+25,PeekL(mem+25)+2000)
    Case 1
      text1.s="Ihr heiratet eine schöne Müllerin."
      text2.s="Als Mitgift springen 5000 Last Korn und eine Kornmühle herraus."
      text3.s="Ja die Liebe!"
      icon1=1
      icon2=15
      PokeL(mem+29,PeekL(mem+29)+5000)
      PokeW(mem+48,PeekW(mem+48)+1)
      PokeL(mem+80,PeekL(mem+80)+2000)
    Case 2
      text1.s="Die Hochzeit mit einer feschen Fürstentochter steht ins Haus."
      text2.s="Ihr Vater bezahlt mit 5000 Talern."
      text3.s="Oh lala!"
      icon1=1
      icon2=24
      PokeL(mem+25,PeekL(mem+25)+5000)
    Case 3
      text1.s="Ihr haltet Hochzeit mit einer Schönheit aus dem Nachbarort."
      text2.s="Als Mitgift erhaltet Ihr 1000 ha Land sowie 3000 Last Korn."
      text3.s="Fein"
      icon1=1
      icon2=2
      PokeL(mem+21,PeekL(mem+21)+1000)
      PokeL(mem+29,PeekL(mem+29)+3000)
  EndSelect
  TextGadget(#PB_Any,60,20,200,30,text1)
  TextGadget(#PB_Any,60,60,200,30,text2)
  button=ButtonGadget(#PB_Any,75,100,130,20,text3)
  ImageGadget(#PB_Any,20,20,32,32,ImageID(icon(icon1)))
  ImageGadget(#PB_Any,20,55,32,32,ImageID(icon(icon2)))
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
Procedure Window_Held(spieler)
  window=WinOpen(270,200,"Was für ein Held!")
  
  ImageGadget(#PB_Any,20,20,32,32,ImageID(icon(3)))
  TextGadget(#PB_Any,60,20,190,30,"Ein jungerHeld aus einem fernen Lande bietet Euch seine Dienste an:")
  TextGadget(#PB_Any,20,60,230,70,Chr(34)+"Ewige Treue will ich Euch schwören, mein einziger Lohn soll das Blut Eurer Feinde sein! Bitte verleiht mir einen heldenhaften Namen:"+Chr(34))
  string=StringGadget(#PB_Any,50,140,150,20,"")
  ImageGadget(#PB_Any,20,20,32,32,ImageID(icon(3)))
  button=ButtonGadget(#PB_Any,75,170,100,20,"Fertig")
  mem=spieler(spieler)
  PokeL(mem+216,7);angriff
  PokeL(mem+220,7);abwehr
  PokeL(mem+224,7);tp
  PokeL(mem+228,2);schritte
  PokeL(mem+232,1);reichweite
  PokeL(mem+236,0);salven
  PokeL(mem+240,0)
  PokeL(mem+244,0)
  PokeL(mem+248,0)
  PokeL(mem+252,0)
  PokeL(mem+256,Random(4)+1)
  PokeL(mem+260,1)
  PokeL(mem+264,PeekL(mem+256));bild
  PokeB(mem+268,0)
  PokeL(mem+269,7);tp
  Select PeekL(mem+256)
    Case 1;lehrmeister
    Case 2;heilkräfte
      PokeL(mem+216,6)
      PokeL(mem+220,6)
      PokeL(mem+224,5)
    Case 3;finesse
      PokeL(mem+216,6)
    Case 4;drachentöter
      PokeL(mem+216,9)
    Case 5;drachenschild
      PokeL(mem+220,8);abwehr
    Case 6;regeneration
      PokeL(mem+220,6)
      PokeL(mem+224,5)
  EndSelect
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            PokeS(mem+200,GetGadgetText(string),16,#PB_Ascii)
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Hexe(spieler)
  window=WinOpen(340,220,"Eine Hexe")
  
  TextGadget(#PB_Any,60,20,260,50,"Eine junge Frau tritt an Euch heran. Sie wirkt recht schlampig mit ihrem roten Haar und dem brennenden Stengel in ihrem Mund.")
  TextGadget(#PB_Any,20,70,300,70,Chr(34)+"Helden sterben und dann kommen neue. Mein Geschenk an Euch soll ewig währen! Ich möchte Euch mit einem nützlichen Zauber belegen. Wählt einen:"+Chr(34))
  ImageGadget(#PB_Any,20,25,32,32,ImageID(icon(12)))
  ImageGadget(#PB_Any,260,130,32,32,ImageID(icon(12)))
  combo=ComboBoxGadget(#PB_Any,20,145,160,22)
  button=ButtonGadget(#PB_Any,220,180,100,20,"Fertig")
  For x=0 To 11
    AddGadgetItem(combo,-1,zauber(x)\zauber)
  Next
  SetGadgetState(combo,0)
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            PokeB(spieler(spieler)+122,GetGadgetState(combo))
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure

;##### ------------------------------------------------------------------------
;##### 
;##### Krieg.pbi
;##### 
;##### ------------------------------------------------------------------------

;##### ------------------------------------------------------------------------
;##### Einheiten Ausserhalb des Schlachtfeldes
;##### ------------------------------------------------------------------------

Procedure AddEinheit(spieler,name.s,angriff,abwehr,tp,schritte,reichweite,salven,sold,spezial,bild)
  Dim EinheitBild(7)
  Dim EinheitName.s(7)
  Dim EinheitSold(7)
  mem=spieler(spieler)
  For y=0 To 7
    If PeekL(mem+224+(y*100))
      count+1
      EinheitBild(y)=PeekL(mem+264+(y*100))
      EinheitSold(y)=PeekL(mem+240+(y*100))
      EinheitName(y)=PeekS(mem+200+(y*100),16)
    EndIf
  Next
  If count<8 ;{
    For y=0 To 7
      If PeekL(mem+224+(y*100))=0
        x=y
        Break
      EndIf
    Next
    PokeS(mem+200+(x*100),name,16,#PB_Ascii)
    PokeL(mem+216+(x*100),angriff)
    PokeL(mem+220+(x*100),abwehr)
    PokeL(mem+224+(x*100),tp)
    PokeL(mem+228+(x*100),schritte)
    PokeL(mem+232+(x*100),reichweite)
    PokeL(mem+236+(x*100),salven)
    PokeL(mem+240+(x*100),sold)
    PokeL(mem+244+(x*100),0);getötet
    PokeL(mem+248+(x*100),0);erfahrung
    PokeL(mem+252+(x*100),0);titel
    PokeL(mem+256+(x*100),spezial)
    PokeL(mem+260+(x*100),0);held
    PokeL(mem+264+(x*100),bild)
    PokeB(mem+268+(x*100),0)
    PokeL(mem+269+(x*100),tp)
    ;}
  Else ;{
    window=WinOpen(400,220,"Einer muss gehen")
    
    TextGadget(#PB_Any,10,10,380,40,"Die Kaserne platzt aus allen Nähten, wir müssen einen Krieger entlassen!")
    o1=OptionGadget(#PB_Any, 10, 60,20,20,"")
    o2=OptionGadget(#PB_Any, 10,100,20,20,"")
    o3=OptionGadget(#PB_Any, 10,140,20,20,"")
    o4=OptionGadget(#PB_Any,140, 60,20,20,"")
    o5=OptionGadget(#PB_Any,140,100,20,20,"")
    o6=OptionGadget(#PB_Any,140,140,20,20,"")
    o7=OptionGadget(#PB_Any,270, 60,20,20,"")
    o8=OptionGadget(#PB_Any,270,100,20,20,"")
    o9=OptionGadget(#PB_Any,270,140,20,20,"")
    TextGadget(#PB_Any, 70, 50,70,40,EinheitName(0)+#CRLF$+"Sold: "+Str(EinheitSold(0)))
    TextGadget(#PB_Any, 70, 90,70,40,EinheitName(1)+#CRLF$+"Sold: "+Str(EinheitSold(1)))
    TextGadget(#PB_Any, 70,130,70,40,EinheitName(2)+#CRLF$+"Sold: "+Str(EinheitSold(2)))
    TextGadget(#PB_Any,200, 50,70,40,EinheitName(3)+#CRLF$+"Sold: "+Str(EinheitSold(3)))
    TextGadget(#PB_Any,200, 90,70,40,EinheitName(4)+#CRLF$+"Sold: "+Str(EinheitSold(4)))
    TextGadget(#PB_Any,200,130,70,40,EinheitName(5)+#CRLF$+"Sold: "+Str(EinheitSold(5)))
    TextGadget(#PB_Any,330, 50,70,40,EinheitName(6)+#CRLF$+"Sold: "+Str(EinheitSold(6)))
    TextGadget(#PB_Any,330, 90,70,40,EinheitName(7)+#CRLF$+"Sold: "+Str(EinheitSold(7)))
    TextGadget(#PB_Any,330,130,70,40,name+#CRLF$+"Sold: "+Str(sold))
    For x=0 To 2
      ImageGadget(#PB_Any,30,50+x*40,32,32,ImageID(icon(ehicon(EinheitBild(x),0))))
    Next
    For x=3 To 5
      ImageGadget(#PB_Any,160,50+(x-3)*40,32,32,ImageID(icon(ehicon(EinheitBild(x),0))))
    Next
    For x=6 To 7
      ImageGadget(#PB_Any,290,50+(x-6)*40,32,32,ImageID(icon(ehicon(EinheitBild(x),0))))
    Next
    ImageGadget(#PB_Any,290,50+(2)*40,32,32,ImageID(icon(ehicon(bild,0))))

    button=ButtonGadget(#PB_Any,150,180,100,20,"Adieu")
    SetGadgetState(o1,1)
    Repeat
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      
      Select Event
        Case #PB_Event_Repaint
          RePaint(EventWindow())
          StartDrawing(WindowOutput(window))
          Line(5, 47,390,0,0)
          Line(5, 87,390,0,0)
          Line(5,127,390,0,0)
          Line(5,167,390,0,0)
          
          Line(5, 47,0,120,0)
          Line(135, 47,0,120,0)
          Line(265, 47,0,120,0)
          Line(395, 47,0,120,0)
          StopDrawing()
        Case #PB_Event_Gadget
          Select EventGadget
            Case button
              If GetGadgetState(o9)
                CloseWindow(window)
              Else
                If GetGadgetState(o1):x=0:EndIf
                If GetGadgetState(o2):x=1:EndIf
                If GetGadgetState(o3):x=2:EndIf
                If GetGadgetState(o4):x=3:EndIf
                If GetGadgetState(o5):x=4:EndIf
                If GetGadgetState(o6):x=5:EndIf
                If GetGadgetState(o7):x=6:EndIf
                If GetGadgetState(o8):x=7:EndIf
                PokeS(mem+200+(x*100),name,16,#PB_Ascii)
                PokeL(mem+216+(x*100),angriff)
                PokeL(mem+220+(x*100),abwehr)
                PokeL(mem+224+(x*100),tp)
                PokeL(mem+228+(x*100),schritte)
                PokeL(mem+232+(x*100),reichweite)
                PokeL(mem+236+(x*100),salven)
                PokeL(mem+240+(x*100),sold)
                PokeL(mem+244+(x*100),0);getötet
                PokeL(mem+248+(x*100),0);erfahrung
                PokeL(mem+252+(x*100),0);titel
                PokeL(mem+256+(x*100),spezial)
                PokeL(mem+260+(x*100),0);held
                PokeL(mem+264+(x*100),bild)
                PokeB(mem+268+(x*100),0)
                PokeL(mem+269+(x*100),tp)
                CloseWindow(window)
              EndIf
              ProcedureReturn 1
          EndSelect
      EndSelect
      
    ForEver
    
  EndIf;}
EndProcedure
Procedure EinheitErfahrung(spieler,einheit,erfahrung)
EndProcedure

Procedure Window_Rekrutieren_Msg_ZuWenigGeld(text.s)
  
  window=WinOpen(200,130,"Nicht genug Taler")
  
  mem=spieler(spieler)
  
  TextGadget(#PB_Any,50,20,140,70,"Ihr habt nicht genug "+#CRLF$+"Taler um Euch"+#CRLF$+text+#CRLF$+"zu kaufen!")
  ImageGadget(#PB_Any,10,20,32,32,ImageID(icon(24)))
  
  button=ButtonGadget(#PB_Any,50,100,100,20,"Ohh!")
  
  Repeat
    
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        
      Case #PB_Event_Gadget
        
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn 1
            
        EndSelect
        
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Rekrutieren(spieler)
  mem=spieler(spieler)
  For y=0 To 7
    If PeekL(mem+224+(y*100))
      x+1
    EndIf
  Next
  If x<8;{
    window=WinOpen(220,230,"Rekrutieren")
    
    mem=spieler(spieler)
    name.s    ="Wachen"
    angriff   =2
    abwehr    =2
    treffer   =2
    schritte  =1
    reichweite=1
    salven    =0
    sold      =40
    spezial   =0
    bild      =102
    
    t1=TextGadget(#PB_Any,50,10,120,40,name.s+#CRLF$+spezial(spezial),#PB_Text_Center)
    TextGadget(#PB_Any,10,050,60,15,"Angriff:")
    TextGadget(#PB_Any,10,065,60,15,"Abwehr:")
    TextGadget(#PB_Any,10,080,60,15,"Treffer:")
    TextGadget(#PB_Any,110,050,65,15,"Reichweite:")
    TextGadget(#PB_Any,110,065,60,15,"Schritte:")
    TextGadget(#PB_Any,110,080,30,15,"Sold:")
    t2=TextGadget(#PB_Any,70,50,30,15,Str(angriff),#PB_Text_Right)
    t3=TextGadget(#PB_Any,70,65,30,15,Str(abwehr),#PB_Text_Right)
    t4=TextGadget(#PB_Any,70,80,30,15,Str(treffer),#PB_Text_Right)
    t5=TextGadget(#PB_Any,175,50,25,15,Str(reichweite),#PB_Text_Right)
    t6=TextGadget(#PB_Any,170,65,30,15,Str(schritte),#PB_Text_Right)
    t7=TextGadget(#PB_Any,140,80,60,15,Str(sold),#PB_Text_Right)
    combo=ComboBoxGadget(#PB_Any,10,105,200,22)
    text=TextGadget(#PB_Any,10,140,200,40,"Diese Einheit "+name+Chr(10)+"kostet euch "+Str(sold*10)+" Taler")
    AddGadgetItem(combo,-1,"Wachen")
    AddGadgetItem(combo,-1,"Kämpfer")
    AddGadgetItem(combo,-1,"Bogenschützen")
    AddGadgetItem(combo,-1,"Infanterie")
    AddGadgetItem(combo,-1,"Kavallerie")
    AddGadgetItem(combo,-1,"Artillerie")
    AddGadgetItem(combo,-1,"Ritter")
    AddGadgetItem(combo,-1,"Kreuzritter")
    SetGadgetState(combo,0)
    
    krieger_bild=ImageGadget(#PB_Any, 10, 10, 32, 32, ImageID (icon(ehicon(bild,0))) )
    ImageGadget(#PB_Any, 178, 10, 32, 32, ImageID (icon(33)) )
    
    button=ButtonGadget(#PB_Any,20,200,80,20,"Kaufen")
    abbrechen=ButtonGadget(#PB_Any,120,200,80,20,"Abbrechen")
    PokeW(mem+46,PeekW(mem+46)+2)
    Repeat
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      Select Event
        Case #PB_Event_Gadget
          Select EventGadget
            Case combo
              Select GetGadgetText(combo)
                Case "Wachen"
                  name.s    ="Wachen"
                  angriff   =2
                  abwehr    =2
                  treffer   =2
                  schritte  =1
                  reichweite=1
                  salven    =0
                  sold      =50
                  spezial   =0
                  bild      =102
                Case "Kämpfer"
                  name.s    ="Kämpfer"
                  angriff   =3
                  abwehr    =3
                  treffer   =3
                  schritte  =1
                  reichweite=1
                  salven    =0
                  sold      =100
                  spezial   =0
                  bild      =103
                Case "Bogenschützen"
                  name.s    ="Bogenschützen"
                  angriff   =3
                  abwehr    =2
                  treffer   =2
                  schritte  =1
                  reichweite=3
                  salven    =4
                  sold      =300
                  spezial   =0
                  bild      =104
                Case "Infanterie"
                  name.s    ="Infanterie"
                  angriff   =4
                  abwehr    =4
                  treffer   =4
                  schritte  =1
                  reichweite=1
                  salven    =0
                  sold      =500
                  spezial   =0
                  bild      =105
                Case "Kavallerie"
                  name.s    ="Kavallerie"
                  angriff   =5
                  abwehr    =4
                  treffer   =4
                  schritte  =3
                  reichweite=1
                  salven    =0
                  sold      =1000
                  spezial   =0
                  bild      =106
                Case "Artillerie"
                  name.s    ="Artillerie"
                  angriff   =6
                  abwehr    =1
                  treffer   =1
                  schritte  =1
                  reichweite=4
                  salven    =5
                  sold      =2500
                  spezial   =0
                  bild      =107
                Case "Ritter"
                  name.s    ="Ritter"
                  angriff   =6
                  abwehr    =5
                  treffer   =6
                  schritte  =2
                  reichweite=1
                  salven    =0
                  sold      =4000
                  spezial   =0
                  bild      =108
                Case "Kreuzritter"
                  name.s    ="Kreuzritter"
                  angriff   =7
                  abwehr    =7
                  treffer   =7
                  schritte  =2
                  reichweite=1
                  salven    =0
                  sold      =7500
                  spezial   =Random(3)+3
                  bild      =109
              EndSelect
              InvalidateRect_(WindowID(window), 0, 1) 
              SetGadgetText(t1,name+#CRLF$+spezial(spezial))
              SetGadgetText(t2,Str(angriff))
              SetGadgetText(t3,Str(abwehr))
              SetGadgetText(t4,Str(treffer))
              SetGadgetText(t5,Str(reichweite))
              SetGadgetText(t6,Str(schritte))
              SetGadgetText(t7,Str(sold))
              SetGadgetText(text,"Diese Einheit "+name+Chr(10)+"kostet euch "+Str(sold*2)+" Taler")
              SetGadgetState(krieger_bild,ImageID(icon(ehicon(bild,0))))
            Case button
              If PeekL(mem+25)-sold*2>0 ;mehr geld - sold * 10
                PokeL(mem+25,PeekL(mem+25)-sold*2)
                AddEinheit(spieler,name,angriff,abwehr,treffer,schritte,reichweite,salven,sold,spezial,bild)
                CloseWindow(window)
                ProcedureReturn 1
              Else
                Window_Rekrutieren_Msg_ZuWenigGeld("einen "+name)
              EndIf
            Case abbrechen
              CloseWindow(window)
              ProcedureReturn 0
          EndSelect
      EndSelect
      
    ForEver
    ;}
  Else ;{ 
    
    window=WinOpen(240,130,"Zu viele Einheiten")
    
    mem=spieler(spieler)
    
    TextGadget(#PB_Any,50,20,180,70,"Ihr habt zu viele Einheiten."+#CRLF$+"Ihr müsst erst welche entlassen"+#CRLF$+"um neue Rekrutieren zu können")
    ImageGadget(#PB_Any, 10, 20, 32, 32, ImageID (icon(3)) )
    button=ButtonGadget(#PB_Any,70,100,100,20,"Schade")
    
    Repeat
      
      Event=WaitWindowEvent(#TimeOut)
      EventMenu=EventMenu()
      EventGadget=EventGadget()
      EventType=EventType()
      
      Select Event
          
        Case #PB_Event_Repaint
          RePaint(EventWindow())
          
        Case #PB_Event_Gadget
          
          Select EventGadget
              
            Case button
              CloseWindow(window)
              ProcedureReturn 1
              
          EndSelect
          
      EndSelect
      
    ForEver
  EndIf;}
EndProcedure
Procedure Window_Inspizieren(spieler)
  mem=spieler(spieler)
  Dim behalten(7)
  window=WinOpen(440,520,"Truppen Inspizieren")
  
  For x=0 To 7
    ;{
    If x<4
      ContainerGadget(#PB_Any,10,10+x*120,200,110,#PB_Container_Single      )
    Else
      ContainerGadget(#PB_Any,230,10+(x-4)*120,200,110,#PB_Container_Single )
    EndIf
    If PeekL(mem+224+(x*100))
      TextGadget(#PB_Any,50,0,80,18,PeekS(mem+200+(x*100),16))
      TextGadget(#PB_Any,130,0,60,20,eh_titel(PeekL(mem+252+(x*100))),#PB_Text_Right)
      TextGadget(#PB_Any,50,18,140,18,"Spezial: "+spezial(PeekL(mem+256+(x*100))))
      TextGadget(#PB_Any,5,36,60,54,"Angriff:"+#CRLF$+"Abwehr:"+#CRLF$+"Treffer:")
      TextGadget(#PB_Any,65,36,30,54,Str(PeekL(mem+216+(x*100)))+#CRLF$+Str(PeekL(mem+220+(x*100)))+#CRLF$+Str(PeekL(mem+224+(x*100)))+"/"+Str(PeekL(mem+269+(x*100))),#PB_Text_Center)
      TextGadget(#PB_Any,95,36,60,54,"Salven:"+#CRLF$+"Schritte:"+#CRLF$+"Sold:")
      TextGadget(#PB_Any,155,36,40,54,Str(PeekL(mem+236+(x*100)))+#CRLF$+Str(PeekL(mem+228+(x*100)))+#CRLF$+Str(PeekL(mem+240+(x*100))),#PB_Text_Right)
      behalten(x)=CheckBoxGadget(#PB_Any,5,90,190,20,"Behalten")
      SetGadgetState(behalten(x),1)
    Else
      behalten(x)=CheckBoxGadget(#PB_Any,0,0,0,0,"")
      HideGadget(behalten(x),1)
    EndIf
    CloseGadgetList()
    ;}
  Next
  For x=0 To 3
    If PeekL(mem+224+(x*100))
      ImageGadget(#PB_Any,15,15+x*120,32,32,ImageID(icon(ehicon(PeekL(mem+264+(x*100)),0))))
    EndIf
  Next
  For x=4 To 7
    If PeekL(mem+224+(x*100))
      ImageGadget(#PB_Any,235,15+(x-4)*120,32,32,ImageID(icon(ehicon(PeekL(mem+264+(x*100)),0))))
    EndIf
  Next
  button=ButtonGadget(#PB_Any,110,490,100,20,"Fertig")
  abbrechen=ButtonGadget(#PB_Any,230,490,100,20,"Abbrechen")
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            For x=0 To 7
              If behalten(x) And GetGadgetState(behalten(x))=0
                If x<>7
                  CopyMemory(mem+300+x*100,mem+200+x*100,(7-x)*100)
                EndIf
                For y=x To 6
                  SetGadgetState(behalten(y),GetGadgetState(behalten(y+1)))
                Next
                SetGadgetState(behalten(7),1)
                For y=0 To 24
                  PokeL(mem+200+7*100+y*4,0)
                Next
                x-1
              EndIf
            Next
            CloseWindow(window)
            ProcedureReturn 1
          Case abbrechen
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
EndProcedure
Procedure Window_Krieg_KampfVerteilung(spieler1,spieler2)
  Dim krieg_verteilung.l(9,7)
  CopyMemory(?krieger_verteilung,@krieg_verteilung(),320)
  
  window=WinOpen(320,310,"Kriegerverteilung")
  
  mem=spieler(spieler1)
  button=ButtonGadget(#PB_Any,100,270,120,30,"So soll es sein!")
  Repeat
    newtime=GetTickCount_()
    time+(newtime-oldtime)
    oldtime=newtime
    time=time&1023
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    WindowMouseX=WindowMouseX(window)
    WindowMouseY=WindowMouseY(window)
    If Event=513
      ;{
      pheilen=0
      pmanoever=0
      pangreifen=0
      einheitgeaendert=0
      For x=0 To 7
        nichtmalen=0
        If PeekL(mem+224+(x*100))
          ;{
          bild=PeekL(mem+264+(x*100))
          angr=PeekB(mem+268+(x*100))-1
          If angr=-1
            px=pheilenx(pheilen)
            py=pheileny(pheilen)
            pheilen+1
          ElseIf angr=-2
            px=pmanoeverx(pmanoever)
            py=pmanoevery(pmanoever)
            pmanoever+1
          ElseIf angr=spieler2 And spieler2>=0
            px=pangreifenx(pangreifen)
            py=pangreifeny(pangreifen)
            pangreifen+1
          Else
            nichtmalen=1
          EndIf
          ;}
          If nichtmalen=0
            If WindowMouseX(window)>px*32 And WindowMouseX(window)<px*32+32
              If WindowMouseY(window)>py*32 And WindowMouseY(window)<py*32+32
                If einheit
                  If einheit=x
                    DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
                  EndIf
                Else    
                  einheit=x+1
                  einheitx=px
                  einheity=py
                  EinheitBild=PeekL(mem+264+(x*100))
                  einheitgeaendert=1
                EndIf
              EndIf
            EndIf
          EndIf
        EndIf
      Next
      If einheitgeaendert=0 And einheit
        If WindowMouseY(window)<160;oberer teil
          If WindowMouseX<160      ;links oben; erholen
            einheit-1
            PokeB(mem+268+(einheit*100),0)
            Event=#PB_Event_Repaint
            einheit=0
            DrawTransparentImage(icon(krieg_verteilung(einheitx,einheity)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
          Else ;rechtsoben ;angriff
            If spieler2>=0
              einheit-1
              PokeB(mem+268+(einheit*100),spieler2+1)
              Event=#PB_Event_Repaint
              einheit=0
              DrawTransparentImage(icon(krieg_verteilung(einheitx,einheity)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
            EndIf
          EndIf
        ElseIf WindowMouseY(window)<257
          einheit-1
          PokeB(mem+268+(einheit*100),-1)
          Event=#PB_Event_Repaint  
          einheit=0
          DrawTransparentImage(icon(krieg_verteilung(einheitx,einheity)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
        EndIf
      EndIf
      ;}
    EndIf
    If einheit 
      If time>511
        DrawTransparentImage(icon(krieg_verteilung(einheitx,einheity)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
      Else
        DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
      EndIf
    EndIf
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        ; For x=0 To 9
        ; For y=0 To 7
        ; DrawTransparentImage(icon(krieg_verteilung(x,y)),WindowOutput(window),x*32,y*32,32,32,0,0,32,32,$FF00FF)
        ; Next
        ; Next
        If EventWindow()=window
          ;{
          StartDrawing(WindowOutput(window))
          DrawImage(ImageID(krieger_verteilung),0,0)
          If spieler2=-1
            DrawImage(ImageID(icon(54)),32*6,0)
            DrawImage(ImageID(icon(54)),32*7,0)
          EndIf
          ; DrawingMode(1)
          ; DrawingFont(FontID(10))
          ; FrontColor($FFFFFF)
          ; For x=-1 To 1 Step 2
          ; For y=-1 To 1 Step 2
          ; DrawText(  5+x,  5+y,"Erholung:")
          ; DrawText(  5+x,165+y,"Manöver:")
          ; DrawText(192+x,  5+y,"Angriff:")
          ; Next
          ; Next
          ; FrontColor($0)
          ; DrawText(  5,  5,"Erholung:")
          ; DrawText(  5,165,"Manöver:")
          ; DrawText(192,  5,"Angriff:")
          StopDrawing()
          pheilen=0
          pmanoever=0
          pangreifen=0
          For x=0 To 7
            nichtmalen=0
            If PeekL(mem+224+(x*100))
              bild=PeekL(mem+264+(x*100))
              angr=PeekB(mem+268+(x*100))-1
              If angr=-1
                px=pheilenx(pheilen)
                py=pheileny(pheilen)
                pheilen+1
              ElseIf angr=-2
                px=pmanoeverx(pmanoever)
                py=pmanoevery(pmanoever)
                pmanoever+1
              ElseIf angr=spieler2 And spieler2>=0
                px=pangreifenx(pangreifen)
                py=pangreifeny(pangreifen)
                pangreifen+1
              Else
                nichtmalen=1
              EndIf
              If nichtmalen=0
                DrawTransparentImage(icon(ehicon(bild,0)),WindowOutput(window),px*32,py*32,32,32,0,0,32,32,$FF00FF)
                res=pangreifen
              EndIf
            EndIf
          Next
        EndIf ;}
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            CloseWindow(window)
            ProcedureReturn res
        EndSelect
    EndSelect
    
  ForEver
  
EndProcedure


;##### ------------------------------------------------------------------------
;##### Kriegsnachrichten
;##### ------------------------------------------------------------------------

Procedure.s Window_Krieg(spieler)
  window=WinOpen(300,240,"Wählt Euer Opfer!")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,50,10,200,40,"Über wen sollen Eure Truppen diesmal herfallen?",#PB_Text_Center)
  combo=ComboBoxGadget(#PB_Any,10,70,280,22)
  For x=0 To PeekB(spiel)
    If x<>spieler
      AddGadgetItem(combo,-1,titel(PeekW(spieler(x)+84),PeekB(spieler(x)+33))+" "+PeekS(spieler(x)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(x)+124))\name)
    EndIf
  Next
  SetGadgetState(combo,0)
  button=ButtonGadget(#PB_Any,25,200,100,30,"Krieg")
  abbrechen=ButtonGadget(#PB_Any,175,200,100,30,"Abbrechen")
  
  ImageGadget(#PB_Any, 10, 10, 32, 32, ImageID (icon(33)) )
  ImageGadget(#PB_Any, 258, 10, 32, 32, ImageID (icon(33)) )
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        
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
Procedure Window_Krieg_Gewonnen(spieler)
  window=WinOpen(260,140,"Gewonnen!")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,50, 10,200,40,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name)
  TextGadget(#PB_Any,10, 50,240,60,"Ihr konntet Euch gegenüber den Angreifern behaupten und seid Siegreich aus der Schlacht emporgegangen")
  button=ButtonGadget(#PB_Any,80,110,100,20,"Fertig")
  ImageGadget(#PB_Any, 10, 10, 32, 32, ImageID (icon(23)) )
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            PokeL(mem+34,PeekL(mem+34)+10)
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
EndProcedure
Procedure Window_Krieg_Verloren(spieler)
  window=WinOpen(260,140,"Verloren!")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,50, 10,200,40,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name)
  TextGadget(#PB_Any,10, 50,240,60,"Ihr seit als Verlierer aus der Schlacht hervorgegangen. Auch eure Enkel werden sich mit Schande an diesen Tag erinnern.")
  button=ButtonGadget(#PB_Any,80,110,100,20,"Grrr!")
  ImageGadget(#PB_Any, 10, 10, 32, 32, ImageID (icon(23)) )
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            PokeL(mem+34,PeekL(mem+34)-10)
            CloseWindow(window)
            ProcedureReturn 1
        EndSelect
    EndSelect
    
  ForEver
EndProcedure
Procedure Window_Krieg_Kriegsforderung(spieler)
  window=WinOpen(260,450,"Gewonnen!")
  
  mem=spieler(spieler)
  Define v.Kriegsforderung
  TextGadget(#PB_Any,50, 10,200,40,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name)
  TextGadget(#PB_Any,10, 50,240,60,"Ihr habt Euern Feind niedergestreckt. Nun könnt Ihr eine Kriegsforderung an den Verlierer stellen.")
  FrameGadget(#PB_Any,10,110,240,60,"Märkte:")
  FrameGadget(#PB_Any,10,170,240,60,"Mühlen:")
  FrameGadget(#PB_Any,10,230,240,60,"Taler:")
  FrameGadget(#PB_Any,10,290,240,60,"Ländereien:")
  FrameGadget(#PB_Any,10,350,240,60,"Sklaven:")
  tb1=TrackBarGadget(#PB_Any,50,130,150,20,0,10,#PB_TrackBar_Ticks)
  tb2=TrackBarGadget(#PB_Any,50,190,150,20,0,10,#PB_TrackBar_Ticks)
  tb3=TrackBarGadget(#PB_Any,50,250,150,20,0,50000)
  tb4=TrackBarGadget(#PB_Any,50,310,150,20,0,10000)
  tb5=TrackBarGadget(#PB_Any,50,370,150,20,0,1000)
  tx1=TextGadget(#PB_Any,200,130,40,20,"0")
  tx2=TextGadget(#PB_Any,200,190,40,20,"0")
  tx3=TextGadget(#PB_Any,200,250,40,20,"0")
  tx4=TextGadget(#PB_Any,200,310,40,20,"0")
  tx5=TextGadget(#PB_Any,200,370,40,20,"0")
  button=ButtonGadget(#PB_Any,80,420,100,20,"Fertig",#PB_TrackBar_Ticks)
  
  ImageGadget(#PB_Any, 10, 10, 32, 32, ImageID (icon(23)) )
  ImageGadget(#PB_Any, 20, 125, 32, 32, ImageID (icon(14)) )
  ImageGadget(#PB_Any, 20, 185, 32, 32, ImageID (icon(15)) )
  ImageGadget(#PB_Any, 20, 245, 32, 32, ImageID (icon(24)) )
  ImageGadget(#PB_Any, 20, 305, 32, 32, ImageID (icon(13)) )
  ImageGadget(#PB_Any, 20, 365, 32, 32, ImageID (icon(28)) )
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        
      Case #PB_Event_Gadget
        Select EventGadget
          Case tb1
            v\maerkte=GetGadgetState(tb1)
            SetGadgetText(tx1,Str(GetGadgetState(tb1)))
          Case tb2
            v\muehlen=GetGadgetState(tb2)
            SetGadgetText(tx2,Str(GetGadgetState(tb2)))
          Case tb3
            v\taler=GetGadgetState(tb3)
            SetGadgetText(tx3,Str(GetGadgetState(tb3)))
          Case tb4
            v\land=GetGadgetState(tb4)
            SetGadgetText(tx4,Str(GetGadgetState(tb4)))
          Case tb5
            v\sklaven=GetGadgetState(tb5)
            SetGadgetText(tx5,Str(GetGadgetState(tb5)))
          Case button
            PokeL(mem+34,PeekL(mem+34)+10)
            CloseWindow(window)
            ProcedureReturn @v
        EndSelect
    EndSelect
    
  ForEver
EndProcedure
Procedure Window_Krieg_Kriegsforderung2(spieler,*forderung.Kriegsforderung,forderer)
  window=WinOpen(260,360,"Gewonnen!")
  
  mem=spieler(spieler)
  mem2=spieler(forderer)
  TextGadget(#PB_Any,50, 10,200,40,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name)
  TextGadget(#PB_Any,10, 50,200,80,titel(PeekW(spieler(forderer)+84),PeekB(spieler(forderer)+33))+" "+PeekS(spieler(forderer)+1,16)+" von "+land(PeekB(spieler(forderer)+124))\name+" hat folgende Forderung an Euch gestellt und erwartet, dass Ihr ihr unverzüglich nachkommt:")
  TextGadget(#PB_Any,60,135,90,20,Str(*forderung\maerkte)+" Märkte")
  TextGadget(#PB_Any,60,175,90,20,Str(*forderung\muehlen)+" Mühlen")
  TextGadget(#PB_Any,60,215,90,20,Str(*forderung\taler)+" Taler")
  TextGadget(#PB_Any,60,255,90,20,Str(*forderung\land)+" Länderreien")
  TextGadget(#PB_Any,60,295,90,20,Str(*forderung\sklaven)+" Sklaven")
  button=ButtonGadget(#PB_Any,80,330,100,20,"Fertig",#PB_TrackBar_Ticks)
  
  ImageGadget(#PB_Any, 10, 10, 32, 32, ImageID (icon(23)) )
  ImageGadget(#PB_Any, 20, 125, 32, 32, ImageID (icon(14)) )
  ImageGadget(#PB_Any, 20, 165, 32, 32, ImageID (icon(15)) )
  ImageGadget(#PB_Any, 20, 205, 32, 32, ImageID (icon(24)) )
  ImageGadget(#PB_Any, 20, 245, 32, 32, ImageID (icon(13)) )
  ImageGadget(#PB_Any, 20, 285, 32, 32, ImageID (icon(28)) )
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        
      Case #PB_Event_Gadget
        Select EventGadget
          Case button
            PokeL(mem+34,PeekL(mem+34)+10)
            CloseWindow(window)
            ProcedureReturn @v
        EndSelect
    EndSelect
    
  ForEver
EndProcedure
Procedure Window_Krieg_Aufgeben()
  window=WinOpen(200,80,"Kapitulation")
  
  mem=spieler(spieler)
  TextGadget(#PB_Any,50, 10,160,40,"Wollt ihr den Rückzug antreten?")
  button=ButtonGadget(#PB_Any,20,50,60,20,"Ja")
  abbrechen=ButtonGadget(#PB_Any,120,50,60,20,"Nein")
  
  ImageGadget(#PB_Any, 10, 10, 32, 32, ImageID (icon(33)) )
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    
    Select Event
      Case #PB_Event_Repaint
        RePaint(EventWindow())
        
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

;##### ------------------------------------------------------------------------
;##### Funktionen Schlachtfeld
;##### und Einheiten auf dem Schlachtfeld
;##### Diese Einheiten werden etwas anders behandelt als die im normalen spiel
;#####
;##### Erst am Ende einer Schlacht werden die Resultate in die 
;##### Spiel-Strukturen zurück geschrieben
;##### ------------------------------------------------------------------------

Procedure Krieg_Init_Einheiten(spieler)
  speicher=0
  mem=spieler(spieler)
  ClearList(einheiten())
  ;{ einheiten suchen
  For x=0 To PeekB(spiel);jeden spieler durchgehen
    For y=0 To 9         ; jede einheit durchgehen
      If PeekB(268+spieler(x)+y*100)=spieler+1
        AddElement(einheiten())
        einheiten()\spieler=x
        einheiten()\einheit=y
        If spieler=x
          einheiten()\angreifer=0
          verteidiger+1
        Else
          einheiten()\angreifer=1
          angreifer+1
        EndIf
        einheiten()\mem=krieg_speicher+speicher
        speicher+100
        CopyMemory(200+spieler(x)+y*100,einheiten()\mem,100)
        PokeL(einheiten()\mem+24,PeekL(einheiten()\mem+69)*4)
        PokeL(einheiten()\mem+69,PeekL(einheiten()\mem+69)*4)
        If x=spieler
          einheiten()\schritte=PeekL(einheiten()\mem+28)
          schritte_gesammt+PeekL(einheiten()\mem+28)
        EndIf
      EndIf
    Next
  Next
  ;}
  If verteidiger<8 Or verteidiger<angreifer
    ;{ miliz aufstellen
    If verteidiger<8
      menge=8-verteidiger
    EndIf
    If verteidiger+menge<angreifer
      menge=angreifer-verteidiger
    EndIf
    If menge+verteidiger>24
      menge=24-verteidiger
    EndIf
    For x=1 To menge
      AddElement(einheiten())
      einheiten()\spieler=spieler
      einheiten()\einheit=-1
      einheiten()\angreifer=0
      einheiten()\schritte=1
      schritte_gesammt+1
      einheiten()\mem=krieg_speicher+speicher
      speicher+100
      CopyMemory(miliz,einheiten()\mem,100)
      PokeL(einheiten()\mem+24,PeekL(einheiten()\mem+69)*4)
      PokeL(einheiten()\mem+69,PeekL(einheiten()\mem+69)*4)
    Next
    ;}
  EndIf
  ;Einheiten auf Ihre Startposition Setzen
  ForEach einheiten()
    ;{ 
    sp=einheiten()\spieler+1
    If sp<>spieler+1
      For x=0 To 4
        If Angreifer_Ort(x)=sp Or Angreifer_Ort(x)=0
          Angreifer_Ort(x)=sp
          Break
        EndIf
      Next
      ;{
      If x=0
        px=1
        py=7
      ElseIf x=1
        px=3
        py=1
      ElseIf x=2
        px=3
        py=13
      ElseIf x=3
        px=9
        py=1
      Else
        px=9
        py=13
      EndIf
      ;}
    Else
      px=18
      py=7
    EndIf
    For x=0 To 5
      For y=157 To 471 Step 8
        If sp=spieler+1
          px2=px+Round(-Cos(y/100)*x,#PB_Round_Nearest)
        Else
          px2=px+Round(Cos(y/100)*x,#PB_Round_Nearest)
        EndIf
        py2=py+Round(-Sin(y/100)*x,#PB_Round_Nearest)
        If px2>=0 And px2<=19 And py2>=0 And py2<=14 And krieg_map_passierbar(px2,py2)=1
          krieg_map_passierbar(px2,py2)=2
          einheiten()\x=px2
          einheiten()\y=py2
          Break 2
        EndIf
      Next
    Next
    ;}
  Next
  
EndProcedure
Procedure Krieg_Init_Map(mapnr=0)
  Select mapnr
      
    Case 1
      
      map_mem=?map1
      
    Default
      
      map_mem=?map1
      
  EndSelect
  
  CopyMemory(map_mem,@krieg_map(),1200)
  
  For x=0 To 19
    For y=0 To 14
      Select krieg_map(x,y)
        Case 54,82,84
          krieg_map_passierbar(x,y)=1
        Default
          krieg_map_passierbar(x,y)=0
      EndSelect
    Next
  Next
EndProcedure
Procedure Krieg_Count_Spieler()
  For x=0 To 4
    If Angreifer_Ort(x)=0
      x-1
      Break
    EndIf
  Next
  ProcedureReturn x
EndProcedure
Procedure Krieg_Set_Current_Player(spieler_dran)
  
  ForEach einheiten()
    If einheiten()\spieler=spieler_dran
      einheiten()\schritte=PeekL(einheiten()\mem+28)
      schritte+PeekL(einheiten()\mem+28)
    EndIf
  Next
  
  ProcedureReturn schritte
  
EndProcedure
Procedure Krieg_Aufgeben(schritte_gesammt.l,spieler_dran,spieler,window)
  PokeL(schritte_gesammt,0)
  x=spieler_dran
  
  For y=0 To 9 ; jede einheit durchgehen
    If PeekB(268+spieler(x)+y*100)=spieler+1
      ForEach einheiten()
        If einheiten()\spieler=x
          If einheiten()\einheit=y
            PokeL(224+spieler(x)+y*100,Round(PeekL(24+einheiten()\mem)/4,#PB_Round_Up))
            PokeB(268+spieler(x)+y*100,-10)
            krieg_map_passierbar(einheiten()\x,einheiten()\y)=1
            DrawTransparentImage(icon(krieg_map(einheiten()\x,einheiten()\y)),WindowOutput(window),einheiten()\x*32,einheiten()\y*32,32,32,0,0,32,32,$FF00FF)
            DeleteElement(einheiten())
            Break
          EndIf
        EndIf
      Next
    EndIf
  Next
  
  ForEach einheiten(); miliz entfernen
    If einheiten()\spieler=x
      If einheiten()\einheit=-1
        krieg_map_passierbar(einheiten()\x,einheiten()\y)=1
        DrawTransparentImage(icon(krieg_map(einheiten()\x,einheiten()\y)),WindowOutput(window),einheiten()\x*32,einheiten()\y*32,32,32,0,0,32,32,$FF00FF)
        DeleteElement(einheiten())
      EndIf
    EndIf
  Next
  
  FirstElement(einheiten())
  wer=einheiten()\spieler
  einer_hat_gewonnen=1
  ForEach einheiten()
    If wer<>einheiten()\spieler
      einer_hat_gewonnen=0
    EndIf
  Next
  ProcedureReturn einer_hat_gewonnen
EndProcedure
Procedure Krieg_Beenden(spieler_dran,spieler)
  If spieler_dran=spieler;verteidiger hat gewonnen
                         ;{
    mem=spieler(spieler)
    If PeekB(spieler(spieler))=1;verteidiger=mensch
      Window_Krieg_Gewonnen(spieler_dran)
    EndIf
    For x=0 To 4
      If Angreifer_Ort(x)
        PokeL(mem+1200+Angreifer_Ort(x)*20+00,0)
        PokeL(mem+1200+Angreifer_Ort(x)*20+04,0)
        PokeL(mem+1200+Angreifer_Ort(x)*20+08,0)
        PokeL(mem+1200+Angreifer_Ort(x)*20+12,0)
        PokeL(mem+1200+Angreifer_Ort(x)*20+16,0)
        If PeekB(spieler(Angreifer_Ort(x)-1))=1;verteidiger=mensch
          Window_Krieg_Verloren(Angreifer_Ort(x)-1)
        EndIf
      EndIf
    Next
    ;}
  Else;Angreifer hat gewonnen
      ;{
    Define *v.Kriegsforderung
    If PeekB(spieler(spieler_dran))=1
      *v=Window_Krieg_Kriegsforderung(spieler_dran)
    Else
      *v=AllocateMemory(20)
    EndIf
    mem=spieler(spieler_dran)
    PokeL(mem+1200+spieler*20+00,0)
    PokeL(mem+1200+spieler*20+04,0)
    PokeL(mem+1200+spieler*20+08,0)
    PokeL(mem+1200+spieler*20+12,0)
    PokeL(mem+1200+spieler*20+16,0)
    mem=spieler(spieler)
    PokeL(mem+1200+spieler_dran*20+00,PeekL(mem+1200+spieler_dran*20+00)+*v\maerkte)
    PokeL(mem+1200+spieler_dran*20+04,PeekL(mem+1200+spieler_dran*20+04)+*v\muehlen)
    PokeL(mem+1200+spieler_dran*20+08,PeekL(mem+1200+spieler_dran*20+08)+*v\taler)
    PokeL(mem+1200+spieler_dran*20+12,PeekL(mem+1200+spieler_dran*20+12)+*v\land)
    PokeL(mem+1200+spieler_dran*20+16,PeekL(mem+1200+spieler_dran*20+16)+*v\sklaven)
    If PeekB(spieler(spieler))=1
      Window_Krieg_Kriegsforderung2(spieler,*v,spieler_dran)
    EndIf
    
    ;}
  EndIf
  
  ;{ getötete einheiten töten
  For x=0 To PeekB(spiel);jeden spieler durchgehen
    For y=0 To 9         ; jede einheit durchgehen
      If PeekB(268+spieler(x)+y*100)=spieler+1
        einheitda=0
        ForEach einheiten()
          If einheiten()\spieler=x
            If einheiten()\einheit=y
              einheitda=1
              PokeL(224+spieler(x)+y*100,Round(PeekL(24+einheiten()\mem)/4,#PB_Round_Up))
            EndIf
          EndIf
        Next
        If einheitda=0
          For z=0 To 24
            PokeL(200+spieler(x)+y*100+z*4,0)
          Next
        EndIf
      EndIf
    Next
  Next
  ;}
EndProcedure
Procedure Krieg_Test_Beendet(window)
  If IsWindow(window)
    ProcedureReturn 0
  EndIf
  ProcedureReturn 1
EndProcedure
Procedure Krieg_Naester_Spieler(mem_wer_ist_dran,anzahl_spieler,spieler,window,einer_hat_gewonnen,einheit,EinheitBild,einheitx,einheity)
  wer_ist_dran=PeekL(mem_wer_ist_dran)
  wer_war_dran=wer_ist_dran
  Repeat
    wer_ist_dran+1
    If wer_ist_dran>anzahl_spieler
      wer_ist_dran=-1
    EndIf
    If wer_ist_dran=-1
      spieler_dran=spieler
    Else
      spieler_dran=Angreifer_Ort(wer_ist_dran)-1
    EndIf
    
    If wer_ist_dran=wer_war_dran Or einer_hat_gewonnen
      ;-einer hat den krieg gewonnen
      Krieg_Beenden(spieler_dran,spieler)
      CloseWindow(window)
      ProcedureReturn 1
      Break
    EndIf
    
    schritte_gesammt=Krieg_Set_Current_Player(spieler_dran)
    If schritte_gesammt
      Break
    EndIf
  ForEver
  If PeekL(einheit)
    DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
    PokeL(einheit,0)
  EndIf
  PokeL(mem_wer_ist_dran,wer_ist_dran)
  ProcedureReturn spieler_dran
EndProcedure

Procedure Krieg_Zeichne_Wer_Ist_Dran(window,wer_ist_dran)
  
  StartDrawing(WindowOutput(window))
  If FontID(Fonts(12))
    DrawingFont(FontID(Fonts(12)))
  EndIf
  For x=0 To 4
    If Angreifer_Ort(x)
      If wer_ist_dran=x
        DrawText(200,501+x*12,PeekS(spieler(Angreifer_Ort(x)-1)+1,16),0,$FFFFFF)
      Else
        DrawText(200,501+x*12,PeekS(spieler(Angreifer_Ort(x)-1)+1,16),0,$C0C0C0)
      EndIf
    EndIf
  Next
  If wer_ist_dran=-1
    DrawText(380,501,PeekS(spieler(spieler)+1,16,#PB_Ascii),0,$FFFFFF)
  Else
    DrawText(380,501,PeekS(spieler(spieler)+1,16,#PB_Ascii),0,$C0C0C0)
  EndIf
  StopDrawing()
  
EndProcedure


;##### ------------------------------------------------------------------------
;##### KI
;##### ------------------------------------------------------------------------

Procedure CPU_Play(*Aktion.AktionOutput,*Spieler.AktionInput,List EH.Krieg_Einheit(),Array KM.l(2))
  ForEach EH()
    If EH()\spieler=*Spieler\spieler
      AnzahlEigeneEinheiten+1
    Else
      AnzahlGegnerEinheiten+1
    EndIf
  Next
  If AnzahlEigeneEinheiten>AnzahlGegnerEinheiten
    If *spieler\einheit
      SelectElement(Eh(),*Spieler\einheit-1)
      
      If krieg_map_passierbar(Eh()\x-1,eh()\y)=1
        *Aktion\CPU_Event=513
        *Aktion\WindowX=(Eh()\x-1)*32+16
        *Aktion\WindowY=(Eh()\y+0)*32+16
      Else
        *Aktion\CPU_Event=513
        *Aktion\WindowX=Eh()\x*32+16
        *Aktion\WindowY=Eh()\y*32+16
        *Aktion\Schritte_Gesammt-EH()\schritte
        EH()\schritte=0
      EndIf
      
    Else;not *spieler\einheit
      ForEach EH()
        If EH()\spieler=*Spieler\spieler And EH()\schritte
          *Aktion\CPU_Event=513
          *Aktion\WindowX=Eh()\x*32+16
          *Aktion\WindowY=Eh()\y*32+16
          Break
        EndIf
      Next
    EndIf
  EndIf
EndProcedure

;##### ------------------------------------------------------------------------
;##### Krieg
;##### ------------------------------------------------------------------------

Procedure Window_Krieg_Kampf(spieler)
  ; vorbereitung
  Krieg_Init_Map(1)
  Krieg_Init_Einheiten(spieler)
  ;## anzahl_spieler - gibt die anzahl der angreifer an
  ;## wer_ist_dran   - reihenfolge der spieler -1=Verteidiger, beginnend bei 0 angreifer
  ;## spieler_dran   - ist pointer für: spieler(spieler_dran) ; spielerdaten(spieler_dran)
  anzahl_spieler=Krieg_Count_Spieler()
  wer_ist_dran=-1;verteidiger startet
  spieler_dran=spieler
  
  ;## schritte_gesammt - counter für die restlich verbleibenden schritte aller eigenen einheiten
  ;##                    wenn schritte_gesammt=0 ist der zug vorbei
  schritte_gesammt=Krieg_Set_Current_Player(spieler_dran)  
  Define Aktion.AktionOutput,Input.AktionInput
  PlaySound(sounds(8))
  window=WinOpen(640,560,"Entfesselt die Hunde des Krieges!")
  
  naechster=ButtonGadget(#PB_Any,280,481,100,39,"Nächster Spieler",#PB_Button_MultiLine)
  ;k_fordern=ButtonGadget(#PB_Any,280,520,100,20,"Kapitulation Fordern")
  aufgeben=ButtonGadget(#PB_Any,280,520,100,40,"Aufgeben")
  SetGadgetFont(naechster,FontID(Fonts(13)))
  SetGadgetFont(aufgeben,FontID(Fonts(13)))
  
  Repeat
    Event=WaitWindowEvent(#TimeOut)
    EventMenu=EventMenu()
    EventGadget=EventGadget()
    EventType=EventType()
    WindowMouseX=WindowMouseX(window)
    WindowMouseY=WindowMouseY(window)
    ;{ Blinken der markierten Einheiten
    newtime=GetTickCount_()
    time+(newtime-oldtime)
    cpu_time+(newtime-oldtime)
    oldtime=newtime
    If cpu_time>256
      cpu_play=1
    EndIf
    cpu_time&255
    time=time&1023
    If GetActiveWindow()=window
      If einheit 
        If time>750
          DrawTransparentImage(icon(krieg_map(einheitx,einheity)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
        Else
          DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
        EndIf
      EndIf
    EndIf
    ;}
    ;{ zeichne in die box links unten infos über gewählte einheit
    If EventWindow()=window And GetActiveWindow()=window
      ForEach einheiten()
        If einheit=ListIndex(einheiten())+1 And gezeichnet2<>einheit
          StartDrawing(WindowOutput(window))
          DrawImage(ImageID(krieg_voll),000,481)
          DrawingFont(FontID(Fonts(12)))
          DrawingMode(1)
          FrontColor(0)
          DrawText(005,483,PeekS(einheiten()\mem,16))
          DrawText(105,483,PeekS(spieler(einheiten()\spieler)+1,16))
          DrawText(022,523,Str(PeekL(einheiten()\mem+16)))
          DrawText(059,523,Str(PeekL(einheiten()\mem+20)))
          DrawText(096,523,Str(PeekL(einheiten()\mem+36)))
          DrawText(133,523,Str(einheiten()\schritte))
          If PeekL(einheiten()\mem+69)
            Box(025,545,99*PeekL(einheiten()\mem+24)/PeekL(einheiten()\mem+69),4,$00FF00)
          EndIf
          StopDrawing()
          gezeichnet2=ListIndex(Einheiten())+1
          Break
        EndIf
      Next
      If Not einheit
        StartDrawing(WindowOutput(window))
        DrawImage(ImageID(krieg_leer),0,481)
        StopDrawing()
        gezeichnet2=0
      EndIf
      
    EndIf
    
    ;}    
    ;{ KI
    If cpu_play And Event=0
      cpu_play=0
      If PeekB(spieler(spieler_dran))=0;spieler=cpu
        ClearStructure(@Aktion,AktionOutput)
        ClearStructure(@Input,AktionInput)
        Aktion\Schritte_Gesammt=schritte_gesammt
        Input\spieler=spieler_dran
        Input\einheit=einheit
        CPU_Play(Aktion,Input,einheiten(),krieg_map())
        CPU_Event=Aktion\CPU_Event
        schritte_gesammt=Aktion\Schritte_Gesammt
        WindowMouseX=Aktion\WindowX
        WindowMouseY=Aktion\WindowY
        CPU_EventGadget=Aktion\Event_Gadget
      EndIf
    Else
      CPU_Event=0
      CPU_EventGadget=0
    EndIf
    ;}
    
    Select Event|CPU_Event
      Case 513;mausklick aufs fenster
              ;{
        If PeekB(spieler(spieler_dran))=1 Or CPU_Event;if spieler_dran=mensch 
          If EventWindow()=window And WindowMouseY<480 And WindowMouseY>0 And WindowMouseX>0 And WindowMouseX<640
            If einheit;{
              Select krieg_map_passierbar(WindowMouseX/32,WindowMouseY/32)
                Case 2
                  ForEach einheiten()
                    If einheiten()\x*32<WindowMouseX And einheiten()\x*32+32>WindowMouseX And einheiten()\y*32<WindowMouseY And einheiten()\y*32+32>WindowMouseY 
                      If einheit=ListIndex(einheiten())+1;{
                        DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
                        einheit=0
                        Break
                        ;}
                      ElseIf einheiten()\spieler=spieler_dran 
                        If einheiten()\schritte;{
                          DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
                          einheitx=einheiten()\x
                          einheity=einheiten()\y
                          EinheitBild=PeekL(einheiten()\mem+64)
                          einheit=ListIndex(einheiten())+1
                          Break
                        EndIf
                        ;}
                      Else;{
                        
                        If WindowMouseX/32>=einheitx-1 And WindowMouseX/32<=einheitx+1
                          If WindowMouseY/32>=einheity-1 And WindowMouseY/32<=einheity+1
                            angegriffene=ListIndex(einheiten())
                            a2=PeekL(einheiten()\mem+16)
                            v2=PeekL(einheiten()\mem+20)
                            SelectElement(einheiten(),einheit-1)
                            a1=PeekL(einheiten()\mem+16)
                            v1=PeekL(einheiten()\mem+20)
                            schaden=0
                            If Random(Round(Sqr(a1),#PB_Round_Up))>=Random(Round(Sqr(v2),#PB_Round_Down))
                              If a1>v2
                                schaden=Random(a1-v2)+Random(a1-v2)+Random(a1-v2)+Random(a1-v2)
                              Else
                                schaden=Random(4)
                              EndIf
                            EndIf
                            If schaden=0
                              PlaySound(sounds(18))
                            EndIf
                            If schaden
                              PlaySound(sounds(4))
                              SelectElement(einheiten(),angegriffene)
                              tp=PeekL(einheiten()\mem+24)
                              If schaden>=tp
                                Delay(100)
                                PlaySound(sounds(5))
                                krieg_map_passierbar(einheiten()\x,einheiten()\y)=1
                                DrawTransparentImage(icon(krieg_map(einheiten()\x,einheiten()\y)),WindowOutput(window),einheiten()\x*32,einheiten()\y*32,32,32,0,0,32,32,$FF00FF)
                                DeleteElement(einheiten())
                                FirstElement(einheiten())
                                t_spieler=einheiten()\spieler
                                ok=0
                                ForEach einheiten()
                                  If t_spieler<>einheiten()\spieler
                                    ok=1
                                    Break
                                  EndIf
                                Next
                                If ok=0
                                  schritte_gesammt=0
                                  Break
                                EndIf
                              Else
                                PokeL(einheiten()\mem+24,tp-schaden)
                              EndIf
                            EndIf
                            SelectElement(einheiten(),einheit-1)
                            schritte_gesammt-einheiten()\schritte
                            einheiten()\schritte=0
                            DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
                            einheit=0
                            Break
                          EndIf
                        EndIf
                        ;}
                      EndIf
                    EndIf
                  Next
                Case 1
                  ;{
                  If WindowMouseX/32>=einheitx-1 And WindowMouseX/32<=einheitx+1
                    If WindowMouseY/32>=einheity-1 And WindowMouseY/32<=einheity+1
                      PlaySound(sounds(15))
                      DrawTransparentImage(icon(krieg_map(einheitx,einheity)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
                      SelectElement(einheiten(),einheit-1)
                      einheiten()\x=WindowMouseX/32
                      einheiten()\y=WindowMouseY/32
                      krieg_map_passierbar(einheitx,einheity)=1
                      krieg_map_passierbar(einheiten()\x,einheiten()\y)=2
                      einheitx=einheiten()\x
                      einheity=einheiten()\y
                      schritte_gesammt-1
                      einheiten()\schritte-1
                      If einheiten()\schritte=0
                        DrawTransparentImage(icon(ehicon(EinheitBild,0)),WindowOutput(window),einheitx*32,einheity*32,32,32,0,0,32,32,$FF00FF)
                        einheit=0
                      EndIf
                    EndIf
                  EndIf
                  ;}
              EndSelect
              ;}
            Else ;{
              ForEach einheiten()
                If einheiten()\spieler=spieler_dran And einheiten()\schritte
                  If einheiten()\x*32<WindowMouseX And einheiten()\x*32+32>WindowMouseX And einheiten()\y*32<WindowMouseY And einheiten()\y*32+32>WindowMouseY
                    einheitx=einheiten()\x
                    einheity=einheiten()\y
                    EinheitBild=PeekL(einheiten()\mem+64)
                    einheit=ListIndex(einheiten())+1
                  EndIf
                EndIf
              Next
              ;}
            EndIf
          EndIf
        EndIf
        ;}
      Case 512;mausmove
              ;{ zeichne in die box rechts unten infos über die mouseover einheit
        If EventWindow()=window And WindowMouseY<480 And GetActiveWindow()=window
          eh_erfasst=0
          ForEach einheiten()
            If einheiten()\x*32<WindowMouseX And einheiten()\x*32+32>WindowMouseX And einheiten()\y*32<WindowMouseY And einheiten()\y*32+32>WindowMouseY
              eh_erfasst=1
              If gezeichnet<>ListIndex(einheiten())+1
                StartDrawing(WindowOutput(window))
                DrawImage(ImageID(krieg_voll),460,481)
                DrawingFont(FontID(Fonts(12)))
                DrawingMode(1)
                FrontColor(0)
                DrawText(465,483,PeekS(einheiten()\mem,16))
                DrawText(565,483,PeekS(spieler(einheiten()\spieler)+1,16))
                DrawText(482,523,Str(PeekL(einheiten()\mem+16)))
                DrawText(519,523,Str(PeekL(einheiten()\mem+20)))
                DrawText(556,523,Str(PeekL(einheiten()\mem+36)))
                DrawText(593,523,Str(einheiten()\schritte))
                If PeekL(einheiten()\mem+69)
                  Box(485,545,99*PeekL(einheiten()\mem+24)/PeekL(einheiten()\mem+69),4,$00FF00)
                EndIf
                StopDrawing()
                gezeichnet=ListIndex(einheiten())+1
              EndIf
            EndIf
          Next
          If eh_erfasst=0 And gezeichnet
            StartDrawing(WindowOutput(window))
            DrawImage(ImageID(krieg_leer),460,481)
            StopDrawing()
            gezeichnet=0
          EndIf
          
        EndIf
        ;}
      Case #PB_Event_Repaint
        ;{
        RePaint(EventWindow())
        If EventWindow()=window
          StartDrawing(WindowOutput(window))
          For x=0 To 19
            For y=0 To 14
              DrawImage(ImageID(icon(krieg_map(x,y))),x*32,y*32)
              ;DrawTransparentImage(icon(krieg_map(x,y)),WindowOutput(window),x*32,y*32,32,32,0,0,32,32,$FF00FF)
            Next
          Next
          DrawImage(ImageID(krieg_leer),0,481)
          DrawImage(ImageID(krieg_leer),460,481)
          Line(0,480,640,0,0)
          Box(200,481,80,80,$C0C0C0)
          Box(380,481,80,80,$C0C0C0)
          BackColor($C0C0C0)
          DrawingFont(FontID(Fonts(11)))
          DrawText(200,481,"Angreifer:",0)
          DrawText(380,481,"Verteidiger:",0)
          DrawingFont(FontID(Fonts(12)))
          For x=0 To 4
            If Angreifer_Ort(x)
              If wer_ist_dran=x
                DrawText(200,501+x*12,PeekS(spieler(Angreifer_Ort(x)-1)+1,16),0,$FFFFFF)
              Else
                DrawText(200,501+x*12,PeekS(spieler(Angreifer_Ort(x)-1)+1,16))
              EndIf
            EndIf
          Next
          If wer_ist_dran=-1
            DrawText(380,501,PeekS(spieler(spieler)+1,16,#PB_Ascii),0,$FFFFFF)
          Else
            DrawText(380,501,PeekS(spieler(spieler)+1,16,#PB_Ascii))
          EndIf
          StopDrawing()
          ForEach einheiten()
            DrawTransparentImage(icon(ehicon(PeekL(einheiten()\mem+64),0)),WindowOutput(window),einheiten()\x*32,einheiten()\y*32,32,32,0,0,32,32,$FF00FF)
          Next
        EndIf
        ;}
      Case #PB_Event_Gadget
        ;{
        Select EventGadget|CPU_EventGadget
          Case naechster
            If PeekB(spieler(spieler_dran))=1
              spieler_dran=Krieg_Naester_Spieler(@wer_ist_dran,anzahl_spieler,spieler,window,einer_hat_gewonnen,@einheit,einheitbild,einheitx,einheity)
              If Krieg_Test_Beendet(window)
                ProcedureReturn 1
              EndIf
              schritte_gesammt=Krieg_Set_Current_Player(spieler_dran)
              Krieg_Zeichne_Wer_Ist_Dran(window,wer_ist_dran)
            EndIf
          Case aufgeben
            If PeekB(spieler(spieler_dran))=1
              wirklich=Window_Krieg_Aufgeben()
              If wirklich
                einer_hat_gewonnen=Krieg_Aufgeben(@schritte_gesammt,spieler_dran,spieler,window)
              EndIf
            EndIf
        EndSelect
        ;}
    EndSelect
    
    If schritte_gesammt=0
      spieler_dran=Krieg_Naester_Spieler(@wer_ist_dran,anzahl_spieler,spieler,window,einer_hat_gewonnen,@einheit,einheitbild,einheitx,einheity)
      If Krieg_Test_Beendet(window)
        ProcedureReturn 1
      EndIf
      schritte_gesammt=Krieg_Set_Current_Player(spieler_dran)
      Krieg_Zeichne_Wer_Ist_Dran(window,wer_ist_dran)
    EndIf  
    
  ForEver
  
EndProcedure

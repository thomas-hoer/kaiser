;##### ------------------------------------------------------------------------
;##### 
;##### Jahresende.pbi
;##### 
;##### ------------------------------------------------------------------------

Procedure CalcNeueWerte(mem)
  
  If PeekL(mem+131)<PeekL(mem+17)*5
    geburt=10
    sterbe=1000-(PeekL(mem+131)*1000/(PeekL(mem+17)*5))
  ElseIf PeekL(mem+131)>PeekL(mem+17)*5
    sterbe=10
    geburt=10+((PeekL(mem+131)-PeekL(mem+17)*5)*100/PeekL(mem+17)*5)
  Else
    geburt=10
    sterbe=10
  EndIf
  
  immigration=(100-PeekB(mem+78))/2
  PokeW(mem+86,geburt)
  PokeW(mem+88,sterbe)
  PokeW(mem+90,immigration)
  zufriedenheit=50+(PeekW(mem+86)-PeekW(mem+88)-PeekW(mem+90))/10;nahrungspolitik
  zufriedenheit+(10-PeekB(mem+76))*2
  zufriedenheit+(10-PeekB(mem+77))*2
  zufriedenheit+(-90+PeekB(mem+78))
  
  If zufriedenheit>100
    zufriedenheit=100
  EndIf
  If zufriedenheit<0
    zufriedenheit=0
  EndIf
  
  PokeB(mem+35,zufriedenheit)
  
  bauten=(PeekW(mem+46)*(100+Random(10)))+(PeekW(mem+48)*(200+Random(40)))
  PokeL(mem+94,bauten);gewinne mühlen und märkte
  PokeL(mem+102,PeekL(mem+17)*(PeekB(mem+76)-9)*0.3);steuern
  PokeL(mem+106,PeekL(mem+17)*(PeekB(mem+77)-6)*0.25);justiz
  
  If PeekL(mem+102)>PeekL(mem+17)*2
    PokeL(mem+102,PeekL(mem+17)*2)
  EndIf
  
  If PeekL(mem+106)>PeekL(mem+17)*2
    PokeL(mem+106,PeekL(mem+17)*2)
  EndIf
  
  PokeL(mem+114,PeekL(mem+25)*0.025);zins
  PokeL(mem+118,PeekL(mem+56)*0.1)  ;lagervermietung
  
EndProcedure
Procedure Window_Befoerderung(spieler)
  
  PlaySound(sounds(1))
  
  window=WinOpen(340,240,"Beförderung")
  
  mem=spieler(spieler)
  
  TextGadget(#PB_Any,50, 10,240,40,"Wisset, daß im Jahre des Herrn "+Str(PeekW(spiel+1))+" das Volk seinem generösem Führer",#PB_Text_Center)
  TextGadget(#PB_Any,50, 50,240,20,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Text_Center)
  TextGadget(#PB_Any,50, 75,240,40,"einen neuen Titel verlieh. Er durfte fürderhin mit vollerm Rechte den Titel",#PB_Text_Center)
  TextGadget(#PB_Any,100,120,140,20,UCase(titel(PeekW(spieler(spieler)+84)+1,PeekB(spieler(spieler)+33))),#PB_Text_Center)
  TextGadget(#PB_Any,50,150,240,40,"tragen und gelobte hoch und heilig, sich dieser Bürde stets würdig zu erweisen.",#PB_Text_Center)
  
  ImageGadget(#PB_Any, 10, 10,32,32,ImageID(icon(11)))
  ImageGadget(#PB_Any, 10,198,32,32,ImageID(icon(11)))
  ImageGadget(#PB_Any,298, 10,32,32,ImageID(icon(11)))
  ImageGadget(#PB_Any,298,198,32,32,ImageID(icon(11)))
  ImageGadget(#PB_Any, 60,110,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any,248,110,32,32,ImageID(icon(10)))
  button=ButtonGadget(#PB_Any,100,200,140,30,"Kier konsolodieren")
  
  PokeL(mem+34,PeekL(mem+34)+10)
  
  If PeekL(mem+34)>100
    PokeL(mem+34,100)
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
            StopSound(sounds(1))
            PokeW(mem+84,PeekW(mem+84)+1)
            CloseWindow(window)
            ProcedureReturn 1
            
        EndSelect
        
    EndSelect
    
  ForEver
  
EndProcedure
Procedure Window_Befoerderung_Kaiser(spieler)
  
  PlaySound(sounds(13))
  
  window=WinOpen(340,340,"Nun schreiten wir zu Huldigung!")
  
  mem=spieler(spieler)
  
  TextGadget(#PB_Any,50, 20,240,20,"VIVAT!",#PB_Text_Center)
  TextGadget(#PB_Any,20, 50,300,40,"Wisset, daß im Jahre des Herrn "+Str(PeekW(spiel+1))+" die Nation einen neuen Despoten gekrönt hat:",#PB_Text_Center)
  TextGadget(#PB_Any,20, 90,300,20,titel(PeekW(spieler(spieler)+84)+1,PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Text_Center)
  TextGadget(#PB_Any,20,240,300,60,"Während Euer Name in die ewigen Annalen eingehen wird, werden Eure Nebenbuhler bald der Vergessenheit anheim gefallen sein!",#PB_Text_Center)
  
  button=ButtonGadget(#PB_Any,100,300,140,30,"Fin")
  ImageGadget(#PB_Any, 10, 10,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any, 10,298,32,32,ImageID(icon(11)))
  ImageGadget(#PB_Any,298, 10,32,32,ImageID(icon(10)))
  ImageGadget(#PB_Any,298,298,32,32,ImageID(icon(11)))
  ImageGadget(#PB_Any,110,115,120,116,ImageID(krone))
  PokeL(mem+34,PeekL(mem+34)+10)
  
  If PeekL(mem+34)>100
    PokeL(mem+34,100)
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
            
            PokeW(mem+84,PeekW(mem+84)+1)
            punkte=0
            punkte+(PeekL(mem+17)-10000)/5;einwohner
            punkte+(PeekL(mem+21)-100000)/20;land
            punkte+PeekB(mem+34)            ;ruhm
            punkte+PeekW(mem+46)            ;mühlen
            punkte+PeekW(mem+48)            ;märkte
            punkte+PeekL(mem+127)           ;armee
            punkte+(1500-PeekW(spiel+1))*5  ;jahr
            punkte+(PeekL(mem+25)-1000000)/400;obligatorische taler
            
            If PeekL(annale+9096)>PeekW(spiel+1)-1400
              PokeS(annale+9000,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Ascii)
              PokeL(annale+9096,PeekW(spiel+1)-1400)
            EndIf
            
            If PeekL(annale+9196)<PeekL(mem+21)
              PokeS(annale+9100,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Ascii)
              PokeL(annale+9196,PeekL(mem+21))
            EndIf
            
            If PeekL(annale+9296)<PeekL(mem+17)
              PokeS(annale+9200,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Ascii)
              PokeL(annale+9296,PeekL(mem+17))
            EndIf
            
            If PeekL(annale+9396)<PeekL(mem+25)
              PokeS(annale+9300,titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Ascii)
              PokeL(annale+9396,PeekL(mem+25))
            EndIf
            
            For x=0 To 9
              If punkte>PeekL(annale+96+(x*100))
                CopyMemory(annale+(x*100),annale+(x*100)+100,(9-x)*100)
                PokeS(annale+(x*100),titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name,#PB_Ascii)
                PokeL(annale+88+(x*100),PeekB(mem+122))
                PokeL(annale+92+(x*100),PeekW(spiel+1))
                PokeL(annale+96+(x*100),punkte)
                Break
              EndIf
            Next
            
            If CreateFile(0,"rekorde")
              lof=CompressMemory(annale,10000,annale2,MemorySize(annale2))
              WriteData(0,annale2,Lof)
              CloseFile(0)
            EndIf
            
            CloseWindow(window)
            
            ProcedureReturn 1
            
        EndSelect
        
    EndSelect
    
  ForEver
  
EndProcedure

Procedure Kriege_Ausfuehren()
  
  For x=0 To PeekB(spiel)
    
    angr=0
    
    For y=0 To PeekB(spiel)
      
      If x<>y
        
        mem=spieler(y)
        If PeekB(mem+1130+x)
          angr=1
        EndIf
      EndIf
      
    Next y
    
    If angr=1
      Window_Krieg_Kampf(x)
    EndIf
    
  Next x
  
  ;Löschen der Angriffserklährung für den nächsten Spielzug
  For x=0 To PeekB(spiel)
    
    mem = Spieler(x)
    
    For y=0 To 9
      PokeB(mem+1130+y,0)
    Next y
    
  Next x
  
EndProcedure
Procedure Einheiten_Upgraden()
  
  For x=0 To PeekB(spiel)
    
    mem=spieler(x)
    
    For y=0 To 7
      
      If PeekL(mem+200+y*100+24)
        
        If PeekB(mem+200+y*100+68)=0
          
          If PeekL(mem+200+y*100+24)<PeekL(mem+200+y*100+69)
            
            PokeL(mem+200+y*100+24,PeekL(mem+200+y*100+69))
            
          EndIf
          
        ElseIf PeekB(mem+200+y*100+68)=-1
          
          PokeL(mem+200+y*100+48,PeekL(mem+200+y*100+48)+1)
          
        EndIf
        
        PokeB(mem+200+y*100+68,0)
        
      EndIf
      
    Next
    
  Next
  
EndProcedure

Procedure NextTurn()
  
  nextturn=1
  
  Repeat
    
    spieler=PeekB(spiel+3)
    
    If spieler>-1;schliesst den allerersten spielzug aus
      
      mem=spieler(spieler)
      
      k=0
      
      ;prüfe vorraussetzungen für beförderung
      
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
      
      ;Wenn alle Vorraussetzungen erfüllt sind kommt es zur beförderung
      If k=7
        
        If PeekB(mem)=1;Wenn Spieler Menschlicht -> Anzeigen das er befördert wurde
          If PeekW(mem+84)=9
            Window_Befoerderung_Kaiser(spieler)
          Else
            Window_Befoerderung(spieler)
          EndIf
          
        Else;Wenn Spieler Computer -> Befördern ohne Anzeige (Außer bei Kaiserkrönung)
          
          If PeekW(mem+84)=9
            Window_Befoerderung_Kaiser(spieler)
          Else
            PokeW(mem+84,PeekW(mem+84)+1)
          EndIf  
          
        EndIf
        
      EndIf
      
    EndIf
    
    ;{ kaiserkrönung
    If PeekB(spiel+3)>-1
      If PeekW(mem+84)=10
        DisableMenu(1)
        Window_Annale()
        ;Wenn Ein Spieler den Kaiserstatus erreicht hat ist das Spiel vorbei
        ProcedureReturn 1
      EndIf
    EndIf
    ;}
    
    ;{ nächster spieler
    spieler=PeekB(spiel+3)+1
    
    If spieler>PeekB(spiel);Nächstes Jahr
      spieler=0
      Kriege_Ausfuehren()
      Einheiten_Upgraden()
      PokeW(spiel+1,PeekW(spiel+1)+1);nächstes jahr
    EndIf
    
    PokeB(spiel+3,spieler)
    ;}
    mem=spieler(spieler)
    
    ;{ einstellen aller zufallsvariablen (jedes jahr und auch bei spielbeginn)
    
    If PeekL(mem+29)>PeekL(mem+17)*5
      PokeL(mem+131,PeekL(mem+17)*5)
    Else
      PokeL(mem+131,PeekL(mem+29))
    EndIf
    
    PokeB(mem+36,15+Random(15)+PeekW(mem+84)*4);landpreis
    PokeB(mem+37,45+Random(45)+PeekW(mem+84)*4);kornpreis
    PokeW(mem+38,8+Random(5+PeekW(mem+84)))    ;salzpreis
    PokeW(mem+40,33+Random(10+PeekW(mem+84)*2));bierpreis
    PokeW(mem+42,80+Random(20+PeekW(mem+84)*4));weinpreis
    PokeW(mem+44,455+Random(50+PeekW(mem+84)*10));waffenpreis
                                                 ;}
    
    If PeekB(mem)=1
      
      ;{ nur menschliche spieler
      Window_Begruesung(spieler)
      SetWindowTitle(MainWindow,"Kaiser - "+titel(PeekW(spieler(spieler)+84),PeekB(spieler(spieler)+33))+" "+PeekS(spieler(spieler)+1,16,#PB_Ascii)+" von "+land(PeekB(spieler(spieler)+124))\name)
      
      If PeekB(spieler(spieler)+123)=0
        ;{ spielbeginn
        
        PokeB(spieler(spieler)+123,1)
        Window_Hochzeitsgeschenk(spieler)
        Window_Held(spieler)
        Window_Hexe(spieler)
        ;}
      Else
        
        ;{ errechnung div sachen (außer bei spielbeginn)
        
        Zufallsereignis(spieler)
        
        wachstum=1000+(PeekW(mem+86)-PeekW(mem+88)+PeekW(mem+90)-PeekW(mem+92))
        gewinne=PeekL(mem+94)+PeekL(mem+98)+PeekL(mem+102)+PeekL(mem+106)+PeekL(mem+110)+PeekL(mem+114)+PeekL(mem+118)
        PokeL(mem+17,PeekL(mem+17)*wachstum/1000);einwohner
        PokeL(mem+25,PeekL(mem+25)+gewinne)      ;taler
        PokeL(mem+29,PeekL(mem+29)-PeekL(mem+131));korn
        PokeB(mem+125,0)                          ;schloss gebaut
        PokeB(mem+126,0)                          ;kathedrale gebaut
        Window_Wetter(spieler)
        
        If PeekL(mem+29)>PeekL(mem+80)
          PokeL(mem+29,PeekL(mem+80))
        EndIf
        
        PokeL(mem+131,PeekL(mem+17)*5)
        
        If PeekL(mem+131)>PeekL(mem+29)
          PokeL(mem+131,PeekL(mem+29))
        EndIf
        
        ;{ diplomatie
        
        For x=0 To 9
          
          If PeekB(mem+1000+(x*10))
            
            Select PeekB(mem+1001+(x*10))
                
              Case 1;talertransfer
                PokeL(mem+25,PeekL(mem+25)+PeekL(mem+1002+(x*10)))
                Window_Spende_3(x,PeekL(mem+1002+(x*10)))
                
              Case 2;landtransfer
                PokeL(mem+21,PeekL(mem+21)+PeekL(mem+1002+(x*10)))
                Window_Spende_4(x,PeekL(mem+1002+(x*10)))
                
              Case 3;friedensvertrag
                If Window_Abkommen_3(x,PeekW(mem+1002+(x*10)))
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),6);friede angenommen
                  PokeW(spieler(x)+1002,PeekW(mem+1002+(x*10)));dauer
                  PokeW(mem+1110+(x*2),PeekW(spiel+1)+PeekW(mem+1002+(x*10)))
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),7);friede abgelehnt
                EndIf
                
              Case 4;handelsvertrag
                If Window_Abkommen_4(x)
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),8);handel angenommen
                  PokeW(mem+1100+x,1)
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),9);handel abgelehnt
                EndIf
                
              Case 5;handelsvertrag kündigen
                Window_Abkommen_5(x)
                PokeW(mem+1100+x,0)
                
              Case 6;friede angenommen
                Window_Abkommen_3_1(x,PeekW(mem+1002+(x*10)))
                PokeW(mem+1110+(x*2),PeekW(spiel+1)+PeekW(mem+1002+(x*10)))
                
              Case 7;friede abgelehnt
                Window_Abkommen_3_2(x)
                
              Case 8;handel angenommen
                Window_Abkommen_4_1(x)
                PokeW(mem+1100+x,1)
                
              Case 9;handel abgelehnt
                Window_Abkommen_4_2(x)
                
              Case 10;erpressung taler
                If Window_Erpressen_3(x,PeekL(mem+1002+(x*10)))
                  If PeekL(mem+25)-PeekL(mem+1002+(x*10))>-PeekL(mem+17)*10
                    PokeL(mem+       25,PeekL(mem       +25)-PeekL(mem+1002+(x*10)))
                    PokeL(spieler(x)+25,PeekL(spieler(x)+25)+PeekL(mem+1002+(x*10)))
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),13);handel angenommen
                  Else
                    Window_Erpressen_3_0()
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                  EndIf
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                EndIf
                
              Case 11;erpressung land
                If Window_Erpressen_4(x,PeekL(mem+1002+(x*10)))
                  If PeekL(mem+21)-PeekL(mem+1002+(x*10))>2000
                    PokeL(mem+       21,PeekL(mem       +21)-PeekL(mem+1002+(x*10)))
                    PokeL(spieler(x)+21,PeekL(spieler(x)+21)+PeekL(mem+1002+(x*10)))
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),13);handel angenommen
                  Else
                    Window_Erpressen_3_0()
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                  EndIf
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                EndIf
                
              Case 12;erpressung sklafen
                If Window_Erpressen_5(x,PeekL(mem+1002+(x*10)))
                  If PeekL(mem+17)-PeekL(mem+1002+(x*10))>100
                    PokeL(mem+       17,PeekL(mem       +17)-PeekL(mem+1002+(x*10)))
                    PokeL(spieler(x)+17,PeekL(spieler(x)+17)+PeekL(mem+1002+(x*10)))
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),13);handel angenommen
                  Else
                    Window_Erpressen_3_0()
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                  EndIf
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                EndIf
                
              Case 13;erpressung angenommen
                Window_Erpressen_0_1(x)
                
              Case 14;erpressung abgelehnt
                Window_Erpressen_0_2(x)
                
            EndSelect
            
            PokeL(mem+1000+(x*10),0)
            PokeL(mem+1004+(x*10),0)
            PokeW(mem+1008+(x*10),0)
            
          EndIf
          
        Next
        ;} 
        ;}
        
      EndIf
      
      Window_Kornverteilen(spieler)
      
      ;}
      
    Else
      
      ;{ hier kommt die ki rein
      
      If PeekB(spieler(spieler)+123)=0
        
        ;{ spielbeginn
        PokeB(spieler(spieler)+123,1)
        ;}
        
      Else
        
        ;{ errechnung div sachen (außer bei spielbeginn)
        
        ;{ wachstum
        wachstum=1000+(PeekW(mem+86)-PeekW(mem+88)+PeekW(mem+90)-PeekW(mem+92))
        gewinne=PeekL(mem+94)+PeekL(mem+98)+PeekL(mem+102)+PeekL(mem+106)+PeekL(mem+110)+PeekL(mem+114)+PeekL(mem+118)
        PokeL(mem+17,PeekL(mem+17)*wachstum/1000);einwohner
        PokeL(mem+25,PeekL(mem+25)+gewinne)      ;taler
        PokeL(mem+29,PeekL(mem+29)-PeekL(mem+131));korn
        PokeB(mem+125,0)                          ;schloss gebaut
        PokeB(mem+126,0)                          ;kathedrale gebaut
                                                  ;}
        
        ;{ wetter u korn
        
        verdorben=5+Random(10)
        wetter=15+Random(35)+Random(35)+Random(35)
        PokeL(mem+29,PeekL(mem+29)*(100-verdorben)/100);korn
        PokeL(mem+29,PeekL(mem+29)+(PeekL(mem+21)*wetter/100));korn
        If PeekL(mem+29)>PeekL(mem+80)
          PokeL(mem+29,PeekL(mem+80))
        EndIf
        PokeL(mem+131,PeekL(mem+17)*5)
        If PeekL(mem+131)>PeekL(mem+29)
          PokeL(mem+131,PeekL(mem+29))
        EndIf
        
        ;}
        
        ;{ diplomatie
        
        PokeB(mem+136,0)
        
        For x=0 To 9
          PokeB(mem+1130+x,0)
        Next
        
        For x=0 To 9
          
          If PeekB(mem+1000+(x*10))
            
            Select PeekB(mem+1001+(x*10))
                
              Case 1;talertransfer
                PokeL(mem+25,PeekL(mem+25)+PeekL(mem+1002+(x*10)))
                
              Case 2;landtransfer
                PokeL(mem+21,PeekL(mem+21)+PeekL(mem+1002+(x*10)))
                
              Case 3;friedensvertrag
                If 0;Window_Abkommen_3(x,PeekW(mem+1002+(x*10)))
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),6);friede angenommen
                  PokeW(spieler(x)+1002,PeekW(mem+1002+(x*10)));dauer
                  PokeW(mem+1110+(x*2),PeekW(spiel+1)+PeekW(mem+1002+(x*10)))
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),7);friede abgelehnt
                EndIf
                
              Case 4;handelsvertrag
                If 0;Window_Abkommen_4(x)
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),8);handel angenommen
                  PokeW(mem+1100+x,1)
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),9);handel abgelehnt
                EndIf
                
              Case 5;handelsvertrag kündigen
                PokeW(mem+1100+x,0)
                
              Case 6;friede angenommen
                PokeW(mem+1110+(x*2),PeekW(spiel+1)+PeekW(mem+1002+(x*10)))
                
              Case 7;friede abgelehnt
                
              Case 8;handel angenommen
                PokeW(mem+1100+x,1)
                
              Case 9;handel abgelehnt
                
              Case 10;erpressung taler
                If 0 ;Window_Erpressen_3(x,PeekL(mem+1002+(x*10)))
                  If PeekL(mem+25)-PeekL(mem+1002+(x*10))>-PeekL(mem+17)*10
                    PokeL(mem+       25,PeekL(mem       +25)-PeekL(mem+1002+(x*10)))
                    PokeL(spieler(x)+25,PeekL(spieler(x)+25)+PeekL(mem+1002+(x*10)))
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),13);handel angenommen
                  Else
                    Window_Erpressen_3_0()
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                  EndIf
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                EndIf
                
              Case 11;erpressung land
                If 0 ;Window_Erpressen_4(x,PeekL(mem+1002+(x*10)))
                  If PeekL(mem+21)-PeekL(mem+1002+(x*10))>2000
                    PokeL(mem+       21,PeekL(mem       +21)-PeekL(mem+1002+(x*10)))
                    PokeL(spieler(x)+21,PeekL(spieler(x)+21)+PeekL(mem+1002+(x*10)))
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),13);handel angenommen
                  Else
                    Window_Erpressen_3_0()
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                  EndIf
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                EndIf
                
              Case 12;erpressung sklafen
                If 0 ;Window_Erpressen_5(x,PeekL(mem+1002+(x*10)))
                  If PeekL(mem+17)-PeekL(mem+1002+(x*10))>100
                    PokeL(mem+       17,PeekL(mem       +17)-PeekL(mem+1002+(x*10)))
                    PokeL(spieler(x)+17,PeekL(spieler(x)+17)+PeekL(mem+1002+(x*10)))
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),13);handel angenommen
                  Else
                    Window_Erpressen_3_0()
                    PokeB(spieler(x)+1000+(spieler*10),1)
                    PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                  EndIf
                Else
                  PokeB(spieler(x)+1000+(spieler*10),1)
                  PokeB(spieler(x)+1001+(spieler*10),14);handel abgelehnt
                EndIf
                
              Case 13;erpressung angenommen
                
              Case 14;erpressung abgelehnt
                
            EndSelect
            
            PokeL(mem+1000+(x*10),0)
            PokeL(mem+1004+(x*10),0)
            PokeW(mem+1008+(x*10),0)
            
          EndIf
          
        Next
        ;} 
        
        ;}
        
      EndIf
      
      ;}
      
      ;{ ki-------------------------------------------------------------------------------------------
      If PeekW(mem+84)<6 ;ca 40-50 jahre bis zum fürst
                         ;{
        einwohner=PeekL(mem+17)
        land=PeekL(mem+21)
        taler=PeekL(mem+25)
        korn=PeekL(mem+29)
        
        ;kornkauf
        If taler<0
          kauf=einwohner*4-korn
        ElseIf korn<einwohner*5
          kauf=einwohner*5-korn
        ElseIf korn>einwohner*10-land*0.15
          kauf=(einwohner*10-land*0.15)-korn
        Else
          kauf=einwohner*5.1-korn
          If kauf<0
            kauf=0
          EndIf
        EndIf
        
        korn+kauf
        taler-(kauf*PeekB(mem+37)/100)
        ;Debug "korn"+Str(kauf*PeekB(mem+37)/100)
        zuteilung=einwohner*5.2
        
        If korn<zuteilung
          zuteilung=korn
        EndIf
        
        ;lagerverkauf
        lager=PeekL(mem+56)+PeekL(mem+60)+PeekL(mem+64)+PeekL(mem+68)+PeekL(mem+72)
        taler+PeekL(mem+60)*PeekW(mem+38)
        taler+PeekL(mem+64)*PeekW(mem+40)
        taler+PeekL(mem+68)*PeekW(mem+42)
        taler+PeekL(mem+72)*PeekW(mem+44)
        PokeL(mem+60,0)
        PokeL(mem+64,0)
        PokeL(mem+68,0)
        PokeL(mem+72,0)
        
        budget=taler-vorraussetzung(PeekW(mem+84))\taler
        ;Debug "TALER :"+Str(taler)
        ;Debug "BUDGET:"+Str(budget)
        ;geäudekauf
        If vorraussetzung(PeekW(mem+84))\palast>PeekB(mem+54) And taler>5000
          PokeB(mem+54,PeekB(mem+54)+1)
          taler-5000
          budget-5000
          ;Debug "palast"
        EndIf
        If vorraussetzung(PeekW(mem+84))\kathedrale>PeekB(mem+54) And taler>9000
          PokeB(mem+55,PeekB(mem+54)+1)
          taler-9000
          budget-9000
          ;Debug "schloss"
        EndIf
        ;Debug PeekL(mem+80)
        ;Debug korn-zuteilung+(land*0.75)
        If PeekL(mem+80)<korn-zuteilung+(land*0.75)
          kauf=Round((korn-zuteilung+(land*0.75)-PeekL(mem+80))/10000,#PB_Round_Up)
          If taler<kauf*2500
            kauf=Round(taler/2500,#PB_Round_Down)
          EndIf
          If kauf<0
            kauf=0
          EndIf
          PokeW(mem+50,PeekW(mem+50)+kauf)
          PokeL(mem+80,PeekL(mem+80)+10000)
          ;Debug "speicher"+Str(kauf)
          taler-kauf*2500
          budget-kauf*2500
        EndIf
        
        kauf=Round(budget/1000,#PB_Round_Down)
        
        If kauf<0
          kauf=0
        EndIf
        
        Repeat
          Select Random(1)
            Case 0
              If kauf>0 And PeekW(mem+46)<=PeekL(mem+21)/1000
                ;Debug "KAUFMARKT"
                PokeW(mem+46,PeekW(mem+46)+1)
                taler-1000
                budget-1000
                kauf-1
              EndIf
              
            Case 1
              If kauf>1 And PeekW(mem+48)<=PeekL(mem+21)/1000
                ;Debug "KAUFMÜHLE"
                PokeW(mem+48,PeekW(mem+48)+1)
                PokeL(mem+80,PeekL(mem+80)+2000)
                taler-2000
                budget-2000
                kauf-2
              EndIf
              
          EndSelect
          
          If Random(500)=1
            Break
          EndIf
          
        Until kauf<=0
        
        ;landkauf
        kauf=0
        If einwohner*10>land
          kauf=einwohner*10-land
          If kauf*PeekB(mem+36)/10>budget
            zuteilung=einwohner*5.01
            kauf=budget/PeekB(mem+36)
          EndIf
        Else
          kauf=budget/(PeekB(mem+36))
        EndIf
        
        If kauf<0
          kauf=0
        EndIf
        
        land+kauf
        ;Debug "landkauf"+Str(kauf)
        taler-(PeekB(mem+36)*kauf/10)
        budget-(PeekB(mem+36)*kauf/10)
        ;rest in land investieren
        kauf=budget/(PeekB(mem+36))
        
        If kauf<0
          kauf=0
        EndIf
        
        land+kauf
        taler-(PeekB(mem+36)*kauf/10)
        budget-(PeekB(mem+36)*kauf/10)
        
        ;steuern festsetzen
        
        If PeekW(mem+84)>4
          PokeW(mem+78,100)
          If vorraussetzung(PeekW(mem+84))\zufriedenheit>PeekB(mem+35)
            PokeB(mem+76,PeekB(mem+76)-1)
          ElseIf PeekB(mem+76)<9
            PokeB(mem+76,PeekB(mem+76)+1)
          EndIf
        EndIf
        
        ;diplomatie
        
        ;krieg
        PokeL(mem+21,land)
        PokeL(mem+25,taler)
        PokeL(mem+29,korn)
        PokeL(mem+56,lager)
        PokeL(mem+131,zuteilung)
        ; Debug "taler:"+Str(taler)
        ; Debug "land:"+Str(land)
        ; Debug "einwohner:"+Str(einwohner)
        ; Debug "kornzuteilung:"+Str(zuteilung)
        ; Debug "korn:"+Str(korn)
        ; Debug "zufriedenheit:"+Str(PeekB(mem+35))
        ;}
      EndIf 
      
      If PeekW(mem+84)=7 Or PeekW(mem+84)=8 Or PeekW(mem+84)=6
        ;{
        einwohner=PeekL(mem+17)
        land=PeekL(mem+21)
        taler=PeekL(mem+25)
        korn=PeekL(mem+29)
        
        k=0
        If einwohner>=vorraussetzung(PeekW(mem+84))\einwohner
          k+1
        EndIf
        ;vorraussetzung(PeekW(mem+84))\zufriedenheit
        If land>=vorraussetzung(PeekW(mem+84))\land
          k+1
        EndIf
        If taler>=vorraussetzung(PeekW(mem+84))\taler
          k+1
        EndIf
        If armee>=vorraussetzung(PeekW(mem+84))\armee
          k+1
        EndIf
        If PeekB(mem+54)>=vorraussetzung(PeekW(mem+84))\palast
          k+1
        EndIf
        
        kauf=0
        ;nur das zuteilen was auch wirklich benötigt wird
        If k<4
          If korn<einwohner*5
            kauf=einwohner*5-korn
          EndIf
          korn+kauf
          taler-(kauf*PeekB(mem+37)/100)
          zuteilung=einwohner*5.04
        Else
          If korn<einwohner*5.3
            kauf=einwohner*5.3-korn
          EndIf
          korn+kauf
          taler-(kauf*PeekB(mem+37)/100)
          zuteilung=einwohner*5.3
        EndIf
        
        If korn<zuteilung
          zuteilung=korn
        EndIf
        
        ;alles geld in gebäude investieren
        Repeat
          
          Select Random(1)
              
            Case 0
              If PeekW(mem+46)<=PeekL(mem+21)/1000 And taler>1000
                PokeW(mem+46,PeekW(mem+46)+1)
                taler-1000
              EndIf
              
            Case 1
              If PeekW(mem+48)<=PeekL(mem+21)/1000 And taler>2000
                PokeW(mem+48,PeekW(mem+48)+1)
                PokeL(mem+80,PeekL(mem+80)+2000)
                taler-2000
              EndIf
              
          EndSelect
          
          If Random(500)=1
            Break
          EndIf
          
        ForEver;Until taler<1000 Or (PeekW(mem+46)>=PeekL(mem+21)/1000 And PeekW(mem+48)>=PeekL(mem+21)/1000)
        
        If 12>PeekB(mem+54) And taler>5000
          PokeB(mem+54,PeekB(mem+54)+1)
          taler-5000
          budget-5000
        EndIf
        
        ;restliches geld investieren für land bis vorraussetzung*1.5 erreicht ist
        kauf=vorraussetzung(PeekW(mem+84))\land*1.3-land
        
        If kauf>taler*10/PeekB(mem+36)
          kauf=taler*10/PeekB(mem+36)
        EndIf
        
        land+kauf
        taler-(PeekB(mem+36)*kauf/10)
        PokeL(mem+21,land)
        PokeL(mem+25,taler)
        PokeL(mem+29,korn)
        PokeL(mem+56,lager)
        PokeL(mem+131,zuteilung)
        
        If k=5
          PokeB(mem+76,0)
        Else
          PokeB(mem+76,10)
        EndIf
        ;}
      EndIf
      
      If PeekW(mem+84)=9
        ;{
        einwohner=PeekL(mem+17)
        land=PeekL(mem+21)
        taler=PeekL(mem+25)
        korn=PeekL(mem+29)
        
        k=0
        If einwohner>=vorraussetzung(PeekW(mem+84))\einwohner
          k+1
        EndIf
        ;vorraussetzung(PeekW(mem+84))\zufriedenheit
        If land>=vorraussetzung(PeekW(mem+84))\land
          k+1
        EndIf
        If taler>=vorraussetzung(PeekW(mem+84))\taler
          k+1
        EndIf
        If armee>=vorraussetzung(PeekW(mem+84))\armee
          k+1
        EndIf
        If PeekB(mem+54)>=vorraussetzung(PeekW(mem+84))\palast
          k+1
        EndIf
        
        kauf=0
        ;nur das zuteilen was auch wirklich benötigt wird
        If k<4
          If korn<einwohner*5
            kauf=einwohner*5-korn
          EndIf
          korn+kauf
          taler-(kauf*PeekB(mem+37)/100)
          zuteilung=einwohner*5.04
        Else
          If korn<einwohner*5.3
            kauf=einwohner*5.3-korn
          EndIf
          korn+kauf
          taler-(kauf*PeekB(mem+37)/100)
          zuteilung=einwohner*5.3
        EndIf
        
        If korn<zuteilung
          zuteilung=korn
        EndIf
        ;alles geld in gebäude investieren
        
        Repeat
          Select Random(1)
            Case 0
              If PeekW(mem+46)<=PeekL(mem+21)/1000 And taler>1000
                PokeW(mem+46,PeekW(mem+46)+1)
                taler-1000
              EndIf
              
            Case 1
              If PeekW(mem+48)<=PeekL(mem+21)/1000 And taler>2000
                PokeW(mem+48,PeekW(mem+48)+1)
                PokeL(mem+80,PeekL(mem+80)+2000)
                taler-2000
              EndIf
              
          EndSelect
          
          If Random(500)=1
            Break
          EndIf
          
        ForEver;Until taler<1000 Or (PeekW(mem+46)>=PeekL(mem+21)/1000 And PeekW(mem+48)>=PeekL(mem+21)/1000)
        
        If 12>PeekB(mem+54) And taler>5000
          PokeB(mem+54,PeekB(mem+54)+1)
          taler-5000
          budget-5000
        EndIf
        
        If 12>PeekB(mem+55) And taler>9000
          PokeB(mem+55,PeekB(mem+55)+1)
          taler-9000
          budget-9000
        EndIf
        
        ;restliches geld investieren für land bis vorraussetzung*1.5 erreicht ist
        kauf=vorraussetzung(PeekW(mem+84))\land*1.3-land
        
        If kauf>taler*10/PeekB(mem+36)
          kauf=taler*10/PeekB(mem+36)
        EndIf
        
        land+kauf
        taler-(PeekB(mem+36)*kauf/10)
        PokeL(mem+21,land)
        PokeL(mem+25,taler)
        PokeL(mem+29,korn)
        PokeL(mem+56,lager)
        PokeL(mem+131,zuteilung)
        
        If k=5
          PokeB(mem+76,0)
        Else
          PokeB(mem+76,10)
        EndIf
        ;}
      EndIf
      ;}
      
      CalcNeueWerte(mem)
      
    EndIf
    
  Until PeekB(mem)=1
  
EndProcedure

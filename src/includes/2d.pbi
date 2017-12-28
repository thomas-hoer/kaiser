;##### ------------------------------------------------------------------------
;##### 
;##### 2D.pbi
;##### 
;##### ------------------------------------------------------------------------

Procedure DrawTransparentImage(TransImage,ZielOutput,x,y,b,h,offx,offy,offb,offh,TransColor) 
  ImageOutput=ImageOutput(TransImage)
  If ImageOutput
    hdc=StartDrawing(ImageOutput) 
    hzwischen=CreateCompatibleBitmap_(hdc,b,h) 
    HdcTemp=CreateCompatibleDC_(hdc) 
    obj=SelectObject_(HdcTemp,hzwischen) 
    HdcBack=CreateCompatibleDC_(hdc) 
    HdcObject=CreateCompatibleDC_(hdc) 
    HdcMem=CreateCompatibleDC_(hdc) 
    HdcSave=CreateCompatibleDC_(hdc) 
    BmPAndBack=CreateBitmap_(b,h,1,1,0) 
    BmPAndObject=CreateBitmap_(b,h,1,1,0) 
    BmPAndMem=CreateCompatibleBitmap_(hdc,b,h) 
    BmPSave=CreateCompatibleBitmap_(hdc,b,h) 
    SetMapMode_(HdcTemp,GetMapMode_(hdc)) 
    BmpBackOld=SelectObject_(HdcBack,BmPAndBack) 
    BmpObjectOld=SelectObject_(HdcObject,BmPAndObject) 
    BmpMemOld=SelectObject_(HdcMem,BmPAndMem) 
    BmpSaveOld=SelectObject_(HdcSave,BmPSave) 
    SetStretchBltMode_(HdcTemp,#COLORONCOLOR) 
    StretchBlt_(HdcTemp,0,0,b,h,hdc,offx,offy,offb,offh,13369376) 
    If TransColor=-1:TransColor= GetPixel_(HdcTemp,(b-1),0):EndIf 
    SetMapMode_(HdcTemp,GetMapMode_(hdc)) 
    BitBlt_(HdcSave,0,0,b,h,HdcTemp,0,0,#SRCCOPY) 
    CColor=SetBkColor_(HdcTemp,TransColor) 
    BitBlt_(HdcObject,0,0,b,h,HdcTemp,0,0,#SRCCOPY) 
    SetBkColor_(HdcTemp,RGB(255,255,255)) 
    StopDrawing() 
    target=StartDrawing(ZielOutput) 
    BitBlt_(HdcBack,0,0,b,h,HdcObject,0,0,#NOTSRCCOPY) 
    BitBlt_(HdcMem,0,0,b,h,target,x,y,#SRCCOPY) 
    BitBlt_(HdcMem,0,0,b,h,HdcObject,0,0,#SRCAND) 
    BitBlt_(HdcTemp,0,0,b,h,HdcBack,0,0,#SRCAND) 
    BitBlt_(HdcMem,0,0,b,h,HdcTemp,0,0,#SRCPAINT) 
    BitBlt_(HdcTemp,0,0,b,h,HdcMem,0,0,#SRCCOPY) 
    BitBlt_(target,x,y,b,h,HdcTemp,0,0,#SRCCOPY) 
    StopDrawing() 
    DeleteObject_(obj):DeleteObject_(BmpBackOld) 
    DeleteObject_(BmpObjectOld):DeleteObject_(BmpMemOld) 
    DeleteObject_(BmpSaveOld):DeleteDC_(HdcMem) 
    DeleteDC_(HdcBack):DeleteDC_(HdcObject) 
    DeleteDC_(HdcSave):DeleteDC_(HdcTemp) 
    DeleteObject_(hzwischen):DeleteObject_(BmPAndBack) 
    DeleteObject_(BmPAndObject):DeleteObject_(BmPAndMem) 
    DeleteObject_(BmPSave) 
  EndIf
EndProcedure 
Procedure DrawTextR(x,y,text.s)
  x-TextWidth(text)
  DrawText(x,y,text)
EndProcedure
Procedure DisableMenu(game)
  
  If game=0
    
    ActiveGame=1
    For x=0 To 39
      DisableMenuItem(0,x,0)
    Next
    For x=1 To 19
      DisableGadget(x,0)
    Next
    
  Else
    
    ActiveGame=0
    DisableMenuItem(0,2,1)
    DisableMenuItem(0,3,1)
    DisableMenuItem(0,38,1)
    For x=7 To 27
      DisableMenuItem(0,x,1)
    Next
    
    For x=1 To 19
      DisableGadget(x,1)
    Next
    
  EndIf
EndProcedure

Procedure.i WinOpen(w,h,Titel.s)
  
  Protected Win.i, Flags.i
  
  Flags = #PB_Window_ScreenCentered
  
  Win = OpenWindow(#PB_Any,0,0,w,h,Titel,Flags,WindowID(MainWindow))
  
  If Win
    StickyWindow(Win,1)
    ProcedureReturn Win.i
  Else
    MessageRequester("Fataler Fehler","Konnte ein Fenster nicht öffnen !")
    End
  EndIf
  
EndProcedure

Procedure.i Paint0()
  
  Spieler = *Game\Spieler_am_Zug
  
  mem=spieler(PeekB(spiel+3))
  
  xoff = -25
  
  With Spielerdaten(Spieler)
    
    If IsGadget(MainGadget)
      
      Output = ImageOutput(MainImage)
      
      DC = StartDrawing(Output)
      
      Box(0,0,ImageWidth(MainImage),ImageHeight(MainImage),0)
      DrawImage(ImageID(Map),xoff+25,0)
      DrawImage(ImageID(info),xoff+502,0)
      
      If \Name <> ""
        
        DrawingMode(#PB_2DDrawing_Transparent|#PB_2DDrawing_AlphaBlend)
        FrontColor(RGBA(0,0,0,255))
        DrawingFont(FontID(Fonts(0)))
        
        DrawText(xoff + 510,190,titel(\Titel,\Geschlecht))
        DrawText(xoff + 510,205,PeekS(Spielerdaten(Spieler)+OffsetOf(Struktur_Spieler\name),16,#PB_Ascii))
        DrawText(xoff + 510,220,"von "+land(\wohnort)\name)
        DrawText(xoff + 510,235,"im Jahre "+Str(*Game\Jahr))
        
        DrawText(xoff + 510,260,"Einwohner")
        DrawText(xoff + 510,275,"Land ha")
        DrawText(xoff + 510,290,"Marktplätze")
        DrawText(xoff + 510,305,"Kornmühlen")
        DrawText(xoff + 510,320,"Ruhm")
        DrawText(xoff + 510,335,"Taler")
        
        DrawTextR(xoff + 630,260,Str(\Einwohner))
        DrawTextR(xoff + 630,275,Str(\Land))
        DrawTextR(xoff + 630,290,Str(\Maerkte))
        DrawTextR(xoff + 630,305,Str(\Muehlen))
        DrawTextR(xoff + 630,320,Str(\Ruhm))
        DrawTextR(xoff + 630,335,Str(\Taler))
        
      EndIf
      
      DrawImage(ImageID(schloss(\Schloss)),xoff + 511,10,120,80)
      DrawImage(ImageID(kathedrale(\Kathedrale)),xoff + 511,100,120,80)
      For x=1 To \Maerkte
        DrawImage(ImageID(icon(14)),xoff + markt(x)\x,markt(x)\y)
        If x>6
          Break
        EndIf
      Next x
      For x=1 To \Muehlen
        DrawImage(ImageID(icon(15)),xoff + muehle(x)\x,muehle(x)\y)
        If x>5
          Break
        EndIf
      Next x
      If \Schloss
        DrawImage(ImageID(icon(17)),xoff + 280,159)
      EndIf
      If \Kathedrale
        DrawImage(ImageID(icon(18)),xoff + 280,223)
      EndIf
      
      For x=0 To 7
        If PeekB(mem+200+(x*100)+64)
          DrawImage(ImageID(Icon(EhIcon(\Einheit[x]\Bild,0))),xoff + 468-(x*32),448)
        EndIf
      Next
      
      StopDrawing()
      
    EndIf
    
  EndWith
  
  SetGadgetState(MainGadget,ImageID(MainImage))
  
EndProcedure
Procedure.i RePaint(Window.i)
  If Window = MainWindow
    Paint0()
  EndIf
EndProcedure


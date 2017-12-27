;##### 
;##### Erstellung der Data Datei
;##### 

IncludeFile "includes/Konstanten.pbi"

Filename.s = "Data.pak"

UseLZMAPacker()

Procedure InsertIntoPack(Pack,Filename.s)
  If Not AddPackFile(Pack,Filename,ReplaceString(Filename,"\","_"))
    Debug "Fehler bei Datei "+Filename
  EndIf
EndProcedure

Define Pack = CreatePack(#PB_Any,Filename.s)

If Pack
  
  Debug "Data"
  
  For x=1 To 19
    InsertIntoPack(Pack,"gfx\"+Str(x)+".bmp")
  Next x 
  
  For x=0 To #img_icon
    InsertIntoPack(Pack,"gfx\icon\"+Str(x)+".png")
  Next x
  
  InsertIntoPack(Pack,"gfx\map.bmp")
  InsertIntoPack(Pack,"gfx\info.bmp")
  InsertIntoPack(Pack,"gfx\korn1.bmp")
  InsertIntoPack(Pack,"gfx\korn2.bmp")
  InsertIntoPack(Pack,"gfx\krone.bmp")
  
  For x=0 To 12
    InsertIntoPack(Pack,"gfx\schloss"+Str(x)+".bmp")
  Next x
  
  For x=0 To 12
    InsertIntoPack(Pack,"gfx\kathedrale"+Str(x)+".bmp")
  Next x
  
  InsertIntoPack(Pack,"gfx\krieger_verteilung.bmp")
  InsertIntoPack(Pack,"gfx\krieg_leer.bmp")
  InsertIntoPack(Pack,"gfx\krieg_voll.bmp")
  
  For x=1 To 24
    InsertIntoPack(Pack,"sfx\"+Str(x)+".wav")
  Next x
  
  ClosePack(Pack)
  
Else
  
  MessageRequester("","Data konnte nicht erstellt werden")
  
EndIf





; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 20
; FirstLine = 3
; EnableXP
; CurrentDirectory = D:\Projekt\MyEd\
; CompileSourceDirectory
;##### 
;##### Erstellung der Data Datei
;##### 

Filename.s = "Data.pak"

Define Pack = CreatePack(Filename.s)

If Pack

  Debug "Data"

  For x=1 To 19
    AddPackFile("gfx\"+Str(x)+".bmp")
  Next x 

  For x=0 To 100
    AddPackFile("gfx\icon\"+Str(x)+".bmp")
  Next x
  For x=0 To 100
    AddPackFile("gfx\icon\"+Str(x)+".ico")
  Next x
  
  AddPackFile("gfx\map.bmp")
  AddPackFile("gfx\info.bmp")
  AddPackFile("gfx\korn1.bmp")
  AddPackFile("gfx\korn2.bmp")
  AddPackFile("gfx\krone.bmp")

  For x=0 To 12
    AddPackFile("gfx\schloss"+Str(x)+".bmp")
  Next x
  
  For x=0 To 12
    AddPackFile("gfx\kathedrale"+Str(x)+".bmp")
  Next x
  
  AddPackFile("gfx\krieger_verteilung.bmp")
  AddPackFile("gfx\krieg_leer.bmp")
  AddPackFile("gfx\krieg_voll.bmp")

  For x=1 To 24
    AddPackFile("sfx\"+Str(x)+".wav")
  Next x

  ClosePack()
  
Else

  MessageRequester("","Data konnte nicht erstellt werden")

EndIf





; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 20
; FirstLine = 3
; EnableXP
; CurrentDirectory = D:\Projekt\MyEd\
; CompileSourceDirectory
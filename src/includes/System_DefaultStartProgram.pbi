;##### ------------------------------------------------------------------------
;##### 
;##### Default Program 
;##### 
;##### Registriert ein Programm in der Windows Registry als Defaultstart
;##### 
;##### Ext     : die Extension .ksg oder .jpg 
;##### ExProg  : Verweis der Extension auf ein Programm (Wird nur Registry-Intern verwendet)
;##### ExName  : Name der im Explorer als Typ angezeigt wird
;##### DefPRG  : Vollstaendiger Pfad der .Exe die gestartet werden soll
;##### DefIcon : Vollstaendiger Pfad eines Icons
;##### 
;##### ------------------------------------------------------------------------

Procedure.i System_DefaultStartProgramm(Ext.s,ExProg.s,ExName.s,DefPRG.s,DefIcon.s)
  
  Protected Res.i, Dir.s
  
  RegOpenKey_(#HKEY_CLASSES_ROOT,Ext,@res)
  
  If res=0
    
    RegCreateKey_(#HKEY_CLASSES_ROOT,Ext,@res)
    RegSetValue_(#HKEY_CLASSES_ROOT,Ext,#REG_SZ,ExProg,Len(ExProg))
    
  EndIf
  
  RegOpenKey_(#HKEY_CLASSES_ROOT,ExProg,@res)
  
  If res=0
    
    RegCreateKey_(#HKEY_CLASSES_ROOT,ExProg,@res)
    RegSetValue_(#HKEY_CLASSES_ROOT,ExProg,#REG_SZ,ExName,Len(ExName))
    
  EndIf
  
  RegOpenKey_(#HKEY_CLASSES_ROOT,ExProg+"\DefaultIcon",@res)
  
  If res=0
    
    RegCreateKey_(#HKEY_CLASSES_ROOT,ExProg+"\DefaultIcon",@res)
    
  EndIf
  
  RegOpenKey_(#HKEY_CLASSES_ROOT,ExProg+"\shell\open\command",@res)
  
  If res=0
    
    RegCreateKey_(#HKEY_CLASSES_ROOT,ExProg+"\shell",@res)
    RegCreateKey_(#HKEY_CLASSES_ROOT,ExProg+"\shell\open",@res)
    RegCreateKey_(#HKEY_CLASSES_ROOT,ExProg+"\shell\open\command",@res)
    
  EndIf
  
  dir.s=Chr(34)+DefPRG+Chr(34)+" "+Chr(34)+"%1"+Chr(34)
  
  RegSetValue_(#HKEY_CLASSES_ROOT,ExProg+"\shell\open\command",#REG_SZ,dir,Len(dir))
  RegSetValue_(#HKEY_CLASSES_ROOT,ExProg+"\DefaultIcon",#REG_SZ,DefIcon,Len(DefIcon))
  
EndProcedure
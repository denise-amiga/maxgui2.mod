Strict

Import "gadget.bmx"
Import "guifont.bmx"

Import Brl.Map

Type TMaxGUIDriver

	Method new()
		NullProxy=New TGadget
	End Method
	
	Method UserName$() Abstract	
	Method ComputerName$() Abstract
	
	Method LoadFont:TGuiFont(name$,size,flags) Abstract
	Method CreateGadget:TGadget(GadgetClass,name$,x,y,w,h,group:TGadget,style) Abstract
	Method ActiveGadget:TGadget() Abstract
	Method RequestColor(r,g,b) Abstract
	Method RequestFont:TGuiFont(font:TGuiFont) Abstract	
	Method SetPointer(shape) Abstract
	Method LoadIconStrip:TIconStrip(source:Object) Abstract
	
	Method LookupColor( colorindex:Int, pRed:Byte Var, pGreen:Byte Var, pBlue:Byte Var )
		
		Select colorindex
			Case GUICOLOR_WINDOWBG
				pRed = 240; pGreen = 240; pBlue = 240
			Case GUICOLOR_GADGETBG
				pRed = 255; pGreen = 255; pBlue = 255
			Case GUICOLOR_GADGETFG
				pRed = 0; pGreen = 0; pBlue = 0
			Case GUICOLOR_SELECTIONBG
				pRed = 50; pGreen = 150; pBlue = 255
			Case GUICOLOR_LINKFG
				pRed = 0; pGreen = 0; pBlue = 255
		EndSelect
		
		Return False
		
	EndMethod
	
	Method LibraryFont:TGuiFont( pFontType% = GUIFONT_SYSTEM, pFontSize:Double = 0, pFontStyle% = FONT_NORMAL )
		?Win32
		If pFontSize <= 0 Then
			Select pFontType
				Case GUIFONT_SYSTEM;pFontSize = 8
				Case GUIFONT_SERIF;pFontSize = 11
				Default;pFontSize = 10
			EndSelect
		EndIf
		?Not Win32
		If pFontSize <= 0 Then
			pFontSize = 12
			?MacOs
			If pFontType = GUIFONT_SYSTEM Then pFontSize = 11
		?Not Win32
		EndIf
		?
		Select pFontType
			Case GUIFONT_MONOSPACED
				?Linux
				Return LoadFontWithDouble("Lucida",pFontSize,pFontStyle)
				?MacOS
				Return LoadFontWithDouble("Monaco",pFontSize,pFontStyle)
				?Win32
				'Let's give any Vista users the chance to use the new Consolas font.
				Local tmpFont:TGuiFont = LoadFontWithDouble("Consolas",pFontSize,pFontStyle)
				If tmpFont.name = "Consolas" Then Return tmpFont
				Return LoadFontWithDouble("Courier New",pFontSize,pFontStyle)
				?
			Case GUIFONT_SANSSERIF
				?Linux
				Return LoadFontWithDouble("FreeSans",pFontSize,pFontStyle)
				?MacOS
				Return LoadFontWithDouble("Helvetica",pFontSize,pFontStyle)
				?Win32
				Return LoadFontWithDouble("Arial",pFontSize,pFontStyle)
				?
			Case GUIFONT_SERIF
				?Linux
				Return LoadFontWithDouble("FreeSerif",pFontSize,pFontStyle)
				?MacOS
				Return LoadFontWithDouble("Times New Roman",pFontSize,pFontStyle)
				?Win32
				Return LoadFontWithDouble("Times New Roman",pFontSize,pFontStyle)
				?
			Case GUIFONT_SCRIPT
				?Linux
				Return LoadFontWithDouble("TSCu_Comic",pFontSize,pFontStyle)
				?MacOS
				Return LoadFontWithDouble("Comic Sans MS",pFontSize,pFontStyle)
				?Win32
				Return LoadFontWithDouble("Comic Sans MS",pFontSize,pFontStyle)
				?
			Default	'GUIFONT_SYSTEM
				?Linux
				Return LoadFontWithDouble("FreeSans",pFontSize,pFontStyle)
				?MacOS
				Return LoadFontWithDouble("Lucida Grande",pFontSize,pFontStyle)
				?Win32
				Return LoadFontWithDouble("MS Shell Dlg",pFontSize,pFontStyle)
				?
		EndSelect
	EndMethod
	
	Method LoadFontWithDouble:TGuiFont(name$,size:Double,flags)
		Return LoadFont(name,Int(size+0.5),flags)
	EndMethod
	
	
End Type

Global maxgui_driver:TMaxGUIDriver

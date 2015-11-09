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
	
	Method DefaultFont:TGuiFont()
		?Linux
		Return LoadFont("FreeSans",20,0)
		?MacOS
		Return LoadFont("Lucida Grande",20,0)
		?Win32
		Return LoadFont("MS Shell Dlg",20,0)
		?
	EndMethod
	
End Type

Global maxgui_driver:TMaxGUIDriver

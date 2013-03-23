;-------------------------------------------------------------------------------
;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         DemoJameson <DemoJameson@gmail.com>
;
;-------------------------------------------------------------------------------

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

;-------------------------------------------------------------------------------
Gui, Add, Text, x6 y6 w180 h20 , Manager your search engines	;���ֱ�ǩ
Gui, Add, ListBox, x6 y26 w160 h250 vSearchList +AltSubmit	;���������б��
Gui, Add, Button, x176 y26 w80 h30 , Top						;���Ƶ�������ť
Gui, Add, Button, x176 y66 w80 h30 , Up						;���ư�ť
Gui, Add, Button, x176 y106 w80 h30 , Down					;���ư�ť
Gui, Add, Button, x176 y146 w80 h30 , Bottom					;���Ƶ��ײ���ť
Gui, Add, Button, x176 y276 w80 h30 , Save					;���水ť
Gui, Add, CheckBox, x6 y276 w120 h30 vShowIcon, Show Icon	;��ʾͼ�긴ѡ��
Gui, +Delimiter`n												;���� ListBox �ķ��з�Ϊ `n �����з���
; Generated using SmartGUI Creator 4.0



;~ ѡ��Ҫ�޸ĵ� Search.ini �ļ�
FileSelectFile, SearchFile, , , choose your search.ini, search.ini (*.ini)

If ( SearchFile = "" )
{
    ExitApp
}

ClipSaved := Clipboard

;~ ��ȡ������������
Loop
{
	IniRead, S_Name%A_Index%, %SearchFile%, % "Search Engine "A_Index, Name
	IniRead, S_Deleted%A_Index%, %SearchFile%, % "Search Engine "A_Index, Deleted

	If ( S_Name%A_Index% = "ERROR" )
	{
		Break
	}

	If ( S_Name%A_Index% = "" )
	{
		S_Name%A_Index% = Blank
	}

	If ( S_Deleted%A_Index% = 1 )
	{
		S_Name%A_Index% := S_Name%A_Index% " : Deleted"
	}

;~ 	������������������� | �ַ������������ List �ķ��з���ͻ��
;~ 	StringReplace, S_Name%A_Index%, S_Name%A_Index%, `| [, ReplaceText, ReplaceAll?]

	Transform, Clipboard, Unicode, % S_Name%A_Index%
	S_Name%A_Index% := Clipboard
	S_Name_Bak%A_Index% := Clipboard
	S_NameList .= "`n" S_Name%A_Index%
	SearchCount := A_Index
}

Clipboard := ClipSaved

GuiControl,, SearchList, %S_NameList%
;~ ¼���б��
GuiControl, Choose, SearchList, 1

Gui, Show, x495 y331 h315 w260, Manager your search engines
Return

GuiEscape:
GuiClose:
ExitApp

;~ ����ѡ�е��������浽����
ButtonTop:
	GuiControlGet, Selected,, SearchList
	If ( Selected > 1 )
	{
;~ 		����������������
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name1
		S_Name1 := Temp
		S_NameList =

;~ 		�������
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		ˢ���б��
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, 1
	}
Return

;~ ����ѡ�е���������
ButtonUp:
	GuiControlGet, Selected,, SearchList
	If ( Selected > 1 )
	{
;~ 		����������������
		TempSelected := Selected - 1
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name%TempSelected%
		S_Name%TempSelected% := Temp
		S_NameList =

;~ 		�������
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		ˢ���б��
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, % Selected - 1
	}
Return

;~ ����ѡ�е���������
ButtonDown:
	GuiControlGet, Selected,, SearchList

	If ( Selected < SearchCount )
	{
;~ 		����������������
		TempSelected := Selected + 1
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name%TempSelected%
		S_Name%TempSelected% := Temp
		S_NameList =

;~ 		�������
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		ˢ���б��
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, % Selected + 1
	}
Return

;~ ����ѡ�е��������浽�ײ�
ButtonBottom:
	GuiControlGet, Selected,, SearchList

	If ( Selected < SearchCount )
	{
;~ 		����������������
		Temp := S_Name%Selected%
		S_Name%Selected% := S_Name%SearchCount%
		S_Name%SearchCount% := Temp
		S_NameList =

;~ 		�������
		Loop
		{
			If ( S_Name%A_Index% = "ERROR" )
			{
				Break
			}
			S_NameList .= "`n" S_Name%A_Index%
		}

;~ 		ˢ���б��
		GuiControl,, SearchList, %S_NameList%
		GuiControl, Choose, SearchList, %SearchCount%
	}
Return

;~ �����޸�
ButtonSave:
	FileRead, SearchContent, %SearchFile%

	Loop, %SearchCount%
	{
		i := A_Index

		Loop, %SearchCount%
		{
			If ( S_Name%i% = S_Name_Bak%A_Index% )
			{
;~ 				�ı�����������������
				StringReplace, SearchContent, SearchContent, Search Engine %i%, Search Engine T
				StringReplace, SearchContent, SearchContent, Search Engine %A_Index%, Search Engine %i%
				StringReplace, SearchContent, SearchContent, Search Engine T, Search Engine %A_Index%
				Temp := S_Name_Bak%i%
				S_Name_Bak%i% := S_Name_Bak%A_Index%
				S_Name_Bak%A_Index% := Temp
				Break
			}
		}
	}

	FileDelete, %SearchFile%
	FileAppend, %SearchContent%, %SearchFile%

	If ( !ErrorLevel )
	{
		MsgBox, OK
	}

;~ 	�޸�ͼ���Ƿ���ʾ
	GuiControlGet, isShowIcon,, ShowIcon

	If ( isShowIcon )
	{
		Loop, %SearchCount%
		{
			IniRead, S_URL, %SearchFile%, % "Search Engine "A_Index, URL

			If ( S_URL = "" )
			{
				IniDelete, %SearchFile%, % "Search Engine "A_Index, Icon
				Continue
			}

			SplitPath, S_URL,,,,, faviconAddress
			If ( faviconAddress != "" )
			{
				faviconAddress = %faviconAddress%/favicon.ico
				IniWrite, %faviconAddress%, %SearchFile%, % "Search Engine "A_Index, Icon
			}
		}
	}
	Else
	{
		Loop, %SearchCount%
		{
			IniWrite, NotShowIcon, %SearchFile%, % "Search Engine "A_Index, Icon
		}
	}
Return

;-------------------------------------------------------------------------------
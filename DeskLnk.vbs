Set objShell = CreateObject("Wscript.Shell")
strPath = Wscript.ScriptFullName 
Set objFSO = CreateObject("Scripting.FileSystemObject") 
Set objFile = objFSO.GetFile(strPath) 
strFolder = objFSO.GetParentFolderName(objFile)
strPath = strFolder '��ȡ�ļ���פ�����ļ��е�����·�� 

set WshShell = Wscript.CreateObject("Wscript.Shell") 
strDesktop = WshShell.SpecialFolders("Desktop") 
set oShellLink = WshShell.CreateShortcut(strDesktop & "\OperaU.lnk") 
oShellLink.TargetPath = strPath & "\opera.exe" '����һ����ݷ�ʽ���� 
oShellLink.Windowstyle = 1 
oShellLink.Hotkey = "" '���ÿ�ݷ�ʽ�Ŀ�ݼ� 
oShellLink.IconLocation = strPath & "\OperaU.ico" '���ÿ�ݷ�ʽ��ͼ��·�� 
oShellLink.Description = "MayBe It's The Best OperaU" '���ÿ�ݷ�ʽ������ 
oShellLink.WorkingDirectory = strPath
oShellLink.Save 
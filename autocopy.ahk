~LButton::
    CoordMode, Mouse, Screen
    ;��һ�䣬��ü��ϣ���Ȼ���л����ڵ�ʱ�������󴥷�����Ȼ�󴥷�Ӧ��Ҳûɶ�¡�
    MouseGetPos, x1, y1
    KeyWait, LButton, U
    WinGetActiveTitle, Title
    If Title contains Firefox, Opera, Internet Explorer
    {
        MouseGetPos, x2, y2
        if (abs(x1-x2)>10 or abs(y1-y2)>10)
        ;��Ȼ���϶�һ�ξ���Ŵ���
        send ^c
    }
return
Option Explicit
Dim choice, WshShell

' ��������˵�������û�֪����ť��Ӧ��ϵ
choice = MsgBox("��ѡ�����뷨ģʽ��" & vbCrLf & vbCrLf & _
                "��ȷ����= ����С��˫ƴ" & vbCrLf & _
                "��ȡ����= ����˫ƴ��ʹ��ȫƴ��", _
                vbOKCancel + vbQuestion, "˫ƴģʽ�л�")

Set WshShell = CreateObject("WScript.Shell")

If choice = vbOK Then
    ' ����С��˫ƴ
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""Enable Double Pinyin"" /t REG_DWORD /d 1 /f", 0, True
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""DoublePinyinScheme"" /t REG_DWORD /d 10 /f", 0, True
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""UserDefinedDoublePinyinScheme0"" /t REG_SZ /d ""С��˫ƴ*2*^*iuvdjhcwfg^xmlnpbksqszxkrltvyovt"" /f", 0, True
    MsgBox "������С��˫ƴ��", vbInformation, "���"
Else
    ' ����˫ƴ��ȫƴ��
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""Enable Double Pinyin"" /t REG_DWORD /d 0 /f", 0, True
    MsgBox "���л���ȫƴģʽ", vbInformation, "���"
End If
Option Explicit
Dim choice, WshShell

' 调整文字说明，让用户知道按钮对应关系
choice = MsgBox("请选择输入法模式：" & vbCrLf & vbCrLf & _
                "【确定】= 启用小鹤双拼" & vbCrLf & _
                "【取消】= 禁用双拼（使用全拼）", _
                vbOKCancel + vbQuestion, "双拼模式切换")

Set WshShell = CreateObject("WScript.Shell")

If choice = vbOK Then
    ' 启用小鹤双拼
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""Enable Double Pinyin"" /t REG_DWORD /d 1 /f", 0, True
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""DoublePinyinScheme"" /t REG_DWORD /d 10 /f", 0, True
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""UserDefinedDoublePinyinScheme0"" /t REG_SZ /d ""小鹤双拼*2*^*iuvdjhcwfg^xmlnpbksqszxkrltvyovt"" /f", 0, True
    MsgBox "已启用小鹤双拼！", vbInformation, "完成"
Else
    ' 禁用双拼（全拼）
    WshShell.Run "reg add ""HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS"" /v ""Enable Double Pinyin"" /t REG_DWORD /d 0 /f", 0, True
    MsgBox "已切换至全拼模式！", vbInformation, "完成"
End If


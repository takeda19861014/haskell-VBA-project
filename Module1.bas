Attribute VB_Name = "Module1"
Declare PtrSafe Function doubleValueWrapper Lib "F:\MyLib.dll" (ByVal x As Long) As Long

Sub Test()
    Dim result As Long
    result = doubleValueWrapper(10)
    MsgBox "Result: " & result  ' 20 と表示されました。
End Sub
' Create an HTTP object
myURL = WScript.Arguments(0)
Set objHTTP = CreateObject( "WinHttp.WinHttpRequest.5.1" )

' Download the specified URL
objHTTP.Open "GET", myURL, False
objHTTP.Send
intStatus = objHTTP.Status

If intStatus = 200 Then
  WScript.Echo " " & intStatus & " A OK " +myURL
Else
  WScript.Echo "OOPS" +myURL
End If
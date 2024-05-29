function Traceroute {
    # target definieren
    $target = Read-Host("Welche route soll getraced werden (Hostname oder IP)")
    
    # Ping an den target senden
    $traceResults = Test-NetConnection -TraceRoute $target -InformationLevel Quiet
    
    $traceResults | Format-Table -AutoSize
}
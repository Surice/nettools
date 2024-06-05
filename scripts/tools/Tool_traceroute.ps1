function Traceroute {
    # target definieren
    $target = Read-Host("Welche route soll getraced werden (Hostname oder IP)")
    $maxHops = 30

    $result = Test-NetConnection -TraceRoute $target -Hops $maxHops -InformationLevel Detailed
    Write-Output $result
}
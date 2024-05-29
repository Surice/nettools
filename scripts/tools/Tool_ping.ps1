function PingTarget {   
    # target definieren
    $target = Read-Host("Welches Ziel soll angepingt werden (Hostname oder IP)")
    
    # Ping an den target senden
    $PingResult = Test-Connection -ComputerName $target
    
    # Ergebnisse anzeigen
    $PingResult | Format-Table -AutoSize
}
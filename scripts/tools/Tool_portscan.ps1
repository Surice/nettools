function Portscan {
    $targetHost = Read-Host("Welches Geraet soll geprueft werden?")
    $timeoutMilliseconds = 2500

    $openPorts = ""

# Alle Ports von 1 bis 65535 scannen (parallel)
$ports = 1..65535 | ForEach-Object {
    $port = $_
    try {
        $tcpClient = New-Object System.Net.Sockets.TcpClient
        $asyncResult = $tcpClient.BeginConnect($targetHost, $port, $null, $null)

        # Verbindungsaufbau (Portscan)
        if ($asyncResult.AsyncWaitHandle.WaitOne($timeoutMilliseconds, $false)) {
            if ($tcpClient.Connected) {
                Write-Output "Der Port $port auf $targetHost ist geöffnet."
            }
        }

        $tcpClient.Close()
    } catch {
        # Fehler ignorieren (z. B. wenn der Port nicht erreichbar ist)
    }
} -ArgumentList $targetHost

# Ergebnisse anzeigen
$ports | ForEach-Object {
    Write-Host $_
}

    # Write-Host "Die folgenden Ports sind auf $targetHost geoeffnet: $openPorts"
}
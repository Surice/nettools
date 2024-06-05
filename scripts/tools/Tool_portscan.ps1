function Test-Port($ip, $port) {
    $tcpClient = New-Object System.Net.Sockets.TcpClient
    try {
        $tcpClient.Connect($ip, $port)
        $tcpClient.Close()
        return $true
    } catch {
        return $false
    }
}

function Portscan {
    $target = Read-Host "Which Target should be checked"

    $portRange = 1..1024
    
    $openPorts = @()
    
    foreach ($port in $portRange) {
        if (Test-Port $target $port) {
            $openPorts += $port
        }
    }
    
    
    Write-Host "Results for $($target):"
    $openPorts | ForEach-Object {
        Write-Host "Port $_ is opened."
    }
}
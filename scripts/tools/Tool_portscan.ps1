function Portscan {
    $Ports = 1..65535 | ForEach-Object {
        $port = $_
        $target = Read-Host "Which Target should be checked: "

        try {
            $tcpClient = New-Object System.Net.Sockets.TcpClient
            $asyncResult = $tcpClient.BeginConnect($target, $port, $null, $null)

            if ($asyncResult.AsyncWaitHandle.WaitOne($timeoutMilliseconds, $false)) {
                if ($tcpClient.Connected) {
                    Write-Output "Der Port $port auf $target ist geöffnet."
                }
            }

            $tcpClient.Close()
        } catch {
            Write-Output "Der Port $port auf $target ist zu."
        }
    }
}
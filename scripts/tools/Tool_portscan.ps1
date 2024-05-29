function Portscan {
    $Ports = 1..65535 | ForEach-Object {
        $port = $_
        $ComputerName = "192.168.95.242"

        try {
            $tcpClient = New-Object System.Net.Sockets.TcpClient
            $asyncResult = $tcpClient.BeginConnect($ComputerName, $port, $null, $null)

            if ($asyncResult.AsyncWaitHandle.WaitOne($timeoutMilliseconds, $false)) {
                if ($tcpClient.Connected) {
                    Write-Output "Der Port $port auf $ComputerName ist geöffnet."
                }
            }

            $tcpClient.Close()
        } catch {
            Write-Output "Der Port $port auf $ComputerName ist zu."
        }
    }
}

. ".\tools\Tool_ping.ps1"
. ".\tools\Tool_portscan.ps1"
. ".\tools\Tool_traceroute.ps1"

$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }
$adapters | Format-Table -AutoSize -Property Name, InterfaceDescription, MacAddress, Status
$adapternum = Read-Host "Wich Adapter should be used? "

$adapter = $adapters[$adapternum-1]

$dhcpServer = Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select-String DHCPServer
$ipAddress = Get-NetAdapter | Where-Object { $_.Name -eq $adapter.Name } | Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" } | Select-Object -ExpandProperty IPAddress
$subnetMask = Get-NetAdapter | Where-Object { $_.Name -eq $adapterName } | Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv4" } | Select-Object -ExpandProperty 
$gateway = Get-NetAdapter | Where-Object { $_.Name -eq $adapter.Name } | Get-NetRoute | Where-Object { $_.DestinationPrefix -eq "0.0.0.0/0" } | Select-Object -ExpandProperty NextHop
$dnsServers = Get-DnsClientServerAddress | Where-Object { $_.InterfaceAlias -eq $adapter.Name } | Select-Object -ExpandProperty ServerAddresses

# Ergebnisse in einer Tabelle ausgeben
Write-Host "Network Informations"
Write-Host "------------------------------------------"
Write-Host "Adapter: $($adapter.Name)"
Write-Host "Description: $($adapter.InterfaceDescription)"
Write-Host "MAC-Adresse: $($adapter.MacAddress)"
Write-Host "Status: $($adapter.Status)"
Write-Host ""
Write-Host "DHCP-Server: $dhcpServer"
Write-Host "IP-Adresse: $ipAddress"
Write-Host "Gateway: $gateway"
Write-Host "DNS-Server: $($dnsServers -join ', ')"


while ($true) {
    $Tool = Read-Host("Wich tool should be started")
    
    switch ($Tool.ToLower()) {
        "ping" { 
            PingTarget
        }
        "traceroute" {
            Traceroute
        }
        "portscan" {
            Portscan
        }
        Default {
            Write-Host "Module not found"
        }
    }
}   
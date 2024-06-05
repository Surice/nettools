. ".\tools\Tool_ping.ps1"
. ".\tools\Tool_portscan.ps1"
. ".\tools\Tool_traceroute.ps1"

while ($true) {
    $Tool = Read-Host("Welches Tool moechtest du verwenden?")
    
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
            Write-Host("Module nicht gefunden")
        }
    }
}   

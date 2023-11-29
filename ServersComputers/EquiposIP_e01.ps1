<# .Description
Nos saca las Ip's el nombre del equipo y el Sistema Operativo de todos los equipos en un rango 
.Parameter
En la variable rango debemos de meter el rango de las IP's que queremos comprobar.
El formato del parametro es 000.000.000. 
.Example
192.168.1.
#>
[CmdletBinding()] param (
    [Parameter(Mandatory=$True,HelpMessage="Escriba un rango tipo 192.168.1. (recuerde terminar en .)")]
    [string]$rango )
$results =@()

1..254| ForEach-Object -Process {
    $ping = Test-Connection $rango$_ -Count 1 -Quiet
    if ($ping ){
        $ip = "$rango$_"
        Try { $equipo = [System.Net.Dns]::GetHostEntry("$ip").hostname}
        catch {$equipo = "No Host"}
        Try {$serialnumber = Get-WmiObject win32_bios -ComputerName $equipo|select serialnumber -Unique}
        catch {$serialnumber = "No tiene S/N"}
        Try {$SO = Get-WmiObject win32_operatingsystem -ComputerName $equipo -Property * |select caption  }
        catch { $so = "Sistema Operativo No compatible"}
        $object = New-Object psobject
        $object |Add-Member -MemberType NoteProperty -Name "hostname" -Value $equipo 
        $object |Add-Member -MemberType NoteProperty -Name "IP" -Value $ip
        $object |Add-Member -MemberType NoteProperty -Name "NumeroSerie" -Value $serialnumber.serialnumber
        $object |Add-Member -MemberType NoteProperty -Name "Sistema Operativo" -Value $SO.caption

        $results += $object

            }
    }
    
    $results |Export-Csv -Path c:\temp\equipo.csv -Delimiter ";" -Append
    $results |ConvertTo-Html -as Table -Fragment -PreContent "<h2>HostName</h2> Se ha ejecutado el $(Get-Date)">>C:\Temp\host.html

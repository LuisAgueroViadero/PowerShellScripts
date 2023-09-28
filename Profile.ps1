<# 
. Synopsis
Perfil usuario
.Description
Se trata del perfil que cargara el PowerShell cuando inicie, este perfil solo es para el usuario donde se inicie el PowerShell y se almacena en "C:\users\nombreusuario\documents\windowspowershell"
.Parameter user
 Metemos el nombre del administrador con el que vamos a cargar el modulo
 .Parameter Pass
 Metemos la password del administrador para que nos deje cargar el modulo
 .Parameter credentials
 En esta variable guardamos el usuario y la password para que lo cargue todo junto
 .Parameter date
 En esta variable gardamos la fecha con el formato ddMMyyy
.Example
.
#>
# Inicia el PowerShell en este directorio
set-location \temp
#Charge a Administrator user to import Active Directory module
$User = 'dominio\AdminAccount'
# Put the file with encrypted password in a variable
$Pass = cat C:\temp\SecurePassword_0.txt | ConvertTo-SecureString
# Charge the credentials in a variable to import the module how a administrator
$Credentials = New-object -TypeName System.Management.Automation.PSCredential -ArgumentList $User,$Pass
# Import a module from other server
#Create a new session a put in a variable
$sesion = New-PSSession -ComputerName svrsan-dc01 -Credential $Credentials
# Updown the session module from activedirectory
Invoke-Command -Session $sesion -ScriptBlock {Import-Module activedirectory}
#Import the module and put a prefix "rem" to execute the command "get-remaduser -identity user"
Import-PSSession -Session $sesion -Module activedirectory -Prefix rem
#Creamos un fichero con la fecha actual donde guardaremos todo lo que ejecutemos en la sesion de PowerShell
$date = Get-Date -Format ddMMyyyy
Start-Transcript -path \\directorio\SizeHD_Restart_Event\comandos$date.txt

<# .Description
Perfil de usuario
.Parameter
 
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

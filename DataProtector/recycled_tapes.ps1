<#
SYNOMPSIS
Programa para limpiar cintas 
.DESCRIPCION
Se trata de limpiar las cintas de un fichero txt en el Data Protector Manager
 .PARAMETER file
 Cargamos el fichero donde estan el nombre de las cintas a limpiar
 . PARAMETER cintas
 Pasamos el contenido del fichero a la variable
 . EXAMPLE
   omnimm -recycle nombrecinta
 #>
set-location "c:\Program Files\OmniBack\bin"
$fichero = "c:\temp\Cintas-1.txt"
$cintas = get-content $fichero
foreach ($c in $cintas){
	omnimm -recycle $c
	}

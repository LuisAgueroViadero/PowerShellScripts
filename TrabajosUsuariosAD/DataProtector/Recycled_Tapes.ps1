CD "\Program Files\OmniBack\bin"
$fichero = "c:\temp\Cintas-1.txt"
$cintas = get-content $fichero
foreach ($c in $cintas){
	omnimm -recycle $c
	}

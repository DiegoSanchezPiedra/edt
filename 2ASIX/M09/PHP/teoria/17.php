<?php
$edat=0;
$nom='Minna';
while($edat<=21)
{
if($edat==21)
{
echo "<br>Felicitats! Ja tens $edat anys, $nom! ";
echo "Tens el carnet adequat?";
$edat=$edat+1;
continue;
echo "Aquesta línia mai s'executarà";
}
 
echo "Ara tens $edat anys! Si no tens 21 anys no
podràs conduir una moto de gran cilindrada, $nom!<br>";
$edat=$edat+1;
}
?>

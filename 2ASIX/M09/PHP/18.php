<?php
//el switch es para decir que vas a ir comparando el valor que tiene $opcio
$opcio=3;
switch($opcio)
{
//en caso de que $opcio tenga el valor 0
case 0:
echo "Estàs aquí perquè el valor de la variable \$opcio és $opcio";
break;
//en caso de que $opciotenga el valor 1
case 1:
echo "Estàs aquí perquè el valor de la variable \$opcio és $opcio";
break;
//en caso de que $opcio tenga el valor 2
case 2:
echo "Estàs aquí perquè el valor de la variable \$opcio és $opcio";
break;
//en caso de que $opcio no coincida con ningun valor
default:
echo "Estàs aquí perquè no hi ha coincidència entre
el valor de la variable \$opcio ($opcio) i els valors dels case";
}
?>

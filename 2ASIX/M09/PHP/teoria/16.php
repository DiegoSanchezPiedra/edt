<?php
while($edat<20)
{
for( ; ; $edat=$edat+1)
{
if($edat==18)
{
echo "Ara ja tens $edat anys!<br>";
break 2;
}
 
echo "Encara ets menor d'edat, ja que tens $edat anys!<br>";
}
 
echo "Aquesta línia no sortirà per pantalla!";
}
 
echo "Ja no ets menor d'edat! Tens $edat anys!";
?>

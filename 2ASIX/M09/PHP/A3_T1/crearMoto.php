<?php
//Diego Sanchez
//isx2031424
$var = "";
foreach($_POST as $key => $value)
{
    $var .= "POST[" . $key . "]=" . $value . "<br>";
}
echo($var);

$servidor = 'localhost';
$userBD = 'root';
$passwdBD = 'jupiter';
$nomBD = 'motos';

$connexio = mysqli_connect($servidor,$userBD,$passwdBD);

if (!$connexio)
{
    exit('No se puede conectar al servidor:'. mysqli_error());
}

if (!mysqli_select_db($connexio,$nomBD))
{
    exit('error al connectar amb la base dades'. mysqli_error());
}

$consulta = sprintf('select * from motos where modelo="%s" ',$_POST['modelo']);
echo $consulta;

if ($result = mysqli_query($connexio,$consulta))
{
    $afectades = mysqli_num_rows($result);
    if($afectades!=0)
    {
        printf('<div class="login">Ja existeix una moto amb el model = %s </div>', $_POST['model']);
    }
    else
    {
        $consulta = sprintf('insert into motos (modelo,marca,tipo,precio) values ("%s","%s","%s","%s")', $_POST["modelo"], $_POST["marca"], $_POST["tipo"], $_POST["precio"]);
        if($result = mysqli_query($connexio,$consulta))
        {
            printf('<div class="login">Inserció correcta </div>');
        }
        else
        {
            printf('<div class="login">Error inserint </div>');
        }
    }
}
else
{
    printf('<div class="login">Error al fer la consulta </div>');
}
?>
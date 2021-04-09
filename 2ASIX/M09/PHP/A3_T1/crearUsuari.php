<?php
//Diego Sanchez Piedra
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
$nomBD = 'biblioteca';

$connexio = mysqli_connect($servidor,$userBD,$passwdBD);

if (!$connexio)
{
    exit('No se puede conectar al servidor:'. mysqli_error());
}

if (!mysqli_select_db($connexio,$nomBD))
{
    exit('error al connectar amb la base dades'. mysqli_error());
}

$consulta = sprintf('select * from usuaris where nom="%s" ',$_POST['nom']);
echo $consulta;

if ($result = mysqli_query($connexio,$consulta))
{
    $afectades = mysqli_num_rows($result);
    if($afectades!=0)
    {
        printf('<div class="login">Ja existeix un usuari amb el nom = %s </div>', $_POST['nom']);
    }
    else
    {
        $consulta = sprintf('insert into usuaris (nom,clau,tipus) values ("%s",MD5("%s"),"%s")', $_POST["nom"], $_POST["nom"], $_POST["tipus"]);
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
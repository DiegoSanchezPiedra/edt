<?php
if(isset($_POST["isbn"]))
{
//Variables de POST definides
    //Podem mostrar tot el contingut de POST a mode de debug
    $var = "";
 
    foreach($_POST as $key => $value)
    {
        $var .= "POST[" . $key . "]= " . $value . "<br>";
        //$var = $var . "POST[" . $key . "]= " . $value . "<br>";
    }
        echo($var);
}
else
{
    //Sense dades del formulari
    exit("No hi ha dades rebudes d'aquest formulari")
}

$servidor = "localhost";
$userBD = "root";
$passwdBD = "jupiter";
// Nom BBDD
$nomBD = "biblioteca";
  
$connexio = mysqli_connect($servidor,$userBD,$passwdBD);
  
if (!$connexio)
{
     exit('No es pot connectar:'. mysqli_error());
}
    if(!mysqli_select_db($connexio,$nomBD))
    {
        exit("Error al connectar amb la base de dades". mysqli_error());
    }
 
    //En primer lloc comprovem que no hi ha cap llibre amb el mateix isbn
    $consulta = sprintf('select * from llibres where isbn="%s" ', $_POST["isbn"]);
    echo $consulta;
 
    //Fem la consulta
    if ($result = mysqli_query($connexio,$consulta))
    {                                
        //Mirem quants registres ha retornat la consulta                        
        $afectades = mysqli_num_rows($result);                
 
        //Existeix un llibre amb aquest isbn
        if($afectades!=0)
        {
            //Llibre existent
            printf('<div class="login">Ja existeix un llibre amb ISBN = %s </div>',  $_POST["isbn"] );
        }
        else
        {
            //No existeix cap llibre, el creem
            //CREAR QUAN NO HI HAGI CAP LLIBRE AMB EL ISBN INTRODUÏT:
                $consulta = sprintf('insert into llibres (nom, autor, isbn, puntuacio, genere) values ("%s", "%s", "%s", "%s", "%s")', $_POST["nom"], $_POST["autor"], $_POST["isbn"], $_POST["puntuacio"], $_POST["genere"]);
 
            //echo $consulta;
 
                if ($result = mysqli_query($connexio,$consulta))
                {
                    //Inserció correcta
                    printf('<div class="login">Inserció correcta </div>');
                }
                else
                {
                    //Error a l'inserir
                    printf('<div class="login">Error inserint </div>');
                }
            }
    }
    else
    {                        
        printf('<div class="login">Error al fer la consulta </div>');
    }
?>
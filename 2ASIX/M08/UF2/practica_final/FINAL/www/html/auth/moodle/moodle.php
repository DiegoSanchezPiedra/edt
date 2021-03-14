<!DOCTYPE html>
<html>
    <head>
        <title>Moodle</title>
    </head>
    <header>
	<h1><a href="http://www.escola_piedra.com">Escola Piedra</h1></a>
    </header>
    <body>
        <?php
                $vars = array();
                parse_str($_COOKIE["session"],$vars);
                $usuari = $vars["/auth-user"];
        ?>
         <h3>Moodle de l'alumne: <?php echo $usuari; ?></h3>
        <p><a href="ftp://localhost/Alumnes/">Directori alumnes</a></p>
    </body>
</html>

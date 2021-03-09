<!DOCTYPE html>
<html>
    <head>
        <title>Moodle</title>
    </head>
    <header>
        <h1>Escola Piedra</h1>
    </header>
    <body>
        <?php
                $vars = array();
                parse_str($_COOKIE["session"],$vars);
                $usuari = $vars["/auth-user"];
        ?>
         <h3>Moodle de l'alumne: <?php echo $usuari; ?></h3>
        <p><a href="#">Moodle</a></p>
    </body>
</html>

<!DOCTYPE html>
<html>
    <head>
        <title>Moodle</title>
        <link href="http://www.escola_piedra.com/main.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <?php
            //agafar l'usuari de la cookie session
            //$vars = array();
            //parse_str($_COOKIE["session"],$vars);
            //$usuari = $vars["/auth-user"];
            
            //Mostra les variables que hi ha al server
            /*foreach($_SERVER as $key_name => $key_value){
                print $key_name. "=" .$key_value."<br>";
            }*/
            
            $usuari = $_SERVER['REMOTE_USER'];

            //quin curs està cursant
            $AuthGroupFile = file("/var/www/grup");
            foreach ($AuthGroupFile as &$line) {
                $line = preg_split("/[\s,:]+/",$line);
                for ($x = 0; $x <= count($line); $x++) {
                    if ($usuari == $line[$x]){
                        $group = $line[0];
                    }
                }
            }

            //depenent del curs li enviem al directori ftp que correspon
            switch ($group) {
                case "ASIX":
                    $link_ftp = "ftp://localhost/Informatica/ASIX/";
                    break;
                case "DAW":
                    $link_ftp = "ftp://localhost/Informatica/DAW/";
                    break;
                case "DAM":
                    $link_ftp = "ftp://localhost/Informatica/DAM/";
                    break;
            }
        ?>

        <h1><a href="http://www.escola_piedra.com">Escola Piedra</h1></a>
        <h2>Moodle</h2>
        <h2>Moodle de l'alumne: <?php echo $usuari; ?></h2>
        <h2>Cursant: <?php echo $group; ?></h2>
        <ul id="navmenu">
            <li><a href="<?php echo $link_ftp?>" target="_blank">Recuros</a></li>
            <li><a href="ftp://localhost/Alumnes/" target="_blank">Directori alumnes</a></li>
        </ul>
    </body>
</html>

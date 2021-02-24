<?php
    $pizza = $_POST['pizza'];
    $complementos = $_POST['complementos'];
    print "<h2>Informacion del formulario recibida</h2>";
    print "pizza escogida: $pizza";
    foreach ($complementos as $complemento)
        print "<br> complemento añdadido: $complemento";
?>
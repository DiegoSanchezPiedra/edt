<html>
    <table border="1">
        <tr>
            <td></td>
            <?php 
                $dividendo = 50;
                for (;$dividendo<=60;)
                {
                    echo "<td>$dividendo</td>";
                    $dividendo += 1;
                }
            ?>
        </tr>
        <?php
            $divisor = 1;
            for (;$divisor<=10;)
            {
                echo "<tr><td>$divisor</td>";
                $divisor += 1;
            }
        ?>
        <?php
            $divisor = 1;
            for(;$divisor<=10;)
            {
                $dividendo = 50;
                for(;$dividendo<=60;)
                {
                    $resultat = $dividendo % $divisor;
                    echo "<td>$resultat</td>";
                    $dividendo += 1;
                }
                echo "</tr>";
                $divisor += 1;
            }
        ?>
    </table>
</html>
<?php
$divisor = 1;
for(;$divisor<=10;)
{
    $dividendo = 50;
    for(;$dividendo<=60;)
    {
        $resultat = $dividendo % $divisor;
        echo "$dividendo % $divisor = $resultat<br>";
        $dividendo += 1;
    }
    echo"<br>";
    $divisor += 1;
}
?>
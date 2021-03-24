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
            for(;$divisor<=10;)
            {
                echo "<tr>";
                $dividendo = 50;
                echo "<td>$divisor</td>";
                for(;$dividendo<=60;)
                {  
                    $resultat = $dividendo % $divisor;
                    if($resultat==0)
                    {
                        echo "<td align='center'>*</td>";
                    }
                    else
                    {
                        echo "<td align='center'>-</td>";
                    }

                    $dividendo += 1;
                }
                $divisor += 1;
            }
            echo "</tr>";
        ?>
    </table>
</html>

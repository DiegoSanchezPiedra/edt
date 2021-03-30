<html>
    <table border="1" align="center">
        <tr>
            <td bgcolor="#767CFA"></td>
            <?php 
                $dividendo = 50;
                for (;$dividendo<=60;)
                {
                    echo "<td bgcolor='#CBACFC'>$dividendo</td>";
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
                echo "<td bgcolor='#CBACFC'>$divisor</td>";
                for(;$dividendo<=60;)
                {  
                    $resultat = $dividendo % $divisor;
                    if($resultat==0)
                    {
                        if($divisor%2==0)
                        {
                            echo "<td align='center' bgcolor='#FFFEB0'>*</td>";
                        }
                        else
                        {
                            echo "<td align='center' bgcolor='#FFDCAD'>*</td>";
                        }
                    }
                    else
                    {
                        if($divisor%2==0)
                        {
                            echo "<td align='center' bgcolor='#FFFEB0'>-</td>";
                        }
                        else
                        {
                            echo "<td align='center' bgcolor='#FFDCAD'>-</td>";
                        }
                    }

                    $dividendo += 1;
                }
                $divisor += 1;
            }
            echo "</tr>";
        ?>
    </table>
</html>

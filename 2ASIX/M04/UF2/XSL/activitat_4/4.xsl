<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <style>
        header {
            text-align:center;
        }
        h1 {
            background-color:grey;
            margin-left:10px;
            margin-right:10px;
            font-size:25px;
        }
        a {
            color:blue;
        }
        .blue{
            color:blue;
        }
    </style>
    <header>
        <h1>Agencia Estatal de Meteorología - AEMET. Gobierno de España</h1>
        <a href="http://www.aemet.es">http://www.aemet.es</a>
    </header>
    <p>Dades per a: <font class="blue">Albarracín, Teruel</font></p>
    <table border="1" align="center">
    <xsl:for-each select="root/prediccion/dia">
    <tr border="1">
        <td colspan="3">
            data: <xsl:value-of select="@fecha"/>
        </td>
    </tr>
    </xsl:for-each>
    </table>
</html>
</xsl:template>
</xsl:stylesheet>
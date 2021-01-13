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
        table{
            border:1px solid;
            align:center;
        }
        a {
            color:blue;
        }
        .blue_font{
            color:blue;
        }
        .blue_bg{
            background-color:blue;
        }
        .yellow_bg{
            background-color:yellow;
        }
        #one td {
            border-color:green; 
        }
        
    </style>
    <xsl:for-each select="root">
        <header>
            <h1><xsl:value-of select="origen/productor"/></h1>
            <a href="http://www.aemet.es"><xsl:value-of select="origen/web"/></a>
        </header>
        <p>Dades per a: <font class="blue_font"><xsl:value-of select="nombre"/> - <xsl:value-of select="provincia"/></font></p>
    </xsl:for-each>
    
    <table border="1" align="center" width="40%">
        <xsl:for-each select="root/prediccion/dia">
        <xsl:sort select="@fecha"/>
            <tr>
                <td colspan="3">
                    Data: <font class="blue_bg"><xsl:value-of select="@fecha"/></font>
                </td>
            </tr>
            <tr align="center" bgcolor="yellow">
                <td colspan="3">
                    Probabilitat Precipitació
                </td>
            </tr>
            <xsl:for-each select="prob_precipitacion">
                <tr>
                    <td>
                        <xsl:value-of select="@periodo/."/>
                    </td>
                    <td colspan="2">
                        <xsl:value-of select="."/>
                    </td>
                </tr>
            </xsl:for-each>
            <tr align="center" bgcolor="yellow">
                <td colspan="3">
                    Dades del Vent
                </td>
            </tr>
            <tr align="center" bgcolor="grey">
                <td>Periode</td>
                <td>Direcció</td>
                <td>Velocitat</td>
            </tr>
            <xsl:for-each select="viento">
                <tr>
                    <td><xsl:value-of select="@periodo/."/></td>
                    <td><xsl:value-of select="direccion/."/></td>
                    <xsl:choose>
                        <xsl:when test="velocidad &gt; 8">
                            <td style="border-color:red;"><font color="red"><xsl:value-of select="velocidad/."/></font></td>
                        </xsl:when>
                        <xsl:otherwise>
                            <td style="border-color:green;"><font color="green"><xsl:value-of select="velocidad/."/></font></td>  
                        </xsl:otherwise>
                    </xsl:choose>
                </tr>
            </xsl:for-each>
            <tr align="center" bgcolor="grey">
                <td colspan="3">
                    Temperatura/UV
                </td>
            </tr>
            <tr align="center" bgcolor="grey">
                <td>
                    Temp. Màxima
                </td>
                <td>
                    Temp. Mínima
                </td>
                <td>
                    UV
                </td>
            </tr>
                <tr>
                    <td><xsl:value-of select="temperatura/maxima/."/></td>
                    <td><xsl:value-of select="temperatura/minima/."/></td>
                    <td><xsl:value-of select="uv_max"/></td>
                </tr>
        </xsl:for-each>
    </table>
</html>
</xsl:template>
</xsl:stylesheet>
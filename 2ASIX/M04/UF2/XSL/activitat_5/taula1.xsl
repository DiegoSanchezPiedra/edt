<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <head>
        <link href="M04 - UF2 - NF3 - practica 5/css/estil_SOLUCIO.css" rel="stylesheet" type="text/css" />
    </head>
    <xsl:for-each select="the_expanse/dades">
        <table border="0" align="center">
            <img style="display:block;margin-left:auto;margin-right:auto;" src="M04 - UF2 - NF3 - practica 5/logos/TheExpanseWiki-S4-title.png">
                <xsl:attribute name="src">M04 - UF2 - NF3 - practica 5/logos/<xsl:value-of select="logo/."/></xsl:attribute>
            </img>
        </table>
    </xsl:for-each>
    <body>
        <table id="t01" border="1" align="center">
            <th width="320px">Nom</th>
            <th width="120px">Bandol</th>
            <th width="400px">Característiques</th>
            <th width="240px">Noms Coneguts</th>
            <xsl:for-each select="the_expanse/Martian_Congressional_Republic_Navy/nau">
                <tr>
                    <td class="normal">
                        <img  width="320px">
                            <xsl:attribute name="src">M04 - UF2 - NF3 - practica 5/imatges/<xsl:value-of select="imatge/."/></xsl:attribute>
                        </img>
                        <a>
                            <xsl:attribute name="href"><xsl:value-of select="web/."/></xsl:attribute>
                            <xsl:value-of select="classe/."/>
                        </a>
                    </td>
                    <td class="normal">
                        <img width="320px">
                            <xsl:attribute name="src">M04 - UF2 - NF3 - practica 5/logos/<xsl:value-of select="logo/."/></xsl:attribute>
                        </img>
                    </td>
                    <td class="normal">
                        Tipus de nau: <xsl:value-of select="tipus/."/><br/>
                        Tonelatge: <xsl:value-of select="caracteristiques/tonelatge/."/> de <xsl:value-of select="caracteristiques/tonelatge/@unitat"/><br/>
                        Longitud: <xsl:value-of select="caracteristiques/longitud/."/> <xsl:value-of select="caracteristiques/longitud/@unitat"/><br/>
                        Tripulació: <xsl:value-of select="capacitat_humana/tripulacio/."/><br/>
                        <xsl:if test="capacitat_humana/tropes/@quantitat &gt; 0">
                            <b>Tropes: <xsl:value-of  select="capacitat_humana/tropes/@quantitat"/> de <xsl:value-of select="capacitat_humana/tropes/."/></b><br/>
                        </xsl:if>
                        Propulsió: <xsl:value-of select="propulsio/numero_de_motors_impulsio/."/> <xsl:value-of select="propulsio/motors_impulsio/."/>
                    </td>
                    <td class="normal">
                        <xsl:for-each select="designacions/nom">
                            <xsl:value-of select="."/><br/><br/>
                        </xsl:for-each>
                        (Nº de noms = <xsl:value-of select="count(designacions/nom)"/>)<br/><br/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>
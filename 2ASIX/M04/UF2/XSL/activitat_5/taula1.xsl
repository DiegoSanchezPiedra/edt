<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <head>
        <link href="M04 - UF2 - NF3 - practica 5/css/estil_SOLUCIO.css" rel="stylesheet" type="text/css" />
    </head>
    
    <img style="display:block;margin-left:auto;margin-right:auto;width:50%;" src="M04 - UF2 - NF3 - practica 5/logos/TheExpanseWiki-S4-title.png"/>
    
    <body>
        <table id="t01" border="1" align="center">
            <th width="320px">Nom</th>
            <th width="120px">Bandol</th>
            <th width="400px">Característiques</th>
            <th width="240px">Noms Coneguts</th>
            <xsl:for-each select="the_expanse/Martian_Congressional_Republic_Navy/nau">
                <tr>
                    <td>
                        <img id="esquinarImagen">
                            <xsl:attribute name="src">M04 - UF2 - NF3 - practica 5/imatges/<xsl:value-of select="imatge/."/></xsl:attribute>
                        </img>
                    </td>
                    <td>
                        <img id="esquinarImagen">
                            <xsl:attribute name="src">M04 - UF2 - NF3 - practica 5/logos/<xsl:value-of select="logo/."/></xsl:attribute>
                        </img>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>
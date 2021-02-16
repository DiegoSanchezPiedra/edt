<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <head>
        <title>The Expanse</title>
        <link href="imatges_y_logos_PELS_ALUMNES/css/estil_SOLUCIO.css"/>
    </head>
    
    <body>
    <xsl:for-each select="the_expanse/dades">
        <table border="0" align="center">
            <a>
                <xsl:attribute name="href"><xsl:value-of select="pag_web/."></xsl:value-of></xsl:attribute>
                <img>
                    <xsl:attribute name="src">imatges_y_logos_PELS_ALUMNES/logos/<xsl:value-of select="logo/."/></xsl:attribute>
                    <xsl:attribute name="tag"><xsl:value-of select="titol/."/></xsl:attribute>
                </img>
            </a>
        </table>
    </xsl:for-each>
    <xsl:for-each select="the_expanse">
        <table id="t01" border="1" align="center" width="1050px">
            <tr>
            <th bgcolor="#DF013A" colspan="4">
                Nº de naus= <xsl:value-of select="count(Martian_Congressional_Republic_Navy/nau)+count(United_Nations_Navy/nau)"/><br/>
                Nº de noms de naus conegudes= <xsl:value-of select="United_Nations_Navy/nau/designacions/@conegudes + Martian_Congressional_Republic_Navy/nau/designacions/@conegudes"/><br/>
                <xsl:for-each select="Martian_Congressional_Republic_Navy/nau[tipus='Cuirasat']">

                    Nº de cuirasats de Martian_Congressional_Republic_Navy = <xsl:value-of select="designacions/@conegudes"/><br/>

                </xsl:for-each>
                
                <xsl:for-each select="United_Nations_Navy/nau[tipus='Cuirasat']">

                    nº de cuirasats de United_Nations_Navy = <xsl:value-of select="designacions/@conegudes"/>    <br/>

                </xsl:for-each>
            </th>
            </tr>
            <tr>
                <th bgcolor="#DF013A" width="320px">
                    nom
                </th>
                <th bgcolor="#DF013A" width="120">
                    Bandol
                </th>
                <th bgcolor="#DF013A" width="470px">
                    Caracteristiques
                </th>
                <th bgcolor="#DF013A" width="140px">
                    Noms Coneguts
                </th>
            </tr>
            <tr>
                <td>
                    <xsl:for-each select="Martian_Congressional_Republic_Navy/nau">                
                    <xsl:sort select="tipus" order="descending"/>
                        <img src="imatges_y_logos_PELS_ALUMNES/imatges/{imatge}" width="100%"/>
                    </xsl:for-each>
                    <xsl:for-each select="United_Nations_Navy/nau">
                    <xsl:sort select="tipus" order="descending"/>
                        <img src="imatges_y_logos_PELS_ALUMNES/imatges/{imatge}" width="100%"/>
                    </xsl:for-each>
                </td>
                <td>
                    <xsl:for-each select="Martian_Congressional_Republic_Navy/nau">                
                        <img src="imatges_y_logos_PELS_ALUMNES/logos/{logo}" width="100%"/>
                    </xsl:for-each>
                    <xsl:for-each select="United_Nations_Navy/nau">
                        <img src="imatges_y_logos_PELS_ALUMNES/logos/{logo}" width="100%"/>
                    </xsl:for-each>
                </td>
                <td>
                    <xsl:for-each select="Martian_Congressional_Republic_Navy/nau/">
                        <xsl:value-of select="tipus"/>
                    </xsl:for-each>
                </td>
            </tr>
        </table>
    </xsl:for-each>

    </body>
</html>
</xsl:template>
</xsl:stylesheet>
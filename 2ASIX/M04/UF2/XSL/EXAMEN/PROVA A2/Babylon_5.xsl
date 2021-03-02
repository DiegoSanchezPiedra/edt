<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <head>
        <title>Babylon 5</title>
        <link href="./estil_SOLUCIO.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
    <xsl:for-each select="babylon5/dades_generals">
        <table width="900px" align="center">
            <a href="{web}"><img id="esquinarImagen" width="100%" height="auto" src="logos_alumnes/logos/{logo}" alt="{titol}"/></a>
        </table>
    </xsl:for-each>
        <table id="t01" width="900" align="center" border="1">
            <tr>
                <th colspan="4">
                    Nº de noms de naus = <xsl:value-of select="count(//nom)"/><br/>
                    Nº de noms de naus coneguts = <xsl:value-of select="sum(//@coneguts)"/><br/>
                    Nº de noms de naus coneguts d'origen Earth_Alliance = <xsl:value-of select="sum(babylon5/nau[origen='Earth_Alliance']/noms/@coneguts)"/><br/>
                    Nº de noms de naus coneguts d'origen Narn = <xsl:value-of select="sum(babylon5/nau[origen='Narn']/noms/@coneguts)"/><br/>
                </th>
            </tr>
            <tr>
                <th width="320px">
                    Nom
                </th>
                <th width="120px">
                    Bandol
                </th>
                <th width="320px">
                    Caracteristiques
                </th>
                <th width="140px">
                    Noms coneguts
                </th>
            </tr>
            <xsl:for-each select="babylon5/nau">
            <xsl:sort select="origen"/>
                <tr>
                    <td class="normal centrado">
                        <a href="{pag_web}"><img width="100%" height="auto" src="imatges_alumnes/imatges/{imatge}" alt="{classe/@classe}"/></a><br/>
                        <xsl:value-of select="classe/@classe"/>
                    </td>
                    <td class="normal centrado">
                        <img width="100%" height="auto" src="logos_alumnes/logos/{logo}" alt=""/>
                    </td>
                    <td class="normal">
                        Tonelatge: <xsl:value-of select="caracteristiques/tonelatge"/> de <xsl:value-of select="caracteristiques/tonelatge/@unitat"/><br/>
                        Longitud: <xsl:value-of select="caracteristiques/longitud"/><br/>
                        Tripulacio: <xsl:value-of select="capacitat_humana/tripulacio"/><br/>
                        Naus Transportades:<br/>
                        &#160;&#160;&#160;&#160;caces: <xsl:value-of select="capacitat_naus/caces"/><br/>
                        &#160;&#160;&#160;&#160;Tranports de tropes: <xsl:value-of select="capacitat_naus/transports_tropes"/><br/>
                        <xsl:choose>
                            <xsl:when test="position()=4">
                                <b>Abast: <xsl:value-of select="abast/quantitat"/>&#160;<xsl:value-of select="abast/unitat_de_mesura"/><br/></b>
                            </xsl:when>
                            <xsl:otherwise>
                                Abast: <xsl:value-of select="abast/quantitat"/>&#160;<xsl:value-of select="abast/unitat_de_mesura"/><br/>
                            </xsl:otherwise>
                        </xsl:choose>
                        Propulsio:<br/>
                        &#160;&#160;&#160;&#160;Reactors: <xsl:value-of select="propulsio/reactors/@numero"/>&#160;<xsl:value-of select="propulsio/reactors"/><br/>
                        &#160;&#160;&#160;&#160;Motors d'impulsio: <xsl:value-of select="propulsio/numero_de_motors_impulsio"/>&#160;<xsl:value-of select="propulsio/motors_impulsio"/><br/>
                        &#160;&#160;&#160;&#160;Potencia standart: <xsl:value-of select="propulsio/potencia_standart"/>&#160;<xsl:value-of select="propulsio/unitat_de_mesura_potencia"/><br/>
                        &#160;&#160;&#160;&#160;Potencia militar: <xsl:value-of select="propulsio/potencia_militar"/>&#160;<xsl:value-of select="propulsio/unitat_de_mesura_potencia"/><br/>
                    </td>
                    <td class="normal">
                        <xsl:value-of select="noms"/><br/><br/>
                        (Nº de noms = <xsl:value-of select="count(noms/nom)"/>)
                    </td>
                </tr>
                <tr>
                    <td colspan="4" class="normal centrado">
                        <a href="{pag_web}"><xsl:value-of select="pag_web"/></a>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>
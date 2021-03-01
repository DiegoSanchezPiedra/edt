<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <head>
        <title>The Expanse</title>
        <link href="imatges_y_logos_PELS_ALUMNES/css/estil_SOLUCIO.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <xsl:for-each select="the_expanse/dades">
        <table width="1050px" align="center">
            <a href="{pag_web}"><img width="100%" src="imatges_y_logos_PELS_ALUMNES/logos/{logo}" alt="{titol}"></img></a>
        </table>
        </xsl:for-each>
        <table id="t01" width="1050px" align="center" border="1">
            <tr>
                <th colspan="4">
                    Nº de naus = <xsl:value-of select="count(//nau)"/> <br/>
                    Nº de noms de naus coneguts = <xsl:value-of select="sum(//designacions/@conegudes)"/><br/>
                    Nº de cuirasats de Martina_Congressional_Republic = <xsl:value-of select="sum(the_expanse/Martian_Congressional_Republic_Navy/nau[tipus='Cuirasat']/designacions/@conegudes)"/><br/>
                    Nº de cuirasats de United_Nations_Navy = <xsl:value-of select="sum(the_expanse/United_Nations_Navy/nau[tipus='Cuirasat']/designacions/@conegudes)"/><br/>
                </th>
            </tr>
            <tr>
                <th>
                    Nom
                </th>
                <th>
                    Bandol
                </th>
                <th>
                    Caracteristiques
                </th>
                <th>
                    Noms Coneguts
                </th>
            </tr>
            
            <xsl:for-each select="the_expanse/Martian_Congressional_Republic_Navy/nau">
            <xsl:sort select="tipus"/>
            <xsl:if test="caracteristiques/longitud > 10">
            <tr>
                <td width="320px" class="normal centrado">
                    <a href="{web}"><img width="100%" height="auto" src="imatges_y_logos_PELS_ALUMNES/imatges/{imatge}" alt="{imatge}"/></a><br/>
                    <xsl:value-of select="tipus"/>
                </td>
                <td width="120px">
                    <img width="100%" src="imatges_y_logos_PELS_ALUMNES/logos/{logo}"/>
                </td>
                <td width="470px" class="normal">
                    <xsl:choose>
                        <xsl:when test="position()=2">
                            <b>tipus de nau: <xsl:value-of select="tipus"/><br/></b>
                        </xsl:when>
                        <xsl:otherwise>
                            tipus de nau: <xsl:value-of select="tipus"/><br/>
                        </xsl:otherwise>
                    </xsl:choose>
                    Tonelatge: <xsl:value-of select="caracteristiques/tonelatge"/> de <xsl:value-of select="caracteristiques/tonelatge/@unitat"/><br/>
                    Longitud: <xsl:value-of select="caracteristiques/longitud"/><br/>
                    Tripulacio: <xsl:value-of select="capacitat_humana/tripulacio"/><br/>
                    <xsl:choose>
                        <xsl:when test="capacitat_humana/tropes/@enPorta = 'Si'">
                            <b>Tropes: <xsl:value-of select="capacitat_humana/tropes/@quantitat"/> de <xsl:value-of select="capacitat_humana/tropes"/></b><br/>
                        </xsl:when>
                        <xsl:otherwise>
                            Tropes: <xsl:value-of select="capacitat_humana/tropes/@quantitat"/> de <xsl:value-of select="capacitat_humana/tropes"/><br/>
                        </xsl:otherwise>
                    </xsl:choose>
                    Propulsio: <xsl:value-of select="propulsio/numero_de_motors_impulsio"/> del tipus <xsl:value-of select="propulsio/motors_impulsio"/><br/>
                    Armament:
                    <ul style="list-style-type:none;">
                        <li>
                            <b><xsl:value-of select="armament/canons_de_riel/@quantitat"/></b> canons de riel <b><xsl:value-of select="armament/canons_de_riel"/></b> del tipus <b><xsl:value-of select="armament/canons_de_riel/@tipus"/></b>
                        </li>
                        <li>
                            <b><xsl:value-of select="armament/llança_torpedes_davanters/@quantitat"/></b> llança torpedes davanters del tipus <b><xsl:value-of select="armament/llança_torpedes_davanters/@tipus"/></b>
                        </li>
                        <li>
                            <b><xsl:value-of select="armament/llança_torpedes_posteriors/@quantitat"/></b> llança torpedes posteriors del tipus <b><xsl:value-of select="armament/llança_torpedes_posteriors/@tipus"/></b>
                        </li>
                        <li>
                            Ampliacion: <b><xsl:value-of select="armament/ampliacions"/></b>
                        </li>
                    </ul>
                </td>
                <td class="normal">
                    <xsl:value-of select="designacions"/><br/><br/>
                    (Nº de noms= <xsl:value-of select="count(designacions/nom)"/>)
                </td>
            </tr>
            <tr>
                <td colspan="4" class="normal centrado">
                    <a href="{web}"><xsl:value-of select="web"/></a>
                </td>
            </tr>
            </xsl:if>
            </xsl:for-each>

            <xsl:for-each select="the_expanse/United_Nations_Navy/nau">
            <xsl:sort select="tipus"/>
            <xsl:if test="caracteristiques/longitud > 10">
            <tr>
                <td width="320px" class="normal centrado">
                    <a href="{web}"><img width="100%" height="auto" src="imatges_y_logos_PELS_ALUMNES/imatges/{imatge}" alt="{imatge}"/></a><br/>
                    <xsl:value-of select="tipus"/>
                </td>
                <td width="120px">
                    <img width="100%" src="imatges_y_logos_PELS_ALUMNES/logos/{logo}"/>
                </td>
                <td width="470px" class="normal">
                    <xsl:choose>
                        <xsl:when test="position()=2">
                            <b>tipus de nau: <xsl:value-of select="tipus"/><br/></b>
                        </xsl:when>
                        <xsl:otherwise>
                            tipus de nau: <xsl:value-of select="tipus"/><br/>
                        </xsl:otherwise>
                    </xsl:choose>
                    Tonelatge: <xsl:value-of select="caracteristiques/tonelatge"/> de <xsl:value-of select="caracteristiques/tonelatge/@unitat"/><br/>
                    Longitud: <xsl:value-of select="caracteristiques/longitud"/><br/>
                    Tripulacio: <xsl:value-of select="capacitat_humana/tripulacio"/><br/>
                    <xsl:choose>
                        <xsl:when test="capacitat_humana/tropes/@enPorta = 'Si'">
                            <b>Tropes: <xsl:value-of select="capacitat_humana/tropes/@quantitat"/> de <xsl:value-of select="capacitat_humana/tropes"/></b><br/>
                        </xsl:when>
                        <xsl:otherwise>
                            Tropes: <xsl:value-of select="capacitat_humana/tropes/@quantitat"/> de <xsl:value-of select="capacitat_humana/tropes"/><br/>
                        </xsl:otherwise>
                    </xsl:choose>
                    Propulsio: <xsl:value-of select="propulsio/numero_de_motors_impulsio"/> del tipus <xsl:value-of select="propulsio/motors_impulsio"/><br/>
                    Armament:
                    <ul style="list-style-type:none;">
                        <li>
                            <b><xsl:value-of select="armament/canons_de_riel/@quantitat"/></b> canons de riel <b><xsl:value-of select="armament/canons_de_riel"/></b> del tipus <b><xsl:value-of select="armament/canons_de_riel/@tipus"/></b>
                        </li>
                        <li>
                            <b><xsl:value-of select="armament/llança_torpedes_davanters/@quantitat"/></b> llança torpedes davanters del tipus <b><xsl:value-of select="armament/llança_torpedes_davanters/@tipus"/></b>
                        </li>
                        <li>
                            <b><xsl:value-of select="armament/llança_torpedes_posteriors/@quantitat"/></b> llança torpedes posteriors del tipus <b><xsl:value-of select="armament/llança_torpedes_posteriors/@tipus"/></b>
                        </li>
                        <li>
                            Ampliacion: <b><xsl:value-of select="armament/ampliacions"/></b>
                        </li>
                    </ul>
                </td>
                <td class="normal">
                    <xsl:value-of select="designacions"/><br/><br/>
                    (Nº de noms= <xsl:value-of select="count(designacions/nom)"/>)
                </td>
            </tr>
            <tr>
                <td colspan="4" class="normal centrado">
                    <a href="{web}"><xsl:value-of select="web"/></a>
                </td>
            </tr>
            </xsl:if>
            </xsl:for-each>
        </table>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>
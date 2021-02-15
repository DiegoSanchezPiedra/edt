<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
<html>
    <head>
        <title>Activitat 1 XSLT</title>
    </head>
    <body>
        <table border="1" align="center">
            <th colspan="3" align="center">Classificació</th>
            <tr bgcolor="#00FF00">
                <th align="center">Plataforma del programa</th>
                <th align="center">Nom</th>
                <th align="center">Tipus de llicència</th>
            </tr>
            <xsl:for-each select="programes/editors_XML/programa">
            <xsl:sort select="llicencia"/>
            <tr>
                <td><xsl:value-of select="plataforma" /></td>
                <td align="center" bgcolor="#F31210"><b><xsl:value-of select="nom" /></b></td>
                <td><xsl:value-of select="llicencia" /></td>
            </tr>
            </xsl:for-each>
        </table>
    </body>
</html>
</xsl:template>
</xsl:stylesheet>

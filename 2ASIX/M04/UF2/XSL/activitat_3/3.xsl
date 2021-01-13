<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <style>
        table{
            border:1px black solid;
            width:50%;
        }
    </style>
<body>
<table align="center">
    <xsl:for-each select="bookstore/book">
    <xsl:sort select="@category" order="descending"/>
    <xsl:choose>
        <xsl:when test="year = 2003 and price &gt;= 30">
    <tr bgcolor="grey">
        <td colspan="2"><font color="yellow">Categoria:</font><xsl:value-of select="@category"/></td>
    </tr>
    <tr>
        <td>Titol</td>
        <td align="right"><xsl:value-of select="title"/></td>
    </tr>
    <tr>
        <td>Any</td>
        <td align="right"><xsl:value-of select="year"/></td>
    </tr>
    <tr>
        <td>Preu</td>
        <td align="right"><xsl:value-of select="price"/></td>
    </tr>
    <tr bgcolor="#00ffff" align="center">
        <td colspan="2">Autor/s</td>
    </tr>
    <xsl:for-each select="author">
        <xsl:sort select="."/>
    <tr>
        <td colspan="2">
                <xsl:value-of select="."/>
        </td>
    </tr>
    </xsl:for-each>
    </xsl:when>
    </xsl:choose>
    </xsl:for-each>
</table>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
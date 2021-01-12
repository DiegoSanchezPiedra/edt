<?xml version="1.0" encoding="UTF-8" ?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html>
        <body>
            <h2>My CD Collection</h2>
            <table border="1">
                <tr bgcolor="#9acd32">
                    <th>Title</th>
                    <th>Artist</th>
                    <th>Year</th>
                </tr>
                <xsl:for-each select="catalog/cd[artist='Bob Dylan']">
                    <xsl:sort select="year"/>
                    <xsl:if test="year >= 1985">
                        <tr>
                            <xsl:choose>
                                <xsl:when test="year=1985">
                                    <td bgcolor="cyan"><xsl:value-of select="title"/></td>
                                    <td bgcolor="cyan"><xsl:value-of select="artist"/></td>
                                    <td bgcolor="cyan"><xsl:value-of select="year"/></td>
                                </xsl:when>
                                <xsl:otherwise>
                                    <td bgcolor="yellow"><xsl:value-of select="title"/></td>
                                    <td bgcolor="yellow"><xsl:value-of select="artist"/></td>
                                    <td bgcolor="yellow"><xsl:value-of select="year"/></td>
                                </xsl:otherwise>
                            </xsl:choose>
                        </tr>
                    </xsl:if>
                </xsl:for-each>
            </table>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>


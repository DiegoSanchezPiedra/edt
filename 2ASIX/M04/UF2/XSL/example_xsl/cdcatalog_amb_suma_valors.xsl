<?xml version="1.0" encoding="UTF-8" ?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
    <html>
        <body>
            <h2>My CD Collection 2</h2>

            <table border="1">
                <tr bgcolor="#9acd32">
                    <td colspan="4">
						sum(//price1) = <xsl:value-of select="sum(//price1)"/>
						<br/>
						sum(//price2) = <xsl:value-of select="sum(//price2)"/>
						<br/>
						count(//price1) = <xsl:value-of select="count(//price1)"/>
						<br/>
						count(//price2) = <xsl:value-of select="count(//price1)"/>
					</td>
                </tr>

				<tr bgcolor="#9acd32">
					<th>title</th>
                    <th>price1</th>
                    <th>price2</th>
                    <th>price1 + price2</th>
                </tr>

                <xsl:for-each select="catalog/cd">
					<tr>
						<td bgcolor="cyan"><xsl:value-of select="title"/></td>
						<td bgcolor="cyan"><xsl:value-of select="price1"/></td>
						<td bgcolor="cyan"><xsl:value-of select="price2"/></td>

						<xsl:variable name="sumaPreusPerCD" select="number(./price1) + number(./price2)"/>
                    
                        <td bgcolor="cyan"><xsl:value-of select="$sumaPreusPerCD"/></td>
                    </tr>
                </xsl:for-each>

				<tr>
					<td>En total hi ha <xsl:value-of select="count(//cd)"/> cd's</td>
					<td>price1 suma <xsl:value-of select="sum(//price1)"/></td>
					<td>price2 suma <xsl:value-of select="sum(//price2)"/></td>

                    <td>
						<xsl:variable name="sumaPrice1" select="sum(//price1)"/>
						<xsl:variable name="sumaPrice2" select="sum(//price2)"/>
						<xsl:variable name="sumaPreusTotal" select="number($sumaPrice1) + number($sumaPrice2)"/>

						<xsl:value-of select="$sumaPreusTotal"/>
						<br/>
						<xsl:value-of select="number($sumaPrice1) + number($sumaPrice2)"/>
					</td>
                </tr>
            </table>
        </body>
    </html>
</xsl:template>
</xsl:stylesheet>


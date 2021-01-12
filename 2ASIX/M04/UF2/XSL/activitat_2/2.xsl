<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
<html>
<table border="1" align="center">
<th colspan="4" align="center" bgcolor="#b6abab">COMANDA</th>
<tr>
    <td align="center" bgcolor="#b6abab"><b>Nom</b></td>
    <td align="center" bgcolor="#b6abab"><b>Adreça</b></td>
    <td align="center" bgcolor="#b6abab"><b>Ciutat</b></td>
    <td align="center" bgcolor="#b6abab"><b>C.P.</b></td>
</tr>
<xsl:for-each select="Pedido/Destino">
<tr>
    <td bgcolor="ligth-blue" align="center"><b><xsl:value-of select="Nombre"/></b></td>
    <td align="center"><xsl:value-of select="Direccion"/></td>
    <td align="center"><xsl:value-of select="Ciudad"/></td>
    <td align="center"><xsl:value-of select="CodPostal"/></td>
</tr>
</xsl:for-each>

<tr style="height: 23px !important;">
<td colspan="4"></td>
</tr>
<td colspan="4" align="center">Llista amb "Precio &gt; 25" i "Precio &lt;= 100"</td>
<th colspan="2">Producte</th>
<th>Preu</th>
<th>Quantitat</th>

<xsl:for-each select="Pedido/Contenido/Producto">
<xsl:sort select="Nombre"/>
<tr>
    <xsl:choose>
        <xsl:when test="Precio &gt; 25 and Precio &lt; 50">
            <td colspan="2"><xsl:value-of select="Nombre" /></td>
            <td align="center"><xsl:value-of select="Precio" /></td>
            <td bgcolor="yellow" align="center"><xsl:value-of select="Cantidad" /></td>
        </xsl:when>
        <xsl:when test="Precio &gt; 50 and Precio &lt;75">
            <td colspan="2"><xsl:value-of select="Nombre" /></td>
            <td align="center"><xsl:value-of select="Precio" /></td>
            <td bgcolor="green" align="center"><xsl:value-of select="Cantidad" /></td>
        </xsl:when>
        <xsl:when test="Precio &gt; 75 and Precio &lt;= 100">
            <td colspan="2"><xsl:value-of select="Nombre" /></td>
            <td align="center"><xsl:value-of select="Precio" /></td>
            <td bgcolor="red" align="center"><xsl:value-of select="Cantidad" /></td>
        </xsl:when>
    </xsl:choose>
</tr>
</xsl:for-each>

</table>
</html>
</xsl:template>
</xsl:stylesheet>
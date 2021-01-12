<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
<html>
<table border="1" align="center">
<th colspan="4" align="center" bgcolor="#b6abab">COMANDA</th>
<xsl:for-each select="Pedido">
<tr>
    <td align="center" bgcolor="#b6abab"><b>Nom</b></td>
    <td align="center" bgcolor="#b6abab"><b>Adreça</b></td>
    <td align="center" bgcolor="#b6abab"><b>Ciutat</b></td>
    <td align="center" bgcolor="#b6abab"><b>C.P.</b></td>
</tr>
<xsl:for-each select="Destino">
<tr>
    <td bgcolor="ligth-blue" align="center"><b><xsl:value-of select="Nombre"/></b></td>
    <td align="center"><xsl:value-of select="Direccion"/></td>
    <td align="center"><xsl:value-of select="Ciudad"/></td>
    <td align="center"><xsl:value-of select="CodPostal"/></td>
</tr>
</xsl:for-each>
<xsl:for-each select="Ordenante">
<tr>
    <td align="center"><xsl:value-of select="Nombre"/></td>
    <td align="center"><xsl:value-of select="Direccion"/></td>
    <td align="center"><xsl:value-of select="Ciudad"/></td>
    <td align="center"><xsl:value-of select="CodPostal"/></td>
</tr>
</xsl:for-each>
<td colspan="4" align="center"><xsl:value-of select="Observaciones"/></td>
<th colspan="2">Producte</th>
<th>Preu</th>
<th>Quantitat</th>

<xsl:for-each select="Contenido/Producto">
<xsl:sort select="Nombre"/>
<tr>
    <td colspan="2"><xsl:value-of select="Nombre" /></td>
    <td><xsl:value-of select="Precio" /></td>
    <td><xsl:value-of select="Cantidad" /></td>
</tr>
</xsl:for-each>
</xsl:for-each>
</table>
</html>
</xsl:template>
</xsl:stylesheet>
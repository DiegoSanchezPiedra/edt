<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html>
    <head>
        <title>The Expanse</title>
        <link href="imatges_y_logos_PELS_ALUMNES/css/estil_SOLUCIO.css"/>
    </head>
    <xsl:for-each select="the_expanse/Martian_Congressional_Republic_Navy/nau[tipus='Cuirasat']">
    <table borde="1">

        <xsl:value-of select="designacions/@conegudes"></xsl:value-of>

    </table>
    </xsl:for-each>
</html>
</xsl:template>
</xsl:stylesheet>
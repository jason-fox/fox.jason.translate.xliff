<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   >
    <xsl:output omit-xml-declaration="no" indent="yes"  method="xml"/>
    <xsl:template match="/">
	 <xliff xmlns:xs="http://www.w3.org/2001/XMLSchema"
       xmlns:xsd="http://www.w3.org/2001/XMLSchema"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
            
            <xsl:apply-templates select="//file">
                <xsl:sort select="@original"/>
                <xsl:sort select="@source-language"/>
                <xsl:sort select="@target-language"/>
            </xsl:apply-templates>
        </xliff>
    </xsl:template>
    <xsl:template match="*">
        <xsl:copy-of select="."/>
        <xsl:text>&#xA;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>



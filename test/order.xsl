<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="urn:oasis:names:tc:xliff:document:2.0" 
   xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" >
   <xsl:output omit-xml-declaration="no" indent="yes" method="xml"/>
   <xsl:template match="/">
      <xliff
         xmlns:xs="http://www.w3.org/2001/XMLSchema"
         xmlns:xsd="http://www.w3.org/2001/XMLSchema"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
         xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0">
         <xsl:apply-templates select="*"/>
      </xliff>
   </xsl:template>

   <xsl:template match="*">
     <xsl:choose> 
     <xsl:when test="name()='file'">
       <xsl:copy-of select="."/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
         <xsl:apply-templates select="*">
            <xsl:sort select="@original"/>
         </xsl:apply-templates>        
      </xsl:otherwise>
   </xsl:choose>
   </xsl:template>
</xsl:stylesheet>

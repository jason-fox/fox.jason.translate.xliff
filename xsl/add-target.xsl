<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   version="2.0" 
   exclude-result-prefixes="xs">
   <xsl:param as="xs:string" name="BASE_DIR" />

   <!-- IdentityTransform -->
   <xsl:template match="@* | node()">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()" />
      </xsl:copy>
   </xsl:template>

   <xsl:template match="xliff">
      <xsl:copy>
         <xsl:copy-of select="@*" />
         <xsl:apply-templates />
      </xsl:copy>
   </xsl:template>

   <xsl:template match="segment[@state='initial']">
      <xsl:variable name="target" select="concat(concat(concat($BASE_DIR, '/'), ../@id), '.xml')" />
      <segment state="translated">
         <xsl:apply-templates select="source" />
         <target>
            <xsl:copy-of select="target/@*" />
            <xsl:apply-templates select="document($target)/text/child::node()" />
         </target>
      </segment>
   </xsl:template>

   <xsl:template match="trans-unit[@approved='no']">
      <xsl:variable name="target" select="concat(concat(concat($BASE_DIR, '/'), @id), '.xml')" />
      <trans-unit>
         <xsl:copy-of select="@*" />
         <xsl:apply-templates select="source" />
         <target>
            <xsl:copy-of select="target/@*" />
            <xsl:apply-templates select="document($target)/text/child::node()" />
         </target>
      </trans-unit>
   </xsl:template>
</xsl:stylesheet>


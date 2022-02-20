<?xml version="1.0" encoding="UTF-8"?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" 
   version="2.0">
   <!-- Process DITA block elements and comments -->
   <xsl:template mode="add-format-style" match="*">
      <xsl:message>Unknown:<xsl:value-of select="name()" /></xsl:message>
   </xsl:template>

   <xsl:template mode="add-format-style" match="comment()|text()" />
   <!-- Typographic elements -->
   <xsl:template mode="add-format-style" match="b|i|u|tt|sup|sub">
      <xsl:call-template name="add-name-style" />
   </xsl:template>

   <xsl:template mode="add-format-style" match="option|kwd|var|parmname|synph|oper|delim|sep|apiname|pt">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'code'" />
      </xsl:attribute>
   </xsl:template>

   <xsl:template mode="add-format-style" match="cite|dd|dt|dl|ol|ul|li|p|title|alt|navtitle">
      <xsl:call-template name="add-name-style" />
   </xsl:template>

   <xsl:template mode="add-format-style" match="xref">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'a'" />
      </xsl:attribute>
      <xsl:attribute name="fs:subFs">
         <xsl:value-of select="concat('href,', @href)" />
      </xsl:attribute>
   </xsl:template>

   <xsl:template mode="add-format-style" match="image">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'img'" />
      </xsl:attribute>
      <xsl:attribute name="fs:subFs">
         <xsl:value-of select="concat('src,', @src)" />
      </xsl:attribute>
   </xsl:template>

   <xsl:template mode="add-format-style" match="bodydiv|div|note|section">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'div'" />
      </xsl:attribute>
   </xsl:template>

   <xsl:template mode="add-format-style" match="table|tbody|thead">
      <xsl:call-template name="add-name-style" />
   </xsl:template>

   <xsl:template mode="add-format-style" match="row">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'tr'" />
      </xsl:attribute>
   </xsl:template>

   <xsl:template mode="add-format-style" match="entry">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'td'" />
      </xsl:attribute>
   </xsl:template>

   <xsl:template mode="add-format-style" match="shortdesc">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'p'" />
      </xsl:attribute>
   </xsl:template>

   <!-- Inline body elements are listed here -->
   <xsl:template mode="add-format-style" match="codeph|synph|term|option|fn">
      <xsl:call-template name="add-monospace" />
   </xsl:template>

   <!-- Inline xmlconstruct elements are listed here -->
   <xsl:template mode="add-format-style" match="numcharref|parameterentity|textentity|xmlatt|xmlelement|xmlnsname|xmlpi">
      <xsl:call-template name="add-monospace" />
   </xsl:template>

   <!-- Inline software elements are listed here -->
   <xsl:template mode="add-format-style" match="filepath|msgph|userinput|systemoutput|cmdname|msgnum|varname">
      <xsl:call-template name="add-monospace" />
   </xsl:template>

   <!-- Inline userinteface elements are listed here -->
   <xsl:template mode="add-format-style" match="uicontrol|menucascade|wintitle">
      <xsl:call-template name="add-monospace" />
   </xsl:template>

   <!-- Inline programming elements are listed here -->
   <xsl:template mode="add-format-style" match="parmname|apiname">
      <xsl:call-template name="add-monospace" />
   </xsl:template>

   <xsl:template name="add-monospace">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="'code'" />
      </xsl:attribute>
   </xsl:template>

   <xsl:template name="add-name-style">
      <xsl:attribute name="fs:fs">
         <xsl:value-of select="name()" />
      </xsl:attribute>
   </xsl:template>
</xsl:stylesheet>
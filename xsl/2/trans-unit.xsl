<?xml version="1.0" encoding="UTF-8" ?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet  version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dita="dita-ot.org">
	<xsl:output omit-xml-declaration="yes" indent="no"  method="xml"/>

	<xsl:template match="/">		
      <xsl:apply-templates select="@* | node()" />
	</xsl:template>

  <xsl:template match="mrk">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="pc">
    <xsl:value-of select="concat(concat('---',@dataRefStart), '---')"/>
    <xsl:apply-templates/>
    <xsl:value-of select="concat(concat('---',@dataRefEnd), '---')"/>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
  </xsl:template>

</xsl:stylesheet>
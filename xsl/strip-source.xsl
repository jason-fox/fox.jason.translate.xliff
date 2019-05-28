<?xml version="1.0" encoding="UTF-8" ?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet  version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dita="dita-ot.org">
	<xsl:output omit-xml-declaration="yes" indent="no"  method="xml"/>

	<xsl:template match="/">
		<xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
	</xsl:template>


	<xsl:template match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()"/>
      </xsl:copy>
   </xsl:template>

   <xsl:template match="source">
   		<xsl:apply-templates/>
   </xsl:template>

   <xsl:template match="target">
      <xsl:apply-templates/>
   </xsl:template>
</xsl:stylesheet>
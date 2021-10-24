<?xml version="1.0" encoding="UTF-8"?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  version="2.0"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dita="dita-ot.org"
>
	<xsl:output omit-xml-declaration="yes" indent="no" method="text"/>

	<xsl:template match="@*|node()">
	  <xsl:copy>
		 <xsl:apply-templates select="@* | node()"/>
	  </xsl:copy>
	</xsl:template>

	<xsl:template match="//unit">
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="count" select="count(preceding-sibling::unit[@id=$id])"/>
		 <xsl:variable name="count2" select="count(../preceding-sibling::file/unit[@id=$id])"/>
		<xsl:if test="$count=0 and $count2=0">
			<xsl:result-document method="xml" href="{@id}.xml">
				<unit>
					<xsl:apply-templates/>
				</unit>
			</xsl:result-document>
		</xsl:if>
	</xsl:template>

	<xsl:template match="//trans-unit">
		<xsl:variable name="id" select="@id"/>
		<xsl:variable name="count" select="count(preceding-sibling::trans-unit[@id=$id])"/>
		<xsl:variable name="count2" select="count(../../preceding-sibling::file/body/trans-unit[@id=$id])"/>
		<xsl:if test="$count=0 and $count2=0">
		 	<xsl:result-document method="xml" href="{@id}.xml">
				<xsl:apply-templates select="./target"/>
			</xsl:result-document>
	 	</xsl:if>
	</xsl:template>
</xsl:stylesheet>

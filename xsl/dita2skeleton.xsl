<?xml version="1.0" encoding="UTF-8" ?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="2.0">

	<xsl:output method="xml" indent="yes"/>
	 <!-- IdentityTransform -->
	 <xsl:template match="/ | @* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	 </xsl:template>

	 <xsl:template match="*[@md5]">
			<xsl:element name="{local-name()}">
			<!-- process attributes -->
			<xsl:for-each select="@*">
				<!-- remove attribute prefix -->
				<xsl:variable name="attr" select="local-name()"/>
				<xsl:if test="local-name()!='md5'">
					<xsl:attribute name="{local-name()}">
						<xsl:value-of select="."/>
					</xsl:attribute>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>@@@</xsl:text>
			<xsl:value-of select="@md5"/>
			<xsl:text>@@@</xsl:text>
		</xsl:element>
			
	 </xsl:template>


</xsl:stylesheet>

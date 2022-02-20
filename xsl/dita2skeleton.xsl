<?xml version="1.0" encoding="UTF-8"?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0"
>

	<xsl:param as="xs:string" name="TARGET_LANG" select="'es'"/>
	<xsl:output method="xml" indent="yes"/>

	<!-- Amend xml:lang -->
	
	 <xsl:template match="/*">
	 	<xsl:element name="{name()}">
			<xsl:for-each select="@*">
				<xsl:variable name="attr" select="local-name()"/>
				<xsl:choose>
					<xsl:when test="$attr='DITAArchVersion'"/>
					<xsl:when test="$attr='domains'"/>
					<xsl:when test="$attr='class'"/>
					<xsl:when test="$attr='lang'"/>
					<xsl:otherwise>
						<xsl:attribute name="{local-name()}">
							<xsl:value-of select="."/>
						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:attribute name="xml:lang">
				<xsl:value-of select="$TARGET_LANG"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
		
	 </xsl:template>

	<!-- IdentityTransform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="*[@md5 and @md5!='0']">
		<xsl:choose>
			<xsl:when test="@translate='no'">
				<xsl:apply-templates select="child::node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="{local-name()}">
					<!-- process attributes -->
					<xsl:for-each select="@*">
						<!-- remove attribute prefix -->
						<xsl:variable name="attr" select="local-name()"/>
						<xsl:choose>
							<xsl:when test="$attr='md5'"/>
							<xsl:when test="$attr='class'"/>
							<xsl:otherwise>
								<xsl:attribute name="{local-name()}">
									<xsl:value-of select="."/>
								</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<xsl:text>@@@</xsl:text>
					<xsl:value-of select="@md5"/>
					<xsl:text>@@@</xsl:text>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[@md5='0']">
		<xsl:apply-templates select="child::node()"/>
	</xsl:template>


</xsl:stylesheet>

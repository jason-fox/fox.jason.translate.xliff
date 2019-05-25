<?xml version="1.0" encoding="UTF-8" ?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet  version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dita="dita-ot.org">

	<xsl:param as="xs:string" name="SOURCE" select="''"/>
	<xsl:param as="xs:string" name="SOURCE_LANG" select="'en'"/>
	<xsl:param as="xs:string" name="TARGET_LANG" select="'es'"/>
	

	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>


	<xsl:variable name="SOURCEPATH" select="replace($SOURCE, '\\', '/')"/>
	<xsl:variable name="document-uri">
		<xsl:value-of select="replace(replace(document-uri(/), $SOURCEPATH, ''), 'file:', '')"/>
	</xsl:variable>


	<xsl:template match="/">
		<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dita="http://www.dita-ot.org" xsi:schemaLocation="urn:oasis:names:tc:xliff:document:1.2 xliff-core-1.2.xsd">
			<file datatype="xml" >
				<xsl:attribute name="source-language">
					<xsl:value-of select="$SOURCE_LANG"/>
				</xsl:attribute>
				<xsl:attribute name="target-language">
					<xsl:value-of select="$TARGET_LANG"/>
				</xsl:attribute>
				<xsl:attribute name="original">
					<xsl:value-of select="substring($document-uri, 1, string-length($document-uri) - 4)"/>
				</xsl:attribute>
				<header>
					 <skl>
						<external-file>
							<xsl:attribute name="href">
								<xsl:value-of select="concat('./skl', concat(substring($document-uri, 1, string-length($document-uri) - 4), '.skl'))"/>
							</xsl:attribute>
						</external-file>
					 </skl>
				</header>
				<body>
					<xsl:apply-templates select="//*[@md5]"/>
				</body>
				</file>
			</xliff>
		</xsl:template>

	 <xsl:template match="*[@md5]">
		<trans-unit>
			<xsl:attribute name="approved">
				<xsl:text>no</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="id">
				<xsl:value-of select="@md5"/>
			</xsl:attribute>
			<xsl:attribute name="xml:space">
				<xsl:text>preserve</xsl:text>
			</xsl:attribute>
			<source>
				<xsl:attribute name="xml:lang">
					<xsl:value-of select="$SOURCE_LANG"/>
				</xsl:attribute>
				<xsl:for-each select="*">
					<xsl:apply-templates mode="trans-source"/>
				</xsl:for-each>
			</source>
			<target>
				<xsl:attribute name="xml:lang">
					<xsl:value-of select="$TARGET_LANG"/>
				</xsl:attribute>
			</target>
		</trans-unit>
		
	 </xsl:template>



	<xsl:template match="@*" mode="trans-source">
		<xsl:copy>
				<xsl:apply-templates select="@* | node()" mode="trans-source" />
		</xsl:copy>
	 </xsl:template>

	 <xsl:template name="add-attributes">
		<xsl:attribute name="id">
			<xsl:value-of select="generate-id()"/> 
		</xsl:attribute>
		<xsl:attribute name="ctype">
			<xsl:text>x-dita-</xsl:text><xsl:value-of select="local-name()"/>
		</xsl:attribute>
		<xsl:for-each select="@*">
			<xsl:choose>
				<xsl:when test="namespace-uri()=''">
					<xsl:variable name="name" select="concat('dita:', name())"/>
					<xsl:attribute name="{$name}">
						<xsl:value-of select="."/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:variable name="name" select="name()"/>
					<xsl:attribute name="{$name}">
						<xsl:value-of select="."/>
					</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		
		</xsl:for-each>
	 </xsl:template>

		<xsl:template match="*" mode="trans-source">
			<xsl:choose>
				<xsl:when test="*">
					<xsl:element name="g" >
						<xsl:call-template name="add-attributes"/>
						<xsl:apply-templates select="node()" mode="trans-source" />
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="x" >
						<xsl:call-template name="add-attributes"/>
						<xsl:apply-templates select="node()" mode="trans-source" />
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
	 </xsl:template>

		<xsl:template match="text()" mode="trans-source">
			<xsl:value-of select="normalize-space(.)"/><xsl:text> </xsl:text>
	 </xsl:template>
</xsl:stylesheet>


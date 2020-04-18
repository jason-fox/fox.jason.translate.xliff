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
	<xsl:preserve-space elements="*" />
	<xsl:include href="../../Customization/xsl/no-translate-elements.xsl"/>


	<xsl:variable name="SOURCEPATH" select="replace($SOURCE, '\\', '/')"/>
	<xsl:variable name="document-uri">
		<xsl:value-of select="replace(replace(document-uri(/), $SOURCEPATH, ''), 'file:', '')"/>
	</xsl:variable>


	<xsl:template match="/">
		<xliff version="2.1" xmlns="urn:oasis:names:tc:xliff:document:2.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dita="http://www.dita-ot.org" xsi:schemaLocation="urn:oasis:names:tc:xliff:document:2.1 xliff-core-2.1.xsd">
			<file>	
				<xsl:attribute name="original">
					<xsl:value-of select="substring($document-uri, 1, string-length($document-uri) - 4)"/>
				</xsl:attribute>

				<skeleton>
					<xsl:attribute name="href">
						<xsl:value-of select="concat('./skl', concat(substring($document-uri, 1, string-length($document-uri) - 4), '.skl'))"/>
					</xsl:attribute>
				</skeleton>
				<xsl:apply-templates select="//*[@md5]"/>
			</file>
		</xliff>
	</xsl:template>

	 <xsl:template match="*[@md5]">
		<unit>
			<xsl:attribute name="id">
				<xsl:value-of select="@md5"/>
			</xsl:attribute>

			<xsl:if test="count(*/*) &gt; 0">
				<originalData>
					<xsl:apply-templates mode="original-data" select="*/*" />
				</originalData>
			</xsl:if>



	 		<segment>
				<xsl:attribute name="state">
					<xsl:choose>
						<xsl:when test="@translate='no'">
							<xsl:text>final</xsl:text>
			 			</xsl:when>
			 			<xsl:otherwise>
							<xsl:text>initial</xsl:text>
			 			</xsl:otherwise>
		 			</xsl:choose>
				</xsl:attribute>
				<source>
					<xsl:attribute name="xml:space">
						<xsl:text>preserve</xsl:text>
					</xsl:attribute>
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
					<xsl:if test="@translate='no'">
						<xsl:apply-templates mode="trans-source"/>
					</xsl:if>
				</target>
			</segment>
		</unit>
		
	 </xsl:template>

	 <xsl:template name="add-attributes">
	 	<xsl:attribute name="id">
			<xsl:value-of select="generate-id()"/> 
		</xsl:attribute>

		<xsl:attribute name="dataRefStart">
			<xsl:value-of select="concat('s',generate-id())"/> 
		</xsl:attribute>
		<xsl:attribute name="dataRefEnd">
			<xsl:value-of select="concat('e',generate-id())"/> 
		</xsl:attribute>		
	 </xsl:template>

	<xsl:template match="*" mode="trans-source">
		<xsl:element name="pc" >
			<xsl:call-template name="add-attributes"/>

			<xsl:choose>
				<xsl:when test="not(@translate)">
					<mrk translate="no" type="term">
						<xsl:attribute name="id">
							<xsl:value-of select="concat('m',generate-id())"/> 
						</xsl:attribute>
						<xsl:apply-templates select="node()" mode="trans-source" />
					</mrk>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="node()" mode="trans-source" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
			
	</xsl:template>

	<xsl:template match="text()" mode="trans-source">
		<xsl:variable name="text" select="."/>
		<xsl:if test="starts-with($text, ' ')">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:value-of select="normalize-space($text)"/>
		<xsl:if test="ends-with($text, ' ')">
			<xsl:text> </xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template name="add-no-translate-attr">
		<xsl:attribute name="translate">
			<xsl:text>no</xsl:text>
		</xsl:attribute>
	</xsl:template>



	<xsl:template match="*" mode="original-data">
		<data>
			<xsl:attribute name="id">
				<xsl:value-of select="concat('s',generate-id())"/> 
			</xsl:attribute>
			<xsl:value-of select="concat('&lt;',name())"/>
			<xsl:for-each select="@*">
				<xsl:value-of select="concat(' ', concat(name(), '=&quot;'))"/>
				<xsl:value-of select="concat(.,'&quot;')"/>
			</xsl:for-each>
			<xsl:text>></xsl:text>
		</data>

		<data>
			<xsl:attribute name="id">
				<xsl:value-of select="concat('e',generate-id())"/> 
			</xsl:attribute>
			<xsl:value-of select="concat(concat('&lt;/',name()), '>')"/>
		</data>
   		<xsl:apply-templates mode="original-data"/>
	</xsl:template>

	<xsl:template match="text()" mode="original-data"/>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8" ?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet exclude-result-prefixes="xs xsi" version="2.0" 
	xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param as="xs:string" name="SOURCE" select="''"/>
	<xsl:param as="xs:string" name="SOURCE_LANG" select="'en'"/>
	<xsl:param as="xs:string" name="TARGET_LANG" select="'es'"/>
	<xsl:param as="xs:string" name="TRANS_CACHE" select="''"/>
	

	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	<xsl:preserve-space elements="*" />
	<xsl:include href="../../Customization/xsl/no-translate-elements.xsl"/>
	<xsl:include href="../../Customization/xsl/add-format-style.xsl"/>


	<xsl:variable name="SOURCEPATH" select="replace($SOURCE, '\\', '/')"/>
	<xsl:variable name="document-uri">
		<xsl:value-of select="replace(replace(document-uri(/), $SOURCEPATH, ''), 'file:', '')"/>
	</xsl:variable>
	<xsl:variable name="cache-doc" select="document($TRANS_CACHE)"/>

	<xsl:template match="/">
		<xliff version="2.1" xmlns="urn:oasis:names:tc:xliff:document:2.0">
			<file xmlns="urn:oasis:names:tc:xliff:document:2.0">
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

	 <xsl:template match="*[@md5 and @md5!='0']">
		<unit>
			<xsl:namespace name="fs" select="'urn:oasis:names:tc:xliff:fs:2.0'"/>
			<xsl:variable name="id">
				<xsl:value-of select="@md5"/>
			</xsl:variable>
			<xsl:attribute name="id">
				<xsl:value-of select="$id"/>
			</xsl:attribute>

			<xsl:apply-templates mode="add-format-style"/>
	
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
			 			<xsl:when test="$cache-doc//*:unit[@id=$id]/*:segment[@state='final']">
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
					<xsl:choose>
						<xsl:when test="@translate='no'">
							<xsl:apply-templates mode="trans-source"/>
						</xsl:when>
						<xsl:when test="$cache-doc//*:unit[@id=$id]/*:segment[@state='final']">
							<xsl:apply-templates select="$cache-doc//*:unit[@id=$id]/*:segment[@state='final']/*:target/child::node()" mode="identity"/>
						</xsl:when>
					</xsl:choose>
				</target>
			</segment>
		</unit>
		
	 </xsl:template>

	 <xsl:template match="*[@md5='0']"/>

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
			<xsl:apply-templates select="." mode="add-format-style"/>
			<xsl:apply-templates select="." mode="add-no-translate-mark"/>
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
				<xsl:variable name="attr" select="local-name()"/>
				<xsl:choose>
					<xsl:when test="$attr='class'"/>
					<xsl:otherwise>
						<xsl:value-of select="concat(' ', concat(name(), '=&quot;'))"/>
						<xsl:value-of select="concat(.,'&quot;')"/>
					</xsl:otherwise>
				</xsl:choose>
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

	<xsl:template match="@* | node()" mode="identity">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" mode="identity" />
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>

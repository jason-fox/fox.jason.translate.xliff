<?xml version="1.0" encoding="utf-8"?>
<!--
	This file is part of the DITA-OT Translate Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
	<!-- Process DITA block elements and comments -->
	<xsl:template mode="no-translate" match="*|comment()|text()"/>

	<!-- draft-comment and required-cleanup should never be translated -->
	<xsl:template mode="no-translate" match="draft-comment|required-cleanup">
		<xsl:call-template name="add-no-translate-attr"/>
	</xsl:template>

	<!-- Inline body elements are listed here -->
	<xsl:template mode="no-translate" match="codeph|synph|term|option|fn">
		<xsl:call-template name="add-no-translate-attr"/>
	</xsl:template>
	<!-- Inline xmlconstruct elements are listed here -->
	<xsl:template mode="no-translate" match="numcharref|parameterentity|textentity|xmlatt|xmlelement|xmlnsname|xmlpi">
		<xsl:call-template name="add-no-translate-attr"/>
	</xsl:template>
	<!-- Inline software elements are listed here -->
	<xsl:template mode="no-translate" match="filepath|msgph|userinput|systemoutput|cmdname|msgnum|varname">
		<xsl:call-template name="add-no-translate-attr"/>
	</xsl:template>
	<!-- Inline userinteface elements are listed here -->
	<xsl:template mode="no-translate" match="uicontrol|menucascade|wintitle">
		<xsl:call-template name="add-no-translate-attr"/>
	</xsl:template>
	<!-- Inline programming elements are listed here -->
	<xsl:template mode="no-translate" match="parmname|apiname">
		<xsl:call-template name="add-no-translate-attr"/>
	</xsl:template>


</xsl:stylesheet>
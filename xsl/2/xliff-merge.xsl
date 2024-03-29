<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA Translate project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns="urn:oasis:names:tc:xliff:document:2.0" 
   xmlns:fs="urn:oasis:names:tc:xliff:fs:2.0" 
   xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
   exclude-result-prefixes="xs xsi" 
   version="2.0" 
   xsi:schemaLocation="urn:oasis:names:tc:xliff:document:2.0 xliff-core-2.0.xsd">

   <!-- Defining that this .xsl generates an indented, UTF8-encoded XML file -->
   <xsl:output encoding="utf-8" indent="yes" method="xml" omit-xml-declaration="no" standalone="yes" />

   <xsl:param name="in">.</xsl:param>
   <xsl:param name="extension">xlf.xml</xsl:param>
   <xsl:param name="out">translate.xlf</xsl:param>
   <xsl:param as="xs:string" name="SOURCE_LANG" select="'en'" />
   <xsl:param as="xs:string" name="TARGET_LANG" select="'es'" />
   <!--
		XSLT engine only accept file path that start with 'file:/'

		In the code below we ensure that $in parameter that hold input path to
		where the *.xlf files file which have to be merge into single .xlf file
		is in a format
	-->
   <xsl:variable name="path">
      <xsl:choose>
         <xsl:when test="not(starts-with($in,'file:')) and not(starts-with($in,'/')) ">
            <xsl:value-of select="translate(concat('file:/', $in ,'?select=*.', $extension ,';recurse=yes;on-error=warning'), '\', '/')" />
         </xsl:when>
         <xsl:when test="starts-with($in,'/')">
            <xsl:value-of select="translate(concat('file:', $in ,'?select=*.', $extension ,';recurse=yes;on-error=warning'), '\', '/')" />
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="translate(concat($in ,'?select=*.', $extension ,';recurse=yes;on-error=warning'), '\', '/')" />
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <!-- Template to once execute generate-xliff template -->
   <xsl:template match="/">
      <xsl:call-template name="generate-xliff" />
   </xsl:template>

   <!--
		Template that generates the single .xlf file by copying contents
		of all .xlf files found in directory specified by $path
	-->
   <xsl:template name="generate-xliff">
      <xsl:element name="xliff">
         <xsl:attribute name="srcLang">
            <xsl:value-of select="$SOURCE_LANG" />
         </xsl:attribute>
         <xsl:attribute name="trgLang">
            <xsl:value-of select="$TARGET_LANG" />
         </xsl:attribute>
         <xsl:attribute name="version">
            <xsl:value-of select="'2.0'" />
         </xsl:attribute>
         <xsl:namespace name="fs" select="'urn:oasis:names:tc:xliff:fs:2.0'" />
         <!-- xsl:copy-of select="@*" is the standard way of copying all attributes. -->
         <xsl:copy-of select="@*" />


         <!-- copies nodes and all their descendants -->
         <xsl:merge>
           <xsl:merge-source for-each-item="collection($path)/*/*" select="." >
               <xsl:merge-key select="@id" order="ascending" />
           </xsl:merge-source>
           <xsl:merge-action>
               <xsl:for-each select="current-merge-group()">
                  <xsl:if test="count(//unit) &gt; 0">
                     <xsl:element name="file">
                        <xsl:attribute name="id" select="position()" />
                        <xsl:for-each select="@*">
                           <xsl:variable name="name" select="name()" />
                           <xsl:attribute name="{$name}">
                              <xsl:value-of select="." />
                           </xsl:attribute>
                        </xsl:for-each>
                        <xsl:apply-templates mode="file" />
                     </xsl:element>
                  </xsl:if>
               </xsl:for-each>
           </xsl:merge-action>
         </xsl:merge>

      </xsl:element>
   </xsl:template>

   <!-- IdentityTransform -->
   <xsl:template match="node()|@*" mode="file">
      <xsl:copy>
         <xsl:apply-templates select="node()|@*" mode="file" />
      </xsl:copy>
   </xsl:template>

</xsl:stylesheet>
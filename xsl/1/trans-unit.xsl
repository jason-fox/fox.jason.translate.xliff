<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA-OT Translate Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:dita="dita-ot.org" 
   xmlns:xs="http://www.w3.org/2001/XMLSchema" 
   version="2.0">

   <!-- Defining that this .xsl generates an XML file -->
   <xsl:output omit-xml-declaration="yes" indent="no" method="xml" />

   <xsl:template match="/">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()" />
      </xsl:copy>
   </xsl:template>

   <xsl:template match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()" />
      </xsl:copy>
   </xsl:template>

   <xsl:template match="source">
      <xsl:apply-templates />
   </xsl:template>

   <xsl:template match="target">
      <xsl:apply-templates />
   </xsl:template>

   <xsl:template match="x|g">
      <xsl:element name="{substring-after(@ctype, 'x-dita-')}">
         <!-- process attributes -->
         <xsl:for-each select="@*">
            <!-- remove attribute prefix -->
            <xsl:choose>
               <xsl:when test="name()='id'" />
               <xsl:when test="name()='ctype'" />
               <xsl:when test="starts-with(name(),'dita')">
                  <xsl:attribute name="{local-name()}">
                     <xsl:value-of select="." />
                  </xsl:attribute>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:attribute name="{name()}">
                     <xsl:value-of select="." />
                  </xsl:attribute>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:for-each>
         <xsl:apply-templates />
      </xsl:element>
   </xsl:template>

   <xsl:template match="text()">
      <xsl:value-of select="normalize-space(.)" />
      <xsl:text> </xsl:text>
   </xsl:template>
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8" ?>
<!--
  This file is part of the DITA-OT Translate Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
     xmlns:foo="http://www.foo.org/"
    exclude-result-prefixes="xs dita-ot"
    version="2.0">

    <xsl:function name="foo:checksum" as="xs:int">
      <xsl:param name="str" as="xs:string"/>
      <xsl:variable name="codepoints" select="string-to-codepoints($str)"/>
      <xsl:value-of select="foo:fletcher16($codepoints, count($codepoints), 1, 0, 0)"/>
    </xsl:function>

    <!-- can I change some xs:integers to xs:int and help performance? -->
    <xsl:function name="foo:fletcher16">
      <xsl:param name="str" as="xs:integer*"/>
      <xsl:param name="len" as="xs:integer" />
      <xsl:param name="index" as="xs:integer" />
      <xsl:param name="sum1" as="xs:integer" />
      <xsl:param name="sum2" as="xs:integer"/>
      <xsl:choose>
        <xsl:when test="$index gt $len">
          <xsl:sequence select="$sum2 * 256 + $sum1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="newSum1" as="xs:integer"
                    select="($sum1 + $str[$index]) mod 255"/>
          <xsl:sequence select="foo:fletcher16($str, $len, $index + 1, $newSum1,
                        ($sum2 + $newSum1) mod 255)" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:function>


   
    <xsl:template match="*" mode="path">
      <xsl:value-of select="concat('/',name())"/>
      <xsl:variable name="vnumPrecSiblings" select=
         "count(preceding-sibling::*[name()=name(current())])"/>
      <xsl:if test="$vnumPrecSiblings">
          <xsl:value-of select="concat('[', $vnumPrecSiblings +1, ']')"/>
      </xsl:if>
    </xsl:template>



  <!-- IdentityTransform -->
  <xsl:template match="/ | @* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>

   <xsl:template match="note|shortdesc|abstract|title|p|li|entry">
      <xsl:element name="{local-name()}">
        <xsl:attribute name="md5">
          <xsl:value-of select="foo:checksum(normalize-space(.))"/>
        </xsl:attribute>
      <!-- process attributes -->
      <xsl:for-each select="@*">
        <!-- remove attribute prefix -->
        <xsl:attribute name="{local-name()}">
          <xsl:value-of select="."/>
        </xsl:attribute>
      </xsl:for-each>
      <xsl:apply-templates select="." mode="copy"/>
    </xsl:element>
      
   </xsl:template>

  <xsl:template match="/ | @* | node()" mode="copy">
      <xsl:copy>
         <xsl:apply-templates select="@* | node()" mode="copy" />
      </xsl:copy>
   </xsl:template>

</xsl:stylesheet>

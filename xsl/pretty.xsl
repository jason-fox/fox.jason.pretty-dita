<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
<!--
   This file is part of the DITA-OT Pretty DITA Plug-in project.
   See the accompanying LICENSE file for applicable licenses.
-->

<xsl:param as="xs:integer" name="INDENT" select="4"/>
<xsl:param as="xs:string" name="STYLE" select="spaces"/>

<xsl:variable name="indentSpaces">
   <xsl:choose> 
       <xsl:when test="$STYLE='tabs'">
         <xsl:text>&#x9;&#x9;&#x9;&#x9;&#x9;&#x9;</xsl:text>
       </xsl:when>
       <xsl:otherwise>
         <xsl:text>&#32;&#32;&#32;&#32;&#32;&#32;</xsl:text>
      </xsl:otherwise>
   </xsl:choose>
</xsl:variable>

<xsl:variable name="newline">
<xsl:text>
</xsl:text>
</xsl:variable>

   <!-- Take control of the whitespace. -->
   <xsl:output method="xml" indent="no" encoding="UTF-8"/>
   <xsl:strip-space elements="*"/>
   <xsl:preserve-space elements="xsl:text"/>

   <xsl:template match="*|comment()">

      <xsl:param name="depth">0</xsl:param>
      <!--
         Set off from the element above if one of the two has children.
         Also, set off a comment from an element.
         And set off from the XML declaration if necessary.
      -->
      <xsl:variable name="isFirstNode" select="count(../..) = 0 and position() = 1"/>
      <xsl:variable name="previous" select="preceding-sibling::node()[1]"/>
      <xsl:variable name="adjacentComplexElement" select="count($previous/*) &gt; 0 or count(*) &gt; 0"/>
      <xsl:variable name="adjacentDifferentType" select="not(($previous/self::comment() and self::comment()) or ($previous/self::* and self::*))"/>
      <xsl:value-of select="$newline"/>

      <xsl:call-template name="indent">
         <xsl:with-param name="depth" select="$depth"/>
      </xsl:call-template>

      <xsl:copy>

         <xsl:choose>
            <!-- Block elements requiring a new line are listed here -->
            <xsl:when test="self::p|self::shortdesc|self::li|self::note">
               <xsl:value-of select="$newline"/>
               <xsl:copy-of select="@*"/>
               <xsl:apply-templates>
                  <xsl:with-param name="depth" select="$depth + 1"/>
               </xsl:apply-templates>
               <xsl:value-of select="$newline"/>

               <xsl:call-template name="indent">
                  <xsl:with-param name="depth" select="$depth"/>
               </xsl:call-template>
            </xsl:when>


            <xsl:when test="self::*">
               <!-- Basic block elements are processed here -->
               <xsl:copy-of select="@*"/>
               <xsl:apply-templates>
                  <xsl:with-param name="depth" select="$depth + 1"/>
               </xsl:apply-templates>

               <xsl:if test="count(*) &gt; 0">
                  <xsl:value-of select="$newline"/>

                  <xsl:call-template name="indent">
                     <xsl:with-param name="depth" select="$depth"/>
                  </xsl:call-template>
               </xsl:if>
            </xsl:when>
         </xsl:choose>
      </xsl:copy>

      <xsl:variable name="isLastNode" select="count(../..) = 0 and position() = last()"/>
      <xsl:if test="$isLastNode">
         <xsl:value-of select="$newline"/>
      </xsl:if>
   </xsl:template>

   <!-- Inline elements are listed here -->
   <xsl:template match="b|i|sup|sub|codeph|xref|xmlatt|xmlelement|ph">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates />
        </xsl:copy>
   </xsl:template>


   <xsl:template name="indent">
      <xsl:param name="depth"/>
      <xsl:if test="$depth &gt; 0">
         <xsl:value-of select="substring($indentSpaces,1,$INDENT)"/>
         <xsl:call-template name="indent">
            <xsl:with-param name="depth" select="$depth - 1"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>



   <!-- Escape newlines within text nodes, for readability. -->

   <xsl:template match="text()">
      <xsl:call-template name="escapeNewlines">
         <xsl:with-param name="text">
            <xsl:value-of select="."/>
         </xsl:with-param>
      </xsl:call-template>
   </xsl:template>



   <xsl:template name="escapeNewlines">

      <xsl:param name="text"/>
      <xsl:if test="string-length($text) &gt; 0">
         <xsl:choose>
            <xsl:when test="substring($text, 1, 1) = '&#xA;'">
               <xsl:value-of select="$newline"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="substring($text, 1, 1)"/>
            </xsl:otherwise>
         </xsl:choose>

         <xsl:call-template name="escapeNewlines">
            <xsl:with-param name="text" select="substring($text, 2)"/>
         </xsl:call-template>
      </xsl:if>

   </xsl:template>

</xsl:stylesheet>
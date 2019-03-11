<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">


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
         <xsl:if test="self::*">
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
         </xsl:if>
      </xsl:copy>

      <xsl:variable name="isLastNode" select="count(../..) = 0 and position() = last()"/>
      <xsl:if test="$isLastNode">
         <xsl:value-of select="$newline"/>
      </xsl:if>
   </xsl:template>

    <xsl:template match="b|i|sup|sub|codeph|xref">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>



   <xsl:template name="indent">
      <xsl:param name="depth"/>
      <xsl:if test="$depth &gt; 0">
         <xsl:text>   </xsl:text>
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
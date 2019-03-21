<?xml version="1.0" encoding="utf-8"?>
<!--
	This file is part of the DITA-OT Pretty DITA Plug-in project.
	See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	
	<!-- Process DITA block elements and comments -->
	<xsl:template match="*|comment()">
		<xsl:param name="depth">0</xsl:param>
		<!--
			Offset from the previous element if one of the two has children.
			Also, set off a comment from an element.
			And also offset from the XML declaration if necessary.
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
					<xsl:call-template name="indented-block">
						<xsl:with-param name="depth" select="$depth"/>
					</xsl:call-template>
				</xsl:when>

				<!-- All other block elements are processed here -->
				<xsl:when test="self::*">
					<xsl:call-template name="basic-block">
						<xsl:with-param name="depth" select="$depth"/>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:copy>

		<xsl:variable name="isLastNode" select="count(../..) = 0 and position() = last()"/>
		<xsl:if test="$isLastNode">
			<xsl:value-of select="$newline"/>
		</xsl:if>
	</xsl:template>


	<!-- Inline elements are listed here -->
	<xsl:template match="ph|codeph|synph|filepath|msgph|userinput|systemoutput|b|u|i|tt|sup|sub|uicontrol|menucascade|term|xref|cite|q|boolean|state|keyword|option|parmname|apiname|cmdname|msgnum|varname|wintitle|tm|fn|indextermref|indexterm">
		<xsl:call-template name="inline-element"/>
	</xsl:template>


	<!-- Escape newlines within text nodes, for readability. -->
	<xsl:template match="text()">
	  <xsl:call-template name="escapeNewlines">
		<xsl:with-param name="text">
		<xsl:value-of select="."/>
	    	</xsl:with-param>
	  </xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
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
			<xsl:copy-of select="@*[not(name()='class' or name()='domains' or  local-name()='DITAArchVersion' or local-name()='space' or name()='xmlns:ditaarch')]"/>
			<xsl:choose>
				<!-- Basic topic elements requiring a new line are listed here -->
				<xsl:when test="self::abstract|self::shortdesc">
					<xsl:call-template name="indented-block">
						<xsl:with-param name="depth" select="$depth"/>
					</xsl:call-template>
				</xsl:when>
				<!-- Basic body elements requiring a new line are listed here -->
				<xsl:when test="self::p|self::p|self::li|self::note|self::lq">
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


	<!-- Inline body elements are listed here -->
	<xsl:template match="ph|codeph|synph|term|xref|cite|q|boolean|state|keyword|option|tm|fn|xref|text">
		<xsl:call-template name="inline-element"/>
	</xsl:template>
	<!-- Inline xmlconstruct elements are listed here -->
	<xsl:template match="numcharref|parameterentity|textentity|xmlatt|xmlelement|xmlnsname|xmlpi">
		<xsl:call-template name="inline-element"/>
	</xsl:template>
	<!-- Inline typographic elements are listed here -->
	<xsl:template match="b|i|sup|sub|tt|u|line-through|overline">
		<xsl:call-template name="inline-element"/>
	</xsl:template>
	<!-- Inline software elements are listed here -->
	<xsl:template match="filepath|msgph|userinput|systemoutput|cmdname|msgnum|varname">
		<xsl:call-template name="inline-element"/>
	</xsl:template>
	<!-- Inline userinteface elements are listed here -->
	<xsl:template match="uicontrol|menucascade|wintitle">
		<xsl:call-template name="inline-element"/>
	</xsl:template>
	<!-- Inline programming elements are listed here -->
	<xsl:template match="parmname|apiname|coderef">
		<xsl:call-template name="inline-element"/>
	</xsl:template>
	<!-- Inline glossary related elements are listed here -->
	<xsl:template match="abbreviated-form">
		<xsl:call-template name="inline-element"/>
	</xsl:template>
	<!-- Inline markup domain elements are listed here -->
	<xsl:template match="markupname">
		<xsl:call-template name="inline-element"/>
	</xsl:template>

	<!-- Escape newlines within text nodes, for readability. -->
	<xsl:template match="text()">
		<xsl:variable name="text">
			<xsl:choose>
				<xsl:when test="ancestor::codeblock|ancestor::lines|ancestor::msgblock|ancestor::pre">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:when test="./following-sibling::*">
					<xsl:value-of select="replace(., '\s+$', ' ')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>  	
		<xsl:call-template name="escapeNewlines">
			<xsl:with-param name="text">
				<xsl:value-of select="$text"/>	
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
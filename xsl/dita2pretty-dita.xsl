<?xml version="1.0" encoding="utf-8"?>
<!--
		This file is part of the DITA-OT Pretty DITA Plug-in project.
		See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
	

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
	<xsl:include href="../Customization/xsl/prettier-rules.xsl"/>
	<xsl:strip-space elements="*"/>
	<xsl:preserve-space elements="xsl:text"/>

	<!-- 
		Block DITA elements without a newline are processed here 
		e.g. <title> and <codeblock> elements
	-->
	<xsl:template name="basic-block">
		<xsl:param name="depth">0</xsl:param>
		
		<xsl:apply-templates>
			<xsl:with-param name="depth" select="$depth + 1"/>
		</xsl:apply-templates>

		<xsl:if test="count(*) &gt; 0">
			<xsl:value-of select="$newline"/>

			<xsl:call-template name="indent">
				<xsl:with-param name="depth" select="$depth"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<!-- 
		Block DITA elements with a newline are processed here 
		e.g. <p> and <li> elements
	-->
	<xsl:template name="indented-block">
		<xsl:param name="depth">0</xsl:param>
		<xsl:value-of select="$newline"/>
		<xsl:apply-templates>
			<xsl:with-param name="depth" select="$depth + 1"/>
		</xsl:apply-templates>
		<xsl:value-of select="$newline"/>

		<xsl:call-template name="indent">
			<xsl:with-param name="depth" select="$depth"/>
		</xsl:call-template>
	</xsl:template>


	<!--
		Add whitespace to an appropriate depth
	-->
	<xsl:template name="indent">
		<xsl:param name="depth"/>
		<xsl:if test="$depth &gt; 0">
			<xsl:value-of select="substring($indentSpaces,1,$INDENT)"/>
			<xsl:call-template name="indent">
				<xsl:with-param name="depth" select="$depth - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>


	<!-- Inline DITA elements are processed here -->
	<xsl:template name="inline-element">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates />
		</xsl:copy>
	</xsl:template>


	<!-- Escape newlines within text nodes, for readability. -->
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
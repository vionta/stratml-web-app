<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
     xmlns:xf="http://www.w3.org/2002/xforms" 
    >
    
    <xsl:param name="doc"/>
    
  
  <xsl:template match="@*">
    <xsl:copy  />
  </xsl:template>
  
  <xsl:template match="node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

	<!-- 
  <xsl:template match="issue[ not(./ps:synchro/ps:actualEndDate/text())]" ></xsl:template>
  
  <xsl:template match="issue[./ps:synchro/ps:actualEndDate/text() and (  $periodStart > number(translate(./ps:synchro/ps:actualEndDate/text(), '-', '')) )  ]">
  </xsl:template>
  
  <xsl:template match="nested[@type='dependency' and datereal/text()]"></xsl:template>
	 -->  

	<xsl:template match="xf:instance[@id='default']">
		 <xf:instance xmlns="" id="default" src="{$doc}" />
	</xsl:template>
	
		<xsl:template match="xf:instance[@id='config']">
		 <xf:instance xmlns="" id="config"  >
			<data>
			  <file>en</file>
			  <subform>dos</subform>
			  <identifier></identifier>
			  <source></source>
			  <path></path>
			  <sourcedocument>../rest/data/template.xml</sourcedocument>
			  <filename><xsl:value-of select="$doc" /></filename>
			  <page>0</page>
			  <plan-load-path>loadplan.htm</plan-load-path>
			  <local-plan-path>localplan.htm</local-plan-path>
			  <browse-path>browse.htm</browse-path>
			</data>
	</xf:instance>
	</xsl:template>
	
	<!-- 
	<xsl:template match="xf:instance">
		 <xf:instance xmlns="" id="{@id}" src="{concat('../../static/wizard/', @src)}" />
	</xsl:template>

	 -->

      
      
</xsl:stylesheet>

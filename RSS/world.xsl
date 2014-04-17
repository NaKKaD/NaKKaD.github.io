<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:media="http://search.yahoo.com/mrss/" xmlns:atom="http://www.w3.org/2005/Atom" 
xmlns:xs="http://www.w3.org/2001/XMLSchema"
targetNamespace="http://www.w3schools.com"
xmlns="http://www.w3schools.com"
elementFormDefault="qualified">

  <xsl:template match="/">
    <html>
		<body>
			<table style="margin-bottom:8px;margin-top:4px;"  cellpadding="10" border="0" width="50%" align="center">
				<tr>
					<td bgcolor="#990000" align="center">						
						<h1><font color="white"><xsl:value-of select="rss/channel/image/title"/></font></h1>
						<img>
							<xsl:attribute name="src">
								<xsl:value-of select="rss/channel/image/url"/>
							</xsl:attribute>
						</img>
					</td>
				</tr>
			</table>
			
			<xsl:variable name="vMonthNames" select="'|Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec'"/>
			
			<xsl:for-each select="rss/channel/item[category='world']">
			
			 <!-- year part -->
			 <xsl:sort select=" substring(pubDate,13,4)" data-type="number" order="descending"/>
			 <!-- month part -->
			 <xsl:sort select="string-length(substring-before($vMonthNames, substring(pubDate,9,3)))" data-type="number"/>
			 <!-- day part -->
			 <xsl:sort select="substring(pubDate,6,2)" data-type="number" order="descending"/>
			 <!-- hour part -->
			 <xsl:sort select="substring(pubDate,18,2)" data-type="number" order="descending"/>
			 <!-- minute part -->
			 <xsl:sort select="substring(pubDate,21,2)" data-type="number" order="descending"/>
			 <!-- second part -->
			 <xsl:sort select="substring(pubDate,24,2)" data-type="number" order="descending"/>
			
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="link"/>
					</xsl:attribute>
				
				<table border="0" width="50%" align="center" onmouseover="style.backgroundColor='#E9E7E7'" onmouseout="style.backgroundColor='transparent'">
					<tr>
						<xsl:choose>
							<xsl:when test="category='technology'">
								<td bgcolor="#CA3535" align="center" width="7%">
									<p><font size="7" color="#FFFFFF">T</font></p>
								</td>
							</xsl:when>
							<xsl:when test="category='world'">
								<td bgcolor="#353ACA" align="center" width="7%">
									<p><font size="7" color="#FFFFFF">W</font></p>
								</td>
							</xsl:when>
							<xsl:when test="category='politics'">
								<td bgcolor="#AAAAB1" align="center" width="7%">
									<p><font size="7" color="#FFFFFF">P</font></p>
								</td>
							</xsl:when>
						</xsl:choose>
						
						<td rowspan="0">
							<xsl:attribute name="width">
								<xsl:value-of select="media:thumbnail[2]/@width"/>
							</xsl:attribute>
							<xsl:attribute name="height">
								<xsl:value-of select="media:thumbnail[2]/@height"/>
							</xsl:attribute>
							<img>
								<xsl:attribute name="src">
									<xsl:value-of select="media:thumbnail[2]/@url"/>
								</xsl:attribute>
							</img>
						</td>
						<td>
						  <p valign="top"><xsl:value-of select="title"/></p>
						  <p><font size="3" color="#A29F9F"><xsl:value-of select="description"/></font></p>
						</td>
						<td align="right" valign="bottom" width="20%">
							<font size="1" color="#A29F9F">
								<xsl:value-of select="pubDate"/>
							</font>
					</td>
					
					<xsl:choose>
						<xsl:when test="category='technology'">
							<td bgcolor="#CA3535" align="center" width="1%"/>
						</xsl:when>
						<xsl:when test="category='world'">
							<td bgcolor="#353ACA" align="center" width="1%"/>
						</xsl:when>
						<xsl:when test="category='politics'">
							<td bgcolor="#AAAAB1" align="center" width="1%"/>
						</xsl:when>
					</xsl:choose>
				  </tr>          
				</table>
				</a>				
				<xsl:if test="last() > position()">
					<hr width="50%" align="center"/>
				</xsl:if>				
			</xsl:for-each>
		</body>
    </html>
  </xsl:template>

</xsl:stylesheet>

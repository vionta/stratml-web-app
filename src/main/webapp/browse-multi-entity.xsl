<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xf="http://www.w3.org/2002/xforms">

	<xsl:output method="xml" omit-xml-declaration="no"
		standalone="yes" indent="yes" />

	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Content-Type"
					content="text/html; charset=utf-8" />
				<meta http-equiv="Content-Style-Type"
					content="text/plain; charset=us-ascii" />
				<meta http-equiv="Pragma" content="no-cache" />
				<meta http-equiv="Expires" content="-1" />
				<title>StratML, Browse Plans</title>
				<meta name="DC.title"
					content="StratML Part 1 to Part 2 Conversion XForm" />
				<meta name="title"
					content="Strategic Plan (StratML Part 2) XForm" />
				<meta name="DC.subject" scheme="DCTERMS.LCSH"
					content="Strategic Plans, StratML Part 2, StratML, XForms, XSLTForms, Performance Plans, Performance Reports" />
				<meta name="DC.contributor" content="Joe Carmel" />
				<meta name="DC.contributor" content="Owen Ambur" />
				<meta name="DC.contributor"
					content="Andre Cusson (hyperbase.com)" />
				<meta name="DC.contributor"
					content="Alain Couthures (agencexml.com)" />
				<meta name="DC.contributor"
					content="Gannon J. Dick (rustprivacy.org)" />
				<meta name="DC.contributor"
					content="Colin Mackenzie (mackenziesolutions.co.uk)" />
				<meta name="DC.contributor" content="Ibrahim Shah" />
				<meta name="DC.contributor"
					content="Jorge Sanchez (vionta.net)" />
				<meta name="DC.rights" content="Public domain" />
				<meta name="DC.rights.accessRights" content="public" />
				<meta name="DC.format.medium" scheme="DCTERMS.IMT"
					content="text/xml" />
				<meta name="medium" content="XForm" />
				<meta name="DC.identifier" scheme="DCTERMS.URI"
					content="http://www.legisworks.org/StratML/" />
				<meta name="DC.language" scheme="DCTERMS.RFC3066"
					content="en-US" />
				<meta http-equiv="Content-Language" content="en-US" />
				<meta name="keywords"
					content="Strategic Plans, StratML, XForms, XSTForms, Performance Plans, Performance Reports" />
				<meta name="DC.date" content="2018-08-19" />
				<link rel="stylesheet" type="text/css" href="css/position-style.css" />
				<link rel="stylesheet" type="text/css" href="css/format-style.css" />
				<link rel="stylesheet" type="text/css" href="css/position-style-webapp.css" />
				<link rel="stylesheet" type="text/css" href="css/format-style-webapp.css" />
				<link rel="stylesheet" type="text/css" href="css/webapp.css" />
			</head>
			<body>
				<div id="marco">
					<header>
						<h1>
							<img class="title-logo" width="80px"
								src="img/plan-white-icon.svg" alt="StratML logo" />
							Strategic Markup Language
							<img class="stratml-logo" src="img/stratml_logo_white.svg"
								alt="StratML logo" />
						</h1>
						<div id="subheader">
							<div id="breadcrumb">
								<a href="http://stratml.us">..</a>
								&gt;
								<a href="Intro.xml">StratML Forms</a>
								&gt;
								<a name="breadcrumb">Intro</a>
							</div>
							<div id="confifurationoptions">
								<a href="browse.htm">
									<img src="img/webapp/single-entity.svg"
										alt="Single entities list view" />
								</a>
								<a href="facets.htm">
									<img src="img/webapp/facets.svg"
										alt="Facets view (preview)" />
								</a>
								<a href="doc/documentation.html" target="blank">
									<img src="img/documentation-icon.svg" alt="documentation" />
								</a>
							</div>
						</div>
					</header>
					<main>
						<div>
							<xsl:apply-templates select=".//results"></xsl:apply-templates>
							<xsl:apply-templates select="//commands" />
						</div>
					</main>
				</div>

			</body>

		</html>
	</xsl:template>
	
	<xsl:template match="commands">
		<div class="pagination">
			<xsl:for-each select="pages/prevpage">
				<a href="browse-multi.htm?start={@start}&amp;q={@q}">
					<img src="img/prev-page-icon.svg" width="12px"
						alt="Previous results" />
				</a>
			</xsl:for-each>
			<xsl:for-each select="pages/nextpage">
				<a href="browse-multi.htm?start={@start}&amp;q={@q}">
					<img src="img/next-page-icon.svg" width="12px"
						alt="Nexts results" />
				</a>
			</xsl:for-each>
		</div>

	</xsl:template>

	<xsl:template match="results">
		<form method="GET" class="searchform">
			<input type="text" name="q" value="{/result/search/query}"
				id="mainsearchbox" />
			<input type="submit" value="Search"></input>
		</form>
		<div id="searchresulstdiv">
			<table class="results">
				<tr>
					<th>Name</th>
					<th>Description</th>
					<th>Org</th>
					<th>Mission</th>
					<!-- <th>Date</th> -->
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<xsl:apply-templates selec="plan"></xsl:apply-templates>
			</table>
			<button onclick="document.location='Intro.xml';">Add Plan</button>
		</div>
	</xsl:template>

	<xsl:template match="plan">
		<tr>
			<td class="short-text">
				<xsl:value-of select="substring(Name,1,20)" />
				<xsl:if test="string-length(Name) > 20">
					...
				</xsl:if>
			</td>
			<td class="long-text">
				<xsl:value-of select="substring(Description,1,30)" />
				<xsl:if test="string-length(Description) > 30">
					...
				</xsl:if>
			</td>
			<td class="short-text">
				<xsl:value-of select="Organization" />
			</td>
			<td class="long-text">
				<xsl:value-of select="substring(Mission,1,30)" />
				<xsl:if test="string-length(Mission) > 30">
					...
				</xsl:if>
			</td>
			<!-- <td class="date" > -->
			<!-- <xsl:value-of select="date" /> -->
			<!-- </td> -->


			<td class="icon-link">
				<a
					href="loadplan.htm?doc=../webdav/data/{path/text()}&amp;repository=true">
					<img src="img/edit-blue-icon.svg" alt="Edit"></img>
				</a>
			</td>
			<td class="icon-link">
				<a href="/stratmlapp/rest/data/{path/text()}">
					<img src="img/download-blue-icon.svg"
						alt="Download {path/text()}"></img>
				</a>
			</td>
			<td class="icon-link">
				<a href="planpresentation.htm?doc={path/text()}">
					<img src="img/view-blue-icon.svg" alt="View"></img>
				</a>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="text()" />

</xsl:stylesheet>

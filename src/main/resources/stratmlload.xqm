(:~
 : This module contains some basic examples for RESTXQ annotations.
 : @author BaseX Team
 :)
module namespace stratapp = 'http://stratml.us/stratmlapp/main-page';

(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
  %rest:GET
  %rest:path('static/loadplan.htm')
  %rest:query-param("doc", "{$doc}", "")
  %rest:query-param("repository", "{$repository}", "true")
  %output:method('xml')
  %output:omit-xml-declaration('no')
function 
		stratapp:start(
			$doc as xs:string, 
			$repository as xs:boolean			
				) 
				{

		
		
		
			let $content :=   
			if( fn:doc($doc)  ) 
								then 
									xslt:transform(
										file:read-text(file:base-dir() || "./static/0_mainform.xml"),
						                file:read-text(file:base-dir() || "./filter-instances.xsl"),
						                map { "doc": $doc }
						                )
								else 
									xslt:transform(
										file:read-text(file:base-dir() || "./static/Intro.xml"),
						                file:read-text(file:base-dir() || "./main.xsl"),
						                map { "message": "Document not found"}
						                )	
									
			
			return 	(<?xml-stylesheet href="xsltforms/xsltforms.xsl" type="text/xsl"?>,
					<?css-conversion no?>,
					<?xsltforms-options debug="no"?>,
					$content/*)
					

};




(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
  %rest:POST
  %rest:path('static/localplan.htm')
  %rest:form-param("doc", "{$doc}", "")
   %output:method('xml')
  %output:omit-xml-declaration('no')
function 
		stratapp:start(
			$doc 	 		) 
				{

			let $content :=   	xslt:transform(
										file:read-text(file:base-dir() || "./static/0_mainform.xml"),
						                file:read-text(file:base-dir() || "./filter-full-instance.xsl"),
						                map { "doc": parse-xml(convert:binary-to-string($doc(map:keys($doc)[1]))) }
						                )
								
								(: 
								map { "doc": fn:parse-xml(convert:binary-to-string($doc(map:keys($doc)[1]))) }
						                
							parse-xml(convert:binary-to-string($doc(map:keys($doc)[1])))					
									
			
						                :)
			return 	(
					$content/*)
					 
					

};


(: 
planpresentation
:) 
(:~
 : Generates a welcome page.
 : @return HTML page
declare
  %rest:GET
  %rest:path('browse/Intro.xml')
  %output:method('xml')
  %output:omit-xml-declaration('no')
function 
		stratapp:redir() 
				{
			web:redirect('/static/Intro.xml') 
		

};

 :)
 
 

(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
  %rest:GET
  %rest:path('static/planpresentation.htm')
  %rest:query-param("doc", "{$doc}", "")
  %output:method('xml')
  %output:omit-xml-declaration('no')
function 
		stratapp:planpresentation(
			$doc as xs:string		
				) 
				{

	
			let $content :=   xslt:transform(
						db:open("data", $doc),
		                file:read-text(file:base-dir() || "./part2stratml.xsl")
		                )
		
			
			
			return 	$content
					

};
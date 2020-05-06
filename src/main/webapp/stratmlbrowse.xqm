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
  %rest:path('static/browse-data.htm')
  %rest:query-param("q","{$q}", "")
  %rest:query-param("start","{$start}", "1")
  %output:method("xhtml")
  %output:omit-xml-declaration("no")
  %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
	function 
		stratapp:browsedata(
		   $q as xs:string, 
		   $start as xs:int 
						) {
		<results>{
			let $docs := if($q="") then 
								db:open("data","/")
							else
								for $initialdoc in db:open("data","/")
									where  ft:contains($initialdoc//text(), $q)
                                return $initialdoc
		
			for $plan in $docs[position() = $start to  ($start + 10)] 
				(:where local-name($plan/*[1]) = 'PerformancePlanOrReport'			:)
				return <plan>	
						{$plan/*:PerformancePlanOrReport/@Type}
						<path>{db:path($plan)}</path>
					   	<Name>{$plan/*:PerformancePlanOrReport/*:Name/text()}</Name>		
					   	<Organization>{$plan//*:Organization/*:Acronym/text()}</Organization>		
					   	<Mission>{$plan//*:Mission/*:Description/text()}</Mission>		
					   	<Description>{$plan/*:PerformancePlanOrReport/*:Description/text()}</Description>
					   	<date>{$plan/*:PerformancePlanOrReport/*:PublicationDate/text()}</date>
					   	<submitter-name>
					   			{$plan/*:PerformancePlanOrReport/*:Submitter/*:GivenName/text()}
					   			{$plan/*:PerformancePlanOrReport/*:Submitter/*:SurName/text()}
						</submitter-name>					   			
    					<goals>{count($plan/*:PerformancePlanOrReport//*:Goal)}</goals>
					   	<objectives>{count($plan/*:PerformancePlanOrReport//*:Objective)}</objectives>
					</plan>
			}</results>
		(:
		 <html>	
			{ 
			  let $queryresults := ft:search("data", $q) 
			  let $searchresults := 
			  		<results>
			      		{ 
					  	for $i in db:list("data", $entity )
							let $doc := fn:doc("personal/"||$i)
							return <result>
			      			{
							 if (
							 	(
							 		((not(searchpage:getQueryParams($query)/querystring/text())
								 	and 
								 	$queryparams/*/*)
							 	)
							 or
							 ft:contains($doc//text(),$queryresults ))
							 and 
							 searchpage:chekQueryFilters($doc, searchpage:getQueryParams($query)/params)							
							 )  then pres-generic:getEntityButtons($doc, $entity) 
							 else  ""   
					  	 	}
					  	 </result>
					  	 }
						</results>
			 let $searchstring := $query
				}
		  </html>
	:)
};


(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
	function 
		stratapp:internaldata(
		   $q as xs:string, 
		   $start as xs:int ) {
			let $prevstart := if ($start <= 10) then 1 else  ($start - 10)
			let $poststart := ($start + 10)
			let $data := 	stratapp:browsedata($q, $start)
			let $commands := 	<pages>
									{ 
									 if ($start != 1) then 
							 		  <prevpage start="{$prevstart}" q="{$q}" />
							 	    else  ""
									}
									{ 
									 if (count($data/*) > 9) then 
							   			  <nextpage start="{$poststart}" q="{$q}" />
							     	 else   "" 
							     	 }
							    </pages>
							    
							 

			return	<result>
										<data>{$data}</data>
										<commands>{$commands}</commands>
										<!-- <facets>
											
										</facets>
										-->
										<search>
											<query>{$q}</query>
											<start>{$start}</start>
										</search>
									</result> 
};

(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
  %rest:GET
  %rest:path('static/browse.htm')
  %rest:query-param("q","{$q}", "")
  %rest:query-param("start","{$start}", "1")
  %output:method("xhtml")
  %output:omit-xml-declaration("yes")
  %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
	function 
		stratapp:browse( $q as xs:string,  $start as xs:int ) {
			xslt:transform(
						stratapp:internaldata($q, $start), 
						file:read-text(file:base-dir()||"main.xsl")
									)
}; 
						
(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
  %rest:GET
  %rest:path('static/browse-multi.htm')
  %rest:query-param("q","{$q}", "")
  %rest:query-param("start","{$start}", "1")
  %output:method("xhtml")
  %output:omit-xml-declaration("yes")
  %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
	function 
		stratapp:browsemulti( $q as xs:string,  $start as xs:int ) {
			xslt:transform(
						stratapp:internaldata($q, $start), 
						file:read-text(file:base-dir()||"browse-multi-entity.xsl")
									)
}; 

(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
  %rest:GET
  %rest:path('static/facets.htm')
  %output:method("xhtml")
  %output:omit-xml-declaration("yes")
  %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
	function 
		stratapp:browsemulti(  ) {
			xslt:transform(
						index:facets("data"), 
						file:read-text(file:base-dir()||"facets.xsl")
									)
		(:
						index:facets("data")
									:)
}; 
						
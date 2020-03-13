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
				for $plan in db:open("data","/")[position() = $start to  ($start + 10)] 
					where local-name($plan/*[1]) = 'PerformancePlanOrReport'
					   return <plan>	
					   		  			{$plan/*:PerformancePlanOrReport/@Type}
					   			<path>{db:path($plan)}</path>
					   			<Name>{$plan/*:PerformancePlanOrReport/*:Name/text()}</Name>		
					   			<Description>{$plan/*:PerformancePlanOrReport/*:Description/text()}</Description>
					   			<date>
					   			{$plan/*:PerformancePlanOrReport/*:PublicationDate/text()}
					   			</date>
					   			<submitter-name>
					   			{$plan/*:PerformancePlanOrReport/*:Submitter/*:GivenName/text()}
					   			{$plan/*:PerformancePlanOrReport/*:Submitter/*:SurName/text()}
								</submitter-name>					   			
    					   					
					   			<goals>
						   			{count($plan/*:PerformancePlanOrReport//*:Goal)}
					   			</goals>
					   			<objectives>
						   			{count($plan/*:PerformancePlanOrReport//*:Objective)}			   			
					   			</objectives>
					   	</plan>
			}</results>
					
(:
		 <html>	
			{ 
			  let $queryresults := ft:search("data", $q) 
			  let $searchresults := <results>
			      		     { 
					  		      for $i in db:list("data", $entity )
							         let $doc := fn:doc("personal/"||$i)
								 return <result>
			      			 {
						 if (	 
						 (((not(searchpage:getQueryParams($query)/querystring/text())
						 and 
						 $queryparams/*/*
						 ))
						 or
						 ft:contains($doc//text(),$queryresults ))
						 and 
						 searchpage:chekQueryFilters($doc, searchpage:getQueryParams($query)/params)							
						 )  then pres-generic:getEntityButtons($doc, $entity) 
						 else 
					   	 ""   
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
  %rest:GET
  %rest:path('static/browse.htm')
  %rest:query-param("q","{$q}", "")
  %rest:query-param("start","{$start}", "1")
  %output:method("xhtml")
  %output:omit-xml-declaration("yes")
  %output:doctype-public("-//W3C//DTD XHTML 1.0 Transitional//EN")
  %output:doctype-system("http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd")
	function 
		stratapp:browse(
		   $q as xs:string, 
		   $start as xs:int 
						) {
						
			let $data := 	stratapp:browsedata($q, $start)
			let $prevstart := if ($start <= 10) then 1 else  ($start - 10)
			let $poststart := ($start + 10)
			let $commands := <div  class="pagination" >
									{ if ($start != 1) then 
							      <a href="browse.htm?start={$prevstart}&amp;q={$q}" >
									<img src="../img/previous-icon.png" width="12px" alt="Previous results" />
							      </a> else ""
									}
									{ if (count($data/*) > 9) then 
							      <a href="browse.htm?start={$poststart}&amp;q={$q}" >
									<img src="../img/next-icon.png" width="12px" alt="Nexts results" />
							     </a> else "" 
							     }
								</div>

				
			return	xslt:transform(<result>
										<data>
											{$data}
										</data>
										<commands>
											{$commands}
										</commands>
										</result>
											, 
										file:read-text(file:base-dir()||"main.xsl")
										)
				
				
						
						
						}; 
(:~
 : This module contains some basic examples for RESTXQ annotations.
 : @author BaseX Team
 :)
module namespace stratappadmin = 'http://stratml.us/stratmlapp/admin';

(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
%updating
  %rest:GET
  %rest:path('admin/start.htm')
    function  stratappadmin:start() {
		if (db:exists("data")) 	
			then db:optimize("data") else 
			db:create("data")
			, 
           update:output("<html xmlns='http://www.w3.org/1999/xhtml'><head><script>location='list';</script></head><body>Finished</body></html>")
		(:
		
				if (fn:exists("personal/"||$entity||"/"||$id[1]))	
		then (pcreate:updateDocument($entity, $id[1], $data))
		else (pcreate:createDocument($entity, $id[1], $data)),
		db:optimize("personal"),
		
		
    		,
	    	db:optimize('data',true(),  map { 'ftindex': true()} )
    	,
           update:output("<html xmlns='http://www.w3.org/1999/xhtml'><head></head><body>OK</body></html>")
        :)
};

(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
%updating
  %rest:GET
  %rest:path('admin/optimize.htm')
    function  stratappadmin:optimize() {
				    	db:optimize('data',true(),  map { 'ftindex': true()} ),
           update:output("<html xmlns='http://www.w3.org/1999/xhtml'><head></head><body>Finished</body></html>")
};
(:~
 : Generates a welcome page.
 : @return HTML page
 :)
declare
  %rest:GET
  %rest:path('admin/facets.htm')
    function  stratappadmin:facets() {
    <data>
    {
    index:texts("data")
    
    }</data>
};

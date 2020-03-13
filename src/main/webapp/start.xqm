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
		(:
		if (db:exists("data")) 	
		then ""
		:)
		db:create("data")	
		(:
    		,
    	db:optimize("data")
    	,
           update:output("<html xmlns='http://www.w3.org/1999/xhtml'><head></head><body>OK</body></html>")
        :)
};

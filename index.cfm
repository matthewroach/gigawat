<cfsilent>
<cfscript>

  requestString = CGI.QUERY_STRING;

  reserved = [ 'about', 'copied', 'faq' ];

	// --- API --- */
	api = new api.private.shorten();
	mongoDB = new api.private.mongo();

	page = 'pages/index.inc';

	if ( requestString != '' ) {

		firstQString 	= listFirst( requestString, '/' );
		requestAction = listLast( requestString, '/' );

		if ( listLen( requestString, '/' ) == 1 && !arrayContains( reserved, firstQString ) ) {

			if ( mongoDB.check( APPLICATION.mongo.links, { shortUrl : firstQString } ) ) {

				data = api.link( APPLICATION.mongo.links, firstQString );
				location( url=data.originalUrl, statuscode=302 );

			} else {
				throw( message='The page you are trying to access does not exists');
			}

		} else if ( listLen( requestString, '/' ) == 1 && arrayContains( reserved, firstQString ) ) {

			page = 'pages/' & firstQString & '.inc';

		} else if ( mongoDB.check( APPLICATION.mongo.links, { shortUrl : firstQString } ) && requestAction == 'details' ) {

			link = mongoDB.getOne( APPLICATION.mongo.links, { shortUrl : firstQString } );

			page = 'pages/details.inc';

		} else if ( firstQString == 'api' ) {

			call = 'api.#requestAction#(form)';
			data = Evaluate(call);

		} else {

			page = requestString & '.inc';

			if ( !FileExists(page) ) {
				throw( message='The page you are trying to access does not exists');
			}

		}

	} else if ( CGI.SERVER_NAME == '1.21.gigaw.at' ) {
		page = 'pages/fun.inc';
	}

</cfscript>
</cfsilent>
<cfif ( listFirst( requestString, '/' ) != 'api' ) >
	<cfinclude template="/inc/header.inc" />
	<cfinclude template="#page#" />
	<cfinclude template="/inc/footer.inc" />

<cfelse>

	<cfheader name="Content-type" value="application/json" />
	<cfoutput>
		#serializeJSON(data)#
	</cfoutput>

</cfif>

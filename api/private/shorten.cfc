component extends='api.private.mongo' {




  public function shorten( formData ) {

    // --- Add http:// to the beginning of the url if it's missing --- */
    var httpsPrefix = Find( 'https://', formData.url );
    if ( httpsPrefix == 0 ) {
      httpPrefix = Find( 'http://', formData.url );
      if ( httpPrefix == 0 ) {
        formData.url = 'http://' & formData.url;
      }
    }

    var checkIfExists = SUPER.check( application.mongo.links, { originalUrl : formData.url });

    if ( checkIfExists >= 1 ) {
      var data = SUPER.getOne( application.mongo.links, { originalUrl : formData.url } );
      var shortLink = data.shortUrl;
      var returnData = {
        shortUrl: data.shortUrl,
        originalUrl: formData.url
      };
    } else {
      shortLink = generateShortLink(4);
      returnData = addShortLink( formData, shortLink );
    }

    var redirectUrl = '?/' & shortLink & '/details';

    return {
      shortUrl: data.shortUrl,
      originalUrl: formData.url
    };

  }


  function generateShortLink( linkLength ) {

    var charList = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var shortLink = '';

    for ( var i=1; i<=arguments.linkLength; i=i+1 ) {
      shortLink = shortLink & Mid( charList, Rand() * Len( charList ) + 1, 1 );
    }

    var checkShortLink = SUPER.check( application.mongo.links, { shortUrl : shortLink } );

    if ( checkShortLink == 0 ) {
      return shortLink;
    } else {
      return THIS.generateShortLink(4);
    }

  }


  function addShortLink( formData, shortLink ) {

    var data = {
      shortUrl: shortLink,
      originalUrl: formData.url,
      title: getPageTitle( formData.url ),
      datetime: Parsedatetime( DateTimeFormat( now(), 'yyyy-MM-dd HH:mm:ss' ) )
    };

    SUPER.insertData( application.mongo.links, data );

    return data;

  }


  function getPageTitle( url ) {

    var http = http( url=ARGUMENTS.url, result='requestHTML');
    var doc = html( requestHTML.filecontent );

    var title = doc.select('title');
    var pageTitle = title[1].text();

    return pageTitle;

  }


  function link( collection, link ) {

    var checkShortLink = SUPER.check( arguments.collection, { shortUrl : link } );

    if ( checkShortLink == 1 ) {
      return SUPER.getOne( arguments.collection, { shortUrl : '#link#' } );
    }

  }



}

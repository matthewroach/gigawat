component {



  this.name = 'Gigawat';



  function onApplicationStart() {


    if ( CGI.HTTP_HOST != '' ) {
      APPLICATION.url = 'http://' & CGI.HTTP_HOST;
    }

    APPLICATION.serverName = CGI.SERVER_NAME;

    // --- System Gettter --- */
    // used as APPLICATION.system.getEnv('key');
    APPLICATION.system = createObject( 'java', 'java.lang.System' );


    // --- Mongo Datasource --- */
    APPLICATION.ds = {
      name: 'mongo',
      server: APPLICATION.system.getEnv('DS_SERVER'),
      port: APPLICATION.system.getEnv('DS_PORT'),
      username: APPLICATION.system.getEnv('DS_USERNAME'),
      password: APPLICATION.system.getEnv('DS_PASSWORD'),
      db: APPLICATION.system.getEnv('DS_DB')
    };

    APPLICATION.mongo = {
      db: 'gigawat_local',
      links: 'links'
    };

    MongoRegister( ArgumentCollection=APPLICATION.ds );

  }




  function onRequestStart() {

    if ( !MongoIsvalid('mongo') ) {
      THIS.onApplicationStart();
    }

    if ( !MongoIsvalid('mongo') ) {
      throw( message='Unable to Connect to Database');
    }

    if ( CGI.HTTP_HOST != '' ) {
      APPLICATION.url = 'http://' & CGI.HTTP_HOST;
    }

  }



  function onError( catchdata, eventname ) {

    var template = renderInclude('/pages/error/404.cfm');
    writeOutput(template);

  }



}

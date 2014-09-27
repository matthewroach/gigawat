component {



  function insertData( collection, data ) {
    return MongoCollectionInsert( APPLICATION.ds.name, ARGUMENTS.collection, ARGUMENTS.data );
  }



  numeric function check( collection, query ) {

    return MongoCollectioncount( APPLICATION.ds.name, ARGUMENTS.collection, ARGUMENTS.query );

  }



  // Grab details of the link we are asking for from link
  function getOne( collection, query ) {
    return MongoCollectionfindone( APPLICATION.ds.name, ARGUMENTS.collection, ARGUMENTS.query );
  }



  function getMany( query ) {
  	return MongoCollectionfind( APPLICATION.ds.name, APPLICATION.mongo.links, ARGUMENTS.query );
  }



  function shortLinkCount( link ) {
    // This will be a function to increase the link count for visited shortLinks
    MongoCollectionUpdate( APPLICATION.ds.name, APPLICATION.mongo.links, { shortUrl : '#link#' },
      { $inc : { 'stats.count' : 1 } }, 'true' );
  }



}

$(document).ready(function() {



  $('#submit').on('click',function(e) {
    e.preventDefault();

    var $url = $('#url');

    if ( $url.val().length !== 0 ) {
      shortenLink($url.val());
    } else {
      $url.attr( 'placeholder', 'You need to enter a URL' );
    }

  });



  $('#copy').zclip({
    path:'/a/libs/jqplugins/ZeroClipboard.swf',
    copy: $.trim($('h1.focus').text()),
    beforeCopy:function(){},
    afterCopy:function(){
      $('#copied').removeClass('hide')
        .hide()
        .fadeIn(500)
        .delay(3000)
        .fadeOut(500);
    }
  });



  function shortenLink( data ) {

    $.ajax({
      type: 'POST',
      url: '/?/api/shorten/',
      dataType: 'JSON',
      data: { url: data },
      success: function( data ) {
        window.location.href = '/?/' + data.shortUrl + '/details'
      },
      error: function() {
        alert('Error');
      }
    });

  }



});

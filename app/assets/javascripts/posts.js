var PostModule = ( function(){ 


  // Allow anyone to retrieve all the tables
  //   which are marked as "post tables"
  var getPostTables = function(){
    return $("table[data-content='posts']");
  }


  // Our public-facing function for attaching
  //   any listeners we want on the DOM
  var attachPostListeners = function(){
    _ajaxFormListener();
  }


  // Attach submit listeners to all forms
  //   we have marked for AJAX submission
  //   with the data attribute `data-ajaxremote`
  var _ajaxFormListener = function(){

    $("form[data-ajaxremote='true']").submit( function( event ){
      
      // Prevent the default behavior so it
      //   doesn't submit as normal
      event.preventDefault();

      // Pull the data off the form
      var $el = $( event.target );
      var formData = $el.serializeArray();

      // Submit the form to the originally intended
      //   URL using our new data object
      $.ajax({
        url: $el.attr("action"),
        method: "POST",
        data: formData,

        // Make sure we're actually requesting
        //   JSON or Rails will assume we want
        //   a normal HTML request!
        dataType: "json",
        success: function( data ){
          console.log( "Success!" );
          _addPostRowToTable( data );
        }
      })

    });
  }


  // Add a new Post as a row in any table
  //   which identifies itself as containing 
  //   Posts
  var _addPostRowToTable = function( post ){

    // Identify our Posts table using a data attr
    var $tables = getPostTables();

    // Build our new row the long way
    var $postRow = $("<tr></tr>")
    var $postTitle = $("<td></td>").text( post.title );
    var $postBody = $("<td></td>").text( post.body );

    // Assemble the pieces
    $postRow.append( $postTitle )
            .append( $postBody );

    // Insert into all Post tables
    $tables.prepend( $postRow );

  }

  return {
    attachPostListeners: attachPostListeners,
    getPostTables: getPostTables
  }

})();



$( document ).ready( function(){  

  // Attach our listeners after the DOM loads
  PostModule.attachPostListeners();

});
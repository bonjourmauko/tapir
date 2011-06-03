var parts_loaded_count = 0
var parts_to_load = 1
//var collection_of_documents = []

var response = ""

function ParseCSS(css)
{
  css = css.replace(/}/g,'}~');
  var cssArray_raw = css.split('~');
  cssArray_parsed = [];
  for(i = 0; i < cssArray_raw.length; i++){
    if(cssArray_raw[i].charAt(0) == '.')
    {
      cssArray_parsed.push("#nonexistent "+cssArray_raw[i])
    }
  }
  return cssArray_parsed.join(' ')
}

function TemporalCSSToContent(css)
{
  css = css.replace(/#nonexistent/g,'#book_contents');
  return css;
}



function LoadDocument(id, position)
 {
   var url = "http://interpres.heroku.com/resources/documents/"+id+"/download?callback=?"
   $.getJSON(url, function(data){
     temporal_div = '#temporal' + position
     contents = '<style type="text/css">'+ParseCSS(data['style'],temporal_div)+'</style>'+data['body']
     $(temporal_div).html(contents)
     parts_loaded_count++
     AfterAllChaptersHaveLoaded() // remove when using collections, then use WaitUntilLoaded()
     //return 0;
   } )
}

/*function LoadCollection(id)
 {
   var url = "http://interpres.heroku.com/resources/folders/"+id+"/contents?callback=?"
   $.getJSON(url, function(data){
     collection_of_documents = data['entry'];
     parts_to_load = collection_of_documents.length;
     for (i = 1; i <= parts_to_load; i++) {
       $('body').append($('<div id="temporal' + i + '" class="temporal"></div>'))
     }
     $('.temporal').hide();
     for(i = 0; i < parts_to_load; i++){
       LoadDocument(collection_of_documents[i]['resource_id'], i);
     }
   } )
}*/

// WAIT UNTIL LOADED IS FOR LOADING COLLECTIONS

/*function WaitUntilLoaded()
 {
    check_every = 100; //miliseconds
    if (parts_loaded_count < parts_to_load) {
        setTimeout(WaitUntilLoaded, check_every);
        return;
    }
    AfterAllChaptersHaveLoaded()
}*/



function AfterAllChaptersHaveLoaded()
 {

    // each temporal div is copied to #book_contents, cleaned and returned to the temporal div
    $('.temporal').each(function() {
        
        pre = $(this).contents();
        $('#book_contents').empty().append(pre);
        $styletag = $('#book_contents style')
        $styletag.html(TemporalCSSToContent($styletag.html()))
        
        clean();
        
        post = $('#book_contents').contents();
        $(this).empty().append(post);
    })
    
    // each temporal is appended to #book_contents
    $('.temporal').each(function() {
        $('#book_contents').append($(this).remove().contents())
    })

    illustrationfy();
    chapterify();
    buildToc();
    

    $('#bookhtml').val($.trim($('#book_contents').html()));
    HideLoading();
    DoSave();

}

function LoadAndProcessExternalDocument()
{
  ShowLoading();
  $('.temporal').remove();
  $('#book_contents').empty();
  
  if(external_resource_type == 'google_document')
  {
    var parts_to_load = 1;
    $('body').append($('<div id="temporal1" class="temporal"></div>'))
    $('.temporal').hide();
    LoadDocument(external_resource_id, 1)
  }
  
}

function LoadPremaster()
{
  ShowLoading();
   var url = "http://interpres.heroku.com/resources/books/premaster/"+premaster_id+"?callback=?"
   $.getJSON(url, function(data){
     $('#book_contents').empty().html(data['body'])
     console.log("Premaster loaded from cache")
     HideLoading();
   } )

}

$(document).ready(function() {

if(premaster_uploaded == 1)
{
  
  LoadPremaster()
}
else
{
  LoadAndProcessExternalDocument();
}

});

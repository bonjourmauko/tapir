function remove_if_empty(obj)
 {
    $obj = $(obj)
    var exceptions = "img, a"
    var empty = $obj.text() == "";
    var no_children = $obj.children(exceptions).length == 0;
    if (empty && no_children) {
        $obj.remove();
    }
}

function clean_classes(obj)
 {
    $obj = $(obj)
    wp = white_properties;
    classes = [];

    for (i in wp) {

        wp_p = wp[i]['property']
        wp_v = wp[i]['value']
        wp_c = wp[i]['class']

        has_wp = $obj.css(wp_p) == wp_v

        if (has_wp) {
            classes.push(wp_c)
        };

    };

    $obj.removeClass();
    $obj.addClass(classes.join(" "));
}

function remove_tag_if_no_class(o)
 {
    var class = $(o).attr('class');
    var no_class = (class == "" || class == false || typeof class == 'undefined')
    if (no_class) {
        $(o).replaceWith($(o).html())
    }

}

function remove_attr_if_attr_empty(o, attr)
 {
    if ($(o).attr(attr) == "") {
        $(o).removeAttr(attr)
    }
}

function remove_tags_inside(o)
 {
    $(o).text($(o).text());
}

function remove_tags_no_white(container)
 {

    var count = 0;
    $(container + " *").not(container + ' style').each(function() {

        var tag = this.tagName.toLowerCase();

        if ($.inArray(tag, white_tags) < 0) {
            // tag not in whitelist
            $(this).replaceWith($(this).html());
            count = count + 1;
        }

    });

    return count;

}

// what happens with footnotes in many chapters?
function parse_foot(o)
 {

    var id = $(o).attr("name").replace(/[^\d\.]+/, '');

    $(o).attr("href", '#foot_anchor' + id);
    $(o).attr('name', 'foot_ref' + id);
    $(o).attr('id', 'foot_ref' + id);
    $(o).addClass("foot_ref").text(id);

    var foot_backlink = $('a[name="ftnt' + id + '"]');
    var foot = foot_backlink.closest('div');

    foot_backlink.attr('name', '#foot_anchor' + id)
    foot_backlink.attr('href', '#foot_ref' + id)
    foot_backlink.removeAttr('id')

    foot.addClass("foot");
    foot.attr('id', 'foot' + id);

}

function style_list(o)
 {

    var type = $(o).css("list-style-type");
    $(o).removeAttr("class");
    $(o).attr("style", "list-style-type:" + type)

}

function wrap_chapter(o, class)
 {
    $chapter = $(o).add($(o).nextUntil($(o).get(0).tagName)).wrapAll('<div />').parent()
    $chapter.addClass(class)
}

var white_tags = ['p', 'span', 'a', 'img', 'ol', 'ul', 'li', 'hr', 'div', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6'];

var white_properties = [
{
    property: 'font-weight',
    value: 'bold',
    class: 'bold'
},
{
    property: 'font-style',
    value: 'italic',
    class: 'italic'
},
{
    property: 'text-decoration',
    value: 'line-through',
    class: 'line-through'
},
{
    property: 'vertical-align',
    value: 'sub',
    class: 'sub'
},
{
    property: 'vertical-align',
    value: 'super',
    class: 'super'
},
{
    property: 'text-align',
    value: 'right',
    class: 'right'
},
{
    property: 'text-align',
    value: 'center',
    class: 'center'
},
];

function clean()
 {
    // fix this, sometimes people put paragraphs as headings!
    $('h3','#book_contents').each(function() {
        $(this).replaceWith($('<p></p>').html($(this).html()))
    })
    
    while (remove_tags_no_white('#book_contents') > 0);

    $('span,a,p,ol,ul,li,h1,h2,h3,h4,h5,h6','#book_contents').each(function() {
        remove_if_empty(this)
    })
    $('span,a,p,ol,ul,li,h1,h2,h3,h4,h5,h6','#book_contents').each(function() {
        remove_if_empty(this)
    })

    $('span,p','#book_contents').each(function() {
        clean_classes(this)
    })
    $('span','#book_contents').each(function() {
        remove_tag_if_no_class(this)
    })

    $('#book_contents *').each(function() {
        remove_attr_if_attr_empty(this, 'class')
    })
    $("h1,h2,h3,h4,h5,h6,li",'#book_contents').removeAttr('class');

    $("h1,h2,h3,h4,h5,h6",'#book_contents').each(function() {
        remove_tags_inside(this)
    });

    $('ol','#book_contents').each(function() {
        style_list(this)
    })

    // remove all hr except page breaks
    $('hr:not([style*="page-break-before"])','#book_contents').remove();

    // Test test test footnotes in collections
    /*

  $('a[name^="ftnt_ref"]').each(function() { parse_foot(this) }
  $('.foot').wrapAll('<div id="foots"/>')
  $('#book_contents').append($('#foots'))

  */

    $('#book_contents style').remove();

    //remove comments
    $('[id*="cmnt"]','#book_contents').parent('p').remove();

    // remove everything that is not inside a chapter or foots
    //$('#book_contents > *').not('.chapter').remove();

    $('span','#book_contents').each(function() {
        remove_tag_if_no_class(this)
    })

    // removes height and width of images
    $('img','#book_contents').removeAttr('width').removeAttr('height');


}

function illustrationfy()
 {
    $('#book_contents img').each(function() {
        $(this).parents('p').addClass('illustration')
    })
}

function chapterify()
 {
    function chapter_class(level)
    {
      if (level == 1)
      {return 'section chapter level'+level}
      else
      {return 'chapter level'+level}
    }
   
    $('h1','#book_contents').each(function() {
        wrap_chapter(this, chapter_class(1))
    })
    $('h2','#book_contents').each(function() {
        wrap_chapter(this, chapter_class(2))
    })
    $('h3','#book_contents').each(function() {
        wrap_chapter(this, chapter_class(3))
    })
    
    if ($('#book_contents h1').length == 0)
    {
      $('#book_contents').contents().wrapAll('<div />').parent().addClass(chapter_class(1))
      $('#book_contents .chapter').prepend($('<h1 />').hide().text('Book'))
    }
}

function buildToc()
{
  $('#toc').empty()
  
  $('#toc').append( $('<div />').addClass('item').text('Cover') )
  
  $('.chapter').each(function(){
    
    var chapter_name = $(this).find('h1').text();
        
    $('#toc').append( $('<div />').addClass('item').text(chapter_name) )
    
  })
}

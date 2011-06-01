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
    $(o).add($(o).nextUntil($(o).get(0).tagName)).wrapAll('<div />').parent().addClass(class)
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
    $('h3').each(function() {
        $(this).replaceWith($('<p></p>').html($(this).html()))
    })

    while (remove_tags_no_white('#contents') > 0);

    $('span,a,p,ol,ul,li,h1,h2,h3,h4,h5,h6').each(function() {
        remove_if_empty(this)
    })
    $('span,a,p,ol,ul,li,h1,h2,h3,h4,h5,h6').each(function() {
        remove_if_empty(this)
    })

    $('span,p').each(function() {
        clean_classes(this)
    })
    $('span').each(function() {
        remove_tag_if_no_class(this)
    })

    $('#contents *').each(function() {
        remove_attr_if_attr_empty(this, 'class')
    })
    $("h1,h2,h3,h4,h5,h6,li").removeAttr('class');

    $("h1,h2,h3,h4,h5,h6").each(function() {
        remove_tags_inside(this)
    });

    $('ol').each(function() {
        style_list(this)
    })

    // remove all hr except page breaks
    $('hr:not([style*="page-break-before"])').remove();

    // Test test test footnotes in collections
    /*

  $('a[name^="ftnt_ref"]').each(function() { parse_foot(this) }
  $('.foot').wrapAll('<div id="foots"/>')
  $('#contents').append($('#foots'))

  */

    $('#contents style').remove();

    //remove comments
    $('[id*="cmnt"]').parent('p').remove();

    // remove everything that is not inside a chapter or foots
    $('#content > *').not('.chapter, #foots').remove();

    $('span').each(function() {
        remove_tag_if_no_class(this)
    })

    // removes height and width of images
    $('img').removeAttr('width').removeAttr('height');


}

function illustrationfy()
 {
    $('#contents img').each(function() {
        $(this).parents('p').addClass('illustration')
    })
}

function chapterify()
 {
    $('h1').each(function() {
        wrap_chapter(this, 'chapter level1')
    })
    $('h2').each(function() {
        wrap_chapter(this, 'chapter level2')
    })
    $('h3').each(function() {
        wrap_chapter(this, 'chapter level3')
    })
    
    if ($('h1').length == 0)
    {
      $('#contents').contents().wrapAll('<div />').parent().addClass('chapter level1')
    }
}

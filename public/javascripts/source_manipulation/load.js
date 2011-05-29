var parts_loaded_count = 0



function LoadExternal(file, position)
 {
    $('#temporal' + position).load(file + ' #doc_content',
    function() {
        parts_loaded_count++
    });  
      
}

function WaitUntilLoaded()
 {
    if (parts_loaded_count < parts) {
        //we want it to match
        setTimeout(WaitUntilLoaded, 100);
        //wait 100 millisecnds then recheck
        return;
    }
    parts_loaded_count = 0
    after_load()
}

function after_load()
 {

    // each temporal div is copied to #contents, cleaned and returned to the temporal div
    $('.temporal').each(function() {
        
        pre = $(this).children('#doc_content').contents();
        $('#contents').empty().append(pre);
        
        clean();
        
        post = $('#contents').contents();
        $(this).empty().append(post);
    })

    // each temporal is appended to #contents
    $('.temporal').each(function() {
        $('#contents').append($(this).remove().contents())
    })

    illustrationfy();
    chapterify();

    $('#bookhtml').val($.trim($('#contents').html()));

}

$(document).ready(function() {


    for (i = 1; i <= parts; i++) {
        $('body').append($('<div id="temporal' + i + '" class="temporal"></div>'))
    }

    $('.temporal').hide();

    for (i = 1; i <= parts; i++) {
        LoadExternal('/test.html', i)
    }

    WaitUntilLoaded()



});

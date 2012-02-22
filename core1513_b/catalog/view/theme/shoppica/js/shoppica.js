// Hover effect for the header menu
$("#categories > ul > li").not("#menu_home").hover(
    function() {
      if ($(this).find("div.s_submenu").length) {
        var offset = $(this).offset();
        var position = $(this).find("div.s_submenu").width() + offset.left;
        var window_width = $(window).width();
        if (position > window_width) {
          $(this).find("div.s_submenu").css({
            'left' : 'auto',
            'right' : 0 
          })
        }
      }
      $(this).find("a:first").stop().animate({
            color: '#ffffff',
            backgroundColor: $("#secondary_color").val()
        },300
      );
    }
    ,
    function() {
      $(this).find("a:first").stop().animate({
            color: $("#secondary_color").val(),
            backgroundColor: '#ffffff'
        },300
      );
    }
);

if (!$.browser.msie || parseInt($.browser.version, 10) > 8) {
    var onMouseOutOpacity = 1;
    $('div.s_listing > div.s_item').css('opacity', onMouseOutOpacity)
    .hover(
        function () {
            $(this).prevAll().stop().fadeTo('slow', 0.60);
            $(this).nextAll().stop().fadeTo('slow', 0.60);
        },
        function () {
            $(this).prevAll().stop().fadeTo('slow', onMouseOutOpacity);
            $(this).nextAll().stop().fadeTo('slow', onMouseOutOpacity);
        }
    );
}

// Hover effect for the shoppica cart
$("#cart_menu").hover(
    function() {
        $(this).find(".s_grand_total").stop().animate({
            color: '#ffffff',
            backgroundColor: $("#main_color").val()
        },300);
    }
    ,
    function() {
        $(this).find(".s_grand_total").stop().animate({
            color: $("#main_color").val(),
            backgroundColor: '#ffffff'
        },300);
    }
);

// Animation for the languages and currency dropdown
$('.s_switcher').hover(function() {
    $(this).find('.s_options').stop(true, true).slideDown('fast');
},function() {
    $(this).find('.s_options').stop(true, true).slideUp('fast');
});


$(".s_server_msg").live("click", function() {
    $(this).fadeOut(200, function(){
        $(this).remove();
    });
});

var search_visibility = 0;
// Animation for the search button
$("#show_search").bind("click", function(){
    if (search_visibility == 0) {
        $("#search_bar").fadeIn();
        search_visibility = 1;
    } else {
        $("#search_bar").fadeOut();
        search_visibility = 0;
    }
});

/* Search */
function moduleSearch() {
    var filter_name = $('#filter_keyword').val();

    if (filter_name) {
        url = 'index.php?route=product/search&filter_name=' + encodeURIComponent(filter_name);
        location = url;
    }
}

$('#search_button').bind('click', function() {
    moduleSearch();
});

$('#filter_keyword').keydown(function(e) {
    if (e.keyCode == 13) {
        moduleSearch();
    }
});

function addToCart(product_id) {
    $.ajax({
        url: 'index.php?route=module/shoppica/cartCallback',
        type: 'post',
        data: 'product_id=' + product_id,
        dataType: 'json',
        success: function(json) {

            if (json['redirect']) {
                location = json['redirect'];
            }

            if (json['error']) {
                if (json['error']['warning']) {
                    addProductNotice(json['title'], json['thumb'], json['error']['warning'], 'failure');
                }
            }

            if (json['success']) {
                addProductNotice(json['title'], json['thumb'], json['success'], 'success');
                $('#cart_menu span.s_grand_total').html(json['total_sum']);
                $('#cart_menu div.s_cart_holder').html(json['output']);
            }
        }
    });
}

function removeCart(key) {
  $.ajax({
    url: 'index.php?route=module/shoppica/cartCallback',
    type: 'post',
    data: 'remove=' + key,
    dataType: 'json',
    success: function(json) {
      if (json['output']) {
                addProductNotice(json['title'], json['thumb'], json['success'], 'success');
                $('#cart_menu span.s_grand_total').html(json['total_sum']);
                $('#cart_menu div.s_cart_holder').html(json['output']);
      }
    }
  });
}

function removeVoucher(key) {
	$.ajax({
		url: 'index.php?route=module/shoppica/cartCallback',
		type: 'post',
		data: 'voucher=' + key,
		dataType: 'json',
		success: function(json) {
			if (json['output']) {
                //simpleNotice(json['title'], json['success'], 'success');
                $('#cart_menu span.s_grand_total').html(json['total_sum']);
                $('#cart_menu div.s_cart_holder').html(json['output']);
			}
		}
	});
}

function addToWishList(product_id) {
  $.ajax({
    url: 'index.php?route=module/shoppica/wishlistCallback',
    type: 'post',
    data: 'product_id=' + product_id,
    dataType: 'json',
    success: function(json) {
      if (json['success']) {
        addProductNotice(json['title'], json['thumb'], json['success'], 'success');
                $('#wishlist_total').html(json['total']);
      }
      if (json['failure']) {
        addProductNotice(json['title'], json['thumb'], json['failure'], 'failure');
                $('#wishlist_total').html(json['total']);
      }
    }
  });
}

function addToCompare(product_id) {
  $.ajax({
    url: 'index.php?route=module/shoppica/compareCallback',
    type: 'post',
    data: 'product_id=' + product_id,
    dataType: 'json',
    success: function(json) {
      if (json['success']) {
                addProductNotice(json['title'], json['thumb'], json['success'], 'success');
        $('#compare_total').html(json['total']);
      }
    }
  });
}

function appendNoticeTemplates() {
  if (!$("#notification-container").length) {
    var tpl = '<div id="notification-container" style="display: none">\
                 <div id="thumb-template">\
                   <a class="ui-notify-cross ui-notify-close s_button_remove" href="javascript:;">x</a>\
                   <h2 class="s_icon_24"><span class="s_icon s_#{type}_24"></span>#{title}</h2>\
                   <div class="s_item s_size_1 clearfix">\
                     <a class="s_thumb" href=""><img src="#{thumb}" /></a>\
                     <h3>#{text}</h3>\
                   </div>\
                 </div>\
                 <div id="nothumb-template">\
                   <a class="ui-notify-cross ui-notify-close s_button_remove" href="javascript:;">x</a>\
                   <h2 class="s_icon_24"><span class="s_icon s_#{type}_24"></span>#{title}</h2>\
                   <div class="s_item s_size_1 clearfix">\
                     <h3>#{text}</h3>\
                   </div>\
                 </div>\
               </div>';
    $(tpl).appendTo("body");
    $("#notification-container").notify();
  }
}

function addProductNotice(title, thumb, text, type) {
    if ($.browser.msie && $.browser.version.substr(0,1) < 8) {
        simpleNotice(title, text, type);

        return false;
    }
    appendNoticeTemplates();
    $("#notification-container").notify("create", "thumb-template", {
        title: title,
        thumb: thumb,
        text:  text,
        type: type
        },{
        expires: 8000
        }
    );
}

function simpleNotice(title, text, type) {
    appendNoticeTemplates();
    $("#notification-container").notify("create", "nothumb-template", {
        title: title,
        text:  text,
        type: type
        },{
        expires: 8000
        }
    );
}

function getUrlParam(name) {
  var name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.href);
  if (results == null)
    return "";
  else
    return results[1];
}

/*
jQuery Fieldtag Plugin
    * Version 1.1
    * 2009-05-07 10:10:35
    * URL: http://ajaxcssblog.com/jquery/fieldtag-watermark-inputfields/
    * Description: jQuery Plugin to dynamically tag an inputfield, with a class and/or text
    * Author: Matthias Jäggli
    * Copyright: Copyright (c) 2009 Matthias Jäggli under dual MIT/GPL license.
*/

(function($){$.fn.fieldtag=function(options){var opt=$.extend({markedClass:"tagged",standardText:false},options);$(this).focus(function(){if(!this.changed){this.clear();}}).blur(function(){if(!this.changed){this.addTag();}}).keyup(function(){this.changed=($(this).val()?true:false);}).each(function(){this.title=$(this).attr("title");if($(this).val()==$(this).attr("title")){this.changed=false;}
this.clear=function(){if(!this.changed){$(this).val("").removeClass(opt.markedClass);}}
this.addTag=function(){$(this).val(opt.standardText===false?this.title:opt.standardText).addClass(opt.markedClass);}
if(this.form){this.form.tagFieldsToClear=this.form.tagFieldsToClear||[];this.form.tagFieldsToClear.push(this);if(this.form.tagFieldsAreCleared){return true;}
this.form.tagFieldsAreCleared=true;$(this.form).submit(function(){$(this.tagFieldsToClear).each(function(){this.clear();});});}}).keyup().blur();return $(this);}})(jQuery);

$("#filter_keyword").fieldtag();

/**
 * jQuery Cookie plugin
 *
 * Copyright (c) 2010 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 *
 */
jQuery.cookie = function (key, value, options) {

    // key and at least value given, set cookie...
    if (arguments.length > 1 && String(value) !== "[object Object]") {
        options = jQuery.extend({}, options);

        if (value === null || value === undefined) {
            options.expires = -1;
        }

        if (typeof options.expires === 'number') {
            var days = options.expires, t = options.expires = new Date();
            t.setDate(t.getDate() + days);
        }

        value = String(value);

        return (document.cookie = [
            encodeURIComponent(key), '=',
            options.raw ? value : encodeURIComponent(value),
            options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
            options.path ? '; path=' + options.path : '',
            options.domain ? '; domain=' + options.domain : '',
            options.secure ? '; secure' : ''
        ].join(''));
    }

    // key and possibly options given, get cookie...
    options = value || {};
    var result, decode = options.raw ? function (s) { return s; } : decodeURIComponent;
    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
};
<h2><?php echo $heading_title; ?></h2>

<div class="cart-content" id="cart-content">

  <p><?php echo $text_shipping; ?></p>
  
  <div id="shipping" class="s_row_2 clearfix">
    <label><?php echo $entry_country; ?> *</label>
    <select id="country_id" name="country_id" onchange="$('select[name=\'zone_id\']').load('index.php?route=total/shipping/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
      <option value=""><?php echo $text_select; ?></option>
      <?php foreach ($countries as $country) { ?>
      <?php if ($country['country_id'] == $country_id) { ?>
      <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
  </div>
    
  <div class="s_row_2 clearfix">
    <label><?php echo $entry_zone; ?> *</label>
    <select id="zone_id" name="zone_id">
    </select>
  </div>
    
  <div class="s_row_2 s_mb_20 clearfix">
    <label><?php echo $entry_postcode; ?> *</label>
    <input type="text" name="postcode" id="postcode" value="<?php echo $postcode; ?>" size="30" />
  </div>
    
  <div class="s_submit clearfix">
    <a id="button-quote" class="s_button_1 s_button_1_small s_main_color_bgr left"><span class="s_text"><?php echo $button_quote; ?></span></a>
  </div>
    
  <div id="quote" style="display: none;"></div>
  <input type="hidden" name="shipping_method" value="<?php echo $code; ?>" />
  
  <script type="text/javascript">
  $('#button-quote').bind('click', function() {
    
    $("#cart-content p.s_error_msg").remove();
    $("#cart-content div.s_row_2").removeClass("s_error_row");  
  
    $.ajax({
      type: 'POST',
      url: 'index.php?route=total/shipping/quote',
      data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
      dataType: 'json',   
      beforeSend: function() {
        $('.success, .warning').remove();
        $('#button-quote').attr('disabled', true);
        $('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-quote').attr('disabled', false);
        $('.wait').remove();
      },    
      success: function(json) {
        $('.error').remove();

        if (json['redirect']) {
          location = json['redirect'];
        }
              
        if (json['error']) {
          if (json['error']['warning']) {
            $('#basket').before('<div class="warning">' + json['error']['warning'] + '</div>');
          }
          
          if (json['error']['country']) {
            $("#country_id").after('<p class="s_error_msg">' + json['error']['country'] + '</p>');
            $("#country_id").parent("div.s_row_3").addClass("s_error_row");
          } 
          
          if (json['error']['zone']) {
            $("#zone_id").after('<p class="s_error_msg">' + json['error']['zone'] + '</p>');
            $("#zone_id").parent("div.s_row_3").addClass("s_error_row");
          }
          
          if (json['error']['postcode']) {
            $("#postcode").after('<p class="s_error_msg">' + json['error']['postcode'] + '</p>');
            $("#postcode").parent("div.s_row_3").addClass("s_error_row");
          }         
        }
        //.length > 0
        if (json['shipping_methods']) {
          html  = '<br />';
          html += '<table width="100%" cellpadding="3">';
          
          for (i in json['shipping_methods']) {
            html += '<tr>';
            html += '  <td colspan="3"><b>' + json['shipping_methods'][i]['title'] + '</b></td>';
            html += '</tr>';
          
            if (!json['shipping_methods'][i]['error']) {
              for (j in json['shipping_methods'][i]['quote']) {
                html += '<tr>';
                
                if (json['shipping_methods'][i]['quote'][j]['code'] == $('input[name=\'shipping_method\']').attr('value')) {
                  html += '<td width="1"><input type="radio" name="shipping_method" value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" id="' + json['shipping_methods'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
                } else {
                  html += '<td width="1"><input type="radio" name="shipping_method" value="' + json['shipping_methods'][i]['quote'][j]['code'] + '" id="' + json['shipping_methods'][i]['quote'][j]['code'] + '" /></td>';
                }
                  
                html += '  <td><label for="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['title'] + '</label></td>';
                html += '  <td width="1"><label for="' + json['shipping_methods'][i]['quote'][j]['code'] + '">' + json['shipping_methods'][i]['quote'][j]['text'] + '</label></td>';
                html += '</tr>';
              }   
            } else {
              html += '<tr>';
              html += '  <td colspan="3"><div class="error">' + json['shipping_methods'][i]['error'] + '</div></td>';
              html += '</tr>  ';            
            }
          }
          
          html += '</table>';
          html += '<br /><a id="button-shipping" class="s_button_1 s_button_1_small s_main_color_bgr left"><span class="s_text"><?php echo $button_shipping; ?></span></a><span class="clear"></span>';        
      
          $('#quote').html(html); 
        
          $('#quote').slideDown('slow');
        }
      }
    });
  });

  $('#button-shipping').live('click', function() {
    var button_element = this;
    
    $("#quote p.s_error_msg").remove();
    $("#quote div.s_row_2").removeClass("s_error_row");  
  
    $.ajax({
      type: 'POST',
      url: 'index.php?route=total/shipping/calculate',
      data: 'shipping_method=' + $('input[name=\'shipping_method\']:checked').attr('value'),
      dataType: 'json',   
      beforeSend: function() {
        $('.warning').remove();
        $('#button-shipping').attr('disabled', true);
        $('#button-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-shipping').attr('disabled', false);
        $('.wait').remove();
      },    
      success: function(json) {
        if (json['error']) {
          $(button_element).after('<p class="s_error_msg">' + json['error'] + '</p>');
          $(button_element).parent("div.s_row_3").addClass("s_error_row");
        }
        
        if (json['redirect']) {
          location = json['redirect'];
        }
      }
    });
  });
  </script> 
  <script type="text/javascript">
  $('select[name=\'zone_id\']').load('index.php?route=total/shipping/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
  </script> 
  
</div>
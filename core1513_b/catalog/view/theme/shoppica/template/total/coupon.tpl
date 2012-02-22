<h2><?php echo $heading_title; ?></h2>

<div id="coupon" class="cart-content">
  
  <div id="apply_coupon" class="s_box_1 grid_6 left alpha">
    <div class="s_row_3 clearfix">
      <label><strong><?php echo $entry_coupon; ?></strong></label>
      <input type="text" name="coupon" value="<?php echo $coupon; ?>" size="28" />
      <a id="button-coupon" class="s_button_1 s_button_1_small s_main_color_bgr"><span class="s_text"><?php echo $button_coupon; ?></span></a>
    </div>
  </div>
  
  <span class="clear"></span>

  <script type="text/javascript">
  $('#button-coupon').bind('click', function() {
    var button_element = this;
    
    $("#apply_coupon p.s_error_msg").remove();
    $("#apply_coupon div.s_row_2").removeClass("s_error_row");
    
    $.ajax({
      type: 'POST',
      url: 'index.php?route=total/coupon/calculate',
      data: $('#coupon :input'),
      dataType: 'json',   
      beforeSend: function() {
        $('.success, .warning').remove();
        $('#button-coupon').attr('disabled', true);
        $('#button-coupon').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-coupon').attr('disabled', false);
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
  
</div>

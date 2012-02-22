<h2><?php echo $heading_title; ?></h2>
<div class="cart-content" id="reward">

  <div id="apply_coupon" class="s_box_1 grid_6 left alpha">
    <div class="s_row_3 clearfix">
      <label><strong><?php echo $entry_reward; ?></strong></label>
      <input type="text" name="reward" value="<?php echo $reward; ?>" size="28" />
      <a id="button-reward" class="s_button_1 s_button_1_small s_main_color_bgr"><span class="s_text"><?php echo $button_reward; ?></span></a>
    </div>
  </div>

  <span class="clear"></span>
  
  <script type="text/javascript"><!--
  $('#button-reward').bind('click', function() {
    $.ajax({
      type: 'POST',
      url: 'index.php?route=total/reward/calculate',
      data: $('#reward :input'),
      dataType: 'json',   
      beforeSend: function() {
        $('.success, .warning').remove();
        $('#button-reward').attr('disabled', true);
        $('#button-reward').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-reward').attr('disabled', false);
        $('.wait').remove();
      },    
      success: function(json) {
        if (json['error']) {
          $('#basket').before('<div class="warning">' + json['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
        }
        
        if (json['redirect']) {
          location = json['redirect'];
        }
      }
    });
  });
  //--></script>

</div>

 

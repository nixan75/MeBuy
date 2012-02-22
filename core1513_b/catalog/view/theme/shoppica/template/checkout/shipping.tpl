    <?php if ($error_warning): ?>
    <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
    <?php endif; ?>

    <p><?php echo $text_shipping_method; ?></p>
    
    <?php foreach ($shipping_methods as $shipping_method): ?>
    <div class="s_row_3 clearfix">
      <label><strong><?php echo $shipping_method['title']; ?></strong></label>
      <?php if (!$shipping_method['error']): ?>
      <div class="s_full clearfix">
        <?php foreach ($shipping_method['quote'] as $quote): ?>
          <?php if ($quote['code'] == $code || !$code): ?>
          <?php $code = $quote['code']; ?>
          <label class="s_radio" for="<?php echo $quote['code']; ?>"><input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" /> <?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></label>
          <?php else: ?>
          <label class="s_radio" for="<?php echo $quote['code']; ?>"><input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" /> <?php echo $quote['title']; ?> - <?php echo $quote['text']; ?></label>
          <?php endif; ?>
        <?php endforeach; ?>
      </div>
      <?php else: ?>
      <div class="s_error_msg"><?php echo $shipping_method['error']; ?></div>
      <?php endif; ?>
    </div>
    <?php endforeach; ?>

    <span class="s_mb_20 clear border_eee"></span>

    <h2><?php echo $text_comments; ?></h2>
    <div class="s_row_3 clearfix">
      <textarea name="comment" rows="8" style="width: 99%;"><?php echo $comment; ?></textarea>
    </div>
    
    <div class="s_submit clearfix"> 
      <a id="button-shipping" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
    </div>

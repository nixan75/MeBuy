  <?php if ($error_warning): ?>
  <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
  <?php endif; ?>

  <?php if ($payment_methods): ?>
  <p><?php echo $text_payment_method; ?></p>
  <div class="s_row_3 clearfix">
    <?php foreach ($payment_methods as $payment_method): ?>
    <?php if ($payment_method['code'] == $code || !$code): ?>
    <label class="s_radio" for="<?php echo $payment_method['code']; ?>">
      <?php $code = $payment_method['code']; ?>
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" checked="checked" />
      <strong><?php echo $payment_method['title']; ?></strong>
    </label>
    <?php else: ?>
    <label class="s_radio" for="<?php echo $payment_method['code']; ?>">
      <input type="radio" name="payment_method" value="<?php echo $payment_method['code']; ?>" id="<?php echo $payment_method['code']; ?>" />
      <strong><?php echo $payment_method['title']; ?></strong>
    </label>
    <?php endif; ?>
    <?php endforeach; ?>
  </div>
  <?php endif; ?>

  <span class="clear border_eee"></span>
  <br />

  <h2><?php echo $text_comments; ?></h2>
  <div class="s_row_3 clearfix">
    <textarea name="comment" rows="8" style="width: 99%;"><?php echo $comment; ?></textarea>
  </div>

  <?php if ($text_agree): ?>
  <div class="s_row_3 clearfix">
    <?php if ($agree): ?>
    <label class="s_checkbox"><input type="checkbox" name="agree" value="1" checked="checked" /> <?php echo $this->document->shoppica_text_agree_checkout; ?></label>
    <?php else: ?>
    <label class="s_checkbox"><input type="checkbox" name="agree" value="1" /> <?php echo $this->document->shoppica_text_agree_checkout; ?></label>
    <?php endif; ?>
  </div>

  <span class="s_mb_20 clear border_eee"></span>
  <?php endif; ?>

  <div class="s_submit clearfix">
    <a id="button-payment" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a></td>
  </div>


  <script type="text/javascript">
    jQuery( function($) {
      $("a[rel^='prettyPhoto']").prettyPhoto({
        theme: 'light_square', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
        opacity: 0.5,
        social_tools: "",
        deeplinking: false
      });
    });
  </script>


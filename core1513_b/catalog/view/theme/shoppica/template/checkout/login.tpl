<div class="s_2col_wrap clearfix">

  <div class="s_col_1_2">
    <h2 class="s_title_1"><?php echo $text_new_customer; ?></h2>
    <div class="clear"></div>
    <div class="s_row_3 clearfix">
      <p><?php echo $text_checkout; ?></p>
      <label class="s_radio" for="register">
        <?php if ($account == 'register'): ?>
        <input type="radio" name="account" value="register" id="register" checked="checked" />
        <?php else: ?>
        <input type="radio" name="account" value="register" id="register" />
        <?php endif; ?>
        <strong><?php echo $text_register; ?></strong>
      </label>
      <?php if ($guest_checkout): ?>
      <label for="guest" style="cursor: pointer;">
        <?php if ($account == 'guest'): ?>
        <input type="radio" name="account" value="guest" id="guest" checked="checked" />
        <?php else: ?>
        <input type="radio" name="account" value="guest" id="guest" />
        <?php endif; ?>
        <strong><?php echo $text_guest; ?></strong>
      </label>
      <?php endif; ?>
      <br />
      <p class="s_mb_10"><?php echo $text_register_account; ?></p>
    </div>
    <span class="clear border_ddd s_mb_20"></span>
    <a id="button-account" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
  </div>

  <div class="s_col_1_2 s_col_last">
    <h2 class="s_title_1"><?php echo $text_returning_customer; ?></h2>
    <div class="clear"></div>
    <form id="returning_customer_login">
      <div class="s_row_3 clearfix">
        <?php echo $text_i_am_returning_customer; ?><br /><br />
        <label><strong><?php echo $entry_email; ?></strong></label>
        <input type="text" name="email" size="35" class="required email" title="<?php echo $this->document->shoppica_text_error_email ?>" />
        <br />
        <br />
        <span class="clear"></span>
        <label><strong><?php echo $entry_password; ?></strong></label>
        <input type="password" name="password" size="35" class="required" title="<?php echo $this->document->shoppica_text_error_password ?>" />
        <br />
      </div>
    </form>
    <span class="clear border_ddd s_mb_20"></span>
    <div class="s_nav s_size_2 left">
      <ul class="s_mb_0 clearfix">
        <li><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>
      </ul>
    </div>
    <a id="button-login" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_login; ?></span></a>

  </div>

</div>


<div class="clear"></div>

<script type="text/javascript">
  $(document).ready(function() {
    $("#returning_customer_login").validate();
  });
</script>
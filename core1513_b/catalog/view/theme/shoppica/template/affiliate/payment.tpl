<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="container_12">
        <div id="breadcrumbs" class="grid_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php endforeach; ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>
      </div>
    </div>
  </div>
  <!-- end of intro -->

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $container = 12; $main = 9; $side_col = 3; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $container = 12; $main = 12; $side_col = 3; } ?>
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 16; $main = 12; $side_col = 4; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 12; $main = 12; $side_col = 3; } ?>
  
  <div id="content" class="container_<?php echo $container; ?>">
  
    <?php if ($this->document->shoppica_column_position == "left" && $column_right): ?>
    <div id="left_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div id="payment_preferences" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <form id="payment_preferences_form" class="clearfix" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

        <h2 class="s_title_1"><?php echo $text_your_payment; ?></h2>
        <div class="clear"></div>

        <div class="s_row_2 clearfix">
          <label><?php echo $entry_tax; ?></label>
          <input type="text" name="tax" size="30" value="<?php echo $tax; ?>" />
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_payment; ?></label>
          <div class="s_full clearfix">
            <?php if ($payment == 'cheque') { ?>
            <label  class="s_checkbox" for="cheque"><input type="radio" name="payment" value="cheque" id="cheque" checked="checked" /> <?php echo $text_cheque; ?></label>
            <?php } else { ?>
            <label class="s_checkbox" for="cheque"><input type="radio" name="payment" value="cheque" id="cheque" /> <?php echo $text_cheque; ?></label>
            <?php } ?>
            <?php if ($payment == 'paypal') { ?>
            <label class="s_checkbox" for="paypal"><input type="radio" name="payment" value="paypal" id="paypal" checked="checked" /> <?php echo $text_paypal; ?></label>
            <?php } else { ?>
            <label class="s_checkbox" for="paypal"><input type="radio" name="payment" value="paypal" id="paypal" /> <?php echo $text_paypal; ?></label>
            <?php } ?>
            <?php if ($payment == 'bank') { ?>
            <label class="s_checkbox" for="bank"><input type="radio" name="payment" value="bank" id="bank" checked="checked" /> <?php echo $text_bank; ?></label>
            <?php } else { ?>
            <label class="s_checkbox" for="bank"><input type="radio" name="payment" value="bank" id="bank" /> <?php echo $text_bank; ?></label>
            <?php } ?>
          </div>
        </div>
        <div id="payment-cheque" class="payment s_row_2 s_mb_20 clearfix">
          <label><?php echo $entry_cheque; ?></label>
          <input type="text" name="cheque" size="30" value="<?php echo $cheque; ?>" />
        </div>
        <div id="payment-paypal" class="payment s_row_2 s_mb_20 clearfix">
          <label><?php echo $entry_paypal; ?></label>
          <input type="text" name="paypal" size="30" value="<?php echo $paypal; ?>" />
        </div>
        <div id="payment-bank" class="payment s_mb_20">
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_name; ?></label>
            <input type="text" name="bank_name" size="30" value="<?php echo $bank_name; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_branch_number; ?></label>
            <input type="text" name="bank_branch_number" size="30" value="<?php echo $bank_branch_number; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_swift_code; ?></label>
            <input type="text" name="bank_swift_code" size="30" value="<?php echo $bank_swift_code; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_account_name; ?></label>
            <input type="text" name="bank_account_name" size="30" value="<?php echo $bank_account_name; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_account_number; ?></label>
            <input type="text" name="bank_account_number" size="30" value="<?php echo $bank_account_number; ?>" />
          </div>
        </div>

        <span class="clear border_ddd s_mb_30"></span>

        <div class="s_submit s_mb_25 clearfix">
          <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo $back; ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#payment_preferences_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

      </form>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($this->document->shoppica_column_position == "right" && $column_right): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->
  

  <script type="text/javascript"><!--
    $('input[name=\'payment\']').bind('change', function() {
      $('.payment').hide();
      $('#payment-' + this.value).show();
    });
    $('input[name=\'payment\']:checked').trigger('change');
  //--></script> 
  

<?php echo $footer; ?>

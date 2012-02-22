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

    <div id="gift_voucher_purchase" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>
      
      <?php if ($error_warning): ?>
      <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>

      <p><?php echo $text_description; ?></p>
  
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="voucher_form">

        <div class="s_row_2<?php if ($error_to_name): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_to_name; ?> *</label>
          <input type="text" name="to_name" size="43" value="<?php echo $to_name; ?>" />
          <?php if ($error_to_name): ?>
          <p class="s_error_msg"><?php echo $error_to_name; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2<?php if ($error_to_email): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_to_email; ?> *</label>
          <input type="text" name="to_email" size="43" value="<?php echo $to_email; ?>" />
          <?php if ($error_to_email): ?>
          <p class="s_error_msg"><?php echo $error_to_email; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2<?php if ($error_from_name): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_from_name; ?> *</label>
          <input type="text" name="from_name" size="43" value="<?php echo $from_name; ?>" />
          <?php if ($error_from_name): ?>
          <p class="s_error_msg"><?php echo $error_from_name; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2<?php if ($error_from_email): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_from_email; ?> *</label>
          <input type="text" name="from_email" size="43" value="<?php echo $from_email; ?>" />
          <?php if ($error_from_email): ?>
          <p class="s_error_msg"><?php echo $error_from_email; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_message; ?></label>
          <textarea name="message" cols="40" rows="5"><?php echo $message; ?></textarea>
        </div>
        <div class="s_row_2<?php if ($error_amount): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_amount; ?> *</label>
          <input type="text" name="amount" value="<?php echo $amount; ?>" size="5" />
          <?php if ($error_amount): ?>
          <p class="s_error_msg"><?php echo $error_amount; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2<?php if ($error_theme): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_theme; ?> *</label>
          <div class="s_full clearfix">
            <?php foreach ($voucher_themes as $voucher_theme): ?>
            <?php if ($voucher_theme['voucher_theme_id'] == $voucher_theme_id): ?>
            <label class="s_radio" for="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>"><input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" id="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>" checked="checked" /> <?php echo $voucher_theme['name']; ?></label>
            <?php else: ?>
            <label class="s_radio" for="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>"><input type="radio" name="voucher_theme_id" value="<?php echo $voucher_theme['voucher_theme_id']; ?>" id="voucher-<?php echo $voucher_theme['voucher_theme_id']; ?>" /> <?php echo $voucher_theme['name']; ?></label>
            <?php endif; ?>
            <?php endforeach; ?>
            <?php if ($error_theme): ?>
            <span class="clear"></span>
            <p class="s_error_msg"><?php echo $error_theme; ?></p>
            <?php endif; ?>
          </div>
        </div>

        <span class="clear s_mb_30 border_eee"></span>

        <div class="s_submit s_mb_25 clearfix">
          <?php if ($agree): ?>
          <label class="s_checkbox left"><input type="checkbox" name="agree" value="1" checked="checked" /> <?php echo $text_agree; ?></label>
          <?php else: ?>
          <label class="s_checkbox left"><input type="checkbox" name="agree" value="1" /> <?php echo $text_agree; ?></label>
          <?php endif; ?>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#voucher_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
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

<?php echo $footer; ?>
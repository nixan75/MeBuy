<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="container_12">
        <div id="breadcrumbs" class="grid_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo str_replace('&', '&amp;', $breadcrumb['href']); ?>"><?php echo $breadcrumb['text']; ?></a>
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

    <div id="newsletter_subscribtion" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <form id="newsletter" class="clearfix" action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" enctype="multipart/form-data">

        <div class="s_row_2 clearfix">
          <label><?php echo $entry_newsletter; ?></label>
          <div class="s_full">
            <?php if ($newsletter): ?>
            <label class="s_radio"><input type="radio" name="newsletter" value="1" checked="checked" /> <?php echo $text_yes; ?></label>
            <label class="s_radio"><input type="radio" name="newsletter" value="0" /> <?php echo $text_no; ?></label>
            <?php else: ?>
            <label class="s_radio"><input type="radio" name="newsletter" value="1" /> <?php echo $text_yes; ?></label>
            <label class="s_radio"><input type="radio" name="newsletter" value="0" checked="checked" /> <?php echo $text_no; ?></label>
            <?php endif; ?>
          </div>
        </div>
        
        <span class="clear s_mb_25 border_ddd"></span>
        
        <div class="s_submit clearfix">
          <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo $back; ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#newsletter').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
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

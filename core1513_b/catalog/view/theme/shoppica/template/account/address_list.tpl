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

    <div id="my_addresses" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <?php if ($success): ?>
      <div class="s_msg_green s_server_msg"><p><?php echo $success; ?></p></div>
      <?php endif; ?>

      <?php if ($error_warning): ?>
      <div class="s_msg_red s_server_msg"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>

      <p><?php echo $text_address_book; ?></p>

      <?php foreach ($addresses as $result): ?>
      <div class="s_address">
        <?php echo $result['address']; ?>
        <span class="clear"></span>
        <br />
        <div class="s_f_12">
          <a class="s_main_color" href="javascript:;" onclick="location = '<?php echo $result['update']; ?>'"><?php echo $button_edit; ?></a>
          &nbsp;&nbsp;
          <a class="s_main_color" href="javascript:;" onclick="location = '<?php echo $result['delete']; ?>'"><?php echo $button_delete; ?></a>
        </div>
      </div>
      <?php endforeach; ?>

      <span class="clear border_ddd s_mb_30"></span>

      <div class="s_submit s_mb_25 clearfix">
        <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo $back; ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
        <a class="s_button_1 s_main_color_bgr" onclick="location = '<?php echo $insert; ?>'"><span class="s_text"><?php echo $button_new_address; ?></span></a>
      </div>

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
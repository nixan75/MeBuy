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

    <div id="return_requests" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <?php if ($returns): ?>
      <div class="s_listing s_grid_view clearfix">
        <?php foreach ($returns as $return): ?>
        <div class="grid_<?php echo $main/3; ?>">
          <div class="s_order clearfix">
            <p class="s_id"><span class="s_999"><?php echo $text_return_id; ?></span> <span class="s_secondary_color">#<?php echo $return['return_id']; ?></span></p>
            <a class="s_main_color right" href="<?php echo $return['href']; ?>"><strong><?php echo $button_view; ?></strong></a>
            <dl>
              <dt><?php echo $text_status; ?></dt>
              <dd><?php echo $return['status']; ?></dd>
              <dt><?php echo $text_date_added; ?></dt>
              <dd><?php echo $return['date_added']; ?></dd>
              <dt><?php echo $text_order_id; ?></dt>
              <dd><?php echo $return['order_id']; ?></dd>
              <dt><?php echo $text_customer; ?></dt>
              <dd><?php echo $return['name']; ?></dd>
              <dt class="s_mb_0"><?php echo $text_products; ?></dt>
              <dd class="s_mb_0"><?php echo $return['products']; ?></dd>
            </dl>
          </div>
        </div>
        <?php endforeach ?>
      </div>

      <div class="pagination"><?php echo $pagination; ?></div>

      <span class="clear border_ddd s_mb_30"></span>
      
      <?php else: ?>
      <p class="align_center s_f_16 s_p_20_0"><?php echo $text_empty; ?></p>
      <?php endif; ?>
      
      <div class="s_submit s_mb_25 clearfix">
        <a class="s_button_1 s_main_color_bgr" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_continue; ?></span></a>
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
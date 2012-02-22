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

    <div id="order_history" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>
      
      <?php if ($orders): ?>
      <div class="s_listing s_grid_view clearfix">
        <?php foreach ($orders as $order): ?>

        <div class="grid_<?php echo $main/3; ?>">
          <div class="s_order clearfix">
            <p class="s_id"><span class="s_999"><?php echo $text_order_id; ?></span> <span class="s_main_color">#<?php echo $order['order_id']; ?></span></p>
            <p class="s_status s_secondary_color"><?php echo $order['status']; ?></p>
            <span class="clear"></span>
            <dl class="clearfix">
              <dt><?php echo $text_date_added; ?></dt>
              <dd><?php echo $order['date_added']; ?></dd>
              <dt><?php echo $text_customer; ?></dt>
              <dd><?php echo $order['name']; ?></dd>
              <dt><?php echo $text_products; ?></dt>
              <dd><?php echo $order['products']; ?></dd>
            </dl>
            <span class="clear border_eee"></span>
            <br />
            <p class="s_total left"><?php echo $order['total']; ?></p>
            <a class="s_main_color right" onclick="location = '<?php echo $order['href']; ?>'"><strong><?php echo $button_view; ?></strong></a>
          </div>
        </div>
        <?php endforeach; ?>
      </div>
      <div class="pagination"><?php echo $pagination; ?></div>
      <?php else: ?>
      <div class="content"><?php echo $text_empty; ?></div>
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
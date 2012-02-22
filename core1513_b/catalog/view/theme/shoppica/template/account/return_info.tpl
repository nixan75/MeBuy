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

    <div id="return_request_info" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <div class="s_order clearfix">

        <p class="s_status"><span class="s_999"><?php echo $text_order_id; ?></span> <span class="s_secondary_color">#<?php echo $order_id; ?></span></p>

        <p class="s_id"><span class="s_999"><?php echo $text_return_id; ?></span> <span class="s_main_color">#<?php echo $return_id; ?></span></p>

        <span class="clear s_mb_20 border_eee"></span>
        
        <dl class="s_mb_15 clearfix">
          <dt><?php echo $text_date_ordered; ?></dt>
          <dd><?php echo $date_ordered; ?></dd>
          <dt><?php echo $text_date_added; ?></dt>
          <dd><?php echo $date_added; ?></dd>
        </dl>
        
        <span class="clear s_mb_10 border_eee"></span>
        
        <h2><?php echo $text_product; ?></h2>
        
        <table class="s_table s_mb_20" width="100%" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th><?php echo $column_name; ?></th>
              <th><?php echo $column_model; ?></th>
              <th><?php echo $column_quantity; ?></th>
              <th><?php echo $column_reason; ?></th>
              <th><?php echo $column_opened; ?></th>
              <th><?php echo $column_comment; ?></th>
              <th><?php echo $column_action; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($products as $product) { ?>
            <tr>
              <td><?php echo $product['name']; ?></td>
              <td><?php echo $product['model']; ?></td>
              <td><?php echo $product['quantity']; ?></td>
              <td><?php echo $product['reason']; ?></td>
              <td><?php echo $product['opened']; ?></td>
              <td class="align_left"><?php echo $product['comment']; ?></td>
              <td><?php echo $product['action']; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
        
        <?php if ($comment) { ?>
        <table class="s_table s_mb_20" width="100%" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <td><?php echo $text_comment; ?></td>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="align_left"><?php echo $comment; ?></td>
            </tr>
          </tbody>
        </table>
        <?php } ?>
        
        <?php if ($histories) { ?>
        <h2><?php echo $text_history; ?></h2>
        <table class="s_table s_mb_20" width="100%" cellpadding="0" cellspacing="0" border="0">
          <thead>
            <tr>
              <th><?php echo $column_date_added; ?></th>
              <th><?php echo $column_status; ?></th>
              <th><?php echo $column_comment; ?></th>
            </tr>
          </thead>
          <tbody>
            <?php foreach ($histories as $history) { ?>
            <tr>
              <td><?php echo $history['date_added']; ?></td>
              <td><?php echo $history['status']; ?></td>
              <td class="align_left"><?php echo $history['comment']; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
        <?php } ?>
      
        <div class="s_submit clearfix">
          <a class="s_button_1 s_main_color_bgr" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>
        
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
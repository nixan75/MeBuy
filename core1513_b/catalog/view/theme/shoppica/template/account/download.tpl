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

    <div id="downloads" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>
      
      <table class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <th><?php echo $text_order; ?></th>
          <th><?php echo $text_name; ?></th>
          <th><?php echo $text_size; ?></th>
          <th><?php echo $text_date_added; ?></th>
          <th><?php echo $text_remaining; ?></th>
          <th>&nbsp;</th>
        </tr>
        <?php foreach ($downloads as $download): ?>
        <tr>
          <td><?php echo $download['order_id']; ?></td>
          <td><?php echo $download['name']; ?></td>
          <td><?php echo $download['size']; ?></td>
          <td><?php echo $download['date_added']; ?></td>
          <td><?php echo $download['remaining']; ?></td>
          <td>
            <?php if ($download['remaining'] > 0): ?>
            <a class="s_main_color" href="<?php echo $download['href']; ?>"><strong><?php echo $text_download; ?></strong></a>
            <?php endif; ?>
          </td>
        </tr>
        <?php endforeach; ?>
      </table>

      <div class="pagination"><?php echo $pagination; ?></div>

      <span class="clear border_ddd s_mb_30"></span>

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

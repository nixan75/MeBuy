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

    <div id="my_account" class="grid_<?php echo $main; ?>">
  
      <?php echo $content_top; ?>
  
      <?php if ($success): ?>
      <div class="s_msg_green s_server_msg"><p><?php echo $success; ?></p></div>
      <?php endif; ?>
  
      <div class="grid_<?php echo $main/3; ?> alpha">
        <h2 class="s_title_1"><?php echo $text_my_account; ?></h2>
        <div class="clear"></div>
        <ul class="s_list_1">
          <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
          <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
          <li><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
          <?php if ($this->affiliate->isLogged()): ?>
          <li><a href="<?php echo $this->url->link('affiliate/logout', '', 'SSL'); ?>"><?php echo $this->document->shoppica_text_logout; ?></a></li>
          <?php endif; ?>
        </ul>
      </div>
  
      <div class="grid_<?php echo $main/3; ?>">
        <h2 class="s_title_1"><?php echo $text_my_tracking; ?></h2>
        <div class="clear"></div>
        <ul class="s_list_1">
          <li><a href="<?php echo $tracking; ?>"><?php echo $text_tracking; ?></a></li>
        </ul>
      </div>
  
      <div class="grid_<?php echo $main/3; ?> omega">
        <h2 class="s_title_1"><?php echo $text_my_transactions; ?></h2>
        <div class="clear"></div>
        <ul class="s_list_1">
          <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
        </ul>
      </div>
  
      <div class="clear"></div>
      <br />
  
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
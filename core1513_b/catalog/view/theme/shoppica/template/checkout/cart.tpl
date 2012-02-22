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
        <h1><?php echo $heading_title; ?><?php if ($weight): ?> (<?php echo $weight; ?>)<?php endif; ?></h1>
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

    <div id="shopping_cart" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <?php if ($error_warning): ?>
      <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>

      <?php if ($attention): ?>
      <div class="s_server_msg s_msg_yellow"><p><?php echo $attention; ?></p></div>
      <?php endif; ?>

      <?php if ($success): ?>
      <div class="s_server_msg s_msg_green"><p><?php echo $success; ?></p></div>
      <?php endif; ?>

      <form id="cart_form" class="clearfix" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <table class="s_table_1" width="100%" cellpadding="0" cellspacing="0" border="0">
          <tr>
            <th width="65"><?php echo $column_remove; ?></th>
            <th width="60"><?php echo $column_image; ?></th>
            <th width="320"><?php echo $column_name; ?></th>
            <th><?php echo $column_model; ?></th>
            <th><?php echo $column_quantity; ?></th>
            <th><?php echo $column_price; ?></th>
            <th><?php echo $column_total; ?></th>
          </tr>
          <?php $class = 'odd'; ?>
          <?php foreach ($products as $product): ?>
          <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
          <tr class="<?php echo $class; ?>">
            <td valign="middle"><input type="checkbox" name="remove[]" value="<?php echo $product['key']; ?>" /></td>
            <td valign="middle">
              <?php if ($product['thumb']): ?>
              <a href="<?php echo $product['href']; ?>">
                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
              </a>
              <?php endif; ?>
            </td>
            <td valign="middle"><a href="<?php echo $product['href']; ?>"><strong><?php echo $product['name']; ?></strong></a>
              <?php if (!$product['stock']): ?>
              <span style="color: #FF0000; font-weight: bold;">***</span>
              <?php endif; ?>
              <div>
                <?php foreach ($product['option'] as $option): ?>
                - <small><?php echo $option['name']; ?> <?php echo $option['value']; ?></small><br />
                <?php endforeach; ?>
              </div>
              <?php if (isset($product['reward']) && $product['reward']): ?>
                <small><?php echo $product['reward']; ?></small>
              <?php endif; ?>
            </td>
            <td valign="middle"><?php echo $product['model']; ?></td>
            <td valign="middle"><input type="text" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="3" /></td>
            <td valign="middle"><?php echo $product['price']; ?></td>
            <td valign="middle"><?php echo $product['total']; ?></td>
          </tr>
          <?php endforeach; ?>
          <?php foreach ($vouchers as $voucher): ?>
          <tr>
            <td valign="middle"><input type="checkbox" name="voucher[]" value="<?php echo $voucher['key']; ?>" /></td>
            <td valign="middle"></td>
            <td valign="middle"><?php echo $voucher['description']; ?></td>
            <td valign="middle"></td>
            <td valign="middle">1</td>
            <td valign="middle"><?php echo $voucher['amount']; ?></td>
            <td valign="middle"><?php echo $voucher['amount']; ?></td>
          </tr>
          <?php endforeach; ?>
        </table>

      </form>

      <div id="cart_totals" class="s_accordion s_mb_30">
        <?php foreach ($modules as $module): ?>
        <?php echo $module; ?>
        <?php endforeach; ?>
      </div>

      <script type="text/javascript">
      $(function() {
        $("#cart_totals").accordion({
          autoHeight:  false,
          collapsible: true,
          active:      false
        });
      });
      </script>

      <span class="clear"></span>

      <?php if ($totals): $i = 0; $j = count($totals); ?>
        <?php foreach ($totals as $total): ?>
        <p class="s_total<?php if($i == $j-1) echo ' s_secondary_color last'; ?>"><strong><?php echo $total['title']; ?></strong> <?php echo $total['text']; ?></p>
        <?php $i++; endforeach; ?>
        <span class="clear"></span>
        <span class="clear s_mb_20"></span>
      <?php endif; ?>

      <div class="s_submit clearfix s_mb_25">
        <a class="s_button_1 s_ddd_bgr left" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_shopping; ?></span></a>
        <a class="s_button_1 s_main_color_bgr" href="<?php echo $checkout; ?>"><span class="s_text"><?php echo $button_checkout; ?></span></a>
        <a class="s_button_1 s_main_color_bgr" onclick="$('#cart_form').submit();"><span class="s_text"><?php echo $button_update; ?></span></a>
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
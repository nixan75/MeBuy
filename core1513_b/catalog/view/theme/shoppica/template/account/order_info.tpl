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

    <div id="order_details" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <div class="s_order clearfix">

        <?php if ($invoice_no): ?>
        <p class="s_status"><span class="s_999"><?php echo $text_invoice_no; ?></span> <span class="s_secondary_color"><?php echo $invoice_no; ?></span></p>
        <?php endif; ?>

        <p class="s_id"><span class="s_999"><?php echo $text_order_id; ?></span> <span class="s_main_color">#<?php echo $order_id; ?></span></p>

        <span class="clear s_mb_20 border_eee"></span>

        <dl class="grid_<?php echo $main/2; ?> s_mb_15 clearfix">
          <dt><?php echo $text_date_added; ?></dt>
          <dd><?php echo $date_added; ?></dd>
          <dt><?php echo $text_payment_method; ?></dt>
          <dd><?php echo $payment_method; ?></dd>
          <?php if ($shipping_method): ?>
          <dt><?php echo $text_shipping_method; ?></dt>
          <dd><?php echo $shipping_method; ?></dd>
          <?php endif; ?>
        </dl>

        <span class="clear s_mb_10 border_eee"></span>

        <div class="left" style="width: 49%;">
          <h2><?php echo $text_payment_address; ?></h2>
          <p><?php echo $payment_address; ?></p>
        </div>

        <?php if ($shipping_address): ?>
        <div class="left" style="width: 49%;">
          <h2><?php echo $text_shipping_address; ?></h2>
          <p><?php echo $shipping_address; ?></p>
        </div>
        <?php endif; ?>

        <span class="clear s_mb_10 border_eee"></span>

        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="order">
          <h2><?php echo $this->document->shoppica_text_ordered_products; ?></h2>
          <table class="s_table s_mb_20" width="100%" cellpadding="0" cellspacing="0" border="0">
            <thead>
              <tr>
                <th width="1"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></th>
                <th><?php echo $column_name; ?></th>
                <th><?php echo $column_model; ?></th>
                <th><?php echo $column_quantity; ?></th>
                <th><?php echo $column_price; ?></th>
                <th><?php echo $column_total; ?></th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product): ?>
              <tr>
                <td style="text-align: center; vertical-align: middle;">
                  <?php if ($product['selected']): ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $product['order_product_id']; ?>" checked="checked" />
                  <?php else: ?>
                  <input type="checkbox" name="selected[]" value="<?php echo $product['order_product_id']; ?>" />
                  <?php endif; ?>
                </td>
                <td>
                  <?php echo $product['name']; ?>
                  <?php foreach ($product['option'] as $option): ?>
                  <br />
                  &nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                  <?php endforeach; ?>
                </td>
                <td><?php echo $product['model']; ?></td>
                <td><?php echo $product['quantity']; ?></td>
                <td><?php echo $product['price']; ?></td>
                <td><?php echo $product['total']; ?></td>
              </tr>
              <?php endforeach; ?>
            </tbody>
            <?php if ($totals): $i = 0; $j = count($totals); ?>
            <tfoot>
              <?php foreach ($totals as $total): ?>
              <tr<?php if($i == $j-1) echo ' class="last"'; ?>>
                <td class="align_right" colspan="5"><strong><?php echo $total['title']; ?></strong></td>
                <td<?php if($i == $j-1) echo ' class="s_secondary_color"'; ?>><?php echo $total['text']; ?></td>
              </tr>
              <?php $i++; endforeach; ?>
            </tfoot>
            <?php endif; ?>
          </table>

          <div class="right">
            <?php echo $text_action; ?>
            <select name="action" onchange="$('#order').submit();">
              <option value="" selected="selected"><?php echo $text_selected; ?></option>
              <option value="reorder"><?php echo $text_reorder; ?></option>
              <option value="return"><?php echo $text_return; ?></option>
            </select>
          </div>

        </form>

        <?php if ($histories): ?>
        <span class="clear"></span>

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
            <?php foreach ($histories as $history): ?>
            <tr>
              <td><?php echo $history['date_added']; ?></td>
              <td><?php echo $history['status']; ?></td>
              <td><?php echo $history['comment']; ?></td>
            </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
        <?php endif; ?>

        <?php if ($comment): ?>
        <span class="clear"></span>

        <h2><?php echo $text_comment; ?></h2>
        <p class="s_mb_25"><?php echo $comment; ?></p>
        <?php endif; ?>

        <span class="clear border_ddd s_mb_20"></span>

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

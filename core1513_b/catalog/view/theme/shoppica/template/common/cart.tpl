<?php if ($products || $vouchers): ?>

  <table class="s_cart_items" cellpadding="0" cellspacing="0" border="0">
    <?php foreach ($products as $product): ?>
    <tr>
      <td width="50">
        <?php if ($product['thumb']): ?>
        <a class="left" href="<?php echo $product['href']; ?>">
          <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
        </a>
        <?php endif; ?>
      </td>
      <td>
        <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
        <?php foreach ($product['option'] as $option): ?>
        <?php if ($option['type'] != 'textarea'): ?>
        <small class="block s_999">- <?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
        <?php endif; ?>
        <?php endforeach; ?>
      </td>
      <td width="35" class="s_cart_number">
        x<strong><?php echo $product['quantity']; ?></strong> -
      </td>
      <td width="50" class="s_cart_price">
        <?php echo $product['total']; ?>
      </td>
      <td width="26">
        <a href="javascript:;" class="s_button_remove" onclick="removeCart('<?php echo $product['key']; ?>');">&nbsp;</a>
      </td>
    </tr>
    <?php endforeach; ?>

    <?php foreach ($vouchers as $voucher): ?>
    <tr>
      <td colspan="2">
        <span class="block"><?php echo $voucher['description']; ?>
      </td>
      <td>
        x<strong>1</strong> -
      </td>
      <td align="right">
        <?php echo $voucher['amount']; ?></span>
      </td>
      <td width="26">
        <a href="javascript:;" class="s_button_remove" onclick="removeVoucher('<?php echo $voucher['key']; ?>');">&nbsp;</a>
      </td>
    </tr>
    <?php endforeach; ?>
    
  </table>

  <span class="clear s_mb_15 border_ddd"></span>
  <?php foreach ($totals as $total): ?>
  <div class="s_total clearfix"><strong class="cart_module_total left"><?php echo $total['title']; ?></strong><span class="cart_module_total"><?php echo $total['text']; ?></span></div>
  <?php endforeach; ?>
  <span class="clear s_mb_15"></span>
  <div class="align_center clearfix">
    <a class="s_button_1 s_secondary_color_bgr s_ml_0" href="<?php echo $this->url->link('checkout/cart'); ?>"><span class="s_text"><?php echo $this->document->shoppica_text_view_cart; ?></span></a>
    <a class="s_button_1 s_secondary_color_bgr" href="<?php echo $checkout; ?>"><span class="s_text"><?php echo $button_checkout; ?></span></a>
  </div>

<?php else: ?>

<div class="empty"><?php echo $text_empty; ?></div>

<?php endif; ?>
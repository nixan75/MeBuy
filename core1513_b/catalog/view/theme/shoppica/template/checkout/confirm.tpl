<div id="shopping_cart_confirm">

  <table class="s_table_1 s_mb_20" width="100%" cellpadding="0" cellspacing="0" border="0">
    <thead>
      <tr>
        <th class="name"><?php echo $column_name; ?></th>
        <th class="model"><?php echo $column_model; ?></th>
        <th class="quantity"><?php echo $column_quantity; ?></th>
        <th class="price"><?php echo $column_price; ?></th>
        <th class="total"><?php echo $column_total; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($products as $product) { ?>
      <tr>
        <td class="align_left"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
          <?php foreach ($product['option'] as $option) { ?>
          <br />
          <small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
          <?php } ?></td>
        <td class="model"><?php echo $product['model']; ?></td>
        <td class="quantity"><?php echo $product['quantity']; ?></td>
        <td class="price"><?php echo $product['price']; ?></td>
        <td class="total"><?php echo $product['total']; ?></td>
      </tr>
      <?php } ?>
      <?php foreach ($vouchers as $voucher) { ?>
      <tr>
        <td class="name"><?php echo $voucher['description']; ?></td>
        <td class="model"></td>
        <td class="quantity">1</td>
        <td class="price"><?php echo $voucher['amount']; ?></td>
        <td class="total"><?php echo $voucher['amount']; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
  
  <?php if ($totals) { $i = 0; $j = count($totals); ?>
  <div class="grid_5 right omega s_mb_20">
    <?php foreach ($totals as $total) { ?>
    <p class="s_total<?php if($i == $j-1) echo ' s_secondary_color last'; ?>">
      <strong><?php echo $total['title']; ?></strong>
      <?php echo $total['text']; ?>
    </p>
    <?php $i++; } ?>
  </div>
  <?php } ?>
  
  <span class="clear s_mb_20 border_eee"></span>

  <div class="payment clearfix"><?php echo $payment; ?></div>

</div>
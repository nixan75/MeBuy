<h2>Add products to slideshow</h2>
<form id="filter_form" action="<?php echo HTTPS_SERVER; ?>" method="post" enctype="multipart/form-data">
  <table class="s_table" cellpadding="0" cellspacing="0" border="0">
    <thead>
      <tr>
        <td width="62"><?php if ($sort == 'added') { ?>
          <a href="<?php echo $sort_added; ?>" class="<?php echo strtolower($order); ?>">added</a>
          <?php } else { ?>
          <a href="<?php echo $sort_added; ?>">added</a>
          <?php } ?></td>
        <td width="80"><?php echo $column_image; ?></td>
        <td width="270"><?php if ($sort == 'pd.name') { ?>
          <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
          <?php } ?></td>
        <td><?php if ($sort == 'p.model') { ?>
          <a href="<?php echo $sort_model; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_model; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_model; ?>"><?php echo $column_model; ?></a>
          <?php } ?></td>
        <td><?php if ($sort == 'p.price') { ?>
          <a href="<?php echo $sort_price; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_price; ?></a>
          <?php } else { ?>
          <a href="<?php echo $sort_price; ?>"><?php echo $column_price; ?></a>
          <?php } ?></td>
      </tr>
    </thead>
    <tbody>
      <tr class="filter">
        <td colspan="2"><a class="s_button_add s_button_filter"><?php echo $button_filter; ?></a></td>
        <td><input type="text" name="filter_name" value="<?php echo $filter_name; ?>" /></td>
        <td><input type="text" name="filter_model" value="<?php echo $filter_model; ?>" /></td>
        <td><input type="text" name="filter_price" value="<?php echo $filter_price; ?>" /></td>
      </tr>
      <?php if ($products) { ?>
      <?php foreach ($products as $product) { ?>
      <tr<?php if ($product['added']) echo ' class="s_selected"'; ?>>
        <td>
          <input type="hidden" value="<?php echo $product['product_id']; ?>" />
          <a class="s_button_add add_product" href="#"><span class="s_text_add">Add</span><span class="s_text_added">Added</span><span class="s_text_remove">Remove</span></a>
        </td>
        <td><img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" /></td>
        <td><strong><?php echo $product['name']; ?></strong></td>
        <td><?php echo $product['model']; ?></td>
        <td>
          <?php if ($product['special']) { ?>
          <span style="text-decoration:line-through"><?php echo $product['price']; ?></span><br/><span style="color:#b00;"><?php echo $product['special']; ?></span>
          <?php } else { ?>
          <?php echo $product['price']; ?>
          <?php } ?>
        </td>
      </tr>
      <?php } ?>
      <?php } else { ?>
      <tr>
        <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
      </tr>
      <?php } ?>
    </tbody>
  </table>
</form>
<div class="pagination"><?php echo $pagination; ?></div>

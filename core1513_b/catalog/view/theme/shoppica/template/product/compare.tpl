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
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1')  { $container = 12; $main = 12; $side_col = 3; } ?>
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 16; $main = 12; $side_col = 4; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2')  { $container = 12; $main = 12; $side_col = 3; } ?>
  
  <div id="content" class="container_<?php echo $container; ?>">
  
    <?php if ($this->document->shoppica_column_position == "left" && !$this->document->shoppica_rightColumnEmpty): ?>
    <div id="left_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
  
    <div id="compare" class="grid_<?php echo $main; ?>">
  
      <?php echo $content_top; ?>
    
      <?php if ($products): ?>
      <table class="s_table_1" width="100%" cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr>
            <th colspan="<?php echo count($products) + 1; ?>"><?php echo $text_product; ?></th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th><?php echo $text_name; ?></th>
            <?php foreach ($products as $product): ?>
            <td class="name"><a class="s_main_color" href="<?php echo $products[$product['product_id']]['href']; ?>"><?php echo $products[$product['product_id']]['name']; ?></a></td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_image; ?></th>
            <?php foreach ($products as $product): ?>
            <td class="s_product_thumb">
              <?php if ($products[$product['product_id']]['thumb']): ?>
              <img src="<?php echo $products[$product['product_id']]['thumb']; ?>" alt="<?php echo $products[$product['product_id']]['name']; ?>" />
              <?php endif; ?>
            </td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_price; ?></th>
            <?php foreach ($products as $product): ?>
            <td>
              <?php if ($products[$product['product_id']]['price']): ?>
                <?php if (!$products[$product['product_id']]['special']): ?>
                <?php echo $products[$product['product_id']]['price']; ?>
                <?php else: ?>
                <span class="price-old"><?php echo $products[$product['product_id']]['price']; ?></span> <span class="price-new"><?php echo $products[$product['product_id']]['special']; ?></span>
                <?php endif; ?>
              <?php endif; ?>
            </td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_model; ?></th>
            <?php foreach ($products as $product): ?>
            <td><?php echo $products[$product['product_id']]['model']; ?></td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_manufacturer; ?></th>
            <?php foreach ($products as $product): ?>
            <td><?php echo $products[$product['product_id']]['manufacturer']; ?></td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_availability; ?></th>
            <?php foreach ($products as $product): ?>
            <td><?php echo $products[$product['product_id']]['availability']; ?></td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_rating; ?></th>
            <?php foreach ($products as $product): ?>
            <td>
              <?php if ($products[$product['product_id']]['rating']): ?>
              <div class="s_rating_holder">
                <p class="s_rating s_rating_5 s_mb_0"><span style="width: <?php echo $products[$product['product_id']]['rating'] * 2 ; ?>0%;" class="s_percent"></span></p>
                <span class="s_average s_mb_0"><?php echo $products[$product['product_id']]['rating']; ?>/5</span>
                <span class="s_total">(<?php echo $products[$product['product_id']]['reviews']; ?>)</span>
              </div>
              <?php else: ?>
              <div class="s_rating_holder">
                <p class="s_rating s_rating_5 s_mb_0"></p>
                <span class="s_total"><?php echo $this->document->shoppica_not_yet_rated; ?></span>
              </div>
              <?php endif; ?>
            </td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_summary; ?></th>
            <?php foreach ($products as $product): ?>
            <td class="description align_left" valign="top"><?php echo $products[$product['product_id']]['description']; ?></td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_weight; ?></th>
            <?php foreach ($products as $product): ?>
            <td><?php echo $products[$product['product_id']]['weight']; ?></td>
            <?php endforeach; ?>
          </tr>
          <tr>
            <th><?php echo $text_dimension; ?></th>
            <?php foreach ($products as $product): ?>
            <td><?php echo $products[$product['product_id']]['length']; ?> x <?php echo $products[$product['product_id']]['width']; ?> x <?php echo $products[$product['product_id']]['height']; ?></td>
            <?php endforeach; ?>
          </tr>
        </tbody>
        <?php foreach ($attribute_groups as $attribute_group): ?>
        <thead>
          <tr>
            <th colspan="<?php echo count($products) + 1; ?>"><?php echo $attribute_group['name']; ?></th>
          </tr>
        </thead>
        <?php foreach ($attribute_group['attribute'] as $key => $attribute): ?>
        <tbody>
          <tr>
            <th><?php echo $attribute['name']; ?></th>
            <?php foreach ($products as $product): ?>
            <?php if (isset($products[$product['product_id']]['attribute'][$key])): ?>
            <td><?php echo $products[$product['product_id']]['attribute'][$key]; ?></td>
            <?php else: ?>
            <td></td>
            <?php endif; ?>
            <?php endforeach; ?>
          </tr>
        </tbody>
        <?php endforeach; ?>
        <?php endforeach; ?>
        <tr>
          <th></th>
          <?php foreach ($products as $product): ?>
          <td><a class="s_button_add_to_cart" onclick="addToCart('<?php echo $product['product_id']; ?>');"><span class="s_icon_16"><span class="s_icon"></span> <?php echo $button_cart; ?></span></a></td>
          <?php endforeach; ?>
        </tr>
        <tr>
          <th></th>
          <?php foreach ($products as $product): ?>
          <td>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
              <input type="hidden" name="remove" value="<?php echo $product['product_id']; ?>" />
              <a class="s_secondary_color" onclick="$(this).parent().submit();"><?php echo $text_remove; ?></a>
            </form>
          </td>
          <?php endforeach; ?>
        </tr>
      </table>
      
      <div class="buttons">
        <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
      </div>
      <?php else: ?>
      <div class="content"><?php echo $text_empty; ?></div>
      <div class="buttons">
        <div class="right"><a href="<?php echo $continue; ?>" class="button"><span><?php echo $button_continue; ?></span></a></div>
      </div>
      <?php endif; ?>
  
      <?php echo $content_bottom; ?>
    
    </div>
  
    <?php if ($this->document->shoppica_column_position == "right" && !$this->document->shoppica_rightColumnEmpty): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>
  
  </div>
  <!-- end of content -->

<?php echo $footer; ?>
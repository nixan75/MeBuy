<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <?php if ($this->document->shoppica_intro_banner): echo $this->document->shoppica_intro_banner; else: ?>

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
    <?php endif; ?>
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

    <div id="wishlist" class="grid_<?php echo $main; ?>">
  
      <?php echo $content_top; ?>
  
      <?php if ($products): ?>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="wishlist_form">
        <div class="wishlist-product">
          <table class="s_table_1" cellpadding="0" cellspacing="0" border="0" width="100%">
            <thead>
              <tr>
                <th class="remove" width="55"><?php echo $column_remove; ?></th>
                <th class="image"><?php echo $column_image; ?></th>
                <th class="name"><?php echo $column_name; ?></th>
                <?php /*
                <th class="model"><?php echo $column_model; ?></th>
                */ ?>
                <th class="stock"><?php echo $column_stock; ?></th>
                <th class="price"><?php echo $column_price; ?></th>
                <th class="cart"><?php echo $column_cart; ?></th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($products as $product): ?>
              <tr>
                <td class="remove"><input type="checkbox" name="remove[]" value="<?php echo $product['product_id']; ?>" /></td>
                <td class="image">
                  <?php if ($product['thumb']): ?>
                  <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
                  <?php endif; ?>
                </td>
                <td class="name"><a class="s_main_color" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></td>
                <?php /*
                <td class="model"><?php echo $product['model']; ?></td>
                */ ?>
                <td class="stock"><?php echo $product['stock']; ?></td>
                <td class="price"><?php if ($product['price']): ?>
                  <div class="price">
                    <?php if (!$product['special']): ?>
                    <?php echo $product['price']; ?>
                    <?php else: ?>
                    <s><?php echo $product['price']; ?></s><br /><b><?php echo $product['special']; ?></b>
                    <?php endif; ?>
                  </div>
                  <?php endif; ?></td>
                <td class="cart">
                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="s_button_add_to_cart"><span class="s_icon_16"><span class="s_icon"></span><?php echo $button_cart; ?></span></a>
                </td>
              </tr>
              <?php endforeach; ?>
            </tbody>
          </table>
        </div>
      </form>
      
      <div class="s_submit s_mb_30 clearfix">
        <a href="<?php echo $back; ?>" class="s_button_1 s_ddd_bgr left"><span class="s_text"><?php echo $button_back; ?></span></a>
        <a onclick="$('#wishlist_form').submit();" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_update; ?></span></a>
      </div>
      
      <?php else: ?>
      
      <div class="content"><?php echo $text_empty; ?></div>
      <div class="s_submit s_mb_30 clearfix">
        <a href="<?php echo $continue; ?>" class="s_button_1 s_ddd_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
      </div>
      
      <?php endif; ?>

      
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
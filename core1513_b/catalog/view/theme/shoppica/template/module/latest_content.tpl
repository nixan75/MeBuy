<?php if ($products): ?>

<?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $grid = 3; $listing_cols = 3; } ?>
<?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $grid = 3; $listing_cols = 4; } ?>
<?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $grid = 3; $listing_cols = 4; } ?>
<?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $grid = 2; $listing_cols = 6; } ?>
<?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2' && $this->document->shoppica_product_listing_type == 'list') { $grid = 3; $listing_cols = 4; } ?>

<div class="s_module_content">

  <h2 class="s_title_1"><?php echo $heading_title; ?></h2>
  <div class="clear"></div>

  <div class="s_listing s_grid_view clearfix">
  <?php for ($i = 0; $i < sizeof($products); $i = $i + $listing_cols): ?>
    <?php for ($j = $i; $j < ($i + $listing_cols); $j++): ?>
      <?php if (isset($products[$j])): ?>
      <div class="s_item grid_<?php echo $grid; ?>">

        <a class="s_thumb" href="<?php echo $products[$j]['href']; ?>">
          <img src="<?php echo $products[$j]['thumb']; ?>" title="<?php echo $products[$j]['name']; ?>" alt="<?php echo $products[$j]['name']; ?>" />
        </a>

        <h3><a href="<?php echo $products[$j]['href']; ?>"><?php echo $products[$j]['name']; ?></a></h3>

        <?php if ($products[$j]['price']): ?>
          <?php if (!$products[$j]['special']): ?>
          <p class="s_price"><?php echo s_format($products[$j]['price']); ?></p>
          <?php else: ?>
          <p class="s_price s_promo_price"><span class="s_old_price"><?php echo s_format($products[$j]['price']); ?></span><?php echo s_format($products[$j]['special']); ?></p>
          <?php endif ?>
        <?php endif; ?>

        <?php if ($products[$j]['rating']): ?>
        <p class="s_rating s_rating_5">
          <span style="width: <?php echo $products[$j]['rating'] * 2 ; ?>0%;" class="s_percent"></span>
        </p>
        <?php endif; ?>
        
        <div class="s_actions">
          <?php if ($products[$j]['price']): ?>
          <a class="s_button_add_to_cart" href="javascript:;" onclick="addToCart('<?php echo $products[$j]['product_id']; ?>');">
            <span class="s_icon_16"><span class="s_icon"></span><?php echo $button_cart; ?></span>
          </a>
          <?php endif; ?>
          <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $products[$j]['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $this->document->shoppica_text_wishlist; ?></a>
          &nbsp;
          <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $products[$j]['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $this->document->shoppica_text_compare; ?></a>
        </div>

      </div>
      <?php endif; ?>
    <?php endfor; ?>

    <div class="clear"></div>
  <?php endfor; ?>
  </div>

</div>
<?php endif; ?>
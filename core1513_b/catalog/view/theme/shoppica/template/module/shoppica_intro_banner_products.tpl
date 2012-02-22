<?php $hasSlider = count($products) > 1; ?>
<div id="intro_wrap">
  <div id="product_intro" class="s_size_<?php echo $size; ?> container_12">
    <div id="product_intro_info" class="grid_<?php echo 5 + (3 - $size) ?>">
      <?php for($i = 0, $j = count($products); $i < $j; $i++): ?>
      <div style="position: relative;<?php if($i > 0) echo ' display: none;'; ?>">
        <h2><a href="<?php echo $products[$i]['href']?>"><?php echo $products[$i]['name']; ?></a></h2>
        <?php if($products[$i]['rating']): ?>
        <div class="s_rating_holder">
          <p class="s_rating s_rating_big s_rating_5">
            <span style="width: <?php echo $products[$i]['rating'] * 2 ; ?>0%;" class="s_percent"></span>
          </p>
          <span class="s_average"><?php echo $products[$i]['rating']; ?> out of 5</span>
        </div>
        <?php endif; ?>
        <p class="s_desc"><?php echo substr($products[$i]['description'], 0, 300); ?>...</p>
        <?php if ($products[$i]['price']): ?>
        <div class="s_price_holder">
          <?php if (!$products[$i]['special']): ?>
          <p class="s_price">
            <?php echo s_format($products[$i]['price']); ?>
          </p>
          <?php else: ?>
          <p class="s_price s_promo_price">
            <span class="s_old_price"><?php echo s_format($products[$i]['price']); ?></span>
            <?php echo s_format($products[$i]['special']); ?>
          </p>
          <?php endif; ?>
        </div>
        <?php endif; ?>
      </div>
      <?php endfor; ?>
    </div>
    <div id="product_intro_preview">
      <div class="slides_container">
      <?php foreach($products as $product): ?>
        <div class="slideItem"<?php if($hasSlider): ?> style="display: none"<?php endif; ?>><a href="<?php echo $product['href']?>"><img src="<?php echo $product['image']; ?>" /></a></div>
      <?php endforeach; ?>
      </div>
      <?php if($hasSlider): ?>
      <a class="s_button_prev" href="javascript:;"></a>
      <a class="s_button_next" href="javascript:;"></a>
      <?php endif; ?>
    </div>
  </div>
</div>

<?php if($hasSlider): ?>
<script type="text/javascript" src="catalog/view/theme/shoppica/js/jquery/jquery.slides.js"></script>
<script type="text/javascript" src="catalog/view/theme/shoppica/js/shoppica.products_slide.js"></script>
<?php endif; ?>
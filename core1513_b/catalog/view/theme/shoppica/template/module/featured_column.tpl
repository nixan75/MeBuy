<div class="s_box clearfix">
  <h2><?php echo $heading_title; ?></h2>
  <?php if ($products): ?>

    <?php foreach ($products as $product): ?>
    <div class="s_item s_size_1 clearfix">

      <?php if ($product['thumb']): ?>
      <a class="s_thumb" href="<?php echo $product['href']; ?>">
        <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
      </a>
      <?php endif; ?>

      <h3><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>

      <?php if ($product['price']): ?>
      <p>
        <a href="<?php echo $product['href']; ?>">
          <?php if (!$product['special']): ?>
          <span class="s_main_color"><?php echo $product['price']; ?></span>
          <?php else: ?>
          <span class="s_old"><?php echo $product['price']; ?></span> <span class="s_secondary_color"><?php echo $product['special']; ?></span>
          <?php endif; ?>
        </a>
      </p>
      <?php endif; ?>

      <?php if ($product['rating']): ?>
      <div class="s_rating_holder clearfix">
        <p class="s_rating s_rating_small s_rating_5 left">
          <span style="width: <?php echo $product['rating'] * 2 ; ?>0%;" class="s_percent"></span>
        </p>
        <span class="left">&nbsp;<?php echo $product['rating']; ?>/5</span>
      </div>
      <?php endif; ?>

    </div>
    <?php endforeach; ?>

  <?php endif; ?>
</div>
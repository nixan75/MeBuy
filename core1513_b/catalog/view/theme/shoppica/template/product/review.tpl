<?php if ($reviews) { $i = 0; $j = count($reviews); ?>
<?php foreach ($reviews as $review) { ?>
<div class="s_review<?php if($i == $j-1) echo ' last'; ?>">
  <p class="s_author"><strong><?php echo $review['author']; ?></strong><small>(<?php echo $review['date_added']; ?>)</small></p>
  <div class="right">
    <div class="s_rating_holder">
      <p class="s_rating s_rating_5"><span style="width: <?php echo $review['rating'] * 2 ; ?>0%;" class="s_percent"></span></p>
      <span class="s_average"><?php echo $review['rating']; ?>/5</span>
    </div>
  </div>
  <div class="clear"></div>
  <p><?php echo $review['text']; ?></p>
</div>
<?php $i++; } ?>
<div class="pagination"><?php echo $pagination; ?></div>
<?php } else { ?>
<p class="align_center s_f_16 s_p_20_0"><?php echo $text_no_reviews; ?></p>
<?php } ?>

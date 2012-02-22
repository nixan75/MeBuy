<div class="s_shoppica_banners">
  <?php $cnt = count($images); ?>
	<div class="s_<?php echo $cnt; ?>col_wrap clearfix">
    <?php $i = 0; foreach($images as $image): ?>
    <div class="s_col_1_<?php echo $cnt; ?><?php if ($i == $cnt-1) echo ' s_col_last'; ?>">
      <?php if ($image['url']): ?>
      <a href="<?php echo $image['url']; ?>"<?php if($image['new_window']) echo ' target="_blank"'; ?>>
        <img src="<?php echo 'image/' . $image['file'];?>">
      </a>
      <?php else: ?>
      <img src="<?php echo 'image/' . $image['file'];?>">
      <?php endif; ?>
    </div>
    <?php $i++; endforeach; ?>
  </div>
  <div class="clear"></div>
</div>
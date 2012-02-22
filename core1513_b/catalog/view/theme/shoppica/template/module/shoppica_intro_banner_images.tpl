<?php $hasSlider = count($shoppica_images) > 1; ?>
<div id="intro_wrap">
  <div id="image_intro" class="container_12">
    <div id="image_intro_preview"<?php if ($image_vars['with_border']) { ?> class="s_boxed"<?php } ?> style="height: <?php echo $image_vars['maxHeight'] ?>px">
      <div class="slides_container">
        <?php $i = 0; foreach($shoppica_images as $image): ?>
        <div class="slideItem"<?php if($hasSlider): ?> style="display: none"<?php endif; ?>>
          <?php if($image['url']): ?>
          <a href="<?php echo $image['url']?>">
          <?php endif; ?>
            <img src="<?php echo 'image/' . $image['file']; ?>" width="<?php echo $image['width'] ?>" height="<?php echo $image['height'] ?>" />
          <?php if($image['url']): ?>
          </a>
          <?php endif; ?>
        </div>
        <?php $i++; endforeach; ?>
      </div>
      <?php if($hasSlider): ?>
      <span class="s_button_prev_holder">
        <a class="s_button_prev" href="javascript:;"></a>
      </span>
      <span class="s_button_next_holder">
        <a class="s_button_next" href="javascript:;"></a>
      </span>
      <?php endif; ?>
    </div>
  </div>
</div>

<?php if($hasSlider): ?>
<script type="text/javascript" src="catalog/view/theme/shoppica/js/jquery/jquery.slides.js"></script>
<script type="text/javascript">
  var slideEffect = '<?php echo $image_vars['rotation_type'] ?>';
</script>
<script type="text/javascript" src="catalog/view/theme/shoppica/js/shoppica.images_slide.js"></script>
<?php endif; ?>
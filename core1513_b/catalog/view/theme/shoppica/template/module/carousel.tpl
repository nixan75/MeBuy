<div id="manufacturer<?php echo $module; ?>"<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?> class="s_carousel s_module_content"<?php else: ?> class="s_box"<?php endif; ?>>
  <div class="jcarousel jcarousel_horizontal s_mb_30">
    <ul class="clearfix">
      <?php foreach ($banners as $banner): ?>
      <li>
        <?php if ($banner['link']): ?>
        <a href="<?php echo $banner['link']; ?>">
          <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" />
        </a>
        <?php else: ?>
        <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" />
        <?php endif; ?>
      </li>
      <?php endforeach; ?>
    </ul>
  </div>
  <span class="clear"></span>

  <style type="text/css">
  #manufacturer<?php echo $module; ?> .jcarousel_horizontal li {
    width: <?php echo 100/$limit ?>%;
  }
  </style>

  <script type="text/javascript">
  $('#manufacturer<?php echo $module; ?> ul').jcarousel({
    visible: <?php echo $limit; ?>,
    scroll: <?php echo $scroll; ?>,
    size: <?php echo count($banners) ?>
  });
  
  // Next/Prev buttons hover effect
  $("#manufacturer<?php echo $module; ?> .jcarousel-prev, #manufacturer<?php echo $module; ?> .jcarousel-next").hover(
    function() {
      $(this).stop().animate({
          backgroundColor: $("#secondary_color").val()
        },300
      );
    }
    ,
    function() {
      $(this).stop().animate({
          backgroundColor: $("#main_color").val()
        },300
      );
    }
  );
  </script>

</div>
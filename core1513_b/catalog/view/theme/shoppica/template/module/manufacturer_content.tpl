<div id="manufacturer<?php echo $module; ?>">
  <h2 class="s_title_1"><?php echo $heading_title; ?></h2>
  <span class="clear"></span>
  <div class="jcarousel <?php echo ($axis == 'horizontal' ? 'jcarousel_horizontal' : 'jcarousel_vertical'); ?> s_mb_30">
    <ul>
      <?php foreach ($manufacturers as $manufacturer): ?>
      <li>
        <a href="<?php echo $manufacturer['href']; ?>">
          <img src="<?php echo $manufacturer['image']; ?>" width="<?php echo $image_width; ?>" height="<?php echo $image_height; ?>" alt="<?php echo $manufacturer['name']; ?>" title="<?php echo $manufacturer['name']; ?>" />
        </a>
      </li>
      <?php endforeach; ?>
    </ul>
  </div>
  <span class="clear"></span>

  <style type="text/css">
  <?php if ($axis == 'vertical'): ?>
  #manufacturer<?php echo $module; ?> .jcarousel_vertical li {
    height: <?php echo $image_height + 20; ?>px;
  }
  #manufacturer<?php echo $module; ?> .jcarousel_vertical li a {
    height: <?php echo $image_height; ?>px;
  }
  #manufacturer<?php echo $module; ?> .jcarousel-container-vertical {
    height: <?php echo $limit * ($image_height + 20) ?>px;
  }
  #manufacturer<?php echo $module; ?> .jcarousel-clip-vertical {
    height: <?php echo $limit * ($image_height + 20) ?>px;
  }
  <?php else: ?>
  #manufacturer<?php echo $module; ?> .jcarousel_horizontal li {
    width: <?php echo 100/$limit ?>%;
  }
  <?php endif; ?>
  </style>
  
  <script type="text/javascript" src="catalog/view/theme/shoppica/js/jquery/jquery.jcarousel.min.js"></script>
  <script type="text/javascript">
  $('#manufacturer<?php echo $module; ?> ul').jcarousel({
    visible: <?php echo $limit; ?>,
    scroll: <?php echo $scroll; ?>,
    size: <?php echo count($manufacturers) ?>,
    vertical: <?php echo ($axis == 'horizontal' ? 'false' : 'true'); ?>
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
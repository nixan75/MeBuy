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
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $container = 12; $main = 12; $side_col = 3; } ?>
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 16; $main = 12; $side_col = 4; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 12; $main = 12; $side_col = 3; } ?>

  <div id="content" class="container_<?php echo $container; ?>">

    <?php if ($this->document->shoppica_column_position == "left" && $column_right): ?>
    <div id="left_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div id="tracking_code" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <p><?php echo $text_description; ?></p>

      <div class="s_row_2 clearfix">
        <label><?php echo $text_code; ?></label>
        <input type="text" size="43" name="product" value="<?php echo $code; ?>" />
      </div>
      <div class="s_row_2 clearfix">
        <label><?php echo $text_generator; ?></label>
        <input type="text" size="43" name="product" value="" />
      </div>
      <div class="s_row_2 s_mb_20 clearfix">
        <label><?php echo $text_link; ?></label>
        <textarea name="link" cols="40" rows="5"></textarea>
      </div>

      <span class="clear s_mb_30 border_eee"></span>

      <div class="s_submit s_mb_25 clearfix">
        <a class="s_button_1 s_main_color_bgr" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_continue; ?></span></a>
      </div>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($this->document->shoppica_column_position == "right" && $column_right): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->

  <link rel="stylesheet" type="text/css" href="catalog/view/theme/shoppica/stylesheet/jquery_ui/jquery-ui-1.8.14.custom.css" media="screen" />
  <script type="text/javascript"><!--
  $('input[name=\'product\']').autocomplete({
    delay: 0,
    create: function() {
      var newclass = 's_jquery_ui';
      $('body > ul.ui-autocomplete').wrap('<div class="'+newclass+'"></div>');
    },
    source: function(request, response) {
        $.ajax({
            url: 'index.php?route=affiliate/tracking/autocomplete&filter_name=' +  encodeURIComponent(request.term),
            dataType: 'json',
            success: function(json) {
                response($.map(json, function(item) {
                    return {
                        label: item.name,
                        value: item.link
                    }
                }));
            }
        });

    },
    select: function(event, ui) {
      $('input[name=\'product\']').attr('value', ui.item.label);
      $('textarea[name=\'link\']').attr('value', ui.item.value);

      return false;
    }
  });
  //--></script>

<?php echo $footer; ?>
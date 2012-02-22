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

    <div id="change_password" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <form id="password_form" class="clearfix" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

        <h2 class="s_title_1"><?php echo $text_password; ?></h2>
        <div class="clear"></div>

        <div class="s_row_2<?php if ($error_password): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_password; ?> *</label>
          <input type="password" name="password" id="password" value="<?php echo $password; ?>" size="30" title="<?php echo $this->language->get('error_password'); ?>" />
          <?php if ($error_password): ?>
          <p class="s_error_msg"><?php echo $error_password; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_confirm): ?> s_error_row<?php endif; ?>  s_mb_20 clearfix">
          <label><?php echo $entry_confirm; ?> *</label>
          <input type="password" name="confirm" id="confirm" value="<?php echo $confirm; ?>" size="30" title="<?php echo $this->language->get('error_confirm'); ?>" />
          <?php if ($error_confirm): ?>
          <p class="s_error_msg"><?php echo $error_confirm; ?></p>
          <?php endif; ?>
        </div>

        <span class="clear border_ddd s_mb_30"></span>

        <div class="s_submit s_mb_30 clearfix">
          <a class="s_button_1 s_ddd_bgr left" onclick="location = '<?php echo $back; ?>'"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#password_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

      </form>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($this->document->shoppica_column_position == "right" && $column_right): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->

  <script type="text/javascript" src="http<?php if(isHTTPS()) echo 's'?>://ajax.aspnetcdn.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>
  <script type="text/javascript">
    jQuery.validator.setDefaults({
        errorElement: "p",
        errorClass: "s_error_msg",
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        highlight: function(element, errorClass, validClass) {
            $(element).addClass("error_element").removeClass(validClass);
            $(element).parent("div").addClass("s_error_row");
        },
        unhighlight: function(element, errorClass, validClass) {
            $(element).removeClass("error_element").addClass(validClass);
            $(element).parent("div").removeClass("s_error_row");
        }
    });
    $("#password_form").validate({
      rules: {
        password: {
            required: true, minlength: 3
        },
        confirm: {
            required: function(element) {
                var str = $("#password").val();

                return str.length > 0;
            },
            equalTo: "#password",
            minlength: 3
        }
      }
    });
  </script>

<?php echo $footer; ?>

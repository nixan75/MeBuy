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

    <div id="login_page" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>
      
      <?php if ($success): ?>
      <div class="s_server_msg s_msg_green"><p><?php echo $success; ?></p></div>
      <?php endif; ?>
      
      <?php if ($error_warning) : ?>
      <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>
      
      <div class="s_2col_wrap clearfix"> 
        <div class="s_col_1_2">
          <h2 class="s_title_1"><?php echo $text_new_customer; ?></h2>
          <div class="clear"></div>
          <div class="s_row_3 clearfix">
            <p><?php echo $text_register_account; ?></p>
          </div>
          <span class="clear s_mb_20 border_ddd"></span>
          <a href="<?php echo $register; ?>" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>

        <div class="s_col_1_2 s_col_last">
          <h2 class="s_title_1"><?php echo $text_returning_customer; ?></h2>
          <div class="clear"></div>
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="login">
            <div class="s_row_3 clearfix">
              <?php echo $text_i_am_returning_customer; ?><br /><br />
              <label><strong><?php echo $entry_email; ?></strong></label>
              <input type="text" name="email" size="35" class="required email" title="<?php echo $this->document->shoppica_text_error_email ?>" />
              <br />
              <br />
              <span class="clear"></span>
              <label><strong><?php echo $entry_password; ?></strong></label>
              <input type="password" name="password" size="35" class="required" title="<?php echo $this->document->shoppica_text_error_password ?>" />
            </div>

            <span class="clear s_mb_20 border_ddd"></span>

            <div class="s_nav s_size_2 left">
              <ul class="s_mb_0 clearfix">
                <li><a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a></li>
              </ul>
            </div>
            <a class="s_button_1 s_main_color_bgr" onclick="$('#login').submit();"><span class="s_text"><?php echo $button_login; ?></span></a>
            <?php if ($redirect): ?>
            <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
            <?php endif; ?>
          </form>
        </div>

      </div>

      <div class="clear s_mb_30"></div>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($this->document->shoppica_column_position == "right" && $column_right): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->


  <script type="text/javascript"><!--
  $('#login input').keydown(function(e) {
    if (e.keyCode == 13) {
      $('#login').submit();
    }
  });
  //--></script>
  <script type="text/javascript" src="http<?php if(isHTTPS()) echo 's'?>://ajax.aspnetcdn.com/ajax/jquery.validate/1.8/jquery.validate.min.js"></script>
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
    $("#login").validate();
  </script>

<?php echo $footer; ?>

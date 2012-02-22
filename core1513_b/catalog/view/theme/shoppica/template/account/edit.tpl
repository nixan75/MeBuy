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

    <div id="edit_account" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>
      
      <?php if ($error_warning): ?>
      <div class="s_msg_red s_server_msg"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>

      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="edit">

        <h2 class="s_title_1"><?php echo $text_your_details; ?></h2>
        <div class="clear"></div>

        <div class="s_row_2<?php if ($error_firstname): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_firstname; ?> *</label>
          <input type="text" name="firstname" value="<?php echo $firstname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
          <?php if ($error_firstname): ?>
          <p class="s_error_msg"><?php echo $error_firstname; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_lastname): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_lastname; ?> *</label>
          <input type="text" name="lastname" value="<?php echo $lastname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
          <?php if ($error_lastname): ?>
          <p class="s_error_msg"><?php echo $error_lastname; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_email): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_email; ?> *</label>
          <input type="text" name="email" value="<?php echo $email; ?>" size="30" class="required" title="<?php echo $this->language->get('error_email'); ?>" />
          <?php if ($error_email): ?>
          <p class="s_error_msg"><?php echo $error_email; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2<?php if ($error_telephone): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_telephone; ?> *</label>
          <input type="text" name="telephone" value="<?php echo $telephone; ?>" size="30" class="required" title="<?php echo $this->language->get('error_telephone'); ?>" />
          <?php if ($error_telephone): ?>
          <p class="s_error_msg"><?php echo $error_telephone; ?></p>
          <?php endif; ?>
        </div>

        <div class="s_row_2 s_mb_20 clearfix">
          <label><?php echo $entry_fax; ?></label>
          <input type="text" name="fax" value="<?php echo $fax; ?>" size="30" />
        </div>

        <span class="clear border_ddd s_mb_30"></span>
        
        <div class="s_submit s_mb_25 clearfix">
          <a class="s_button_1 s_ddd_bgr left" href="<?php echo $back; ?>"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#edit').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
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
    $("#edit").validate();
  </script>

<?php echo $footer; ?>
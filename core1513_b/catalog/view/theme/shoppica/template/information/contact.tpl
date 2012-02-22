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

    <div id="contacts" class="s_info_page grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <p class="alpha grid_<?php if($this->document->shoppica_products_listing == "size_1"): echo "3"; elseif ($this->document->shoppica_products_listing == "size_2"): echo "4"; endif; ?>"><strong><?php echo $store; ?></strong><br /> <?php echo $address; ?></p>
      
      <?php if ($telephone) { ?>
      <p class="grid_<?php if($this->document->shoppica_products_listing == "size_1"): echo "3"; elseif ($this->document->shoppica_products_listing == "size_2"): echo "4"; endif; ?>">
      <strong><?php echo $text_telephone; ?></strong><br /> <?php echo $telephone; ?>
      </p>
      <?php } ?>

      <?php if ($fax) { ?>
      <p class="omega grid_<?php if($this->document->shoppica_products_listing == "size_1"): echo "3"; elseif ($this->document->shoppica_products_listing == "size_2"): echo "4"; endif; ?>">
      <strong><?php echo $text_fax; ?></strong><br /> <?php echo $fax; ?>
      </p>
      <?php } ?>
      
      <br />
      <span class="clear border_eee"></span>
      <br />

      <form action="<?php echo str_replace('&', '&amp;', $action); ?>" method="post" enctype="multipart/form-data" id="contact">

        <div class="s_row_3<?php if ($error_name) { ?> s_error_row<?php } ?> clearfix">
          <label><strong><?php echo $entry_name; ?></strong> *</label>
          <input type="text" name="name" value="<?php echo $name; ?>" size="40" class="required" title="<?php echo $this->language->get('error_name'); ?>" />
          <?php if ($error_name) { ?>
          <p class="s_error_msg"><?php echo $error_name; ?></p>
          <?php } ?>
        </div>

        <div class="s_row_3<?php if ($error_email) { ?> s_error_row<?php } ?> clearfix">
          <label><strong><?php echo $entry_email; ?></strong> *</label>
          <input type="text" name="email" value="<?php echo $email; ?>" size="40" class="required email" title="<?php echo $this->language->get('error_email'); ?>" />
          <?php if ($error_email) { ?>
          <p class="s_error_msg"><?php echo $error_email; ?></p>
          <?php } ?>
        </div>

        <div class="s_row_3<?php if ($error_enquiry) { ?> s_error_row<?php } ?> clearfix">
          <label><strong><?php echo $entry_enquiry; ?></strong> *</label>
          <div class="s_full">
            <textarea name="enquiry" id="enquiry" style="width: 98%;" rows="10" class="required" title="<?php echo $this->language->get('error_enquiry'); ?>"><?php echo $enquiry; ?></textarea>
            <?php if ($error_enquiry) { ?>
            <p class="s_error_msg"><?php echo $error_enquiry; ?></p>
            <?php } ?>
          </div>
        </div>

        <div class="s_row_3<?php if ($error_captcha) { ?> s_error_row<?php } ?> clearfix">
          <label><strong><?php echo $entry_captcha; ?></strong> *</label>
          <input type="text" name="captcha" value="<?php echo $captcha; ?>" class="required" autocomplete="off" />
          <?php if ($error_captcha) { ?>
          <p class="s_error_msg"><?php echo $error_captcha; ?></p>
          <?php } ?>
          <span class="clear"></span>
          <br />
          <img src="index.php?route=information/contact/captcha" />
        </div>

        <br />
        <span class="clear border_eee"></span>
        <br />
        
        <div class="s_submit s_mb_30 clearfix">
          <a class="s_button_1 s_main_color_bgr" onclick="$('#contact').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
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
    $("#contact").validate({
      rules: {
        enquiry: {
            required: true,
            minlength: 10
        }
      }
    });
  </script>

<?php echo $footer; ?>
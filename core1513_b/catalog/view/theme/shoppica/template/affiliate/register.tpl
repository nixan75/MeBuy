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

    <div id="register" class="grid_<?php echo $main; ?>">
  
      <?php echo $content_top; ?>
  
      <?php if ($error_warning) : ?>
      <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>
    
      <p><?php echo $text_account_already; ?></p>

      <p><?php echo $text_signup; ?></p>
      
      <form id="register_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

        <div class="left" style="width: 49.5%">
          <h2><?php echo $text_your_details; ?></h2>
          <div class="s_row_2<?php if ($error_firstname): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php echo $entry_firstname; ?> *</label>
            <input type="text" name="firstname" value="" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
            <?php if ($error_firstname): ?>
            <p class="s_error_msg"><?php echo $error_firstname; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_lastname): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php echo $entry_lastname; ?> *</label>
            <input type="text" name="lastname" value="" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
            <?php if ($error_lastname): ?>
            <p class="s_error_msg"><?php echo $error_lastname; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_email): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php echo $entry_email; ?> *</label>
            <input type="text" name="email" value="" size="30" class="required" title="<?php echo $this->language->get('error_email'); ?>" />
            <?php if ($error_email): ?>
            <p class="s_error_msg"><?php echo $error_email; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_telephone): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php echo $entry_telephone; ?> *</label>
            <input type="text" name="telephone" value="" size="30" class="required" title="<?php echo $this->language->get('error_telephone'); ?>" />
            <?php if ($error_telephone): ?>
            <p class="s_error_msg"><?php echo $error_telephone; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_fax; ?></label>
            <input type="text" name="fax" value="" size="30" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_company; ?></label>
            <input type="text" name="company" value="" size="30" />
          </div>
          <div class="s_row_2 s_mb_20 clearfix">
            <label><?php echo $entry_website; ?></label>
            <input type="text" name="website" value="" size="30" />
          </div>
        </div>

        <div class="left" style="width: 49.5%">
          <h2><?php echo $text_your_address; ?></h2>
          <div class="s_row_2<?php if ($error_address_1): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php echo $entry_address_1; ?> *</label>
            <input type="text" name="address_1" value="" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
            <?php if ($error_address_1): ?>
            <p class="s_error_msg"><?php echo $error_address_1; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_address_2; ?></label>
            <input type="text" name="address_2" value="" size="30" />
          </div>
          <div class="s_row_2<?php if ($error_city): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php echo $entry_city; ?> *</label>
            <input type="text" name="city" value="" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
            <?php if ($error_city): ?>
            <p class="s_error_msg"><?php echo $error_city; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_postcode): ?> s_error_row<?php endif; ?> clearfix">
            <label id="postcode"><?php echo $entry_postcode; ?> *</label>
            <input type="text" name="postcode" value="" size="30" class="required" title="<?php echo $this->language->get('error_postcode'); ?>" />
            <?php if ($error_postcode): ?>
            <p class="s_error_msg"><?php echo $error_postcode; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_country): ?> s_error_row<?php endif; ?> clearfix">
            <label><?php echo $entry_country; ?> *</label>
            <select id="country_id" name="country_id" class="large-field" onchange="$('select[name=\'zone_id\']').load('index.php?route=account/register/zone&country_id=' + this.value + '&zone_id=<?php echo $zone_id; ?>');">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($countries as $country): ?>
              <?php if ($country['country_id'] == $country_id): ?>
              <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
              <?php else: ?>
              <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
              <?php endif; ?>
              <?php endforeach; ?>
            </select>
            <?php if ($error_country): ?>
            <p class="s_error_msg"><?php echo $error_country; ?></p>
            <?php endif; ?>
          </div>
          <div class="s_row_2<?php if ($error_zone): ?> s_error_row<?php endif; ?> s_mb_20 clearfix">
            <label><?php echo $entry_zone; ?> *</label>
            <select id="zone_id" name="zone_id"></select>
            <?php if ($error_zone): ?>
            <p class="s_error_msg"><?php echo $error_zone; ?></p>
            <?php endif; ?>
          </div>
        </div>
        
        <span class="clear s_mb_20 border_eee"></span>

        <div class="s_row_2 clearfix">
          <label><?php echo $entry_tax; ?></label>
          <input type="text" name="tax" size="30" value="<?php echo $tax; ?>" />
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_payment; ?></label>
          <div class="s_full clearfix">
            <?php if ($payment == 'cheque'): ?>
            <label  class="s_checkbox" for="cheque"><input type="radio" name="payment" value="cheque" id="cheque" checked="checked" /> <?php echo $text_cheque; ?></label>
            <?php else: ?>
            <label class="s_checkbox" for="cheque"><input type="radio" name="payment" value="cheque" id="cheque" /> <?php echo $text_cheque; ?></label>
            <?php endif; ?>
            <?php if ($payment == 'paypal'): ?>
            <label class="s_checkbox" for="paypal"><input type="radio" name="payment" value="paypal" id="paypal" checked="checked" /> <?php echo $text_paypal; ?></label>
            <?php else: ?>
            <label class="s_checkbox" for="paypal"><input type="radio" name="payment" value="paypal" id="paypal" /> <?php echo $text_paypal; ?></label>
            <?php endif; ?>
            <?php if ($payment == 'bank'): ?>
            <label class="s_checkbox" for="bank"><input type="radio" name="payment" value="bank" id="bank" checked="checked" /> <?php echo $text_bank; ?></label>
            <?php else: ?>
            <label class="s_checkbox" for="bank"><input type="radio" name="payment" value="bank" id="bank" /> <?php echo $text_bank; ?></label>
            <?php endif; ?>
          </div>
        </div>
        <div id="payment-cheque" class="payment s_row_2 s_mb_20 clearfix">
          <label><?php echo $entry_cheque; ?></label>
          <input type="text" name="cheque" size="30" value="<?php echo $cheque; ?>" />
        </div>
        <div id="payment-paypal" class="payment s_row_2 s_mb_20 clearfix">
          <label><?php echo $entry_paypal; ?></label>
          <input type="text" name="paypal" size="30" value="<?php echo $paypal; ?>" />
        </div>
        <div id="payment-bank" class="payment s_mb_20">
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_name; ?></label>
            <input type="text" name="bank_name" size="30" value="<?php echo $bank_name; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_branch_number; ?></label>
            <input type="text" name="bank_branch_number" size="30" value="<?php echo $bank_branch_number; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_swift_code; ?></label>
            <input type="text" name="bank_swift_code" size="30" value="<?php echo $bank_swift_code; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_account_name; ?></label>
            <input type="text" name="bank_account_name" size="30" value="<?php echo $bank_account_name; ?>" />
          </div>
          <div class="s_row_2 clearfix">
            <label><?php echo $entry_bank_account_number; ?></label>
            <input type="text" name="bank_account_number" size="30" value="<?php echo $bank_account_number; ?>" />
          </div>
        </div>
        
        <span class="clear s_mb_20 border_eee"></span>
        
        <h2><?php echo $text_your_password; ?></h2>
        <div class="s_row_2<?php if ($error_password): ?> s_error_row<?php endif; ?> clearfix">
          <label><?php echo $entry_password; ?> *</label>
          <input type="password" name="password" id="password" value="" class="required" size="30" title="<?php echo $this->language->get('error_password'); ?>" />
          <?php if ($error_password): ?>
          <p class="s_error_msg"><?php echo $error_password; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2<?php if ($error_confirm): ?> s_error_row<?php endif; ?> s_mb_20 clearfix">
          <label><?php echo $entry_confirm; ?> *</label>
          <input type="password" name="confirm" id="confirm" value="" class="required" size="30" title="<?php echo $this->language->get('error_password'); ?>" />
          <?php if ($error_confirm): ?>
          <p class="s_error_msg"><?php echo $error_confirm; ?></p>
          <?php endif; ?>
        </div>
        
        <span class="clear s_mb_30 border_eee"></span>
        
        <?php if ($text_agree): ?>
        <div class="s_submit s_mb_30 clearfix">
          <?php if ($agree): ?>
          <label class="s_checkbox left"><input type="checkbox" name="agree" value="1" checked="checked" /> <?php echo $this->document->shoppica_text_agree_affiliate; ?></label>
          <?php else: ?>
          <label class="s_checkbox left"><input type="checkbox" name="agree" value="1" /> <?php echo $this->document->shoppica_text_agree_affiliate; ?></label>
          <?php endif; ?>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#register_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>
        <?php else: ?>
        <div class="s_submit s_mb_30 clearfix">
          <a class="s_button_1 s_main_color_bgr" onclick="$('#register_form').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
        </div>
        <?php endif; ?>
      </form>

      <?php echo $content_bottom; ?>
      
      <div class="clear"></div>
  
    </div>

    <?php if ($this->document->shoppica_column_position == "right" && $column_right): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->

      
  <script type="text/javascript">
  
    $('select[name=\'zone_id\']').load('index.php?route=account/register/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');

    $('input[name=\'payment\']').bind('change', function() {
      $('.payment').hide();
      $('#payment-' + this.value).show();
    });
  
    $('input[name=\'payment\']:checked').trigger('change');
    
  </script>

  <link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/stylesheet/prettyPhoto.css" media="all" />
  <script type="text/javascript" src="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/js/jquery/jquery.prettyPhoto.js"></script>
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
    $("#register_form").validate({
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

    jQuery( function($) {
      $("a[rel^='prettyPhoto']").prettyPhoto({
        theme: 'light_square', /* light_rounded / dark_rounded / light_square / dark_square / facebook */
        opacity: 0.5,
        social_tools: "",
        deeplinking: false
      });
    });
  </script>
      
      
<?php echo $footer; ?>
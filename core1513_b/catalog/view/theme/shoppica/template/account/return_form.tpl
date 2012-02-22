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

    <div id="return_request" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <?php if ($error_warning) : ?>
      <div class="s_server_msg s_msg_red"><p><?php echo $error_warning; ?></p></div>
      <?php endif; ?>

      <?php echo $text_description; ?>
      
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="return">

        <h2><?php echo $text_order; ?></h2>
        
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_firstname; ?> *</label>
          <input type="text" name="firstname" value="<?php echo $firstname; ?>" size="30" />
          <?php if ($error_firstname): ?>
          <p class="s_error_msg"><?php echo $error_firstname; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_lastname; ?> *</label>
          <input type="text" name="lastname" value="<?php echo $lastname; ?>" size="30" />
          <?php if ($error_lastname): ?>
          <p class="s_error_msg"><?php echo $error_lastname; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_email; ?> *</label>
          <input type="text" name="email" value="<?php echo $email; ?>" size="30" />
          <?php if ($error_email): ?>
          <p class="s_error_msg"><?php echo $error_email; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_telephone; ?> *</label>
          <input type="text" name="telephone" value="<?php echo $telephone; ?>" size="30" />
          <?php if ($error_telephone): ?>
          <p class="s_error_msg"><?php echo $error_telephone; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_order_id; ?> *</label>
          <input type="text" name="order_id" value="<?php echo $order_id; ?>" size="30" />
          <?php if ($error_order_id): ?>
          <p class="s_error_msg"><?php echo $error_order_id; ?></p>
          <?php endif; ?>
        </div>
        <div class="s_row_2 clearfix">
          <label><?php echo $entry_date_ordered; ?></label>
          <input type="text" name="date_ordered" value="<?php echo $date_ordered; ?>" size="30" class="date" />
        </div>
        
        <span class="clear s_mb_20"></span>

        <div class="s_box_1 clearfix">
          <h2 class="left s_secondary_color"><?php echo $text_product; ?></h2>
          <div id="return-product">

            <?php $return_product_row = 0; ?>
            <?php foreach ($return_products as $return_product): ?>
            <div id="return_product_<?php echo $return_product_row; ?>" class="s_product_row">
              <span class="s_row_number"><?php echo $return_product_row; ?></span>
              <div class="s_row_2 clearfix">
                <label><?php echo $entry_product; ?> *</label>
                <input type="text" size="30" name="return_product[<?php echo $return_product_row; ?>][name]" value="<?php echo $return_product['name']; ?>" />
                <?php if (isset($error_name[$return_product_row])): ?>
                <p class="s_error_msg"><?php echo $error_name[$return_product_row]; ?></p>
                <?php endif; ?>
              </div>
              <div class="s_row_2 clearfix">
                <label><?php echo $entry_model; ?> *</label>
                <input type="text" size="30" name="return_product[<?php echo $return_product_row; ?>][model]" value="<?php echo $return_product['model']; ?>" />
                <?php if (isset($error_model[$return_product_row])): ?>
                <p class="s_error_msg"><?php echo $error_model[$return_product_row]; ?></p>
                <?php endif; ?>
              </div>
              <div class="s_row_2 clearfix">
                <label><?php echo $entry_quantity; ?></label>
                <input type="text" size="30" name="return_product[<?php echo $return_product_row; ?>][quantity]" value="<?php echo $return_product['quantity']; ?>" />
              </div>
              <div class="s_row_2 clearfix">
                <label><?php echo $entry_reason; ?> *</label>
                <div class="s_full">
                  <?php foreach ($return_reasons as $return_reason): ?>
                  <?php if (isset($return_product['return_reason_id']) && $return_reason['return_reason_id'] == $return_product['return_reason_id']): ?>
                  <label class="s_radio" for="return-reason-id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>">  
                    <input type="radio" name="return_product[<?php echo $return_product_row; ?>][return_reason_id]" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>" checked="checked" />
                    <?php echo $return_reason['name']; ?>
                  </label>
                  <?php else: ?>
                  <label class="s_radio" for="return-reason-id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>">
                  	<input type="radio" name="return_product[<?php echo $return_product_row; ?>][return_reason_id]" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id<?php echo $return_product_row; ?><?php echo $return_reason['return_reason_id']; ?>" /></td>
                    <?php echo $return_reason['name']; ?>
                  </label>
                  <?php endif; ?>
                  <?php endforeach; ?>
                  <?php if (isset($error_reason[$return_product_row])): ?>
                  <span class="clear"></span>
                  <p class="s_error_msg"><?php echo $error_reason[$return_product_row]; ?></p>
                  <?php endif; ?>
                </div>
              </div>
              <div class="s_row_2 clearfix">
                <label><?php echo $entry_opened; ?></label>
                <div class="s_full clearfix">
                  <label class="s_radio" for="opened<?php echo $return_product_row; ?>"><input type="radio" name="return_product[<?php echo $return_product_row; ?>][opened]" value="1" id="opened<?php echo $return_product_row; ?>" checked="checked" /> <?php echo $text_yes; ?></label>
                  <label class="s_radio" for="unopened<?php echo $return_product_row; ?>"><input type="radio" name="return_product[<?php echo $return_product_row; ?>][opened]" value="0" id="unopened<?php echo $return_product_row; ?>" /> <?php echo $text_no; ?></label>
                </div>
              </div>
              <div class="s_row_2 s_mb_10 clearfix">
                <label><?php echo $entry_fault_detail; ?></label>
                <div class="s_full clearfix">
                  <textarea name="return_product[<?php echo $return_product_row; ?>][comment]" cols="45" rows="6"></textarea>
                </div>
              </div>
              <div class="clearfix s_mb_10">
                <a onclick="$('#return_product_<?php echo $return_product_row; ?>').remove();" class="s_button_1 s_button_1_small s_ddd_bgr"><span class="s_text"><?php echo $button_remove; ?></span></a>
              </div>
            </div>
            <?php $return_product_row++; ?>
            <?php endforeach; ?>
          </div>
            
          <a onclick="addReturnProduct();" class="s_button_1 s_button_1_small s_main_color_bgr"><span class="s_text"><?php echo $button_add_product; ?></span></a>

        </div>
        
        <h2 class="s_mb_0"><?php echo $text_additional; ?></h2>
        <div class="s_row_2 clearfix">
          <textarea name="comment" rows="6" style="width: 99%;"><?php echo $comment; ?></textarea>
        </div>
        <div class="s_row_3 clearfix">
          <label><?php echo $entry_captcha; ?></label>
          <input type="text" name="captcha" value="<?php echo $captcha; ?>" />
          <span class="clear"></span>
          <br />
          <img src="index.php?route=account/return/captcha" alt="" />
          <?php if ($error_captcha): ?>
          <p class="s_error_msg"><?php echo $error_captcha; ?></p>
          <?php endif; ?>
        </div>

        <span class="clear s_mb_25 border_eee"></span>

        <div class="s_submit s_mb_25 clearfix">
          <a href="<?php echo $back; ?>" class="s_button_1 s_ddd_bgr left"><span class="s_text"><?php echo $button_back; ?></span></a>
          <a class="s_button_1 s_main_color_bgr" onclick="$('#return').submit();"><span class="s_text"><?php echo $button_continue; ?></span></a>
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

  <link rel="stylesheet" type="text/css" href="catalog/view/theme/shoppica/stylesheet/jquery_ui/jquery-ui-1.8.14.custom.css" media="screen" />
  <script type="text/javascript"><!--
  var return_product_row = <?php echo $return_product_row; ?>;
  
  
  function addReturnProduct() {
    html  = '<div id="return_product_' + return_product_row + '" class="s_product_row">';
    html += '  <div class="content">';
    html += '    <span class="s_row_number">' + return_product_row + '</span>';
    html += '    <div class="s_row_2 clearfix"><label><?php echo $entry_product; ?> *</label><input type="text" size="30" name="return_product[' + return_product_row + '][name]" value="" /></div>';
    html += '    <div class="s_row_2 clearfix"><label><?php echo $entry_model; ?> *</label><input type="text" size="30" name="return_product[' + return_product_row + '][model]" value="" /></div>';
    html += '    <div class="s_row_2 clearfix"><label><?php echo $entry_quantity; ?></label><input type="text" size="30" name="return_product[' + return_product_row + '][quantity]" value="1" /></div>';
    html += '    <div class="s_row_2 clearfix">';
    html += '      <label><?php echo $entry_reason; ?> *</label>';
    html += '      <div class="s_full">';
    <?php foreach ($return_reasons as $return_reason): ?>
    html += '        <label class="s_radio s_col_1_3" for="return-reason-id' + return_product_row + '<?php echo $return_reason['return_reason_id']; ?>"><input type="radio" name="return_product[' + return_product_row + '][return_reason_id]" value="<?php echo $return_reason['return_reason_id']; ?>" id="return-reason-id' + return_product_row + '<?php echo $return_reason['return_reason_id']; ?>" /> <?php echo $return_reason['name']; ?></label>';
    <?php  endforeach; ?>
    html += '      </div>';
    html += '    </div>';
    html += '    <div class="s_row_2 clearfix">';
    html += '      <label><?php echo $entry_opened; ?></label>';
    html += '      <div class="s_full clearfix">';
    html += '        <label class="s_radio" for="opened' + return_product_row + '"><input type="radio" name="return_product[' + return_product_row + '][opened]" value="1" id="opened' + return_product_row + '" checked="checked" /> <?php echo $text_yes; ?></label>';
    html += '        <label class="s_radio" for="unopened' + return_product_row + '"><input type="radio" name="return_product[' + return_product_row + '][opened]" value="0" id="unopened' + return_product_row + '" /> <?php echo $text_no; ?></label>';
    html += '      </div>';
    html += '    </div>';
    html += '    <div class="s_row_2 s_mb_10 clearfix">';
    html += '      <label><?php echo $entry_fault_detail; ?></label>';
    html += '      <div class="s_full clearfix">';
    html += '        <textarea name="return_product[' + return_product_row + '][comment]" cols="45" rows="6"></textarea>';
    html += '      </div>';
    html += '    </div>';
    html += '    <div class="clearfix s_mb_10">';
    html += '      <a onclick="$(\'#return_product_' + return_product_row + '\').remove();" class="s_button_1 s_button_1_small s_ddd_bgr"><span class="s_text"><?php echo $button_remove; ?></span></a>';
    html += '    </div>';
    html += '  </div>';
    html += '</div>';
    
    $('#return-product').append(html);
   
    $('#return-product-row' + return_product_row + ' .date').datepicker({dateFormat: 'yy-mm-dd'});
    
    return_product_row++;
  }
  //--></script> 
  
  <script type="text/javascript"><!--
  $(document).ready(function() {
    $('.date').datepicker({
      dateFormat: 'yy-mm-dd',
      beforeShow: function(input, inst) {
        var newclass = 's_jquery_ui';
        if (!inst.dpDiv.parent().hasClass('s_jquery_ui')) {
          inst.dpDiv.wrap('<div class="'+newclass+'"></div>')
        }
      } 
    });
  });
  //--></script> 

<?php echo $footer; ?>
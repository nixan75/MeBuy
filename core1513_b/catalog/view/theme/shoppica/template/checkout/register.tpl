  <form id="register_details_form">
    <div class="left" style="width: 49.99%;">

      <h2><?php echo $text_your_details; ?></h2>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_firstname; ?> *</label>
        <input type="text" name="firstname" value="" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_lastname; ?> *</label>
        <input type="text" name="lastname" value="" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_email; ?> *</label>
        <input type="text" name="email" value="" size="30" class="required" title="<?php echo $this->language->get('error_email'); ?>" />
      </div>
      
      <div class="s_row_2 clearfix">
        <label><?php echo $entry_telephone; ?> *</label>
        <input type="text" name="telephone" value="" size="30" class="required" title="<?php echo $this->language->get('error_telephone'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_fax; ?></label>
        <input type="text" name="fax" value="" size="30" />
      </div>

      <div class="s_row_2 s_mb_20 clearfix">
        <label><?php echo $entry_company; ?></label>
        <input type="text" name="company" value="" size="30" />
      </div>

    </div>

    <div class="right" style="width: 49.99%;">

      <h2><?php echo $text_your_address; ?></h2>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_address_1; ?> *</label>
        <input type="text" name="address_1" value="" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_address_2; ?></label>
        <input type="text" name="address_2" value="" size="30" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_city; ?> *</label>
        <input type="text" name="city" value="" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label id="postcode"><?php echo $entry_postcode; ?> *</label>
        <input type="text" name="postcode" value="" size="30" title="<?php echo $this->language->get('error_postcode'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_country; ?></label>
        <select id="country_id" name="country_id" class="large-field" onchange="$('#payment-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=' + this.value);">
          <option value=""><?php echo $text_select; ?></option>
          <?php foreach ($countries as $country): ?>
          <?php if ($country['country_id'] == $country_id): ?>
          <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
          <?php else: ?>
          <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
          <?php endif; ?>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="s_row_2 s_mb_20 clearfix">
        <label><?php echo $entry_zone; ?> *</label>
        <select id="zone_id" name="zone_id" class="required"></select>
      </div>

    </div>


    <span class="clear s_mb_20 border_eee"></span>


    <div class="left" style="width: 49.99%;">
      <h2><?php echo $text_your_password; ?></h2>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_password; ?> *</label>
        <input type="password" name="password" id="password" value="" class="required" size="30" title="<?php echo $this->language->get('error_password'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_confirm; ?> *</label>
        <input type="password" name="confirm" id="confirm" value="" class="required" size="30" title="<?php echo $this->language->get('error_password'); ?>" />
      </div>

      <span class="clear s_mb_20"></span>

      <div class="s_row_2 s_mb_20 clearfix">
        <label class="s_checkbox" for="newsletter"><input type="checkbox" name="newsletter" value="1" id="newsletter" /> <?php echo $entry_newsletter; ?></label>
        <?php if ($shipping_required): ?>
        <span class="clear"></span>
        <label class="s_checkbox" for="shipping"><input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" /> <?php echo $entry_shipping; ?></label>
        <?php endif; ?>
        <?php if ($text_agree): ?>
        <label class="s_checkbox left"><input type="checkbox" name="agree" value="1" class="required" title="<?php echo $this->document->shoppica_text_error_required; ?>" /> <?php echo $this->document->shoppica_text_agree_account; ?></label>
        <?php endif; ?>
      </div>
    </div>

  </form>

  <span class="clear s_mb_20 border_eee"></span>

  <div class="s_submit clearfix">
    <a id="button-register" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
  </div>

  <script type="text/javascript">
  $('#payment-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>');
  </script>

  <script type="text/javascript">

    $(document).ready(function() {
      $("#register_details_form").validate({
        rules: {
          password: {
              required: true,
              minlength: 4
          },
          confirm: {
              required: function(element) {
                  var str = $("#password").val();

                  return str.length > 0;
              },
              minlength: 4,
              equalTo: "#password"
          }
        },
        messages: {
          confirm: {
            equalTo: "<?php echo $this->document->shoppica_text_error_password_match; ?>"
          }
        }
      });
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
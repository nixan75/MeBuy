  <form id="guest_details_form">
    <h2><?php echo $text_your_details; ?></h2>

    <div class="left" style="width: 49.99%;">
      <div class="s_row_2 clearfix">
        <label><?php echo $entry_firstname; ?> *</label>
        <input type="text" name="firstname" value="<?php echo $firstname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_lastname; ?> *</label>
        <input type="text" name="lastname" value="<?php echo $lastname; ?>" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_email; ?> *</label>
        <input type="text" name="email" value="<?php echo $email; ?>" size="30" class="required" title="<?php echo $this->language->get('error_email'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_telephone; ?> *</label>
        <input type="text" name="telephone" value="<?php echo $telephone; ?>" size="30" class="required" title="<?php echo $this->language->get('error_telephone'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_fax; ?></label>
        <input type="text" name="fax" value="<?php echo $fax; ?>" size="30" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_company; ?></label>
        <input type="text" name="company" value="<?php echo $company; ?>" size="30" />
      </div>
      
    </div>

    <div class="right" style="width: 49.99%;">

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_address_1; ?> *</label>
        <input type="text" name="address_1" value="<?php echo $address_1; ?>" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_address_2; ?></label>
        <input type="text" name="address_2" value="<?php echo $address_2; ?>" size="30" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_city; ?> *</label>
        <input type="text" name="city" value="<?php echo $city; ?>" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label id="postcode"><?php echo $entry_postcode; ?> *</label>
        <input type="text" name="postcode" value="<?php echo $postcode; ?>" size="30" title="<?php echo $this->language->get('error_postcode'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label class="required"><?php echo $entry_country; ?> *</label>
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

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_zone; ?> *</label>
        <select id="zone_id" name="zone_id" class="required"></select>
      </div>

    </div>
    
    <span class="clear s_mb_10"></span>
    
    <?php if ($shipping_required): ?>
    <div class="s_row_2 s_mb_10 clearfix">
      <?php if ($shipping_address): ?>
      <label class="s_checkbox" for="shipping"><input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" /> <?php echo $entry_shipping; ?></label>
      <?php else: ?>
      <label class="s_checkbox" for="shipping"><input type="checkbox" name="shipping_address" value="1" id="shipping" /> <?php echo $entry_shipping; ?></label>
      <?php endif; ?>
    </div>
    <?php endif; ?>
    
  </form> 
    
  <span class="clear s_mb_20 border_eee"></span>

  <div class="s_submit clearfix">
    <a id="button-guest" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
  </div>

<script type="text/javascript">
$('#payment-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
</script>

<script type="text/javascript">
  $(document).ready(function() {
    $("#guest_details_form").validate();
  });
</script>


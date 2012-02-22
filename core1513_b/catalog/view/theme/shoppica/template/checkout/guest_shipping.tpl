  <form id="guest_shipping_form">

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
        <label><?php echo $entry_company; ?></label>
        <input type="text" name="company" value="<?php echo $company; ?>" size="30" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_address_1; ?> *</label>
        <input type="text" name="address_1" value="<?php echo $address_1; ?>" size="30" class="required" title="<?php echo $this->language->get('error_address_1'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_address_2; ?></label>
        <input type="text" name="address_2" value="<?php echo $address_2; ?>" size="30" />
      </div>

    </div>

    <div class="right" style="width: 49.99%;">

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_city; ?> *</label>
        <input type="text" name="city" value="<?php echo $city; ?>" size="30" class="required" title="<?php echo $this->language->get('error_city'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label id="postcode"><?php echo $entry_postcode; ?> *</label>
        <input type="text" name="postcode" value="<?php echo $postcode; ?>" size="30" class="required" title="<?php echo $this->language->get('error_postcode'); ?>" />
      </div>

      <div class="s_row_2 clearfix">
        <label><?php echo $entry_country; ?> *</label>
        <select id="country_id" name="country_id" class="required" onchange="$('#shipping-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=' + this.value);">
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
    
  </form>
  
  <span class="clear s_mb_20"></span>

  <div class="s_submit clearfix">
    <a id="button-guest-shipping" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
  </div>

<script type="text/javascript">
$('#shipping-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>&zone_id=<?php echo $zone_id; ?>');
</script>

<script type="text/javascript">
  $(document).ready(function() {
    $("#guest_shipping_form").validate();
  });
</script>
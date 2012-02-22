  <div class="s_row_3 clearfix">
    <?php if ($addresses): ?>
    <label class="s_checkbox" for="<?php echo $type; ?>-address-existing">
      <input type="radio" name="<?php echo $type; ?>_address" value="existing" id="<?php echo $type; ?>-address-existing" checked="checked" />
      <?php echo $text_address_existing; ?>
    </label>
    <div id="<?php echo $type; ?>-existing" class="s_mb_20 clearfix">
      <select name="address_id" id="<?php echo $type; ?>_address_id" size="5" style="min-width: 406px;">
        <?php foreach ($addresses as $address): ?>
        <?php if ($address['address_id'] == $address_id): ?>
        <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
        <?php else: ?>
        <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['country']; ?></option>
        <?php endif; ?>
        <?php endforeach; ?>
      </select>
    </div>
    <span class="clear"></span>
    <?php endif; ?>
    <label class="s_checkbox" for="<?php echo $type; ?>-address-new"> <input type="radio" name="<?php echo $type; ?>_address" value="new" id="<?php echo $type; ?>-address-new" /> <?php echo $text_address_new; ?></label>
  </div>

  <form id="<?php echo $type; ?>_form" class="s_address" style="display: none;">

    <div class="s_row_2 clearfix">
      <label><?php echo $entry_firstname; ?> *</label>
      <input type="text" name="firstname" value="" size="30" class="required" title="<?php echo $this->language->get('error_firstname'); ?>" />
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $entry_lastname; ?> *</label>
      <input type="text" name="lastname" value="" size="30" class="required" title="<?php echo $this->language->get('error_lastname'); ?>" />
    </div>

    <div class="s_row_2 clearfix">
      <label><?php echo $entry_company; ?></label>
      <input type="text" name="company" value="" size="30" />
    </div>

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
      <label><?php echo $entry_country; ?> *</label>
      <select name="country_id" id="country_id" class="required" onchange="$('#<?php echo $type; ?>-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=' + this.value);">
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

  </form>

  <span class="clear s_mb_20 border_eee"></span>
  
  <div class="s_submit clearfix">
    <a class="<?php echo $type; ?>_button-address s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
  </div>

  <script type="text/javascript">
    $(document).ready(function() {
      $("#<?php echo $type; ?>_form").validate();
      if($("#<?php echo $type; ?>_address_id option:selected").length == 0) {
        $("#<?php echo $type; ?>_address_id option:first").attr("selected", "selected");
      }
    });
  </script>

  <script type="text/javascript">
  $('#<?php echo $type; ?>-address select[name=\'zone_id\']').load('index.php?route=checkout/address/zone&country_id=<?php echo $country_id; ?>');
  $('#<?php echo $type; ?>-address input[name=\'<?php echo $type; ?>_address\']').live('change', function() {
    if (this.value == 'new') {
      $('#<?php echo $type; ?>-existing').hide();
      $('#<?php echo $type; ?>_form').show();
    } else {
      $('#<?php echo $type; ?>-existing').show();
      $('#<?php echo $type; ?>_form').hide();
    }
  });
  </script>

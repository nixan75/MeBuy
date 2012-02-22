<script type="text/javascript" src="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/js/jquery/colorpicker/colorpicker.js"></script>

<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/stylesheet/colorpicker/colorpicker.css" media="all" />
<link rel="stylesheet" href="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/stylesheet/cp.css" type="text/css" />

<div id="shoppica_cp_open">
  <a href="javascript:;"></a>
</div>
<div id="shoppica_cp" style="display: none;">
  <a id="shoppica_cp_close" href="javascript:;"></a>
  <span id="shoppica_cp_title">Control Panel</span>
  <div id="shoppica_cp_wrapper">
    <form class="clearfix" name="shoppica" action="<?php echo HTTP_SERVER . 'index.php?route=module/shoppica/saveTheme'; ?>" method="post">
      <h3>Theme colors</h3>
      <div class="s_panel_section">
        <div class="s_cp_row clearfix">
          <label><strong>Category:</strong></label>
          <span class="clear"></span>
          <select id="modify_theme_categories" name="shoppica[path]">
            <option value="<?php echo $category_id != 0 ? HTTP_SERVER . 'index.php?route=common/home' : 0; ?>">*Global*</option>
            <?php foreach ($categories as $category): ?>
            <?php if ($category['category_id'] == $category_id): ?>
            <?php $url = $category['url']; ?>
            <option value="<?php echo $category['path']; ?>" selected="selected"><?php echo $category['name']; ?></option>
            <?php else: ?>
            <option value="<?php echo $category['url']; ?>"><?php echo $category['name']; ?></option>
            <?php endif; ?>
            <?php endforeach; ?>
          </select>
        </div>
        <div class="s_cp_row clearfix">
          <label><strong>Color scheme:</strong></label>
          <span class="clear"></span>
          <div id="prefedined_themes">
            <?php $already_selected = false; ?>
            <select id="modify_theme_predefined" name="shoppica[predefined_theme]">
                <?php if ($category_id != 0): ?>
                <option value="parent"<?php if($color_themes_config['is_parent'] == 1) { echo ' selected="selected"'; $already_selected = true; } ?>><?php echo "Inherit `{$color_themes_config['parent_name']}` ("; if ($color_themes_config['parent_theme'] != 'custom') echo $theme_names[$color_themes_config['parent_theme']]; else echo 'custom';?>)</option>
                <?php endif; ?>
                <option value="custom"<?php if($color_themes_config['predefined_theme'] == "custom" && $color_themes_config['is_parent'] == 0) { echo ' selected="selected"'; $already_selected = true; } ?>>custom</option>
              <?php foreach ($predefined_themes as $name => $settings): ?>
                <?php if (($name == $color_themes_config['predefined_theme']) && !$already_selected): ?>
                <option value="<?php echo $name; ?>" selected="selected"><?php echo $theme_names[$name]; ?></option>
                <?php else: ?>
                <option value="<?php echo $name; ?>"><?php echo $theme_names[$name]; ?></option>
                <?php endif; ?>
              <?php endforeach; ?>
            </select>
          </div>
        </div>
        <div class="s_cp_row clearfix">
          <label>Main color:</label>
          <div id="mainColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['main_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][main_color]" value="<?php echo $color_themes_config['theme_colors']['main_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Secondary color:</label>
          <div id="secondaryColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['secondary_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][secondary_color]" value="<?php echo $color_themes_config['theme_colors']['secondary_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Intro:</label>
          <div id="introColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['intro_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][intro_color]" value="<?php echo $color_themes_config['theme_colors']['intro_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Intro text:</label>
          <div id="introTextColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['intro_text_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][intro_text_color]" value="<?php echo $color_themes_config['theme_colors']['intro_text_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Intro title:</label>
          <div id="introTitleColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['intro_title_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][intro_title_color]" value="<?php echo $color_themes_config['theme_colors']['intro_title_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Price:</label>
          <div id="priceColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['price_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][price_color]" value="<?php echo $color_themes_config['theme_colors']['price_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Price text:</label>
          <div id="priceTextColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['price_text_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][price_text_color]" value="<?php echo $color_themes_config['theme_colors']['price_text_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Promo price:</label>
          <div id="promoPriceColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['promo_price_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][promo_price_color]" value="<?php echo $color_themes_config['theme_colors']['promo_price_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix">
          <label>Promo price text:</label>
          <div id="promoPriceTextColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['promo_price_text_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][promo_price_text_color]" value="<?php echo $color_themes_config['theme_colors']['promo_price_text_color'] ?>" size="6" maxlength="6" />
        </div>
        <div class="s_cp_row clearfix"<?php if($this->document->shoppica_layout_type != 'fixed') echo ' style="display:none"';?>>
          <label>Body background:</label>
          <div id="backgroundColorSelector" class="colorSelector">
            <div style="background-color: #<?php echo $color_themes_config['theme_colors']['background_color'] ?>"></div>
          </div>
          <input class="s_color" type="hidden" name="shoppica[theme_colors][background_color]" value="<?php echo $color_themes_config['theme_colors']['background_color'] ?>" size="6" maxlength="6" />
        </div>

        <div class="s_cp_row clearfix">
          <label>Texture:</label>
          <select id="textureSelector" class="right" style="width: 90px; margin-right: 0;" name="shoppica[theme_colors][texture]">
            <optgroup label="Shoppica">
              <option value="texture_1"<?php if($color_themes_config['theme_colors']['texture'] == 'texture_1') echo ' selected="selected"';?>>Squares</option>
              <option value="texture_2"<?php if($color_themes_config['theme_colors']['texture'] == 'texture_2') echo ' selected="selected"';?>>Noise</option>
              <option value="texture_3"<?php if($color_themes_config['theme_colors']['texture'] == 'texture_3') echo ' selected="selected"';?>>Rough</option>
              <option value="no_texture"<?php if($color_themes_config['theme_colors']['texture'] == 'no_texture') echo ' selected="selected"';?>>No texture</option>
            </optgroup>
            <?php if ($backgrounds): ?>
            <optgroup label="Custom">
              <?php foreach ($backgrounds as $background): ?>
              <option value="<?php echo $background['id']; ?>"<?php if($color_themes_config['theme_colors']['texture'] == $background['id']) echo ' selected="selected"';?>><?php echo $background['name']; ?></option>
              <?php endforeach; ?>
            </optgroup>
            <?php endif; ?>
          </select>
        </div>

        <input type="hidden" id="colors_data" name="colors_data" value='<?php echo $colors_data; ?>' />
        <button type="submit"><span class="s_icon_10"><span class="s_icon s_save_10"></span>Save settings</span></button>
      </div>
      <?php /*
      <h3>Theme options</h3>
      <div class="s_panel_section">
        <div class="s_cp_row clearfix">
          <label><strong>Layout type:</strong></label>
          <span class="clear"></span>
          <select>
            <option>Fixed width</option>
            <option>Full width</option>
          </select>
        </div>
        <div class="s_cp_row clearfix">
          <label><strong>Side column position:</strong></label>
          <span class="clear"></span>
          <select>
            <option>Left</option>
            <option>Right</option>
          </select>
        </div>
        <div class="s_cp_row clearfix">
          <label><strong>Products per row:</strong></label>
          <span class="clear"></span>
          <select>
            <option>3 (4 on full width)</option>
            <option>4 (6 on full width)</option>
          </select>
        </div>
        <button type="submit"><span class="s_icon_10"><span class="s_icon s_save_10"></span>Save settings</span></button>
      </div>
      */ ?>
    </form>
  </div>
</div>

<script type="text/javascript">

  $(document).ready(function() {
    if($.cookie('shoppica_cp_closed') == 1) {
      $("#shoppica_cp").hide();
      $("#shoppica_cp_open").show();
    } else {
      $("#shoppica_cp").show();
    }
  });

  $("#shoppica_cp_close").bind("click", function() {
    $("#shoppica_cp").hide("slide", { direction: "left" }, 1000, function() {
      $("#shoppica_cp_open").show("slide", { direction: "left" }, 500);
      $.cookie('shoppica_cp_closed', 1);
    });
  });

  $("#shoppica_cp_open a").bind("click", function() {
    $("#shoppica_cp_open").hide("slide", { direction: "left" }, 500, function() {
      $("#shoppica_cp").show("slide", { direction: "left" }, 1000);
      $.cookie('shoppica_cp_closed', null);
    });
  });

  $("#modify_theme_categories").bind("change", function() {
    window.location = $(this).val();
  });

  $("#textureSelector").bind("change", function(event, type) {
      if ($("#modify_theme_predefined").val() != "custom" && type != 'apply-only') {
        $("#modify_theme_predefined").val("custom");
      }

      var texture_type = $(this).find("option:selected").parent().attr("label");

      if (texture_type == "Shoppica") {
        if ($(this).val() != 'no_texture') {
          $("body.s_layout_fixed").css('background-image', "url(catalog/view/theme/shoppica/images/" + $(this).val() + ".png)");
          $("body.s_layout_fixed").css('background-repeat', "repeat");
          $("body.s_layout_fixed").css('background-position', "top left");
          $("body.s_layout_fixed").css('background-attachment', "scroll");
        } else {
          $("body.s_layout_fixed").css('background-image', 'none');
        }
      } else {
        <?php if ($backgrounds): ?>
        var background_settings = jQuery.parseJSON('<?php echo json_encode($backgrounds); ?>');
        var item_id = $(this).find("option:selected").val();

        $("body.s_layout_fixed").css('background-image', "url(image/" + background_settings[item_id].image + ")");
        $("body.s_layout_fixed").css('background-repeat', background_settings[item_id].repeat);
        $("body.s_layout_fixed").css('background-position', background_settings[item_id].position);
        $("body.s_layout_fixed").css('background-attachment', background_settings[item_id].attachment);

        <?php endif; ?>
      }

  });

  $('#mainColorSelector, #secondaryColorSelector, #introColorSelector, #introTextColorSelector, #introTitleColorSelector, #priceColorSelector, #priceTextColorSelector, #promoPriceColorSelector, #promoPriceTextColorSelector, #backgroundColorSelector').each(function() {
    var $el = $(this);

    $el.ColorPicker({
      color: '#0000ff',
      onShow: function (colpkr) {

        if ($("#modify_theme_predefined").val() != "custom") {
          $("#modify_theme_predefined").val("custom");
        }

        $(colpkr).fadeIn(500);
        $(this).ColorPickerSetColor($el.next("input").val());

        return false;
      },
      onHide: function (colpkr) {

        if ($("#modify_theme_predefined").val() != "custom") {
          $("#modify_theme_predefined").val("custom");
        }

        $(colpkr).fadeOut(500);
        $el.next("input").val($(colpkr).data('colorpicker').fields.eq(0).val());

        return false;
      },
      onChange: function (hsb, hex, rgb) {

        $el.find('div').css('backgroundColor', '#' + hex);
        switch ($el.attr("id")) {

          case 'mainColorSelector' :
            $(".s_main_color, #twitter li span a, .s_box h2, .box .top").css('color', '#' + hex);
            $(".s_main_color_bgr, #cart .s_icon, #shop_contacts .s_icon, .s_list_1 li, .s_item .s_button_add_to_cart .s_icon, #cart_menu .s_icon, #intro .s_button_prev, #intro .s_button_next, .s_product_row .s_row_number").css('backgroundColor', '#' + hex);
            $("#main_color").val('#' + hex);
            break;

          case 'secondaryColorSelector' :
            $("#categories > ul > li > a, #footer_categories h2, .pagination a, #view_mode .s_selected a, .s_secondary_color").css('color', '#' + hex);
            $(".s_secondary_color_bgr, #site_search .s_search_button, #view_mode .s_selected .s_icon").css('backgroundColor', '#' + hex);
            $("#secondary_color").val('#' + hex);
            break;

          case 'introColorSelector' :
            $("#intro").css('backgroundColor', '#' + hex);
            break;

          case 'introTextColorSelector' :
            $("#intro, #breadcrumbs a").css('color', '#' + hex);
            break;

          case 'introTitleColorSelector' :
            $("#intro h1, #intro h1 *, #intro h2, #intro h2 *").css('color', '#' + hex);
            break;

          case 'priceColorSelector' :
            $(".s_price").not(".s_promo_price").css('backgroundColor', '#' + hex);
            break;

          case 'priceTextColorSelector' :
            $(".s_price, .s_price .s_currency").not(".s_promo_price, .s_old_price, .s_promo_price .s_currency").css('color', '#' + hex);
            break;

          case 'promoPriceColorSelector' :
            $(".s_promo_price").css('backgroundColor', '#' + hex);
            break;

          case 'promoPriceTextColorSelector' :
            $(".s_promo_price, .s_old_price, .s_promo_price .s_currency").css('color', '#' + hex);
            break;

          case 'backgroundColorSelector' :
            $("body.s_layout_fixed").css('backgroundColor', '#' + hex);
            break;

        }
      }
    });
    /*
    $el.next("input").bind("keyup", function(){
      $el.ColorPickerSetColor(this.value);
      $el.find('div').css('backgroundColor', '#' + this.value);
    });
    */
  });

  var colorsData = jQuery.parseJSON($("#colors_data").val());

  $("#modify_theme_predefined").bind("change", function() {
    themeName = $(this).val();
    themeData = colorsData[themeName];

    $("#textureSelector").val(themeData.texture).trigger("change", ['apply-only']);

    $("#mainColorSelector").ColorPickerSetColor(themeData.main_color);
    $("#" + $("#mainColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#mainColorSelector").next("input").val($("#" + $("#mainColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#secondaryColorSelector").ColorPickerSetColor(themeData.secondary_color);
    $("#" + $("#secondaryColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#secondaryColorSelector").next("input").val($("#" + $("#secondaryColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#introColorSelector").ColorPickerSetColor(themeData.intro_color);
    $("#" + $("#introColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#introColorSelector").next("input").val($("#" + $("#introColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#introTextColorSelector").ColorPickerSetColor(themeData.intro_text_color);
    $("#" + $("#introTextColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#introTextColorSelector").next("input").val($("#" + $("#introTextColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#introTitleColorSelector").ColorPickerSetColor(themeData.intro_title_color);
    $("#" + $("#introTitleColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#introTitleColorSelector").next("input").val($("#" + $("#introTitleColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#priceColorSelector").ColorPickerSetColor(themeData.price_color);
    $("#" + $("#priceColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#priceColorSelector").next("input").val($("#" + $("#priceColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#priceTextColorSelector").ColorPickerSetColor(themeData.price_text_color);
    $("#" + $("#priceTextColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#priceTextColorSelector").next("input").val($("#" + $("#priceTextColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#promoPriceColorSelector").ColorPickerSetColor(themeData.promo_price_color);
    $("#" + $("#promoPriceColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#promoPriceColorSelector").next("input").val($("#" + $("#promoPriceColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#promoPriceTextColorSelector").ColorPickerSetColor(themeData.promo_price_text_color);
    $("#" + $("#promoPriceTextColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#promoPriceTextColorSelector").next("input").val($("#" + $("#promoPriceTextColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());

    $("#backgroundColorSelector").ColorPickerSetColor(themeData.background_color);
    $("#" + $("#backgroundColorSelector").data("colorpickerId")).find("input").trigger("change");
    $("#backgroundColorSelector").next("input").val($("#" + $("#backgroundColorSelector").data("colorpickerId")).find("div.colorpicker_hex input").val());
  });

</script>
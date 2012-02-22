<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb): ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php endforeach; ?>
  </div>
  <?php if ($error_warning): ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php endif ?>
  <?php if ($success): ?>
  <div class="success"><?php echo $success; ?></div>
  <?php endif; ?>

<div id="shoppica_cp">
  <?php //<a id="themeburn_logo" href="http://www.themeburn.com">ThemeBurn.com</a>?>

  <h1><?php echo $heading_title; ?></h1>

  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
    <input type="hidden" name="intro_banner_path" value="<?php echo $intro_banner_path?>" />
    <input type="hidden" name="return_to" id="return_to" value="<?php echo $return_to?>" />

    <div class="s_row_2 clearfix" style="padding-top: 0">
      <label><?php echo $entry_status; ?></label>
      <select class="s_w_200" name="shoppica[shoppica_status]">
        <?php if ($shoppica_status): ?>
        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
        <option value="0"><?php echo $text_disabled; ?></option>
        <?php else: ?>
        <option value="1"><?php echo $text_enabled; ?></option>
        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
        <?php endif; ?>
      </select>
    </div>

    <div id="settings_tabs" class="htabs clearfix">
      <a href="#layout_settings">Layout</a>
      <a href="#payment_settings">Payment Images</a>
      <a href="#intro_settings">Intro</a>
      <a href="#footer_settings">Footer</a>
      <a href="#background_settings">Background</a>
    </div>

    <div id="layout_settings" class="divtab">

      <div class="s_row_2 clearfix">
        <label>Layout Type</label>
        <select name="shoppica[shoppica_layout_type]" style="width: 150px;">
          <option value="fixed"<?php if($shoppica_layout_type == 'fixed') echo ' selected="selected"';?>>Fixed Width</option>
          <option value="full"<?php if($shoppica_layout_type == 'full') echo ' selected="selected"';?>>Full Width</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Side Column Position</label>
        <select name="shoppica[shoppica_column_position]" style="width: 150px;">
          <option value="right"<?php if($shoppica_column_position == 'right') echo ' selected="selected"';?>>Right</option>
          <option value="left"<?php if($shoppica_column_position == 'left') echo ' selected="selected"';?>>Left</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Products per row</label>
        <select name="shoppica[shoppica_products_listing]" style="width: 150px;">
          <option value="size_1"<?php if($shoppica_products_listing == 'size_1') echo ' selected="selected"';?>>3 (4 on home page)</option>
          <option value="size_2"<?php if($shoppica_products_listing == 'size_2') echo ' selected="selected"';?>>4 (6 on home page)</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Show categories in footer</label>
        <select name="shoppica[shoppica_show_footer_categories]" style="width: 150px;">
          <option value="1"<?php if($shoppica_show_footer_categories == '1') echo ' selected="selected"';?>>Yes</option>
          <option value="0"<?php if($shoppica_show_footer_categories != '1') echo ' selected="selected"';?>>No</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Show brands in the main menu</label>
        <select name="shoppica[shoppica_show_menu_brands]" style="width: 150px;">
          <option value="1"<?php if($shoppica_show_menu_brands == '1') echo ' selected="selected"';?>>Yes</option>
          <option value="0"<?php if($shoppica_show_menu_brands != '1') echo ' selected="selected"';?>>No</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Search bar visibility</label>
        <select name="shoppica[shoppica_show_search_bar]" style="width: 150px;">
          <option value="1"<?php if($shoppica_show_search_bar == '1') echo ' selected="selected"';?>>Always visible</option>
          <option value="0"<?php if($shoppica_show_search_bar != '1') echo ' selected="selected"';?>>Show onclick</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Subcategories display style</label>
        <select name="shoppica[shoppica_subcategories_style]" style="width: 150px;">
          <option value="shoppica"<?php if($shoppica_subcategories_style == 'shoppica') echo ' selected="selected"';?>>Shoppica</option>
          <option value="opencart"<?php if($shoppica_subcategories_style == 'opencart') echo ' selected="selected"';?>>Opencart</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Show information pages in the menu</label>
        <select name="shoppica[shoppica_menu_information_pages]" style="width: 150px;">
          <option value="1"<?php if($shoppica_menu_information_pages == '1') echo ' selected="selected"';?>>Yes</option>
          <option value="0"<?php if($shoppica_menu_information_pages != '1') echo ' selected="selected"';?>>No</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Show cart label</label>
        <select name="shoppica[shoppica_show_cart_label]" style="width: 150px;">
          <option value="1"<?php if($shoppica_show_cart_label == '1') echo ' selected="selected"';?>>Yes</option>
          <option value="0"<?php if($shoppica_show_cart_label == '0') echo ' selected="selected"';?>>No</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Cart menu position</label>
        <select name="shoppica[shoppica_cart_menu_position]" style="width: 150px;">
          <option value="right"<?php if($shoppica_cart_menu_position == 'right') echo ' selected="selected"';?>>Right to the menu</option>
          <option value="above"<?php if($shoppica_cart_menu_position == 'above') echo ' selected="selected"';?>>Above the menu</option>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Product images position</label>
        <select name="shoppica[shoppica_product_images_position]" style="width: 150px;">
          <option value="tab"<?php if($shoppica_product_images_position == 'tab') echo ' selected="selected"';?>>In a separate tab</option>
          <option value="outside"<?php if($shoppica_product_images_position == 'outside') echo ' selected="selected"';?>>Under the preview image</option>
        </select>
      </div>

      <input type="hidden" name="shoppica[shoppica_show_menu_brands_count]" value="0">
      <!--
      <div class="s_row_2 clearfix">
        <label class="s_checkbox"><input type="checkbox" name="shoppica[shoppica_show_menu_brands_count]" value="1"<?php if($shoppica_show_menu_brands_count == '1') echo ' checked="checked"'; ?> /> Show products count for every category</label>
      </div>
      -->

      <div class="s_row_2 clearfix">
        <label>Modify theme colors</label>
        <a class="s_button_white s_button_green s_f_12 left" href="<?php echo $modify_theme; ?>" target="_blank">Launch Color Schemer</a>
        <?php if($has_color_themer): ?>
        <a class="s_button_white s_button_red s_f_12 right" href="<?php echo $remove_themer_url; ?>">Remove Color Schemer from Frontend</a>
        <?php endif; ?>
      </div>

    </div>

    <div id="payment_settings" class="divtab">
      <table id="shoppica_payment_images_table" class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr>
            <td width="60">Image</td>
            <td>Url</td>
            <td>Order</td>
            <td>&nbsp;</td>
          </tr>
        </thead>
        <tbody>
          <?php $payment_image_row = 0; ?>
          <?php foreach ($payment_images as $banner_image): ?>
          <tr id="payment_image_row<?php echo $payment_image_row; ?>">
            <td>
              <input type="hidden" name="payment[images][<?php echo $payment_image_row; ?>][image]" value="<?php echo $banner_image['file']; ?>" id="payment_image<?php echo $payment_image_row; ?>"  />
              <img src="<?php echo $banner_image['preview']; ?>" alt="" id="payment_preview<?php echo $payment_image_row; ?>" class="image" onclick="image_upload('payment_image<?php echo $payment_image_row; ?>', 'payment_preview<?php echo $payment_image_row; ?>');" />
            </td>
            <td><input type="text" name="payment[images][<?php echo $payment_image_row; ?>][url]" value="<?php echo $banner_image['url']; ?>" size="60" /></td>
            <td><input type="text" name="payment[images][<?php echo $payment_image_row; ?>][order]" value="<?php echo $banner_image['order']; ?>" size="1" /></td>
            <td><a onclick="$('#payment_image_row<?php echo $payment_image_row; ?>').remove();" class="s_button_white s_button_blue"><span>Remove</span></a></td>
          </tr>
          <?php $payment_image_row++; ?>
          <?php endforeach; ?>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="4"><br /><a onclick="addImagePayment();" class="s_button_white s_button_green right"><strong class="s_f_12">Add Image</strong></a></td>
          </tr>
        </tfoot>
      </table>
    </div>

    <div id="intro_settings" class="divtab">

      <div class="s_row_2 clearfix">
        <label>Category</label>
        <select id="intro_banner_categories" name="intro_banner[category_path]">
          <?php if ($intro_banner_category_id == 0): ?>
          <option value="0">*Global*</option>
          <?php else: ?>
          <option value="<?php echo HTTPS_SERVER . 'index.php?route=module/shoppica&token=' . $this->session->data['token']; ?>">*Global*</option>
          <?php endif; ?>
          <?php foreach ($intro_banner_categories as $category): ?>
          <?php if ($category['category_id'] == $intro_banner_category_id): ?>
          <?php $url = $category['url']; ?>
          <option value="<?php echo $category['path']; ?>" selected="selected"><?php echo $category['name']; ?></option>
          <?php else: ?>
          <option value="<?php echo $category['url']; ?>&return_to=intro_settings"><?php echo $category['name']; ?></option>
          <?php endif; ?>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="s_row_2 clearfix">
        <label>Intro type</label>
        <div class="s_full">
          <?php if($intro_banner_category_id != 0): ?>
          <label class="s_radio block nofloat"><input type="radio" value="parent" name="intro_banner[banner_type]" <?php if($modify_theme_config['intro_banner_type'] == 'parent') echo ' checked="checked"';?> /> Inhreit from parent</label>
          <?php endif; ?>
          <label class="s_radio block nofloat"><input type="radio" value="nobanner" name="intro_banner[banner_type]" class="choose_intro"<?php if($modify_theme_config['intro_banner_type'] == 'nobanner') echo ' checked="checked"';?> /> No intro</label>
          <label class="s_radio block nofloat"><input type="radio" value="products" name="intro_banner[banner_type]" class="choose_intro"<?php if($modify_theme_config['intro_banner_type'] == 'products') echo ' checked="checked"';?> /> Product slideshow</label>
          <label class="s_radio block nofloat"><input type="radio" value="images" name="intro_banner[banner_type]" class="choose_intro"<?php if($modify_theme_config['intro_banner_type'] == 'images') echo ' checked="checked"';?> /> Custom images slideshow</label>
        </div>
      </div>

      <div id="shoppica_intro_banner_type_products" style="display: none">
        <div class="s_row_2 clearfix">
          <label>Size:</label>
          <select name="intro_banner[products_size]">
            <option value="3"<?php if($modify_theme_config['intro_banner_products_size'] == '3') echo ' selected="selected"';?>>Large</option>
            <option value="2"<?php if($modify_theme_config['intro_banner_products_size'] == '2') echo ' selected="selected"';?>>Middle</option>
            <option value="1"<?php if($modify_theme_config['intro_banner_products_size'] == '1') echo ' selected="selected"';?>>Small</option>
          </select>
        </div>
        <div class="s_row_2 clearfix">
          <div class="s_full">
            <a class="sModal s_button_white s_button_green left s_f_12" href="<?php echo HTTPS_SERVER.'index.php?route=module/shoppica/getIntroBannerProductsHtml&token='.$this->session->data['token']; ?>">Choose products</a>
          </div>
        </div>
      </div>

      <div id="shoppica_intro_banner_type_images" style="display: none">

        <div id="shoppica_intro_banner_type_images_tabs" class="htabs clearfix">
          <?php foreach ($languages as $language): ?>
          <a href="#language_<?php echo $language['language_id']; ?>">
            <img class="inline" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
          </a>
          <?php endforeach; ?>
        </div>

        <?php foreach ($languages as $language): ?>
        <div id="language_<?php echo $language['language_id']; ?>" class="divtab">

          <div class="s_row_2 clearfix">
            <label>Images settings</label>
            <div class="s_full">
              <label class="s_radio"><input type="checkbox" value="1" name="intro_banner[image_vars][<?php echo $language['language_id']; ?>][with_border]"<?php if($intro_banner_image_vars[$language['language_id']]['with_border'] == '1') echo ' checked="checked"'; ?> /> Put border on image</label>
            </div>
          </div>

          <div class="s_row_2 clearfix">
            <label>Rotation type</label>
            <select name="intro_banner[image_vars][<?php echo $language['language_id']; ?>][rotation_type]">
              <option value="slide"<?php if($intro_banner_image_vars[$language['language_id']]['rotation_type'] == 'slide') echo ' selected="selected"'; ?>>Slide</option>
              <option value="fade"<?php if($intro_banner_image_vars[$language['language_id']]['rotation_type'] == 'fade') echo ' selected="selected"'; ?>>Fade</option>
            </select>
          </div>

          <table id="shoppica_intro_banner_type_images_table_<?php echo $language['language_id']; ?>" class="s_table" cellpadding="0" cellspacing="0" border="0">
            <thead>
              <tr>
                <td width="100">Image</td>
                <td>Url</td>
                <td>Order</td>
                <td>&nbsp;</td>
              </tr>
            </thead>
            <tbody>
              <?php if (isset($intro_banner_images[$language['language_id']])): ?>
              <?php $image_row = 0; ?>
              <?php foreach ($intro_banner_images[$language['language_id']] as $banner_image): ?>
              <tr id="image_row_<?php echo $language['language_id']; ?>_<?php echo $image_row; ?>" class="image_row">
                <td>
                  <input type="hidden" name="intro_banner[images][<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['file']; ?>" id="image_<?php echo $image_row; ?>_<?php echo $image_row; ?>"  />
                  <img src="<?php echo $banner_image['preview']; ?>" alt="" id="preview_<?php echo $image_row; ?>_<?php echo $image_row; ?>" class="image" onclick="image_upload('image_<?php echo $image_row; ?>_<?php echo $image_row; ?>', 'preview_<?php echo $image_row; ?>_<?php echo $image_row; ?>');" />
                </td>
                <td><input type="text" name="intro_banner[images][<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][url]" value="<?php echo $banner_image['url']; ?>" size="60" /></td>
                <td><input type="text" name="intro_banner[images][<?php echo $language['language_id']; ?>][<?php echo $image_row; ?>][order]" value="<?php echo $banner_image['order']; ?>" size="1" /></td>
                <td><a onclick="$('#image_row_<?php echo $language['language_id']; ?>_<?php echo $image_row; ?>').remove();" class="s_button_white s_button_blue"><span>Remove</span></a></td>
              </tr>
              <?php $image_row++; ?>
              <?php endforeach; ?>
              <?php endif; ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="4"><br /><a onclick="addImage('shoppica_intro_banner_type_images_table_<?php echo $language['language_id']; ?>', 'intro_banner', <?php echo $language['language_id']; ?>);" class="s_button_white s_button_green right"><strong class="s_f_12">Add Image</strong></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <?php endforeach; ?>

      </div>

    </div>

    <div id="footer_settings" class="divtab">
      <div id="footer_settings_tabs" class="vtabs">
        <a href="#footer_info_settings">Info</a>
        <a href="#footer_contacts_settings">Contacts</a>
        <a href="#footer_twitter_settings">Twitter</a>
        <a href="#footer_facebook_settings">Facebook</a>
      </div>

      <div id="footer_info_settings" class="vtabs_page">

        <div id="shoppica_footer_info_language_tabs" class="htabs clearfix">
          <?php foreach ($languages as $language): ?>
          <a href="#footer_info_language_<?php echo $language['language_id']; ?>">
            <img class="inline" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
          </a>
          <?php endforeach; ?>
        </div>

        <?php foreach ($languages as $language): ?>
        <?php $language_id = $language['language_id']; ?>
        <div id="footer_info_language_<?php echo $language_id; ?>" class="divtab">
          <div class="vtabs_page_holder">
            <div class="s_row_2 clearfix">
              <label style="width: 110px">Enabled</label>
              <select name="shoppica_footer[<?php echo $language_id; ?>][info_enabled]">
                <option value="1"<?php if($shoppica_footer[$language_id]['info_enabled'] == '1') echo ' selected="selected"';?>>Yes</option>
                <option value="0"<?php if($shoppica_footer[$language_id]['info_enabled'] != '1') echo ' selected="selected"';?>>No</option>
              </select>
            </div>
            <div class="s_row_2 clearfix">
              <label style="width: 110px"><?php echo $entry_footer_info_title; ?></label>
              <input type="text" name="shoppica_footer[<?php echo $language_id; ?>][info_title]" size="55" value="<?php echo $shoppica_footer[$language_id]['info_title']; ?>" />
            </div>
            <div class="s_row_2 clearfix">
              <label style="width: 110px"><?php echo $entry_footer_info_text; ?></label>
              <textarea name="shoppica_footer[<?php echo $language_id; ?>][info_text]" cols="52" rows="10"><?php echo $shoppica_footer[$language_id]['info_text']; ?></textarea>
            </div>
          </div>
        </div>
        <?php endforeach; ?>
      </div>

      <div id="footer_contacts_settings" class="vtabs_page">

        <div id="shoppica_footer_contacts_language_tabs" class="htabs clearfix">
          <?php foreach ($languages as $language): ?>
          <a href="#footer_contacts_language_<?php echo $language['language_id']; ?>">
            <img class="inline" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
          </a>
          <?php endforeach; ?>
        </div>

        <?php foreach ($languages as $language): ?>
        <?php $language_id = $language['language_id']; ?>
        <div id="footer_contacts_language_<?php echo $language_id; ?>" class="divtab">
          <div class="vtabs_page_holder">
            <div class="s_row_2 clearfix">
              <label style="width: 110px">Enabled</label>
              <select name="shoppica_footer[<?php echo $language_id; ?>][contacts_enabled]">
                <option value="1"<?php if($shoppica_footer[$language_id]['contacts_enabled'] == '1') echo ' selected="selected"';?>>Yes</option>
                <option value="0"<?php if($shoppica_footer[$language_id]['contacts_enabled'] != '1') echo ' selected="selected"';?>>No</option>
              </select>
            </div>

            <div class="s_row_2 clearfix">
              <input type="hidden" name="shoppica_footer[<?php echo $language_id; ?>][skypename_show]" value="0">
              <label style="width: 110px"><?php echo $entry_skypename; ?></label>
              <label class="s_checkbox"><input type="checkbox" value="1" name="shoppica_footer[<?php echo $language_id; ?>][skypename_show]"<?php if($shoppica_footer[$language_id]['skypename_show'] == '1') echo ' checked="checked"';?> /> Show</label>
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][skypename1]" value="<?php echo $shoppica_footer[$language_id]['skypename1']; ?>" />&nbsp;&nbsp;
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][skypename2]" value="<?php echo $shoppica_footer[$language_id]['skypename2']; ?>" />
            </div>

            <div class="s_row_2 clearfix">
              <input type="hidden" name="shoppica_footer[<?php echo $language_id; ?>][email_show]" value="0">
              <label style="width: 110px">Email</label>
              <label class="s_checkbox"><input type="checkbox" value="1" name="shoppica_footer[<?php echo $language_id; ?>][email_show]"<?php if($shoppica_footer[$language_id]['email_show'] == '1') echo ' checked="checked"';?> /> Show</label>
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][email1]" value="<?php echo $shoppica_footer[$language_id]['email1']; ?>" />&nbsp;&nbsp;
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][email2]" value="<?php echo $shoppica_footer[$language_id]['email2']; ?>" />
            </div>

            <div class="s_row_2 clearfix">
              <input type="hidden" name="shoppica_footer[<?php echo $language_id; ?>][mobile_show]" value="0">
              <label style="width: 110px">Mobile Phone</label>
              <label class="s_checkbox"><input type="checkbox" value="1" name="shoppica_footer[<?php echo $language_id; ?>][mobile_show]"<?php if($shoppica_footer[$language_id]['mobile_show'] == '1') echo ' checked="checked"';?> /> Show</label>
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][mobile1]" value="<?php echo $shoppica_footer[$language_id]['mobile1']; ?>" />&nbsp;&nbsp;
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][mobile2]" value="<?php echo $shoppica_footer[$language_id]['mobile2']; ?>" />
            </div>

            <div class="s_row_2 clearfix">
              <input type="hidden" name="shoppica_footer[<?php echo $language_id; ?>][phone_show]" value="0">
              <label style="width: 110px">Static Phone</label>
              <label class="s_checkbox"><input type="checkbox" value="1" name="shoppica_footer[<?php echo $language_id; ?>][phone_show]"<?php if($shoppica_footer[$language_id]['phone_show'] == '1') echo ' checked="checked"';?> /> Show</label>
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][phone1]" value="<?php echo $shoppica_footer[$language_id]['phone1']; ?>" />&nbsp;&nbsp;
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][phone2]" value="<?php echo $shoppica_footer[$language_id]['phone2']; ?>" />
            </div>

            <div class="s_row_2 clearfix">
              <input type="hidden" name="shoppica_footer[<?php echo $language_id; ?>][fax_show]" value="0">
              <label style="width: 110px">Fax</label>
              <label class="s_checkbox"><input type="checkbox" value="1" name="shoppica_footer[<?php echo $language_id; ?>][fax_show]"<?php if($shoppica_footer[$language_id]['fax_show'] == '1') echo ' checked="checked"';?> /> Show</label>
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][fax1]" value="<?php echo $shoppica_footer[$language_id]['fax1']; ?>" />&nbsp;&nbsp;
              <input class="inline" type="text" name="shoppica_footer[<?php echo $language_id; ?>][fax2]" value="<?php echo $shoppica_footer[$language_id]['fax2']; ?>" />
            </div>
          </div>
        </div>
        <?php endforeach; ?>
      </div>

      <div id="footer_twitter_settings" class="vtabs_page">

        <div id="shoppica_footer_twitter_language_tabs" class="htabs clearfix">
          <?php foreach ($languages as $language): ?>
          <a href="#footer_twitter_language_<?php echo $language['language_id']; ?>">
            <img class="inline" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
          </a>
          <?php endforeach; ?>
        </div>

        <?php foreach ($languages as $language): ?>
        <?php $language_id = $language['language_id']; ?>
        <div id="footer_twitter_language_<?php echo $language_id; ?>" class="divtab">
          <div class="vtabs_page_holder">
            <div class="s_row_2 clearfix">
              <label style="width: 110px">Enabled</label>
              <select name="shoppica_footer[<?php echo $language_id; ?>][twitter_enabled]">
                <option value="1"<?php if($shoppica_footer[$language_id]['twitter_enabled'] == '1') echo ' selected="selected"';?>>Yes</option>
                <option value="0"<?php if($shoppica_footer[$language_id]['twitter_enabled'] != '1') echo ' selected="selected"';?>>No</option>
              </select>
            </div>

            <div class="s_row_2 clearfix">
              <label style="width: 110px">Tweets number</label>
              <select name="shoppica_footer[<?php echo $language_id; ?>][twitter_tweets]">
                <option value="1"<?php if($shoppica_footer[$language_id]['twitter_tweets'] == '1') echo ' selected="selected"';?>>1</option>
                <option value="2"<?php if($shoppica_footer[$language_id]['twitter_tweets'] == '2') echo ' selected="selected"';?>>2</option>
                <option value="3"<?php if($shoppica_footer[$language_id]['twitter_tweets'] == '3') echo ' selected="selected"';?>>3</option>
              </select>
            </div>

            <div class="s_row_2 clearfix">
              <label style="width: 110px"><?php echo $entry_twitter_username; ?></label>
              <td><input type="text" name="shoppica_footer[<?php echo $language_id; ?>][twitter_username]" value="<?php echo $shoppica_footer[$language_id]['twitter_username']; ?>" /></td>
            </div>
          </div>
        </div>
        <?php endforeach; ?>
      </div>

      <div id="footer_facebook_settings" class="vtabs_page">

        <div id="shoppica_footer_facebook_language_tabs" class="htabs clearfix">
          <?php foreach ($languages as $language): ?>
          <a href="#footer_facebook_language_<?php echo $language['language_id']; ?>">
            <img class="inline" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
          </a>
          <?php endforeach; ?>
        </div>

        <?php foreach ($languages as $language): ?>
        <?php $language_id = $language['language_id']; ?>
        <div id="footer_facebook_language_<?php echo $language_id; ?>" class="divtab">
          <div class="vtabs_page_holder">
            <div class="s_row_2 clearfix">
              <label style="width: 110px">Enabled</label>
              <select name="shoppica_footer[<?php echo $language_id; ?>][facebook_enabled]">
                <option value="1"<?php if($shoppica_footer[$language_id]['facebook_enabled'] == '1') echo ' selected="selected"';?>>Yes</option>
                <option value="0"<?php if($shoppica_footer[$language_id]['facebook_enabled'] != '1') echo ' selected="selected"';?>>No</option>
              </select>
            </div>
            <div class="s_row_2 clearfix">
              <label style="width: 110px"><?php echo $entry_facebook_id; ?></label>
              <td><input type="text" name="shoppica_footer[<?php echo $language_id; ?>][facebook_id]" value="<?php echo $shoppica_footer[$language_id]['facebook_id']; ?>" /></td>
            </div>
          </div>
        </div>
        <?php endforeach; ?>
      </div>
    </div>

    <div id="background_settings" class="divtab">
      <table id="shoppica_background_settings_table" class="s_table" width="100%" cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr>
            <td width="60">Image</td>
            <td>Name</td>
            <td>Position</td>
            <td>Repeat</td>
            <td>Attachment</td>
            <td>&nbsp;</td>
          </tr>
        </thead>
        <tbody>
          <?php $background_row = 0; ?>
          <?php foreach ($backgrounds as $background): ?>
          <tr id="background_row<?php echo $background_row; ?>">
            <td>
              <input type="hidden" name="background[images][<?php echo $background_row; ?>][id]" value="<?php echo $background['id']; ?>" />
              <input type="hidden" name="background[images][<?php echo $background_row; ?>][image]" value="<?php echo $background['image']; ?>" id="background_image<?php echo $background_row; ?>"  />
              <img src="<?php echo $background['preview']; ?>" alt="" id="background_preview<?php echo $background_row; ?>" class="image" onclick="image_upload('background_image<?php echo $background_row; ?>', 'background_preview<?php echo $background_row; ?>');" />
            </td>
            <td>
              <input type="text" name="background[images][<?php echo $background_row; ?>][name]" value="<?php echo $background['name']; ?>" />
            </td>
            <td>
              <select name="background[images][<?php echo $background_row; ?>][position]">
                <option value="top left"<?php if ($background['position'] == 'top left') echo ' selected="selected"'; ?>>top left</option>
                <option value="top center"<?php if ($background['position'] == 'top center') echo ' selected="selected"'; ?>>top center</option>
                <option value="top right"<?php if ($background['position'] == 'top right') echo ' selected="selected"'; ?>>top right</option>
                <option value="left"<?php  if ($background['position'] == 'left') echo ' selected="selected"'; ?>>left</option>
                <option value="center"<?php  if ($background['position'] == 'center') echo ' selected="selected"'; ?>>center</option>
                <option value="right"<?php  if ($background['position'] == 'right') echo ' selected="selected"'; ?>>right</option>
                <option value="bottom left"<?php if ($background['position'] == 'bottom left') echo ' selected="selected"'; ?>>bottom left</option>
                <option value="bottom center"<?php if ($background['position'] == 'bottom center') echo ' selected="selected"'; ?>>bottom center</option>
                <option value="bottom right"<?php if ($background['position'] == 'bottom right') echo ' selected="selected"'; ?>>bottom right</option>
              </select>
            </td>
            <td>
              <select name="background[images][<?php echo $background_row; ?>][repeat]">
                <option value="no-repeat"<?php if ($background['repeat'] == 'no-repeat') echo ' selected="selected"'; ?>>no-repeat</option>
                <option value="repeat-x"<?php if ($background['repeat'] == 'repeat-x') echo ' selected="selected"'; ?>>repeat-x</option>
                <option value="repeat-y"<?php if ($background['repeat'] == 'repeat-y') echo ' selected="selected"'; ?>>repeat-y</option>
                <option value="repeat"<?php if ($background['repeat'] == 'repeat') echo ' selected="selected"'; ?>>repeat</option>
              </select>
            </td>
            <td>
              <select name="background[images][<?php echo $background_row; ?>][attachment]">
                <option value="fixed"<?php if ($background['attachment'] == 'fixed') echo ' selected="selected"'; ?>>fixed</option>
                <option value="scroll"<?php if ($background['attachment'] == 'scroll') echo ' selected="selected"'; ?>>scroll</option>
              </select>
            </td>
            <td><a onclick="$('#background_row<?php echo $background_row; ?>').remove();" class="s_button_white s_button_blue"><span>Remove</span></a></td>
          </tr>
          <?php $background_row++; ?>
          <?php endforeach; ?>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="6"><br /><a onclick="addBackground();" class="s_button_white s_button_green right"><strong class="s_f_12">Add Image</strong></a></td>
          </tr>
        </tfoot>
      </table>
    </div>

    <span class="clear"></span>
    <br />
    <span class="clear border_ddd"></span>
    <br />

    <div class="clearfix">
      <a class="s_button s_size_2" onclick="shoppica_submit_form()"><span class="s_icon_10"><span class="s_icon s_save_10"></span><?php echo $button_save; ?></span></a>
      <a class="s_button s_size_2" onclick="location = '<?php echo $cancel; ?>';"><span class="s_icon_10"><span class="s_icon s_cancel_10"></span><?php echo $button_cancel; ?></span></a>
    </div>

  </form>

</div>

<!-- The closing </div> of the <div id="content"> is in the footer.tpl -->

<?php echo $footer; ?>

<link rel="stylesheet" type="text/css" href="view/stylesheet/cp.css" />

<script type="text/javascript">
<?php if (strcmp(VERSION,'1.5.1.3') >= 0): ?>
function image_upload(field, preview) {
  $('#dialog').remove();

  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" class="image" onclick="image_upload(\'' + field + '\', \'' + preview + '\');" />');
          }
        });
      }
    },
    bgiframe: false,
    width: 700,
    height: 400,
    resizable: false,
    modal: false
  });
};
<?php else: ?>
function image_upload(field, preview) {
  $('#dialog').remove();

  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>',
          type: 'POST',
          data: 'image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + preview).replaceWith('<img src="' + data + '" alt="" id="' + preview + '" class="image" onclick="image_upload(\'' + field + '\', \'' + preview + '\');" />');
          }
        });
      }
    },
    bgiframe: false,
    width: 700,
    height: 400,
    resizable: false,
    modal: false
  });
};
<?php endif; ?>
</script>
<script type="text/javascript">

function addImage(table_id, varname, language_id) {
  var table = $("#" + table_id);
  var image_row = table.find("tr.image_row").length + 1;

  html = '<tr id="image_row_' + language_id + '_' + image_row + '" class="image_row">\
            <td>\
              <input type="hidden" name="' + varname + '[images][' + language_id + '][' + image_row + '][image]" id="image_' + language_id + '_' + image_row + '" />\
              <img src="<?php echo $no_image; ?>" alt="" id="preview_' + language_id + '_' + image_row + '" class="image" onclick="image_upload(\'image_' + language_id + '_' + image_row + '\', \'preview_' + language_id + '_' + image_row + '\');" />\
            </td>\
            <td><input type="text" name="' + varname + '[images][' + language_id + '][' + image_row + '][url]" size="60" /></td>\
            <td><input type="text" name="' + varname + '[images][' + language_id + '][' + image_row + '][order]" size="1" /></td>\
            <td><a onclick="$(\'#image_row_' + language_id + '_' + image_row  + '\').remove();" class="s_button_white s_button_blue">Remove</a></td>\
          </tr>';

  table.append(html);
}

var payment_image_row = <?php echo $payment_image_row; ?>;
function addImagePayment() {
  html = '<tr id="payment_image_row' + payment_image_row + '">';
  html += '<td><input type="hidden" name="payment[images][' + payment_image_row + '][image]" value="" id="payment_image' + payment_image_row + '" /><img width="51" src="<?php echo $no_image; ?>" alt="" id="payment_preview' + payment_image_row + '" class="image" onclick="image_upload(\'payment_image' + payment_image_row + '\', \'payment_preview' + payment_image_row + '\');" /></td>';
  html += '<td><input type="text" name="payment[images][' + payment_image_row + '][url]" value="" size="60" /></td>';
  html += '<td><input type="text" name="payment[images][' + payment_image_row + '][order]" value="' + (payment_image_row + 1) + '" size="1" /></td>';
  html += '<td><a onclick="$(\'#payment_image_row' + payment_image_row  + '\').remove();" class="s_button_white s_button_blue">Remove</a></td>';
  html += '</tr>';

  $("#shoppica_payment_images_table tbody").append(html);
  payment_image_row++;
}

var background_row = <?php echo $background_row; ?>;
function addBackground() {
  html = '<tr id="background_row' + background_row + '">';
  html += '<td><input type="hidden" name="background[images][' + background_row + '][id]" value="' + guidGenerator() + '" /><input type="hidden" name="background[images][' + background_row + '][image]" value="" id="background_image' + background_row + '" /><img width="51" src="<?php echo $no_image; ?>" alt="" id="background_preview' + background_row + '" class="image" onclick="image_upload(\'background_image' + background_row + '\', \'background_preview' + background_row + '\');" /></td>';
  html += '<td><input type="text" name="background[images][' + background_row + '][name]" value="" /></td>';
  html += '<td><select name="background[images][' + background_row + '][position]"><option value="top left">top left</option><option value="top center">top center</option><option value="top right">top right</option><option value="left">left</option><option value="center">center</option><option value="right">right</option><option value="bottom left">bottom left</option><option value="bottom center">bottom center</option><option value="bottom right">bottom right</option></select></td>';
  html += '<td><select name="background[images][' + background_row + '][repeat]"><option value="no-repeat">no-repeat</option><option value="repeat-x">repeat-x</option><option value="repeat-y">repeat-y</option><option value="repeat">repeat</option></select></td>';
  html += '<td><select name="background[images][' + background_row + '][attachment]"><option value="fixed">fixed</option><option value="scroll">scroll</option></select></td>';
  html += '<td><a onclick="$(\'#background_row' + background_row  + '\').remove();" class="s_button_white s_button_blue">Remove</a></td>';
  html += '</tr>';

  $("#shoppica_background_settings_table tbody").append(html);
  background_row++;
}
</script>

<script type="text/javascript" src="view/javascript/shoppica/sModal/sModal.js"></script>
<link rel="stylesheet" type="text/css" href="view/javascript/shoppica/sModal/sModal.css" />

<script type="text/javascript">

  $('#settings_tabs a').tabs();
  $('#footer_settings_tabs a').tabs();
  $("#shoppica_intro_banner_type_images_tabs a").tabs();
  $("#shoppica_footer_info_language_tabs a").tabs();
  $("#shoppica_footer_contacts_language_tabs a").tabs();
  $("#shoppica_footer_twitter_language_tabs a").tabs();
  $("#shoppica_footer_facebook_language_tabs a").tabs();

  $("#settings_tabs a[href='#" + $("#return_to").val() + "']").trigger("click");

    var theTimeout = setTimeout(function() {
        $("div.success").hide("slow");
    }, 5000);
    $("div#yourdiv").mouseover(function() {
      clearTimeout(theTimeout);
    });


  function shoppica_submit_form() {
    $("#return_to").val($("div.divtab:visible").attr("id"));
    $('#form').submit();
  }

  $("#intro_banner_categories").bind("change", function() {
    window.location = $(this).val();
  });

  $("input.choose_intro").bind("click", function() {
    $('div[id^="shoppica_intro_banner_type"]').hide();
    $("#shoppica_intro_banner_type_" + $(this).val()).show();
  });

  $("input.choose_intro:checked").trigger("click");

  $('div[id^="shoppica_intro_banner_type"] a.sModal').sModal({
    'width'   : 800,
    'height'  : 600,
    'linktag' : function() {
      return $(this).attr("href") + "&category_path=" + $("#intro_banner_categories").val();
    },
    'onShow'  : function() {
      $("#sm_ajaxContent div.links > a").live("click", function() {
        url = $(this).attr("href");
        url = url + "&category_path=" + $("#intro_banner_categories").val();
        $.get(url, function(data, textStatus) {
            $("#sm_ajaxContent").empty().append(data);
        });

        return false;
      });

      $("#sm_ajaxContent a.s_button_filter").live("click", function() {
        url = filter() + "&category_path=" + $("#intro_banner_categories").val();
        $.get(url, function(data, textStatus) {
            $("#sm_ajaxContent").empty().append(data);
        });

        return false;
      });

      $('#sm_ajaxContent form input').live("keydown", function(e) {
        if (e.keyCode == 13) {
          url = filter() + "&category_path=" + $("#intro_banner_categories").val();
          $.get(url, function(data, textStatus) {
              $("#sm_ajaxContent").empty().append(data);
          });
        }
      });

      $("#sm_ajaxContent table.s_table thead a").live("click", function() {
        url = $(this).attr("href") + "&category_path=" + $("#intro_banner_categories").val();
        $.get(url, function(data, textStatus) {
            $("#sm_ajaxContent").empty().append(data);
        });

        return false;
      });

      $("#sm_ajaxContent a.add_product").live("click", function() {
        elem = $(this);
        if (elem.parents("tr:first").is(":not(.s_selected)")) {
          action = "addIntroBannerProduct";
        } else {
          action = "removeIntroBannerProduct";
        }
        url = 'index.php?route=module/shoppica/' + action + '&product_id=' + $(this).prev("input").val()+ "&category_path=" + $("#intro_banner_categories").val() + '&token=<?php echo $token; ?>';
        $.get(url, function(data, textStatus) {
            if (action == "addIntroBannerProduct") {
              elem.parents("tr:first").addClass("s_selected");
            } else {
              elem.parents("tr:first").removeClass("s_selected");
            }
        });

        return false;
      });
    }
  });

  function filter() {
    url = 'index.php?route=module/shoppica/getIntroBannerProductsHtml&token=<?php echo $token; ?>';

    var filter_name = $('input[name=\'filter_name\']').attr('value');
    if (filter_name) {
      url += '&filter_name=' + encodeURIComponent(filter_name);
    }

    var filter_model = $('input[name=\'filter_model\']').attr('value');
    if (filter_model) {
      url += '&filter_model=' + encodeURIComponent(filter_model);
    }

    var filter_price = $('input[name=\'filter_price\']').attr('value');
    if (filter_price) {
      url += '&filter_price=' + encodeURIComponent(filter_price);
    }

    return url;
  }

  function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
      var pair = vars[i].split("=");
      if (pair[0] == variable) {
        return pair[1];
      }
    }

    return null;
  }

  function guidGenerator() {
      var S4 = function() {
         return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
      };
      return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
  }

  /*
  $(document).ready(function() {
    if (getQueryVariable('intro_banner_path') !== null) {
      $("#settings_tabs > a:eq(2)").trigger("click");
    }
  });
  */

</script>
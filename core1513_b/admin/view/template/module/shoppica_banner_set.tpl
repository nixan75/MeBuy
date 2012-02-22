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
  <a id="themeburn_logo" href="http://www.themeburn.com">ThemeBurn.com</a>

  <h1><?php echo $heading_title; ?></h1>

  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

    <input type="hidden" name="banner[setId]" value="<?php echo $setId; ?>" />
    
    <div class="s_row_2 s_mb_15 clearfix">
      <label>Set Name:</label>
      <input type="text" id="banner_name" name="banner[name]" value="<?php echo $name; ?>" size="40" />
    </div>

    <div id="shoppica_banners_images_tabs" class="htabs clearfix">
      <?php foreach ($languages as $language): ?>
      <a href="#language_<?php echo $language['language_id']; ?>">
        <img class="inline" src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
      </a>
      <?php endforeach; ?>
    </div>
    
    <?php foreach ($languages as $language): $lid = $language['language_id']; ?>
    <div id="language_<?php echo $language['language_id']; ?>" class="divtab">

      <table id="shoppica_banner_images_table_<?php echo $lid; ?>" class="s_table" cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr>
            <td width="100">Image</td>
            <td>Url</td>
            <td>New Window</td>
            <td>Order</td>
            <td>&nbsp;</td>
          </tr>
        </thead>
        <tbody>
          <?php $image_row = 0; ?>
          <?php foreach ($banner_images[$lid] as $banner_image): ?>
          <tr id="image_row_<?php echo $lid; ?>_<?php echo $image_row; ?>">
            <td>
              <input type="hidden" name="banner[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['file']; ?>" id="image_<?php echo $lid; ?>_<?php echo $image_row; ?>"  />
              <img src="<?php echo $banner_image['preview']; ?>" id="preview_<?php echo $lid; ?>_<?php echo $image_row; ?>" class="image" onclick="image_upload('image_<?php echo $lid; ?>_<?php echo $image_row; ?>', 'preview_<?php echo $lid; ?>_<?php echo $image_row; ?>');" />
            </td>
            <td><input type="text" name="banner[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][url]" value="<?php echo $banner_image['url']; ?>" size="50" /></td>
            <td><input type="checkbox" name="banner[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][new_window]" value="1"<?php if($banner_image['new_window']) echo ' checked="checked"';?> /></td>
            <td><input type="text" name="banner[images][<?php echo $lid; ?>][<?php echo $image_row; ?>][order]" value="<?php echo $banner_image['order']; ?>" size="1" /></td>
            <td><a onclick="$('#image_row_<?php echo $lid; ?>_<?php echo $image_row; ?>').remove();" class="s_button_white s_button_blue"><span>Remove</span></a></td>
          </tr>
          <?php $image_row++; ?>
          <?php endforeach; ?>
        </tbody>
        <tfoot>
          <tr>
            <td colspan="4"><br /><a onclick="addImage('shoppica_banner_images_table_<?php echo $lid; ?>', 'banner', '<?php echo $lid; ?>');" class="s_button_white s_button_green right"><strong class="s_f_12">Add Image</strong></a></td>
          </tr>
        </tfoot>
      </table>

    </div>
    <?php endforeach; ?>

    <span class="clear"></span>
    <br />
    <span class="clear border_ddd"></span>
    <br />

    <div class="clearfix">
      <a class="s_button s_size_2" onclick="submit_banner_set_form()"><span class="s_icon_10"><span class="s_icon s_save_10"></span><?php echo $button_save; ?></span></a>
      <a class="s_button s_size_2" onclick="location = '<?php echo $cancel; ?>';"><span class="s_icon_10"><span class="s_icon s_cancel_10"></span><?php echo $button_cancel; ?></span></a>
    </div>

  </form>

</div>

<!-- The closing </div> of the <div id="content"> is in the footer.tpl -->
<?php echo $footer; ?>

<link rel="stylesheet" type="text/css" href="view/stylesheet/cp.css" />

<script type="text/javascript">

$("#shoppica_banners_images_tabs a").tabs();
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

var image_row = <?php echo $image_row; ?>;

function addImage(table_id, varname, language_id) {
  if ($("#shoppica_banner_images_table tbody > tr").length < 4) {
    html = '<tr id="image_row_' + language_id + '_' + image_row + '">';
    html += '<td><input type="hidden" name="'   + varname + '[images][' + language_id + '][' + image_row + '][image]" value="" id="image_' + language_id + '_' + image_row + '" /><img src="<?php echo $no_image; ?>" alt="" id="preview_' + language_id + '_' + image_row + '" class="image" onclick="image_upload(\'image_' + language_id + '_' + image_row + '\', \'preview_' + language_id + '_' + image_row + '\');" /></td>';
    html += '<td><input type="text" name="'     + varname + '[images][' + language_id + '][' + image_row + '][url]" size="50" /></td>';
    html += '<td><input type="checkbox" name="' + varname + '[images][' + language_id + '][' + image_row + '][new_window]" value="1" size="50" /></td>';
    html += '<td><input type="text" name="'     + varname + '[images][' + language_id + '][' + image_row + '][order]" size="1" /></td>';
    html += '<td><a onclick="$(\'#image_row_' + language_id + '_' + image_row  + '\').remove();" class="s_button_white s_button_blue">Remove</a></td>';
    html += '</tr>';

    $("#" + table_id + ' tbody').append(html);
    image_row++;
  } else {
    alert("Only 4 images allowed");
  }

  return false;
}

var theTimeout = setTimeout(function() {
    $("div.success").hide("slow");
}, 5000);
$("div#yourdiv").mouseover(function() {
  clearTimeout(theTimeout);
});

function submit_banner_set_form() {
  if ($("#banner_name").val()) {
    $('#form').submit();
  } else {
    alert("Please, enter a set name!");
    return false;
  }
}

</script>

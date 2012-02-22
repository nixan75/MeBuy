<?php echo $header; ?>

<div id="content">

<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb): ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php endforeach; ?>
</div>

<?php if ($error_warning): ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php endif; ?>

<div id="shoppica_cp">

  <div class="heading">
    <h1><?php echo $heading_title; ?></h1>
  </div>

  <div id="layout_settings">

    <form action="<?php echo $action; ?>" method="post" id="form">

      <div id="settings_tabs" class="htabs clearfix">
        <a class="selected" href="#" onclick="return false;" style="display: block;">Banner Positions</a>
        <a href="<?php echo $this->url->link('module/shoppica_banners/listSets', 'token=' . $this->session->data['token'], 'SSL'); ?>" style="display: block;">Banner Sets</a>
      </div>

      <table id="module" class="s_table" cellpadding="0" cellspacing="0" border="0">
        <thead>
          <tr>
            <td width="120">Banner Set</td>
            <td><?php echo $entry_layout; ?></td>
            <td><?php echo $entry_position; ?></td>
            <td><?php echo $entry_status; ?></td>
            <td>Order:</td>
            <td>&nbsp;</td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module): ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td>
              <select name="shoppica_banners_module[<?php echo $module_row; ?>][setId]" style="width: 110px">
                <?php foreach ($banners_sets as $banners_set): ?>
                <option value="<?php echo $banners_set['setId']; ?>"<?php if ($banners_set['setId'] == $module['setId']): ?> selected="selected"<?php endif; ?>>
                  <?php echo $banners_set['name']; ?>
                </option>
                <?php endforeach; ?>
              </select>
            </td>
            </td>
            <td>
                <select name="shoppica_banners_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout): ?>
                <?php if ($layout['layout_id'] == $module['layout_id']): ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php else: ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php endif; ?>
                <?php endforeach; ?>
              </select>
            </td>
            <td>
                <select name="shoppica_banners_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top'): ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php else: ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php endif; ?>
                <?php if ($module['position'] == 'content_bottom'): ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php else: ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php endif; ?>
              </select>
            </td>
            <td>
                <select name="shoppica_banners_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']): ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php else: ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php endif; ?>
              </select>
            </td>
            <td><input type="text" name="shoppica_banners_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="1" style="width: 15px;" /></td>
            <td><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="s_button_white s_button_blue"><span><?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php endforeach; ?>
        <tfoot>
          <tr>
            <td colspan="5"></td>
            <td class="left"><br /><a onclick="addModule();" class="s_button_white s_button_green right"><span><?php echo $button_add_module; ?></span></a></td>
          </tr>
        </tfoot>
      </table>

      <span class="clear border_ddd"></span>
      <br />

      <div class="clearfix">
        <a class="s_button s_size_2" onclick="$('#form').submit();"><span class="s_icon_10"><span class="s_icon s_save_10"></span><?php echo $button_save; ?></span></a>
        <a class="s_button s_size_2" onclick="location = '<?php echo $cancel; ?>';"><span class="s_icon_10"><span class="s_icon s_cancel_10"></span><?php echo $button_cancel; ?></span></a>
      </div>

    </form>
  </div>
</div>

<link rel="stylesheet" type="text/css" href="view/stylesheet/cp.css" />
<script type="text/javascript">

var module_row = <?php echo $module_row; ?>;

function addModule() {
    <?php if (empty($banners_sets)): ?>
    alert('Please, add at least one banner set first!');
    return false;
    <?php endif; ?>
    html  = '<tbody id="module-row' + module_row + '">';
    html += '  <tr>';
    html += '    <td><select name="shoppica_banners_module[' + module_row + '][setId]" style="width: 110px">';
    <?php foreach ($banners_sets as $banner_set): ?>
    html += '      <option value="<?php echo $banner_set['setId']; ?>"><?php echo $banner_set['name']; ?></option>';
    <?php endforeach; ?>
    html += '    </select></td>';
    html += '    <td><select name="shoppica_banners_module[' + module_row + '][layout_id]">';
    <?php foreach ($layouts as $layout): ?>
    html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
    <?php endforeach; ?>
    html += '    </select></td>';
    html += '    <td><select name="shoppica_banners_module[' + module_row + '][position]">';
    html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
    html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
    html += '    </select></td>';
    html += '    <td><select name="shoppica_banners_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
    html += '    <td><input type="text" name="shoppica_banners_module[' + module_row + '][sort_order]" value="" size="1" style="width: 15px;" /></td>';
    html += '    <td><a onclick="$(\'#module-row' + module_row + '\').remove();" class="s_button_white s_button_blue"><span><?php echo $button_remove; ?></span></a></td>';
    html += '  </tr>';
    html += '</tbody>';

    $('#module tfoot').before(html);

    module_row++;
}

</script>

<?php echo $footer; ?>

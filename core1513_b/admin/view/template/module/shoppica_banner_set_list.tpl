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

  <div class="heading">
    <h1><?php echo $heading_title; ?></h1>
  </div>

  <form>

    <div id="settings_tabs" class="htabs clearfix">
      <a href="<?php echo $this->url->link('module/shoppica_banners', 'token=' . $this->session->data['token'], 'SSL'); ?>" style="display: block;">Banner Positions</a>
      <a class="selected" href="#" onclick="return false;" style="display: block;">Banner Sets</a>
    </div>

    <table id="shoppica_banner_images_table" class="s_table s_mb_0" cellpadding="0" cellspacing="0" border="0">
      <thead>
        <tr>
          <td width="500">Banner set</td>
          <td>&nbsp;</td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($sets as $setId => $set): ?>
        <tr>
          <td><strong><?php echo $set['name']; ?></strong></td>
          <td>
            <a class="s_button_white s_button_blue s_ml_10 right" href="<?php echo $this->url->link('module/shoppica_banners/deleteSet', 'setId=' . $setId . '&token=' . $this->session->data['token'], 'SSL'); ?>" onclick='return confirm ("Are you sure you want to delete this item?");'>Delete</a>
            <a class="s_button_white right" href="<?php echo $this->url->link('module/shoppica_banners/editSet', 'setId=' . $setId . '&token=' . $this->session->data['token'], 'SSL'); ?>">Edit</a>
          </td>
        </tr>
        <?php endforeach; ?>
      </tbody>
      <tfoot>
        <tr>
          <td colspan="2"><br /><a class="s_button_white s_button_green right" href="<?php echo $this->url->link('module/shoppica_banners/editSet', 'token=' . $this->session->data['token'], 'SSL'); ?>">New banner set</a></td>
        </tr>
      </tfoot>
    </table>
  
  </form>

</div>

<link rel="stylesheet" type="text/css" href="view/stylesheet/cp.css" />

<?php echo $footer; ?>
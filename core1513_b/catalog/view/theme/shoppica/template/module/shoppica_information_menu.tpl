<li id="shoppica_menu_information">
  <a href="#" onclick="return false; "><?php echo $this->document->shoppica_menu_information; ?></a>

  <div class="s_submenu">

    <h3><?php echo $this->document->shoppica_menu_information; ?></h3>
    <ul class="s_list_1 clearfix">
    <?php foreach ($informations as $result): ?>
        <li><a href="<?php echo $_url->link('information/information', 'information_id=' . $result['information_id']); ?>"><?php echo $result['title']; ?></a></li>
    <?php endforeach; ?>
    </ul>
    <span class="clear border_eee"></span>

    <h3><?php echo $text_extra; ?></h3>
    <ul class="s_list_1 clearfix">
      <li><a href="<?php echo $_url->link('product/manufacturer', '', 'SSL'); ?>"><?php echo $text_manufacturer; ?></a></li>
      <li><a href="<?php echo $_url->link('checkout/voucher', '', 'SSL'); ?>"><?php echo $text_voucher; ?></a></li>
      <li><a href="<?php echo $_url->link('affiliate/account', '', 'SSL'); ?>"><?php echo $text_affiliate; ?></a></li>
      <li><a href="<?php echo $_url->link('product/special', '', 'SSL'); ?>"><?php echo $text_special; ?></a></li>
    </ul>
    <span class="clear border_eee"></span>

    <h3><?php echo $text_service; ?></h3>
    <ul class="s_list_1 clearfix">
      <li><a href="<?php echo $_url->link('information/contact', '', 'SSL'); ?>"><?php echo $text_contact; ?></a></li>
      <li><a href="<?php echo $_url->link('account/return/insert', '', 'SSL'); ?>"><?php echo $text_return; ?></a></li>
      <li><a href="<?php echo $_url->link('information/sitemap', '', 'SSL'); ?>"><?php echo $text_sitemap; ?></a></li>
    </ul>

  </div>
</li>

<?php /*
<!-- use this if you want to add another custom menu -->
<li id="custom_menu_id">
  <a href="#" onclick="return false; ">Custom Menu Name</a>
  <div class="s_submenu">

    <h3>Section 1</h3>
    <ul class="s_list_1 clearfix">
      <li><a href="link1">Item 1</a></li>
      <li><a href="link2">Item 2</a></li>
    </ul>

    <h3>Section 2</h3>
    <ul class="s_list_1 clearfix">
      <li><a href="link1">Item 1</a></li>
      <li><a href="link2">Item 2</a></li>
    </ul>
  </div>
<li>
*/ ?>
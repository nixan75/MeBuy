  <?php $browser = Browser::detect(); ?>
  <?php if ($this->document->shoppica_enabled_footer_columns_cnt > 0): ?>
  <?php $shoppica_footer = $this->document->shoppica_footer; ?>
  <!-- ---------------------- -->
  <!--   S H O P   I N F O    -->
  <!-- ---------------------- -->
  <div id="shop_info">
    <div id="shop_info_wrap">
      <div class="container_12">
        <?php if($shoppica_footer['info_enabled'] == '1'): ?>
        <div id="shop_description" class="grid_<?php echo 12 / $this->document->shoppica_enabled_footer_columns_cnt; ?>">
          <h2><?php echo $shoppica_footer['info_title']?></h2>
          <p><?php echo $shoppica_footer['info_text']?></p>
        </div>
        <?php endif; ?>
        <?php if($shoppica_footer['contacts_enabled'] == '1'): ?>
        <div id="shop_contacts" class="grid_<?php echo 12 / $this->document->shoppica_enabled_footer_columns_cnt; ?>">
          <h2><?php echo $this->document->shoppica_text_contact_us?></h2>
          <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <?php if ($shoppica_footer['phone_show'] == "1"): ?>
            <tr<?php if ($browser['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
              <td valign="middle">
                <span class="s_icon_32">
                  <span class="s_icon s_phone_32"></span>
                  <?php echo $shoppica_footer['phone1']; ?> <?php echo '<br />' . $shoppica_footer['phone2']; ?>
                </span>
              </td>
            </tr>
            <?php endif; ?>
            <?php if ($shoppica_footer['mobile_show']  == "1"): ?>
            <tr<?php if ($browser['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
              <td valign="middle">
                <span class="s_icon_32">
                  <span class="s_icon s_mobile_32"></span>
                  <?php echo $shoppica_footer['mobile1']; ?> <?php echo '<br />' . $shoppica_footer['mobile2']; ?>
                </span>
              </td>
            </tr>
            <?php endif; ?>
            <?php if ($shoppica_footer['fax_show'] == "1"): ?>
            <tr<?php if ($browser['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
              <td valign="middle">
                <span class="s_icon_32">
                  <span class="s_icon s_fax_32"></span>
                  <?php echo $shoppica_footer['fax1']; ?> <?php echo '<br />' . $shoppica_footer['fax2']; ?>
                </span>
              </td>
            </tr>
            <?php endif; ?>
            <?php if ($shoppica_footer['email_show'] == "1"): ?>
            <tr<?php if ($browser['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
              <td valign="middle">
                <span class="s_icon_32">
                  <span class="s_icon s_mail_32"></span>
                  <?php echo $shoppica_footer['email1']; ?> <?php echo '<br />' . $shoppica_footer['email2']; ?>
                </span>
              </td>
            </tr>
            <?php endif; ?>
            <?php if ($shoppica_footer['skypename_show'] == "1"): ?>
            <tr<?php if ($browser['name'] == "safari"): ?> class="s_webkit"<?php endif; ?>>
              <td valign="middle">
                <span class="s_icon_32">
                  <span class="s_icon s_skype_32"></span>
                  <?php echo $shoppica_footer['skypename1']; ?> <?php echo '<br />' . $shoppica_footer['skypename2']; ?>
                </span>
              </td>
            </tr>
            <?php endif; ?>
          </table>
        </div>
        <?php endif; ?>
        <?php if($shoppica_footer['twitter_enabled'] == '1'): ?>
        <div id="twitter" class="grid_<?php echo 12 / $this->document->shoppica_enabled_footer_columns_cnt; ?>">
          <h2>Twitter</h2>
          <ul id="twitter_update_list"></ul>
          <script type="text/javascript" src="http<?php if(isHTTPS()) echo 's'?>://twitter.com/javascripts/blogger.js"></script>
          <script type="text/javascript" src="http<?php if(isHTTPS()) echo 's'?>://twitter.com/statuses/user_timeline/<?php echo $shoppica_footer['twitter_username']; ?>.json?callback=twitterCallback2&amp;count=<?php echo $shoppica_footer['twitter_tweets']; ?>"></script>
        </div>
        <?php endif; ?>
        <?php if($shoppica_footer['facebook_enabled'] == '1'): ?>
        <div id="facebook" class="grid_<?php echo 12 / $this->document->shoppica_enabled_footer_columns_cnt; ?>">
          <h2>Facebook</h2>
          <div class="s_widget_holder">
            <?php if ($browser['name'] == "msie"): ?>
            <fb:fan profileid="<?php echo $shoppica_footer['facebook_id']; ?>" stream="0" connections="<?php echo (12 / $this->document->shoppica_enabled_footer_columns_cnt)*2 ; ?>" logobar="0" width="<?php echo ((12 / $this->document->shoppica_enabled_footer_columns_cnt)*80) - 20; ?>" css="<?php echo HTTP_SERVER; ?>catalog/view/theme/shoppica/stylesheet/facebook_ie.css.php?300"></fb:fan>
            <?php else: ?>
            <fb:fan profileid="<?php echo $shoppica_footer['facebook_id']; ?>" stream="0" connections="<?php echo (12 / $this->document->shoppica_enabled_footer_columns_cnt)*2 ; ?>" logobar="0" width="<?php echo ((12 / $this->document->shoppica_enabled_footer_columns_cnt)*80) - 20; ?>" css="<?php echo HTTP_SERVER; ?>catalog/view/theme/shoppica/stylesheet/facebook.css.php?300"></fb:fan>
            <?php endif; ?>
          </div>
        </div>
        <?php endif; ?>
        <div class="clear"></div>
      </div>
    </div>
  </div>
  <!-- end of content -->
  <?php endif; ?>

  <!-- ---------------------- -->
  <!--      F O O T E R       -->
  <!-- ---------------------- -->

  <div id="footer" class="container_12">

    <?php $categories = isset($this->document->shoppica_categories_nested_arr) && $this->config->get('shoppica_show_footer_categories') == '1' ? $this->document->shoppica_categories_nested_arr : array();  ?>
    <?php if ($categories && !$this->document->in_maintenance): ?>
    <div id="footer_categories" class="clearfix">
      <?php for($i = 0, $j = count($categories); $i < $j; $i++): ?>
        <div class="grid_2">
          <h2><a href="<?php echo $categories[$i]['url'];?>"><?php echo $categories[$i]['name'];?></a></h2>
          <ul class="s_list_1">
          <?php foreach($categories[$i]['children'] as $subcategory): ?>
            <li><a href="<?php echo $subcategory['url']?>"><?php echo $subcategory['name']?></a></li>
          <?php endforeach; ?>
          </ul>
        </div>
        <?php if(($i+1) % 6 == 0): ?>
        <div class="clear"></div>
        <?php endif; ?>
      <?php endfor; ?>
      <div class="grid_12 border_eee"></div>
    </div>
    <?php endif; ?>

    <div class="clear"></div>

    <?php if (!$this->document->in_maintenance): ?>
    <div id="footer_nav" class="grid_12">
      <div class="grid_3 alpha">
        <h2 class="s_main_color"><?php echo $text_information; ?></h2>
        <ul class="s_list_1">
          <?php foreach ($informations as $information): ?>
          <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
          <?php endforeach; ?>
        </ul>
      </div>
      <div class="grid_3">
        <h2 class="s_main_color"><?php echo $text_extra; ?></h2>
        <ul class="s_list_1">
          <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
          <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
          <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
          <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
      </div>
      <div class="grid_3">
        <h2 class="s_main_color"><?php echo $text_account; ?></h2>
        <ul class="s_list_1">
          <?php if($this->customer->isLogged()): ?>
          <li><a href="<?php echo $this->url->link('account/account', '', 'SSL'); ?>"><?php echo $text_account; ?></a></li>
          <?php else: ?>
          <li><a href="<?php echo $this->url->link('account/login', '', 'SSL'); ?>"><?php echo $this->document->shoppica_text_login; ?></a></li>
          <?php endif; ?>
          <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
          <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>
      </div>
      <div class="grid_3 omega">
        <h2 class="s_main_color"><?php echo $text_service; ?></h2>
        <ul class="s_list_1">
          <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
          <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
          <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>
      </div>
    </div>
    <?php endif; ?>

    <div class="clear"></div>

    <div id="payments_types" class="right clearfix">
    <?php foreach($this->document->shoppica_payment_images as $image): ?>
      <?php if ($image['url']): ?>
      <a href="<?php echo $image['url'];?>" target="_blank"><img src="<?php echo 'image/' . $image['file'];?>" /></a>
      <?php else: ?>
      <img src="<?php echo 'image/' . $image['file'];?>" />
      <?php endif; ?>
    <?php endforeach; ?>
    </div>
    <p id="copy">&copy; Copyright AnnartE Design. Powered by MeBuy &amp; OpenCart</p>
    <div class="clear"></div>
  </div>
  <!-- end of FOOTER -->

</div>

<script type="text/javascript" src="catalog/view/theme/shoppica/js/shoppica.js?v=1.0.11"></script>
<script type="text/javascript" src="catalog/view/theme/shoppica/js/jquery/jquery.notify.js"></script>

<?php if($this->document->shoppica_enabled_footer_columns_cnt > 0 && $shoppica_footer['facebook_enabled'] == '1'): ?>
<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
    FB.init({appId: '0c18007de6f00f7ecda8c040fb76cd90', status: true, cookie: true,
     xfbml: true});
  };
  (function() {
    var e = document.createElement('script'); e.async = true;
    e.src = document.location.protocol +
    '//connect.facebook.net/en_US/all.js';
    document.getElementById('fb-root').appendChild(e);
  }());
</script>
<?php endif; ?>
</body>
</html>

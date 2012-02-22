<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="container_12">
        <div id="breadcrumbs" class="grid_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php endforeach; ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>
      </div>
    </div>
  </div>
  <!-- end of intro -->

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $container = 12; $main = 9; $side_col = 3; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1')  { $container = 12; $main = 12; $side_col = 3; } ?>
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 16; $main = 12; $side_col = 4; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2')  { $container = 12; $main = 12; $side_col = 3; } ?>

  <div id="content" class="container_<?php echo $container; ?><?php if ($this->document->shoppica_rightColumnEmpty): ?> s_single_col<?php endif; ?>">

    <?php if ($this->document->shoppica_column_position == "left" && $column_right): ?>
    <div id="left_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div id="product" class="grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <span class="clear"></span>

      <div id="product_images">
        <a id="product_image_preview" rel="prettyPhoto[gallery]" href="<?php echo $popup; ?>">
          <img id="image" src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
        </a>
        <?php if ($images && $this->config->get('shoppica_product_images_position') == 'outside'): ?>
        <div id="product_gallery">
          <ul class="s_thumbs clearfix">
            <?php foreach ($images as $image): ?>
            <li>
              <a class="s_thumb" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" rel="prettyPhoto[gallery]">
                <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
              </a>
            </li>
            <?php endforeach; ?>
          </ul>
        </div>
        <?php endif; ?>
      </div>

      <div id="product_info">

        <?php if ($price): ?>
        <div id="product_price">
          <?php if (!$special): ?>
          <p class="s_price"><?php echo s_format($price); ?></p>
          <?php else: ?>
          <p class="s_price s_promo_price">
            <span class="s_old_price"><?php echo s_format($price); ?></span>
            <?php echo s_format($special); ?>
          </p>
          <?php endif; ?>

          <?php if ($tax): ?>
          <p class="s_price_tax"><?php echo $text_tax; ?> <?php echo $tax; ?></p>
          <?php endif; ?>

          <?php if ($points): ?>
          <p class="s_reward_points"><small><?php echo $text_points; ?> <?php echo $points; ?></small></p>
          <?php endif; ?>

        </div>
        <?php endif; ?>

        <dl class="clearfix">
          <dt><?php echo $text_stock; ?></dt>
          <dd><?php echo $stock; ?></dd>
          <dt><?php echo $text_model; ?></dt>
          <dd><?php echo $model; ?></dd>
          <?php if ($reward): ?>
          <dt><?php echo $text_reward; ?></dt>
          <dd><?php echo $reward; ?></dd>
          <?php endif; ?>
          <?php if ($manufacturer): ?>
          <dt><?php echo $text_manufacturer; ?></dt>
          <dd><a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></dd>
          <?php endif; ?>
        </dl>

        <div id="product_share" class="clearfix">
          <?php if ($review_status): ?>
          <?php if ($rating): ?>
          <div class="s_rating_holder">
            <p class="s_rating s_rating_5"><span style="width: <?php echo $rating * 2 ; ?>0%;" class="s_percent"></span></p>
            <span class="s_average"><?php echo $rating; ?>/5 <span class="s_total">(<a class="s_999" href="<?php echo CURRENT_URL; ?>#product_tabs"><?php echo $reviews; ?></a>)</span></span>
            <br />
            <a class="s_review_write s_icon_10 s_main_color" href="<?php echo CURRENT_URL; ?>#product_tabs"><span class="s_icon s_main_color_bgr"></span> <?php echo $text_write; ?></a>
          </div>
          <?php else: ?>
          <div class="s_rating_holder">
            <p class="s_rating s_rating_5 s_rating_blank"></p>
            <span class="s_average"><span class="s_total"><?php echo $this->document->shoppica_not_yet_rated; ?></span></span>
            <br />
            <a class="s_review_write s_icon_10 s_main_color" href="<?php echo CURRENT_URL; ?>#product_tabs"><span class="s_icon s_main_color_bgr"></span> <?php echo $text_write; ?></a>
          </div>
          <?php endif; ?>
          <?php endif; ?>
          <!-- AddThis Button BEGIN -->
          <div class="addthis_toolbox addthis_default_style ">
            <script type="text/javascript" src="https://apis.google.com/js/plusone.js"></script>
            <div class="s_plusone"><g:plusone size="medium"></g:plusone></div>
            <a class="addthis_button_tweet"></a>
            <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
          </div>
          <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=xa-4e20919036eba525"></script>
          <!-- AddThis Button END -->
        </div>

      <?php if ($this->document->shoppica_rightColumnEmpty): ?>
      </div>
      <div id="product_buy_col">
      <?php endif; ?>

        <?php if ($price): ?>
        <form id="product_add_to_cart_form">

          <?php if ($options) require 'product_options.tpl' ?>

          <?php if ($price && $discounts): ?>
          <div id="product_discounts">
            <h3><?php echo $this->document->shoppica_text_discount; ?></h3>
            <table width="100%" class="s_table" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <th><?php echo $this->document->shoppica_text_order_quantity; ?></th>
                <th><?php echo $this->document->shoppica_text_price_per_item; ?></th>
              </tr>
              <?php foreach ($discounts as $discount): ?>
              <tr>
                <td><?php echo sprintf($this->document->shoppica_text_discount_items, $discount['quantity']); ?></td>
                <td><?php echo $discount['price']; ?></td>
              </tr>
              <?php endforeach; ?>
            </table>
          </div>
          <?php endif; ?>

          <div id="product_buy" class="clearfix">
            <label for="product_buy_quantity"><?php echo $text_qty; ?></label>
            <input id="product_buy_quantity" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
            <a id="add_to_cart" class="s_main_color_bgr">
              <span class="s_text"><span class="s_icon"></span> <?php echo $button_cart; ?></span>
            </a>

            <?php if ($minimum > 1): ?>
            <p class="s_purchase_info"><?php echo $text_minimum; ?></p>
            <?php endif; ?>

            <span class="clear"></span>

            <p class="s_actions">
              <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $product_id; ?>');"><span class="s_icon s_add_10"></span><?php echo $button_wishlist; ?></a>
              &nbsp;
              <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $product_id; ?>');"><span class="s_icon s_add_10"></span><?php echo $button_compare; ?></a>
            </p>
          </div>

          <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
        </form>
        <?php endif; ?>

      </div>

      <div id="product_tabs" class="clear"></div>

      <div class="s_tabs grid_<?php echo $main; ?> alpha omega">
        <ul class="s_tabs_nav clearfix">
          <li><a href="#product_description"><?php echo $tab_description; ?></a></li>
          <?php if ($attribute_groups): ?>
          <li><a href="#product_attributes"><?php echo $tab_attribute; ?></a></li>
          <?php endif; ?>
          <?php if ($review_status): ?><li><a href="#product_reviews"><?php echo $tab_review; ?></a></li><?php endif; ?>
          <?php if ($images && $this->config->get('shoppica_product_images_position') == 'tab'): ?>
          <li><a href="#product_gallery"><?php echo $this->document->shoppica_tab_images; ?> (<?php echo count($images); ?>)</a></li>
          <?php endif; ?>
        </ul>

        <div class="s_tab_box">
          <div id="product_description"><?php echo $description; ?></div>

          <?php if ($attribute_groups): ?>
          <div id="product_attributes">
            <table class="s_table_1" width="100%" cellpadding="0" cellspacing="0" border="0">
              <?php foreach ($attribute_groups as $attribute_group): ?>
              <thead>
                <tr>
                  <th colspan="2"><?php echo $attribute_group['name']; ?></th>
                </tr>
              </thead>
              <tbody>
                <?php foreach ($attribute_group['attribute'] as $attribute): ?>
                <tr>
                  <td width="30%"><?php echo $attribute['name']; ?></td>
                  <td><?php echo $attribute['text']; ?></td>
                </tr>
                <?php endforeach; ?>
              </tbody>
              <?php endforeach; ?>
            </table>
          </div>
          <?php endif; ?>

          <?php if ($review_status): ?>
          <div id="product_reviews">
            <div id="review" class="s_listing"></div>
            <h2 class="s_title_1"><?php echo $text_write; ?></h2>
            <div id="review_title" class="clear"></div>
            <div class="s_row_3 clearfix">
              <label><strong><?php echo $entry_name; ?></strong></label>
              <input type="text" name="name" value="" />
            </div>
            <div class="s_row_3 clearfix">
              <label><strong><?php echo $entry_review; ?></strong></label>
              <textarea name="text" style="width: 98%;" rows="8"></textarea>
              <p class="s_legend"><?php echo $text_note; ?></p>
            </div>
            <div class="s_row_3 clearfix">
              <label><strong><?php echo $entry_rating; ?></strong></label>
              <span class="clear"></span>
              <span><?php echo $entry_bad; ?></span>&nbsp;
              <input type="radio" name="rating" value="1" />
              &nbsp;
              <input type="radio" name="rating" value="2" />
              &nbsp;
              <input type="radio" name="rating" value="3" />
              &nbsp;
              <input type="radio" name="rating" value="4" />
              &nbsp;
              <input type="radio" name="rating" value="5" />
              &nbsp; <span><?php echo $entry_good; ?></span>
            </div>
            <div class="s_row_3 clearfix">
              <label><strong><?php echo $entry_captcha; ?></strong></label>
              <input type="text" name="captcha" value="" autocomplete="off" />
              <span class="clear"></span>
              <br />
              <img src="index.php?route=product/product/captcha" id="captcha" />
            </div>
            <span class="clear border_ddd"></span>
            <br />
            <a onclick="review();" class="s_button_1 s_main_color_bgr"><span class="s_text"><?php echo $button_continue; ?></span></a>
            <span class="clear"></span>
          </div>
          <?php endif; ?>

          <?php if ($images && $this->config->get('shoppica_product_images_position') == 'tab'): ?>
          <div id="product_gallery">
            <ul class="s_thumbs clearfix">
              <?php foreach ($images as $image): ?>
              <li>
                <a class="s_thumb" href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" rel="prettyPhoto[gallery]">
                  <img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" />
                </a>
              </li>
              <?php endforeach; ?>
            </ul>
          </div>
          <?php endif; ?>
        </div>

      </div>


      <?php if ($products): ?>
      <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $grid = 3; $listing_cols = 3; } ?>
      <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1')  { $grid = 3; $listing_cols = 4; } ?>
      <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $grid = 3; $listing_cols = 4; } ?>
      <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2')  { $grid = 2; $listing_cols = 6; } ?>

      <div id="related_products" class="grid_12 alpha omega">
        <h2 class="s_title_1"><?php echo $tab_related; ?></h2>
        <div class="clear"></div>
        <div class="s_grid_view s_listing clearfix">
          <?php for ($i = 0; $i < sizeof($products); $i = $i + $listing_cols): ?>
          <?php for ($j = $i; $j < ($i + $listing_cols); $j++): ?>
          <?php if (isset($products[$j])): ?>
          <div class="s_item grid_<?php echo $grid; ?>">
            <a class="s_thumb" href="<?php echo $products[$j]['href']; ?>">
              <img src="<?php echo $products[$j]['thumb']; ?>" title="<?php echo $products[$j]['name']; ?>" alt="<?php echo $products[$j]['name']; ?>" />
            </a>
            <h3><a href="<?php echo $products[$j]['href']; ?>"><?php echo $products[$j]['name']; ?></a></h3>
            <?php if ($products[$j]['price']): ?>
              <?php if (!$products[$j]['special']): ?>
              <p class="s_price"><?php echo s_format($products[$j]['price']); ?></p>
              <?php else: ?>
              <p class="s_price s_promo_price"><span class="s_old_price"><?php echo s_format($products[$j]['price']); ?></span><?php echo s_format($products[$j]['special']); ?></p>
              <?php endif; ?>
            <?php endif; ?>
            <?php if ($products[$j]['rating']): ?>
            <p class="s_rating s_rating_5"><span style="width: <?php echo $products[$j]['rating'] * 2 ; ?>0%;" class="s_percent"></span></p>
            <?php endif; ?>
            <?php if ($products[$j]['price']): ?>
            <div class="s_actions">
              <?php if ($products[$j]['price']): ?>
              <a class="s_button_add_to_cart" href="javascript:;" onclick="addToCart('<?php echo $products[$j]['product_id']; ?>');">
                <span class="s_icon_16"><span class="s_icon"></span><?php echo $button_cart; ?></span>
              </a>
              <?php endif; ?>
              <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $products[$j]['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $this->document->shoppica_text_wishlist; ?></a>
              &nbsp;
              <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $products[$j]['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $this->document->shoppica_text_compare; ?></a>
            </div>
            <?php endif ?>
          </div>
          <?php endif; ?>
          <?php endfor; ?>
          <div class="clear"></div>
          <?php endfor; ?>
        </div>
      </div>
      <?php endif; ?>

      <?php if ($tags): ?>
      <div class="clear"></div>

      <div id="product_tags" class="grid_12 alpha omega">
        <h2 class="s_title_1"><?php echo $text_tags; ?></h2>
        <div class="clear"></div>
        <ul class="clearfix">
          <?php foreach ($tags as $tag): ?>
          <li><a href="<?php echo $tag['href']; ?>"><?php echo $tag['tag']; ?></a></li>
          <?php endforeach; ?>
        </ul>
      </div>
      <?php endif; ?>

      <span class="clear"></span>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($this->document->shoppica_column_position == "right" && $column_right): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->


<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/stylesheet/prettyPhoto.css" media="all" />
<script type="text/javascript" src="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/js/jquery/jquery.prettyPhoto.js"></script>

<script type="text/javascript">

jQuery( function($) {
  $(".s_tabs").tabs({ fx: { opacity: 'toggle', duration: 300 } });

  $(".s_review_write, .s_total a").bind("click", function() {
    $('.s_tabs').tabs('select', '#product_reviews');
  });

  $("#product_images a[rel^='prettyPhoto'], #product_gallery a[rel^='prettyPhoto']").prettyPhoto({
    theme: 'light_square',
    opacity: 0.5,
    deeplinking: false,
    ie6_fallback: false,
    social_tools: ''
  });

  $('#review .pagination a').live('click', function() {
    $('#review').slideUp('slow');
    $('#review').load(this.href);
    $('#review').slideDown('slow');

    return false;
  });

  $('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');


});

function review() {
  $.ajax({
    type: 'POST',
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
    beforeSend: function() {
      $('#review_button').attr('disabled', 'disabled');
      $('#review_title').after('<div class="wait"><img src="catalog/view/theme/default/image/loading_1.gif" alt="" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#review_button').attr('disabled', '');
      $('.wait').remove();
    },
    success: function(data) {
      if (data.error) {
        simpleNotice('Error!', data.error, 'failure');
      }

      if (data.success) {
        simpleNotice('Success!', data.success, 'success');

        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').attr('checked', '');
        $('input[name=\'captcha\']').val('');
      }
    }
  });
}

$('#add_to_cart').bind('click', function() {
  $.ajax({
    url: 'index.php?route=module/shoppica/cartCallback',
    type: 'post',
    data: $('#product_add_to_cart_form input[type=\'text\'], #product_add_to_cart_form input[type=\'hidden\'], #product_add_to_cart_form input[type=\'radio\']:checked, #product_add_to_cart_form input[type=\'checkbox\']:checked, #product_add_to_cart_form select, #product_add_to_cart_form textarea'),
    dataType: 'json',
    success: function(json) {

      if (json['error']) {
        if (json['error']['warning']) {
          addProductNotice(json['title'], json['thumb'], json['error']['warning'], 'failure');
          $('.warning').fadeIn('slow');
        }

        for (i in json['error']) {
          $('#option-' + i).append('<p class="s_error_msg">' + json['error'][i] + '</p>');
        }
      }

      if (json['success']) {
        addProductNotice(json['title'], json['thumb'], json['success'], 'success');
        $('#cart_menu span.s_grand_total').html(json['total_sum']);
        $('#cart_menu div.s_cart_holder').html(json['output']);
      }
    }
  });

  return false;
});

</script>

<?php echo $footer; ?>
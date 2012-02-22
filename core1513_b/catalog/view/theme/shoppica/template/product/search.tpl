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
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $container = 12; $main = 12; $side_col = 3; } ?>
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 16; $main = 12; $side_col = 4; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 12; $main = 12; $side_col = 3; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2' && $this->document->shoppica_product_listing_type == 'list') { $container = 16; $main = 16; $side_col = 4; } ?>
  
  <div id="content" class="container_<?php echo $container; ?>">
  
    <?php if ($this->document->shoppica_column_position == "left" && $column_right): ?>
    <div id="left_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div id="search_results" class="grid_<?php echo $main; ?>">
    
      <?php echo $content_top; ?>

      <span class="clear"></span>

      <div id="adv_search_box">
        <h2><?php echo $text_critea; ?></h2>
        <div class="s_row_2 s_mb_0 clearfix">
          <input id="search_input" type="text" name="filter_name" class="filter_keyword"<?php if ($filter_name):?> value="<?php echo $filter_name; ?>"<?php endif; ?> size="50" />
          <select name="filter_category_id" id="filter_category_id">
            <option value="0"><?php echo $text_category; ?></option>
            <?php foreach ($categories as $category_1): ?>
              <?php if ($category_1['category_id'] == $filter_category_id): ?>
              <option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
              <?php else: ?>
              <option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
              <?php endif; ?>
              <?php foreach ($category_1['children'] as $category_2): ?>
                <?php if ($category_2['category_id'] == $filter_category_id): ?>
                <option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                <?php else: ?>
                <option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
                <?php endif; ?>
                <?php foreach ($category_2['children'] as $category_3): ?>
                  <?php if ($category_3['category_id'] == $filter_category_id): ?>
                  <option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                  <?php else: ?>
                  <option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
                  <?php endif; ?>
                <?php endforeach; ?>
              <?php endforeach; ?>
            <?php endforeach; ?>
          </select>
          <a class="s_button_1 s_button_1_small s_main_color_bgr search_button"><span class="s_text"><?php echo $button_search; ?></span></a>
        </div>
        
        <span class="clear"></span>
        
        <div class="s_row_3 clearfix">
          <?php if ($filter_sub_category): ?>
          <label class="s_checkbox" for="sub_category"><input type="checkbox" name="filter_sub_category" value="1" id="filter_sub_category" checked="checked" /> <?php echo $text_sub_category; ?></label>
          <?php else: ?>
          <label class="s_checkbox" for="sub_category"><input type="checkbox" name="filter_sub_category" value="1" id="filter_sub_category" /> <?php echo $text_sub_category; ?></label>
          <?php endif; ?>
        
          <label class="s_checkbox">
            <?php if ($filter_description): ?>
            <input type="checkbox" name="filter_description" value="1" id="filter_description" checked="checked" />
            <?php else: ?>
            <input type="checkbox" name="filter_description" value="1" id="filter_description" />
            <?php endif; ?>
            <?php echo $entry_description; ?>
          </label>
        </div>
        
      </div>

      <?php if ($products): ?>
      <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $grid = 3; $listing_cols = 3; } ?>
      <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $grid = 3; $listing_cols = 4; } ?>
      <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $grid = 3; $listing_cols = 4; } ?>
      <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $grid = 2; $listing_cols = 6; } ?>

      <h2><?php echo $text_search; ?></h2>

      <div id="listing_options">
        <div id="listing_arrange">
          <span class="s_label"><?php echo $text_sort; ?></span>
          <div id="listing_sort" class="s_switcher">
            <?php foreach ($sorts as $sortss): ?>
              <?php if (($sort . '-' . $order) == $sortss['value']): ?>
                <span class="s_selected"><?php echo $sortss['text']; ?></span>
              <?php endif; ?>
            <?php endforeach; ?>
            <ul class="s_options" style="display: none;">
            <?php foreach ($sorts as $sortss): ?>
              <?php if (($sort . '-' . $order) != $sortss['value']): ?>
                <li><a href="<?php echo $sortss['href']; ?>"><?php echo $sortss['text']; ?></a></li>
              <?php endif; ?>
            <?php endforeach; ?>
            </ul>
          </div>
          <span class="s_label"><?php echo $text_limit; ?></span>
          <div id="items_per_page" class="s_switcher">
            <?php foreach ($limits as $limitss): ?>
              <?php if ($limit == $limitss['value']): ?>
                <span class="s_selected"><?php echo $limitss['text']; ?></span>
              <?php endif; ?>
            <?php endforeach; ?>
            <ul class="s_options" style="display: none;">
            <?php foreach ($limits as $limitss): ?>
              <?php if ($limit != $limitss['value']): ?>
                <li><a href="<?php echo $limitss['href']; ?>"><?php echo $limitss['text']; ?></a></li>
              <?php endif; ?>
            <?php endforeach; ?>
            </ul>
          </div>
        </div>
        <div id="view_mode" class="s_nav">
          <ul class="clearfix">
            <li id="view_grid"<?php if($this->document->shoppica_product_listing_type == 'grid') echo ' class="s_selected"';?>>
              <a href="<?php echo $this->url->link('product/search', 'filter_name=' . $filter_name . '&setListingType=grid'); ?>" rel="nofollow">
                <span class="s_icon"></span><?php echo $this->document->shoppica_text_grid; ?>
              </a>
            </li>
            <li id="view_list"<?php if($this->document->shoppica_product_listing_type == 'list') echo ' class="s_selected"';?>>
              <a href="<?php echo $this->url->link('product/search', 'filter_name=' . $filter_name . '&setListingType=list'); ?>" rel="nofollow">
                <span class="s_icon"></span><?php echo $this->document->shoppica_text_list; ?>
              </a>
            </li>
          </ul>
        </div>
        <div>
          <a href="<?php echo $compare; ?>" id="compare_total" class="s_main_color"><?php echo $text_compare; ?></a>
        </div>
      </div>

      <div class="clear"></div>

      <?php if ($this->document->shoppica_product_listing_type == 'list'): ?>

      <?php $products = $this->model_shoppica_shoppica->addDescriptionsToProducts($products); ?>
      <div class="s_listing s_list_view clearfix">
      <?php for ($i = 0, $j = sizeof($products); $i < $j; $i = $i + 1): ?>
        <?php if (isset($products[$i])): ?>
        <div class="s_item clearfix<?php if($i == $j-1) echo ' last';?>">
          <div class="grid_3 alpha">
            <a class="s_thumb" href="<?php echo $products[$i]['href']; ?>">
              <img src="<?php echo $products[$i]['thumb']; ?>" title="<?php echo $products[$i]['name']; ?>" alt="<?php echo $products[$i]['name']; ?>" />
            </a>
          </div>
          <div class="grid_<?php echo $main - 3; ?> omega">
            <h3><a href="<?php echo $products[$i]['href']; ?>"><?php echo $products[$i]['name']; ?></a></h3>

            <?php if ($products[$i]['price']): ?>
              <?php if (!$products[$i]['special']): ?>
              <p class="s_price"><?php echo s_format($products[$i]['price']); ?></p>
              <?php else: ?>
              <p class="s_price s_promo_price"><span class="s_old_price"><?php echo s_format($products[$i]['price']); ?></span><?php echo s_format($products[$i]['special']); ?></p>
              <?php endif ?>
            <?php endif; ?>

            <?php if (isset($products[$i]['description'])): ?>
            <p class="s_description"><?php echo substr($products[$i]['description'], 0, 200); ?>...</p>
            <?php endif; ?>

            <?php if ($products[$i]['rating']): ?>
            <p class="s_rating s_rating_5">
              <span style="width: <?php echo $products[$i]['rating'] * 2 ; ?>0%;" class="s_percent"></span>
            </p>
            <?php endif; ?>

            <div class="s_actions">
              <?php if ($products[$i]['price']): ?>
              <a class="s_button_add_to_cart" href="javascript:;" onclick="addToCart('<?php echo $products[$i]['product_id']; ?>');">
                <span class="s_icon_16">
                  <span class="s_icon"></span>
                  <?php echo $button_cart; ?>
                </span>
              </a>
              <?php endif; ?>
              <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $products[$i]['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $button_wishlist; ?></a>
              &nbsp;
              <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $products[$i]['product_id']; ?>');"><span class="s_icon s_add_10"></span><?php echo $button_compare; ?></a>
            </div>

          </div>
        </div>
        <?php endif; ?>
        <div class="clear"></div>
      <?php endfor; ?>
      </div>

      <?php  else: ?>

      <div class="s_listing s_grid_view clearfix">
      <?php for ($i = 0; $i < sizeof($products); $i = $i + $listing_cols): ?>
        <?php for ($j = $i; $j < ($i + $listing_cols); $j++): ?>
        <?php if (isset($products[$j])): ?>
        <div class="s_item grid_<?php echo $grid ?>">
          <a class="s_thumb" href="<?php echo $products[$j]['href']; ?>">
            <img src="<?php echo $products[$j]['thumb']; ?>" title="<?php echo $products[$j]['name']; ?>" alt="<?php echo $products[$j]['name']; ?>" />
          </a>
          <h3><a href="<?php echo $products[$j]['href']; ?>"><?php echo $products[$j]['name']; ?></a></h3>

          <?php if ($products[$j]['price']): ?>
            <?php if (!$products[$j]['special']): ?>
            <p class="s_price"><?php echo s_format($products[$j]['price']); ?></p>
            <?php else: ?>
            <p class="s_price s_promo_price">
              <span class="s_old_price"><?php echo s_format($products[$j]['price']); ?></span><?php echo s_format($products[$j]['special']); ?>
            </p>
            <?php endif ?>
          <?php endif; ?>

          <?php if ($products[$j]['rating']): ?>
          <p class="s_rating s_rating_5">
            <span style="width: <?php echo $products[$j]['rating'] * 2 ; ?>0%;" class="s_percent"></span>
          </p>
          <?php endif; ?>

          <div class="s_actions">
            <?php if ($products[$j]['price']): ?>
            <a class="s_button_add_to_cart" href="javascript:;" onclick="addToCart('<?php echo $products[$j]['product_id']; ?>');">
              <span class="s_icon_16">
                <span class="s_icon"></span>
                <?php echo $button_cart; ?>
              </span>
            </a>
            <?php endif; ?>
            <a class="s_button_wishlist s_icon_10" onclick="addToWishList('<?php echo $products[$j]['product_id']; ?>');" title="<?php echo $button_wishlist; ?>"><span class="s_icon s_add_10"></span><?php echo $this->document->shoppica_text_wishlist; ?></a>
            &nbsp;
            <a class="s_button_compare s_icon_10" onclick="addToCompare('<?php echo $products[$j]['product_id']; ?>');" title="<?php echo $button_compare; ?>"><span class="s_icon s_add_10"></span><?php echo $this->document->shoppica_text_compare; ?></a>
          </div>

        </div>
        <?php endif; ?>
        <?php endfor; ?>
        <div class="clear"></div>
      <?php endfor; ?>
      </div>

      <?php endif; ?>

      <div class="pagination">
        <?php echo $pagination; ?>
      </div>

      <?php else: ?>

      <p class="align_center s_f_16 s_mb_30 s_p_20_0"><?php echo $text_empty; ?></p>

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


  <script type="text/javascript">
  $('#content input[name=\'filter_name\']').keydown(function(e) {
    if (e.keyCode == 13) {
      $('#button-search').trigger('click');
    }
  });

  $('#adv_search_box a.search_button').bind('click', function() {
    url = 'index.php?route=product/search';

    var filter_name = $('#adv_search_box input.filter_keyword').attr('value');

    if (filter_name) {
      url += '&filter_name=' + encodeURIComponent(filter_name);
    }

    var filter_category_id = $('#filter_category_id').attr('value');

    if (filter_category_id > 0) {
      url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
    }

    var filter_sub_category = $('#filter_sub_category:checked').attr('value');

    if (filter_sub_category) {
      url += '&filter_sub_category=true';
    }

    var filter_description = $('#filter_description:checked').attr('value');

    if (filter_description) {
      url += '&filter_description=true';
    }

    location = url;
  });

  </script>

<?php echo $footer; ?> 
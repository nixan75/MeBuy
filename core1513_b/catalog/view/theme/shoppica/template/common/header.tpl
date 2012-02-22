<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<title><?php echo $title; ?></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<?php if ($keywords): ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php endif; ?>
<?php if ($description): ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php endif; ?>
<?php echo $this->document->shoppica_fb_meta;  ?>

<base href="<?php echo $this->document->shoppica_base_ssl; ?>" />
<?php if ($icon): ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php endif; ?>
<?php foreach ($links as $link): ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php endforeach; ?>

<link rel="stylesheet" type="text/css" href="catalog/view/theme/shoppica/stylesheet/960.css" media="all" />
<link rel="stylesheet" type="text/css" href="catalog/view/theme/shoppica/stylesheet/screen.css?v=1.0.11" media="screen" />
<!--[if lt IE 9]>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/shoppica/stylesheet/ie.css?v=1.0.11" media="screen" />
<![endif]-->

<?php foreach ($styles as $style): ?>
<link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
<?php endforeach; ?>

<style type="text/css">
  <?php if (isset($this->document->shoppica_modify_theme_css_temp)) echo $this->document->shoppica_modify_theme_css_temp; ?>
</style>

<script type="text/javascript" src="http<?php if(isHTTPS()) echo 's'?>://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
<script type="text/javascript" src="http<?php if(isHTTPS()) echo 's'?>://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>

<?php foreach ($scripts as $script): ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php endforeach; ?>

<?php echo $google_analytics; ?>
</head>
<body<?php if (isset($this->document->shoppica_layout_type) && $this->document->shoppica_layout_type != 'full') echo ' class="s_layout_fixed"'; ?>>

<?php if (isset($this->document->shoppica_modify_theme)) echo $this->document->shoppica_modify_theme; ?>
<input type="hidden" id="main_color" value="#<?php echo $this->document->shoppica_color_themes_config['theme_colors']['main_color'] ?>" />
<input type="hidden" id="secondary_color" value="#<?php echo $this->document->shoppica_color_themes_config['theme_colors']['secondary_color'] ?>" />

<div id="wrapper">


  <!-- ---------------------- -->
  <!--      H E A D E R       -->
  <!-- ---------------------- -->
  <div id="header" class="container_12 clearfix">
    <div class="grid_12">

      <?php if ($logo): ?>
      <a id="site_logo" href="<?php echo $this->document->shoppica_base_http; ?>">
        <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" />
      </a>
      <?php endif; ?>


      <div id="top_navigation" class="s_<?php echo $this->config->get('shoppica_show_search_bar') ? 'static' : 'dynamic' ?>">

        <?php if (!$this->document->in_maintenance): ?>

        <?php if ($this->config->get('shoppica_show_search_bar') == '0'): ?>
        <div id="site_search">
          <a id="show_search" class="s_search_button" href="javascript:;" title="<?php echo $text_search; ?>"></a>
          <div id="search_bar" class="clearfix">
            <input id="filter_keyword" type="text" name="filter_name"<?php if ($filter_name): ?> value="<?php echo $filter_name; ?>"<?php endif; ?> title="<?php echo $text_search; ?>" />
            <a id="search_button" class="s_button_1 s_button_1_small s_secondary_color_bgr"><span class="s_text"><?php echo $text_search; ?></span></a>
          </div>
        </div>
        <?php else: ?>
        <div id="site_search">
          <input id="filter_keyword" type="text" name="filter_name"<?php if ($filter_name): ?> value="<?php echo $filter_name; ?>"<?php endif; ?> title="<?php echo $text_search; ?>" />
          <a id="search_button" class="s_search_button" href="javascript:;" title="<?php echo $text_search; ?>"></a>
        </div>
        <?php endif; ?>

        <?php endif; ?>

        <?php if (count($currencies) > 1 && !$this->document->in_maintenance): ?>
        <form action="<?php echo $action; ?>" method="post" id="currency_form">
          <div id="language_switcher" class="s_switcher">
            <?php foreach ($currencies as $currency): ?>
            <?php if ($currency['code'] == $currency_code): ?>
            <span class="s_selected"><?php echo $currency['title']; ?></span>
            <?php endif; ?>
            <?php endforeach; ?>
            <ul class="s_options">
              <?php foreach ($currencies as $currency): ?>
              <li>
                <a href="javascript:;" onclick="$('input[name=\'currency_code\']').attr('value', '<?php echo $currency['code']; ?>'); $('#currency_form').submit();"><?php echo $currency['title']; ?></a>
              </li>
              <?php endforeach; ?>
            </ul>
          </div>
          <input class="s_hidden" type="hidden" name="currency_code" value="" />
          <input class="s_hidden" type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        </form>
        <?php endif; ?>

        <?php if ($languages && count($languages) > 1): ?>
        <form action="<?php echo $action; ?>" method="post" id="language_form">
          <div id="currency_switcher" class="s_switcher">
            <?php foreach ($languages as $language): ?>
            <?php if ($language['code'] == $language_code): ?>
            <span class="s_selected"><img src="catalog/view/theme/shoppica/images/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></span>
            <?php endif; ?>
            <?php endforeach; ?>
            <ul class="s_options">
              <?php foreach ($languages as $language): ?>
              <li>
                <a href="javascript:;" onclick="$('input[name=\'language_code\']').attr('value', '<?php echo $language['code']; ?>'); $('#language_form').submit();">
                  <img src="catalog/view/theme/shoppica/images/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
                </a>
              </li>
              <?php endforeach; ?>
            </ul>
          </div>
          <input class="s_hidden" type="hidden" name="language_code" value="" />
          <input class="s_hidden" type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        </form>
        <?php endif; ?>

      </div>

      <?php if (!$this->document->in_maintenance): ?>

      <div id="system_navigation">
        <?php if ($this->config->get('shoppica_cart_menu_position') == 'above'): ?>
        <div id="cart_menu" class="s_nav">
          <a href="javascript:;">
            <span class="s_icon"></span>
            <?php if ($this->config->get('shoppica_show_cart_label') == '1'): ?>
            <small class="s_text"><?php echo $this->document->shoppica_text_cart;?></small>
            <?php endif; ?>
            <span class="s_grand_total s_main_color"><?php echo strip_tags($this->document->shoppica_total_price); ?></span>
          </a>
          <div class="s_submenu s_cart_holder">
            <?php echo $this->document->shoppica_cart_contents; ?>
          </div>
        </div>
        <?php endif; ?>
        <?php if (!$this->document->in_maintenance): ?>
        <p id="welcome_message">
          <?php if (!$logged) echo $text_welcome; else echo $text_logged; ?>
        </p>
        <?php endif; ?>
        <ul class="s_list_1 clearfix">
          <li><a href="<?php echo $wishlist; ?>" id="wishlist_total"><?php echo $text_wishlist; ?></a></li>
          <li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
          <li><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></li>
          <li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
        </ul>
      </div>

      <div id="categories" class="s_nav">
        <?php echo $this->document->shoppica_categories; ?>
      </div>

      <?php if ($this->config->get('shoppica_cart_menu_position') == 'right'): ?>
      <div id="cart_menu" class="s_nav">
        <a href="javascript:;">
          <span class="s_icon"></span>
          <?php if ($this->config->get('shoppica_show_cart_label') == '1'): ?>
          <small class="s_text"><?php echo $this->document->shoppica_text_cart;?></small>
          <?php endif; ?>
          <span class="s_grand_total s_main_color"><?php echo strip_tags($this->document->shoppica_total_price); ?></span>
        </a>
        <div class="s_submenu s_cart_holder">
          <?php echo $this->document->shoppica_cart_contents; ?>
        </div>
      </div>
      <?php endif; ?>

      <?php endif; ?>

    </div>
  </div>
  <!-- end of header -->

  <?php if (isset($common_error)): ?>
  <div class="s_server_msg">
    <?php echo $common_error; ?>
  </div>
  <?php endif; ?>


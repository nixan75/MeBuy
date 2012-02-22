<?php
// Shoppica 1.0.11 for OC 1.5.1.x

class ControllerModuleShoppica extends Controller
{
    private $_theme_name = 'shoppica';
    private $_namespace  = 'shoppica';

    private $_path_arr        = array(),
            $_path_str        = '',
            $_parent_path_str = '',
            $_category_id     = 0;

    public function init()
    {
        if ($this->config->get('config_template') != $this->_theme_name) {

            return;
        }

        $this->_url = null;

        $this->load->model('shoppica/shoppica');

        $this->model_shoppica_shoppica->setThemeName($this->_theme_name);
        $this->model_shoppica_shoppica->setNamespace($this->_namespace);

        if ($this->config->get('shoppica_status') == 0) {
            echo $this->model_shoppica_shoppica->fetchTemplate($this->_theme_name  . '/template/common/install_error.tpl', array());
            die();
        }

        if (isHTTPS()) {
            define('RES_URL', HTTPS_SERVER);
            define('CURRENT_URL', "https://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
            $base_ssl = $this->config->get('config_ssl');
        } else {
            define('RES_URL', HTTP_SERVER);
            define('CURRENT_URL', "http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
            $base_ssl = $this->config->get('config_url');
        }
        $base_http = $this->config->get('config_url');

        $this->doRouting();
        $this->extractShoppicaLang();

        s_format(null, $this->currency);

        if ($this->isAjaxRequest()) {

            return;
        }

        $in_maintenance = $this->config->get('config_maintenance');
        if ($in_maintenance) {
            // Check if logged in as admin
            $this->load->library('user');
            $this->registry->set('user', new User($this->registry));

            if ($this->user->isLogged()) {
                $in_maintenance = 0;
            }
        }
        $this->document->in_maintenance = $in_maintenance;

        $this->checkListingType();
        $this->resolveCategoryPath();

        $this->load->model('catalog/category');
        $this->load->model('catalog/manufacturer');
        $this->load->model('catalog/information');
        $this->load->model('tool/image');

        $this->language->load('module/shoppica');
        $this->language->load('checkout/cart');

        $this->document->shoppica_modify_theme_css_temp = $this->model_shoppica_shoppica->getStylesFile($this->_path_str);
        $this->document->shoppica_color_themes_config   = $this->model_shoppica_shoppica->getCascadeConfig($this->_path_str);

        $this->document->shoppica_base_http        = modifyBase($base_http, $_SERVER['HTTP_HOST']);
        $this->document->shoppica_base_ssl         = modifyBase($base_ssl, $_SERVER['HTTP_HOST']);
        $this->document->shoppica_layout_type      = $this->config->get('shoppica_layout_type');
        $this->document->shoppica_column_position  = $this->config->get('shoppica_column_position');
        $this->document->shoppica_products_listing = $this->config->get('shoppica_products_listing');

        $language = $this->model_shoppica_shoppica->getCurrentLanguage();
        $this->document->shoppica_language = $language;

        $shoppica_footer = unserialize($this->config->get('shoppica_footer'));
        if (isset($shoppica_footer[$language['language_id']])) {
            $this->document->shoppica_footer = $shoppica_footer[$language['language_id']];
            $this->document->shoppica_enabled_footer_columns_cnt =
                (int) $this->document->shoppica_footer['info_enabled']     +
                (int) $this->document->shoppica_footer['contacts_enabled'] +
                (int) $this->document->shoppica_footer['twitter_enabled']  +
                (int) $this->document->shoppica_footer['facebook_enabled'];
        } else {
            $this->document->shoppica_enabled_footer_columns_cnt = 0;
        }

        $this->document->shoppica_rightColumnEmpty      = $this->checkRightColumnEmpty();
        $this->document->shoppica_modify_theme          = $this->getModifyThemeBar();
        $this->document->shoppica_categories            = $this->generateCategoriesMenu();
        $this->document->shoppica_categories_arr        = $this->getCategoriesArray(0);
        $this->document->shoppica_categories_nested_arr = $this->getCategoriesNestedArray(0, 0, '', 2);
        $this->document->shoppica_manufacturers         = $this->model_catalog_manufacturer->getManufacturers();
        $this->document->shoppica_payment_images        = $this->getPaymentImages();
        $this->document->shoppica_intro_banner          = $this->getIntroBanner();

        $this->document->shoppica_fb_meta = '';
        if (isset($this->request->get['route']) && $this->request->get['route'] == 'product/product' && isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
            if ($product_id > 0) {
                $this->load->model('catalog/product');
                $product_info = $this->model_catalog_product->getProduct($product_id);
                if ($product_info['image']) {
                    $thumb = $this->model_tool_image->resize($product_info['image'], $this->config->get('config_image_thumb_width'), $this->config->get('config_image_thumb_height'));
                } else {
                    $thumb = RES_URL . '/image/no_image.jpg';
                }
            }
            $this->document->shoppica_fb_meta = '<meta property="og:image" content="' . $thumb . '" />';
        }

        $cart_contents = $this->getCartContents();

        $this->document->shoppica_cart_contents       = $cart_contents['output'];
        $this->document->shoppica_cart_products_count = $cart_contents['products_count'];
        $this->document->shoppica_total_price         = $cart_contents['total_sum'];

        $this->setSubcategoiesImages();
    }

    public function saveTheme()
    {
        if ($this->request->server['REQUEST_METHOD'] != 'POST' || !isset($this->request->post['shoppica'])) {

            return false;
        }

        $this->load->model('shoppica/shoppica');

        if (isset($this->session->data['modify_theme']) && $this->session->data['modify_theme'] == 1 &&
            isset($this->session->data['user_id']) && is_numeric($this->session->data['user_id'])
        ) {
            $user = $this->model_shoppica_shoppica->getUser($this->session->data['user_id']);
            if (empty($user) || $user['status'] != 1 || !in_array('module/shoppica', $user['permission']['modify'])) {

                return false;
            }
        } else {

            return false;
        }

        $form_data = $this->request->post['shoppica'];
        $this->model_shoppica_shoppica->saveModifiedTheme($form_data);

        if ($form_data['path'] == 0) {
            $this->redirect(HTTP_SERVER . 'index.php?route=common/home');
        } else {
            $this->redirect(HTTP_SERVER . 'index.php?route=product/category&path=' . $form_data['path']);
        }
    }

    public function cartCallback()
    {
        $this->response->setOutput(json_encode($this->getCartContents()));
    }

    public function wishlistCallback()
    {
        $this->language->load('account/wishlist');

        $json = array();

        if (!isset($this->session->data['wishlist'])) {
            $this->session->data['wishlist'] = array();
        }

        $product_id = 0;
        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        }

        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        $product_info = $this->model_catalog_product->getProduct($product_id);

        if ($product_info) {
            if (!in_array($product_id, $this->session->data['wishlist'])) {
                $this->session->data['wishlist'][] = $this->request->post['product_id'];
            }

            if ($this->customer->isLogged()) {
                $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('account/wishlist'));
                $json['title'] = $this->language->get('shoppica_text_add_wishlist');
            } else {
                $json['failure'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'), $this->url->link('product/product', 'product_id=' . $this->request->post['product_id']), $product_info['name'], $this->url->link('account/wishlist'));
                $json['title'] = $this->language->get('shoppica_text_failure');
            }

            $json['thumb'] = $this->model_tool_image->resize($product_info['image'], 40, 40);;
            $json['total'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
        }

        $this->response->setOutput(json_encode($json));
    }

    public function compareCallback()
    {
        $this->language->load('product/compare');
        $this->load->model('tool/image');

        $json = array();

        if (!isset($this->session->data['compare'])) {
            $this->session->data['compare'] = array();
        }

        $product_id = 0;
        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        }

        $this->load->model('catalog/product');

        $product_info = $this->model_catalog_product->getProduct($product_id);
        if ($product_info) {
            if (!in_array($product_id, $this->session->data['compare'])) {
                if (count($this->session->data['compare']) > 4) {
                    array_shift($this->session->data['compare']);
                }
                $this->session->data['compare'][] = $product_id;
            }

            $json['thumb']   = $this->model_tool_image->resize($product_info['image'], 40, 40);
            $json['title']   = $this->language->get('shoppica_text_add_compare');
            $json['success'] = sprintf($this->language->get('text_success'), $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('product/compare'));
            $json['total']   = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        }

        $this->response->setOutput(json_encode($json));
    }

    public function rewrite($link)
    {
        if ($this->config->get('config_seo_url')) {
            $url_data = parse_url(str_replace('&amp;', '&', $link));

            $url = '';

            $data = array();

            parse_str($url_data['query'], $data);

            foreach ($data as $key => $value) {
                if (isset($data['route'])) {
                    if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/product' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
                        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");

                        if ($query->num_rows) {
                            $url .= '/' . $query->row['keyword'];

                            unset($data[$key]);
                        }
                    } elseif ($key == 'path') {
                        $categories = explode('_', $value);

                        foreach ($categories as $category) {
                            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");

                            if ($query->num_rows) {
                                $url .= '/' . $query->row['keyword'];
                            }
                        }

                        unset($data[$key]);
                    }
                }
            }

            if ($url) {
                unset($data['route']);

                $query = '';

                if ($data) {
                    foreach ($data as $key => $value) {
                        $query .= '&' . $key . '=' . $value;
                    }

                    if ($query) {
                        $query = '?' . trim($query, '&');
                    }
                }

                return $url_data['scheme'] . '://' . $url_data['host'] . (isset($url_data['port']) ? ':' . $url_data['port'] : '') . str_replace('/index.php', '', $url_data['path']) . $url . $query;
            } else {
                return $link;
            }
        } else {
            return $link;
        }
    }

    private function doRouting()
    {
        if ($this->config->get('config_seo_url')) {
            $this->_url = new Url($this->config->get('config_url'), $this->config->get('config_ssl'));
            $this->_url->addRewrite($this);
        } else {
            $this->_url = $this->url;
        }

        if (!isset($this->request->get['_route_'])) {

            return;
        }

        $parts = explode('/', $this->request->get['_route_']);

        $escaped_parts = array();
        foreach ($parts as $part) {
            $escaped_parts[] = trim($this->db->escape($part));
        }

        $parts_sql = "keyword = '" . implode("' OR keyword = '", $escaped_parts) . "'";
        $sql = 'SELECT *
                FROM '  . DB_PREFIX . 'url_alias
                WHERE ' . $parts_sql;
        $query = $this->db->query($sql);

        $category_path_arr = array();
        if ($query->num_rows) {
            foreach ($query->rows as $row) {
                $url = explode('=', $row['query']);

                if ($url[0] == 'product_id') {
                    $this->request->get['product_id'] = $url[1];
                }

                if ($url[0] == 'category_id') {
                    $category_path_arr[$row['keyword']] = $url[1];
                }

                if ($url[0] == 'manufacturer_id') {
                    $this->request->get['manufacturer_id'] = $url[1];
                }

                if ($url[0] == 'information_id') {
                    $this->request->get['information_id'] = $url[1];
                }
            }
        }

        if (!empty($category_path_arr)) {
            $sorted_parts = array();
            foreach ($escaped_parts as $part) {
                if (isset($category_path_arr[$part])) {
                    $sorted_parts[$part] = $category_path_arr[$part];
                }
            }
            $this->_path_str = implode('_', $sorted_parts);
        }

        if (isset($this->request->get['product_id'])) {
            $this->request->get['route'] = 'product/product';
        } elseif ($this->_path_str != '') {
            $this->request->get['route'] = 'product/category';
        } elseif (isset($this->request->get['manufacturer_id'])) {
            $this->request->get['route'] = 'product/manufacturer/product';
        } elseif (isset($this->request->get['information_id'])) {
            $this->request->get['route'] = 'information/information';
        }
    }

    private function resolveCategoryPath()
    {
        if (isset($this->request->get['route']) && $this->request->get['route'] == 'product/category') {
            if ($this->_path_str == '') {
                $this->_path_str = (string) $this->request->get['path'];
            }
        } else {

            return;
        }

        $this->_path_arr = explode('_', $this->_path_str);
        $this->_category_id = end($this->_path_arr);
        if (!empty($this->_path_arr)) {
            $parent_path = $this->_path_arr;
            array_pop($parent_path);
            $this->_parent_path_str = implode('_', $parent_path);
        }
    }

    private function checkRightColumnEmpty()
    {
        $this->load->model('design/layout');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('catalog/information');
        $this->load->model('setting/extension');

        if (isset($this->request->get['route'])) {
            $route = $this->request->get['route'];
        } else {
            $route = 'common/home';
        }

        $layout_id = 0;

        if (substr($route, 0, 16) == 'product/category' && isset($this->_path_str)) {
            $path = explode('_', (string) $this->_path_str);

            $layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
        }

        if (substr($route, 0, 16) == 'product/product' && isset($this->request->get['product_id'])) {
            $layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
        }

        if (substr($route, 0, 16) == 'product/information' && isset($this->request->get['information_id'])) {
            $layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
        }

        if (!$layout_id) {
            $layout_id = $this->model_design_layout->getLayout($route);
        }

        if (!$layout_id) {
            $layout_id = $this->config->get('config_layout_id');
        }

        $column_isEmpty = true;
        $extensions = $this->model_setting_extension->getExtensions('module');
        foreach ($extensions as $extension) {
            $modules = $this->config->get($extension['code'] . '_module');
            if (is_array($modules) && !empty($modules)) {
                foreach ($modules as $module) {
                    if ($module['layout_id'] == $layout_id && $module['position'] == 'column_right' && $module['status']) {
                        $column_isEmpty = false;
                    }
                }
            }
        }

        return $column_isEmpty;
    }

    private function checkListingType()
    {
        if (isset($this->request->get['setListingType'])) {
            $listingType = (string) $this->request->get['setListingType'];
            if ($listingType == 'grid' || $listingType == 'list') {
                setcookie('listingType', $listingType, time() + 604800);
                if (!isset($_SERVER['HTTP_REFERER']) || empty($_SERVER['HTTP_REFERER'])) {
                    $_SERVER['HTTP_REFERER'] = getenv('HTTP_REFERER');
                }
                if(!empty($_SERVER['HTTP_REFERER'])){
                    $this->redirect($_SERVER['HTTP_REFERER']);
                }
            }
        } else
        if (isset($_COOKIE['listingType']) && ($_COOKIE['listingType'] == 'grid' || $_COOKIE['listingType'] = 'list')) {
            $listingType = $_COOKIE['listingType'];
        } else {
            $listingType = 'grid';
        }
        $this->document->shoppica_product_listing_type = $listingType;
    }

    private function getCartContents()
    {
        $this->language->load('checkout/cart');
        $this->language->load('module/shoppica');

        $this->load->model('catalog/product');

        if (isset($this->request->get['route']) && $this->request->get['route'] == 'checkout/success') {
            $this->cart->clear();
        }

        $json = array();
        $product_id = 0;
        if (isset($this->request->post['product_id'])) {
            $product_id = (int) $this->request->post['product_id'];
        }

        if (!empty($product_id)) {
            $product_info = $this->model_catalog_product->getProduct($product_id);
            if ($product_info) {
                // Minimum quantity validation
                $quantity = 1;
                if (isset($this->request->post['quantity'])) {
                    $quantity = (int) $this->request->post['quantity'];
                }
                if (!$quantity) {
                    $quantity = 1;
                }

                $product_total = 0;

                if (strcmp(VERSION,'1.5.1.3') >= 0) {
                    $products = $this->cart->getProducts();

                    foreach ($products as $product_2) {
                        if ($product_2['product_id'] == $product_id) {
                            $product_total += $product_2['quantity'];
                        }
                    }
                } else {
                    foreach ($this->session->data['cart'] as $key => $value) {
                        $product = explode(':', $key);
                        $product[0] = (int) $product[0];
                        if ($product[0] == $product_id) {
                            $product_total += $value;
                        }
                    }
                }

                if ($product_info['minimum'] > ($product_total + $quantity)) {
                    $json['title'] = $this->language->get('shoppica_text_failure');
                    $json['error']['warning'] = sprintf($this->language->get('error_minimum'), $product_info['name'], $product_info['minimum']);
                }

                // Option validation
                $option = array();
                if (isset($this->request->post['option'])) {
                    $option = array_filter((array) $this->request->post['option']);
                }

                $product_options = $this->model_catalog_product->getProductOptions($product_id);
                foreach ($product_options as $product_option) {
                    if ($product_option['required'] && (!isset($this->request->post['option'][$product_option['product_option_id']]) ||
                        !$this->request->post['option'][$product_option['product_option_id']]))
                    {
                        $json['error'][$product_option['product_option_id']] = sprintf($this->language->get('error_required'), $product_option['name']);
                    }
                }
                $this->load->model('tool/image');
                $json['thumb'] = $this->model_tool_image->resize($product_info['image'], 40, 40);
            }

            if (!isset($json['error'])) {
                $this->cart->add($product_id, $quantity, $option);
                $json['title'] = $this->language->get('shoppica_text_title_add_cart');
                $json['success'] = sprintf($this->language->get('shoppica_text_add_cart'), $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('checkout/cart'));

                unset($this->session->data['shipping_methods']);
                unset($this->session->data['shipping_method']);
                unset($this->session->data['payment_methods']);
                unset($this->session->data['payment_method']);
            } else {
                $json['redirect'] = str_replace('&amp;', '&', $this->url->link('product/product', 'product_id=' . $product_id));
            }
        }

        if (isset($this->request->post['remove'])) {
            $product_id = (int) $this->request->post['remove'];
            $product_info = $this->model_catalog_product->getProduct($product_id);
            if ($product_info) {
                $this->load->model('tool/image');

                $json['thumb'] = $this->model_tool_image->resize($product_info['image'], 40, 40);
                $this->cart->remove($this->request->post['remove']);

                $json['title'] = $this->language->get('shoppica_text_title_remove_cart');
                $json['success'] = sprintf($this->language->get('shoppica_text_remove_cart'), $this->url->link('product/product', 'product_id=' . $product_id), $product_info['name'], $this->url->link('checkout/cart'));

                unset($this->session->data['shipping_methods']);
                unset($this->session->data['shipping_method']);
                unset($this->session->data['payment_methods']);
                unset($this->session->data['payment_method']);
            }
        }

        if (isset($this->request->post['voucher']) && !is_array($this->request->post['voucher'])) {
            if ($this->session->data['vouchers'][$this->request->post['voucher']]) {
                unset($this->session->data['vouchers'][$this->request->post['voucher']]);
            }
        }

        $this->load->model('tool/image');

        $this->data['text_empty']      = $this->language->get('text_empty');
        $this->data['button_checkout'] = $this->language->get('button_checkout');
        $this->data['button_remove']   = $this->language->get('button_remove');

        $this->data['products'] = array();

        foreach ($this->cart->getProducts() as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], 40, 40);
            } else {
                $image = '';
            }

            $option_data = array();

            foreach ($result['option'] as $option) {
                if ($option['type'] != 'file') {
                    $option_data[] = array(
                        'type'  => $option['type'],
                        'name'  => $option['name'],
                        'value' => (strlen($option['option_value']) > 20 ? substr($option['option_value'], 0, 20) . '..' : $option['option_value'])
                    );
                } else {
                    $this->load->library('encryption');

                    $encryption = new Encryption($this->config->get('config_encryption'));

                    $file = substr($encryption->decrypt($option['option_value']), 0, strrpos($encryption->decrypt($option['option_value']), '.'));

                    $option_data[] = array(
                        'type'  => $option['type'],
                        'name'  => $option['name'],
                        'value' => (strlen($file) > 20 ? substr($file, 0, 20) . '..' : $file)
                    );
                }
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $total = $this->currency->format($this->tax->calculate($result['total'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $total = false;
            }

            $urlObj = empty($this->_url) ? $this->url : $this->_url;
            $this->data['products'][] = array(
                'id'       => $result['product_id'],
                'key'      => $result['key'],
                'thumb'    => $image,
                'name'     => $result['name'],
                'model'    => $result['model'],
                'option'   => $option_data,
                'quantity' => $result['quantity'],
                'stock'    => $result['stock'],
                'price'    => $price,
                'total'    => $total,
                'href'     => $urlObj->link('product/product', 'product_id=' . $result['product_id'])
            );
        }

        // Gift Voucher
        $this->data['vouchers'] = array();

        if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
            foreach ($this->session->data['vouchers'] as $key => $voucher) {
                $this->data['vouchers'][] = array(
                    'key'         => $key,
                    'description' => $voucher['description'],
                    'amount'      => $this->currency->format($voucher['amount'])
                );
            }
        }

        // Calculate Totals
        $total_data = array();
        $total = 0;
        $taxes = $this->cart->getTaxes();

        if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
            $this->load->model('setting/extension');

            $sort_order = array();

            $results = $this->model_setting_extension->getExtensions('total');

            foreach ($results as $key => $value) {
                $sort_order[$key] = $this->config->get($value['code'] . '_sort_order');
            }

            array_multisort($sort_order, SORT_ASC, $results);

            foreach ($results as $result) {
                if ($this->config->get($result['code'] . '_status')) {
                    $this->load->model('total/' . $result['code']);

                    $this->{'model_total_' . $result['code']}->getTotal($total_data, $total, $taxes);
                }
            }

            $sort_order = array();

            foreach ($total_data as $key => $value) {
                $sort_order[$key] = $value['sort_order'];
            }

            array_multisort($sort_order, SORT_ASC, $total_data);
        }

        $products_count = $this->cart->countProducts();
        $json['total'] = sprintf($this->language->get('text_items'), $products_count  + (isset($this->session->data['vouchers']) ? count($this->session->data['vouchers']) : 0), $this->currency->format($total));
        $json['total_sum'] = $this->currency->format($total);
        $json['products_count'] = $products_count;

        $this->data['products_count'] = $products_count;
        $this->data['totals'] = $total_data;
        $this->data['checkout'] = $this->url->link('checkout/checkout', '', 'SSL');

        $this->template = $this->_theme_name . '/template/common/cart.tpl';
        $json['output'] = $this->render();

        return $json;
    }

    private function getIntroBanner()
    {
        $result = '';
        $route = false;
        if (isset($this->request->get['route'])) {
            $route = (string) $this->request->get['route'];
        }

        if (!$route || $route == 'product/category' || $route == 'common/home') {
            $banner_config = $this->model_shoppica_shoppica->getCascadeConfigIntroBanner($this->_path_str);
            if ($banner_config['intro_banner_type'] == 'default') {
                $tpl = $this->_theme_name . '/template/module/shoppica_intro_banner_default.tpl';
                $result = $this->model_shoppica_shoppica->fetchTemplate($tpl, $this->data);
            } else {
                switch ($banner_config['intro_banner_type']) {
                    case 'products' :
                        $products = array();
                        if (isset($banner_config['intro_banner_product_id']) && !empty($banner_config['intro_banner_product_id'])) {
                            $products = $this->model_shoppica_shoppica->getProductsById($banner_config['intro_banner_product_id']);
                        }
                        if (!empty($products)) {
                            foreach ($products as &$product) {
                                if (!empty($product['meta_description'])) {
                                    $product['description'] = $product['meta_description'];
                                } else {
                                    $product['description'] = strip_tags(html_entity_decode($product['description'], ENT_QUOTES, 'UTF-8'));
                                }

                                if ($product['image']) {
                                    switch ($banner_config['intro_banner_products_size']) {
                                        case '3':
                                            $product['image'] = $this->model_tool_image->resize($product['image'], 300, 300);
                                            break;
                                        case '2':
                                            $product['image'] = $this->model_tool_image->resize($product['image'], 250, 250);
                                            break;
                                        case '1':
                                            $product['image'] = $this->model_tool_image->resize($product['image'], 200, 200);
                                            break;
                                    }
                                    $this->data['size'] = $banner_config['intro_banner_products_size'];
                                } else {
                                    $product['image'] = false;
                                }

                                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                                    $product['price'] = $this->currency->format($this->tax->calculate($product['price'], $product['tax_class_id'], $this->config->get('config_tax')));
                                } else {
                                    $product['price'] = false;
                                }

                                if ((float) $product['special']) {
                                    $product['special'] = $this->currency->format($this->tax->calculate($product['special'], $product['tax_class_id'], $this->config->get('config_tax')));
                                } else {
                                    $product['special'] = false;
                                }

                                if ($this->config->get('config_tax')) {
                                    $product['tax'] = $this->currency->format((float) $product['special'] ? $product['special'] : $product['price']);
                                } else {
                                    $product['tax'] = false;
                                }

                                if ($this->config->get('config_review_status')) {
                                    $product['rating'] = (int) $product['rating'];
                                } else {
                                    $product['rating'] = false;
                                }

                                $product['href'] = $this->_url->link('product/product', 'product_id=' . $product['product_id']);
                            }

                            $this->data['products'] = $products;

                            $this->language->load('product/product');
                            $this->data['text_average'] = $this->language->get('text_average');
                            $this->data['text_price']   = $this->language->get('text_price');

                            $result = $this->model_shoppica_shoppica->fetchTemplate($this->_theme_name . '/template/module/shoppica_intro_banner_products.tpl', $this->data);
                        }
                    break;

                    case 'images':
                        $language = $this->model_shoppica_shoppica->getCurrentLanguage();
                        $images = isset($banner_config['intro_banner_images']) ? $banner_config['intro_banner_images'] : array();
                        if (isset($images[$language['language_id']]) && !empty($images[$language['language_id']])) {
                            $this->data['shoppica_images'] = $images[$language['language_id']];
                            $this->data['image_vars']      = $banner_config['intro_banner_image_vars'][$language['language_id']];

                            $result = $this->model_shoppica_shoppica->fetchTemplate($this->_theme_name . '/template/module/shoppica_intro_banner_images.tpl', $this->data);
                        }
                    break;
                }
            }
        }

        return trim($result);
    }

    private function getPaymentImages()
    {
        $payment_images = $this->config->get('shoppica_payment_images');
        if (!empty($payment_images)) {
            $payment_images = unserialize($payment_images);
        } else {
            $payment_images = array();
        }

        return $payment_images;
    }

    private function getModifyThemeBar()
    {
        if (isset($this->session->data['modify_theme']) && $this->session->data['modify_theme'] == 1 &&
            isset($this->session->data['user_id']) && is_numeric($this->session->data['user_id'])
        ) {
            $user = $this->model_shoppica_shoppica->getUser($this->session->data['user_id']);
            if (!empty($user) && $user['status'] == 1 && in_array('module/shoppica', $user['permission']['modify'])) {
                $this->data['color_themes_config'] = $this->document->shoppica_color_themes_config;
                $this->data['theme_names'] = $this->model_shoppica_shoppica->getThemeNames();
            } else {

                return '';
            }
        } else {

            return '';
        }

        $this->data['predefined_themes'] = $this->model_shoppica_shoppica->getColorThemes();
        $this->data['categories']        = $this->getCategoriesArray(0);
        $this->data['category_id']       = $this->_category_id;

        if ($this->data['color_themes_config']['predefined_theme'] == 'parent' && $this->data['color_themes_config']['is_parent'] == '1') {

        }

        if ($this->_category_id != 0) {
            $category = $this->model_catalog_category->getCategory($this->_category_id);
            if ($category['parent_id'] != 0) {
                $parent = $this->model_catalog_category->getCategory($category['parent_id']);
                $this->data['color_themes_config']['parent_name'] = $parent['name'];
            } else {
                $this->data['color_themes_config']['parent_name'] = 'Global';
            }
        }

        $colors_data = $this->data['predefined_themes'];
        $colors_data['parent'] = $this->data['color_themes_config']['parent_vars']['theme_colors'];
        $colors_data['custom'] = $this->data['color_themes_config']['theme_colors'];

        $this->data['colors_data'] = json_encode($colors_data);

        $backgrounds = $this->config->get('shoppica_background');
        if (!empty($backgrounds)) {
            $this->data['backgrounds'] = unserialize($backgrounds);
        } else {
            $this->data['backgrounds'] = array();
        }

        $tpl = $this->_theme_name . '/template/module/shoppica_modify_theme.tpl';
        $result = $this->model_shoppica_shoppica->fetchTemplate($tpl, $this->data);

        return $result;
    }

    private function getCategoriesArray($parent_id, $level = 0, $current_path = '')
    {
        $level++;

        $results = $this->model_catalog_category->getCategories($parent_id);

        $data = array();
        foreach ($results as $result) {
            if (!$current_path) {
                $new_path = $result['category_id'];
            } else {
                $new_path = $current_path . '_' . $result['category_id'];
            }

            if ($result['image']) {
                $image = $result['image'];
            } else {
                $image = 'no_image.jpg';
            }

            $data[] = array(
                'category_id' => $result['category_id'],
                'parent_id'   => $parent_id,
                'name'        => str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $level) . $result['name'],
                'thumb'       => $this->model_tool_image->resize($image, $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height')),
                'url'         => $this->_url->link('product/category', 'path=' . $new_path),
                'path'        => $new_path,
                'level'       => $level
            );

            $children = $this->getCategoriesArray($result['category_id'], $level, $new_path);

            if ($children) {
              $data = array_merge($data, $children);
            }
        }

        return $data;
    }

    private function getCategoriesNestedArray($parent_id, $level = 0, $current_path = '', $max_level = null)
    {
        $level++;

        if ($max_level !== null && $level > $max_level) {
            return array();
        }

        $results = $this->model_catalog_category->getCategories($parent_id);

        $data = array();
        foreach ($results as $result) {
            if (!$current_path) {
                $new_path = $result['category_id'];
            } else {
                $new_path = $current_path . '_' . $result['category_id'];
            }

            $category = array(
                'category_id' => $result['category_id'],
                'parent_id'   => $parent_id,
                'name'        => $result['name'],
                'url'         => $this->_url->link('product/category', 'path=' . $new_path),
                'path'        => $new_path,
                'level'       => $level
            );
            $category['children'] = $this->getCategoriesNestedArray($result['category_id'], $level, $new_path, $max_level);

            $data[] = $category;
        }

        return $data;
    }

    private function generateCategoriesMenu()
    {
        $this->language->load('checkout/cart');

        $parents = $this->model_catalog_category->getCategories(0);

        $output = '<ul class="clearfix"><li id="menu_home"><a href="' . $this->document->shoppica_base_http . '">Home</a></li>';
        foreach ($parents as $category) {
            if (!$category['top']) {

                continue;
            }
            $childrens = $this->getCategoriesHtml($category['category_id'], $category['category_id']);

            if ($this->_category_id == $category['category_id'] || in_array($this->_category_id, $childrens['ids'])) {
                $output .= '<li class="s_selected">';
            } else {
                $output .= '<li>';
            }

            $output .= '<a href="' . $this->_url->link('product/category', 'path=' . $category['category_id'])  . '">' . $category['name'] . '</a>';

            array_push($childrens['ids'], $category['category_id']);

            $manufacturers = array();
            if ($this->config->get('shoppica_show_menu_brands') == '1') {
                if ($this->config->get('shoppica_show_menu_brands_count') == '1') {
                    $manufacturers = $this->model_shoppica_shoppica->getManufacturersByCategoryWithProductsCount($childrens['ids']);
                } else {
                    $manufacturers = $this->model_shoppica_shoppica->getManufacturersByCategory($childrens['ids']);
                }
            }

            if (empty($manufacturers)) {
                if (!empty($childrens['html'])) {
                    $output .= '<div class="s_submenu"><h3>' . sprintf($this->language->get('shoppica_menu_inside'), $category['name']) . '</h3>' . $childrens['html'] . '</div>';
                }
            } else {
                $output .= '<div class="s_submenu">';

                if (!empty($childrens['html'])) {
                    $output .= '<h3>' . sprintf($this->language->get('shoppica_menu_inside'), $category['name']) . '</h3>' . $childrens['html'];
                    $output .= '<span class="clear border_eee"></span>';
                }

                $output .= '<h3>' . sprintf($this->language->get('shoppica_menu_brands'), $category['name']) . '</h3><ul class="s_list_1 clearfix">';
                foreach ($manufacturers as $manufacturer) {
                    if (isset($manufacturer['products_count'])) {
                        $output .= sprintf('<li><a href="%s">%s  (%s)</a></li>',
                            $this->document->shoppica_base_http . 'index.php?route=product/shoppica&amp;c_path=' . $category['category_id'] . '&amp;man_id=' . $manufacturer['manufacturer_id'],
                            $manufacturer['name'],
                            $manufacturer['products_count']
                        );
                    } else {
                        $output .= sprintf('<li><a href="%s">%s</a></li>',
                            $this->document->shoppica_base_http . 'index.php?route=product/shoppica&amp;c_path=' . $category['category_id'] . '&amp;man_id=' . $manufacturer['manufacturer_id'],
                            $manufacturer['name']);
                    }
                }
                $output .= '</ul></div>';
            }

            $output .= '</li>';
        }
        if ($this->config->get('shoppica_menu_information_pages') == '1') {
            $language = $this->language->load('common/footer');
            $this->data = array_merge($this->data, $language);

            $this->data['informations'] = $this->model_catalog_information->getInformations();
            $this->data['_url'] = $this->_url;
            $output .= $this->model_shoppica_shoppica->fetchTemplate($this->_theme_name . '/template/module/shoppica_information_menu.tpl', $this->data);
        }

        $output .= '</ul>';

        return $output;
    }

    private function getCategoriesHtml($parent_id, $current_path = '')
    {
        $output = '';
        $ids = array();

        $results = $this->model_catalog_category->getCategories($parent_id);

        if ($results) {
            $output .= '<ul class="s_list_1 clearfix">';
        }

        foreach ($results as $result) {
            if (!$current_path) {
                $new_path = $result['category_id'];
            } else {
                $new_path = $current_path . '_' . $result['category_id'];
            }

            $output .= '<li>';
            $ids[] = $result['category_id'];
            $children = $this->getCategoriesHtml($result['category_id'], $new_path);
            $ids = array_merge_recursive($ids, $children['ids']);

            if ($this->_category_id == $result['category_id']) {
                $output .= '<a href="' . $this->_url->link('product/category', 'path=' . $new_path)  . '"><b>' . $result['name'] . '</b></a>';
            } else {
                $output .= '<a href="' . $this->_url->link('product/category', 'path=' . $new_path)  . '">' . $result['name'] . '</a>';
            }

            $output .= $children['html'];
            $output .= '</li>';
        }

        if ($results) {
            $output .= '</ul>';
        }

        return array('html' => $output, 'ids' => $ids);
    }

    private function setSubcategoiesImages()
    {
        if ($this->_category_id == 0) {

            return;
        }
        $subcategories = $this->model_catalog_category->getCategories($this->_category_id);
        foreach ($subcategories as &$category) {
            if ($category['image']) {
                $image = $category['image'];
            } else {
                $image = 'no_image.jpg';
            }
            $category['thumb'] = $this->model_tool_image->resize($image, $this->config->get('config_image_category_width'), $this->config->get('config_image_category_height'));
            $category['description'] = html_entity_decode($category['description'], ENT_QUOTES, 'UTF-8');
            $category['href']  = $this->_url->link('product/category', 'path=' . $this->_path_str . '_' . $category['category_id']);
        }

        $this->document->shoppica_subcategories = $subcategories;
    }

    private function extractShoppicaLang()
    {
        $lang = $this->language->load('module/shoppica');
        foreach ($lang as $key => $value) {
            if (substr($key, 0, 8) == 'shoppica') {
                $this->document->$key = $value;
            }
        }

        $this->load->model('catalog/information');

        $this->document->shoppica_text_agree_checkout = '';
        if ($this->config->get('config_checkout_id')) {
            $information_info = $this->model_catalog_information->getInformation($this->config->get('config_checkout_id'));
            if ($information_info) {
                $this->document->shoppica_text_agree_checkout = sprintf($this->language->get('shoppica_text_agree_checkout'), $this->_url->link('information/information/info', 'information_id=' . $this->config->get('config_checkout_id') . '&iframe=true', 'SSL'), $information_info['title'], $information_info['title']);
            }
        }

        $this->document->shoppica_text_agree_account = '';
        if ($this->config->get('config_account_id')) {
            $information_info = $this->model_catalog_information->getInformation($this->config->get('config_account_id'));
            if ($information_info) {
                $this->document->shoppica_text_agree_account = sprintf($this->language->get('shoppica_text_agree_account'), $this->_url->link('information/information/info', 'information_id=' . $this->config->get('config_account_id') . '&iframe=true', 'SSL'), $information_info['title'], $information_info['title']);
            }
        }

        $this->document->shoppica_text_agree_affiliate = '';
        if ($this->config->get('config_affiliate_id')) {
            $information_info = $this->model_catalog_information->getInformation($this->config->get('config_affiliate_id'));
            if ($information_info) {
                $this->document->shoppica_text_agree_affiliate = sprintf($this->language->get('shoppica_text_agree_affiliate'), $this->url->link('information/information/info', 'information_id=' . $this->config->get('config_affiliate_id') . '&iframe=true', 'SSL'), $information_info['title'], $information_info['title']);
            }
        }
    }

    private function isAjaxRequest()
    {
        return (bool) $this->getHeader('X-Requested-With') || $this->getHeader('x-requested-with') || (isset($_REQUEST['type']) && $_REQUEST['type'] == 'XMLHttpRequest');
    }

    private function getHeader($header)
    {
        $temp = 'HTTP_' . strtoupper(str_replace('-', '_', $header));
        if (isset($_SERVER[$temp]) && !empty($_SERVER[$temp])) {

            return $_SERVER[$temp];
        }

        if (function_exists('apache_request_headers')) {
            $headers = apache_request_headers();
            if (!empty($headers[$header])) {

                return $headers[$header];
            }
        }

        return false;
    }
}
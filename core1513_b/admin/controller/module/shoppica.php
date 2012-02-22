<?php
class ControllerModuleShoppica extends Controller
{
    private $error = array(),
            $_path_str,
            $_path_arr,
            $_intro_banner_category_id = 0;

    public function index()
    {
        $language = $this->load->language('module/shoppica');
        $this->data = array_merge($this->data, $language);

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');
        $this->load->model('catalog/category');
        $this->load->model('shoppica/shoppica');
        $this->load->model('localisation/language');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
            $this->model_shoppica_shoppica->editSettingGroup('shoppica', $this->request->post['shoppica']);
            $this->saveIntroBannerVars($this->request->post['intro_banner']);
            if (isset($this->request->post['payment'])) {
                $this->savePaymentVars($this->request->post['payment']);
            } else {
                $this->savePaymentVars(array());
            }

            if (isset($this->request->post['shoppica_footer'])) {
                $this->model_shoppica_shoppica->editSetting('shoppica', 'shoppica_footer', serialize($this->request->post['shoppica_footer']));
            }

            if (isset($this->request->post['background']) && is_array($this->request->post['background'])) {
                $this->saveBackgroundVars($this->request->post['background']);
            } else {
                $this->saveBackgroundVars(array());
            }

            if (!isset($this->request->post['return_to'])) {
                $return_to = 'layout_settings';
            } else {
                $return_to = $this->request->post['return_to'];
            }

            $this->session->data['success'] = $this->language->get('text_success');

            if (isset($this->request->post['intro_banner_path']) && !empty($this->request->post['intro_banner_path'])) {
                $this->redirect(HTTPS_SERVER . 'index.php?route=module/shoppica&return_to=' . $return_to . '&intro_banner_path=' . $this->request->post['intro_banner_path'] . '&token=' . $this->session->data['token']);
            } else {
                $this->redirect(HTTPS_SERVER . 'index.php?route=module/shoppica&return_to=' . $return_to . '&token=' . $this->session->data['token']);
            }
        } else {
            if (isset($this->session->data['success'])) {
                $this->data['success'] = $this->session->data['success'];

                unset($this->session->data['success']);
            } else {
                $this->data['success'] = '';
            }

            if (isset($this->request->get['removeThemer']) && $this->request->get['removeThemer'] == 1) {
                $this->session->data['modify_theme'] = null;
                unset($this->session->data['modify_theme']);

                $this->redirect(HTTPS_SERVER . 'index.php?route=module/shoppica&token=' . $this->session->data['token']);
            }
        }

        if (!isset($this->request->get['return_to'])) {
            $this->data['return_to'] = 'layout_settings';
        } else {
            $this->data['return_to'] = $this->request->get['return_to'];
        }

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->addBreadCrumbs();

        $this->data['action'] = HTTPS_SERVER . 'index.php?route=module/shoppica&token=' . $this->session->data['token'];
        $this->data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token'];

        $this->data['modify_theme'] = HTTPS_SERVER . 'index.php?route=module/shoppica/modifyTheme&token=' . $this->session->data['token'];
        $this->data['has_color_themer'] = false;
        if (isset($this->session->data['modify_theme']) && $this->session->data['modify_theme'] == 1) {
          $this->data['has_color_themer']  = true;
          $this->data['remove_themer_url'] = HTTPS_SERVER . 'index.php?route=module/shoppica&removeThemer=1&token=' . $this->session->data['token'];
        }

        if (isset($this->request->get['intro_banner_path'])) {
            $this->_path_str = $this->request->get['intro_banner_path'];
            $this->_path_arr = explode('_', $this->request->get['intro_banner_path']);
            $this->_intro_banner_category_id = end($this->_path_arr);

            $this->data['modify_theme_config'] = unserialize($this->config->get('modify_theme_' . $this->_path_str));
            $this->data['intro_banner_path']   = $this->_path_str;
        } else {
            $this->data['modify_theme_config'] = unserialize($this->config->get('modify_theme_0'));
            $this->data['intro_banner_path'] = '';
        }

        if (empty($this->data['modify_theme_config']) || !isset($this->data['modify_theme_config']['intro_banner_type'])) {
            $this->data['modify_theme_config']['intro_banner_type'] = 'nobanner';
        }
        $this->data['intro_banner_category_id']  = $this->_intro_banner_category_id;
        if (empty($this->data['modify_theme_config']) || !isset($this->data['modify_theme_config']['intro_banner_products_size'])) {
            $this->data['modify_theme_config']['intro_banner_products_size'] = 'large';
        }
        $this->data['intro_banner_categories']   = $this->getCategoriesArray();

        $this->setIntroBannerImages();
        $this->setPaymentImages();
        $this->setBackgrounds();

        $this->data['token'] = $this->session->data['token'];

        $vars = array('layout_type', 'column_position', 'show_footer_categories', 'show_menu_brands', 'show_cart',
                      'show_menu_brands_count', 'show_search_bar', 'subcategories_style', 'products_listing', 'latest_products_max', 'special_products_max',
                      'bestseller_products_max', 'featured_products_max', 'menu_information_pages', 'show_cart_label', 'cart_menu_position', 'product_images_position');
        $this->setVars($vars);

        $shoppicaLangVars = array('info_enabled', 'info_title', 'info_text', 'contacts_enabled', 'skypename_show', 'skypename1', 'skypename2', 'email_show',
                                  'email1', 'email2', 'mobile_show', 'mobile1', 'mobile2', 'phone_show', 'phone1', 'phone2', 'fax_show', 'fax1', 'fax2',
                                  'twitter_enabled', 'twitter_username', 'twitter_tweets', 'facebook_enabled', 'facebook_id');
        $this->setShoppicaLangVars($shoppicaLangVars, 'footer');

        $this->data['languages'] = $this->model_localisation_language->getLanguages();

        if (isset($this->request->post['shoppica_status'])) {
            $this->data['shoppica_status'] = $this->request->post['shoppica_status'];
        } else {
            $this->data['shoppica_status'] = $this->config->get('shoppica_status');
        }


        $this->template = 'module/shoppica.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
    }

    private function addBreadCrumbs()
    {
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/shoppica', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
    }

    private function setPaymentImages()
    {
        $this->load->model('tool/image');

        $images = unserialize($this->config->get('shoppica_payment_images'));
        if (!empty($images)) {
            foreach ($images as $key => &$values) {
                if ($values['file'] && file_exists(DIR_IMAGE . $values['file'])) {
                    $values['preview'] = $this->model_tool_image->resize($values['file'], 51, 32);
                } else {
                    unset($images[$key]);
                }
            }
        } else {
            $images = array();
        }

        $this->data['payment_images'] = $images;
    }

    private function setBackgrounds()
    {
        $this->load->model('tool/image');

        $backgrounds = unserialize($this->config->get('shoppica_background'));
        if (!empty($backgrounds)) {
            foreach ($backgrounds as $key => &$values) {
                if ($values['image'] && file_exists(DIR_IMAGE . $values['image'])) {
                    $values['preview'] = $this->model_tool_image->resize($values['image'], 100, 100);
                } else {
                    unset($backgrounds[$key]);
                }
            }
        } else {
            $backgrounds = array();
        }

        $this->data['backgrounds'] = $backgrounds;
    }

    private function savePaymentVars($form_data)
    {
        $config = array();
        if (isset($form_data['images']) && !empty($form_data['images']) && is_array($form_data['images'])) {
            // Guess what I am trying to achieve :)
            $orders = array();
            foreach ($form_data['images'] as $key => $values) {
                $order = (int) $values['order'];
                $orders[] = $order;
            }
            sort($orders);

            $result = array();
            foreach ($form_data['images'] as $key => $values) {
                $order = (int) $values['order'];
                $key = array_search($order, $orders);
                $result[$key] = $values;
                unset($orders[$key]);
            }
            // Confused already ?
            ksort($result);

            foreach ($result as $key => $values) {
                if (!empty($values['image'])) {
                    $config[$key]['order']  = $key + 1;
                    $config[$key]['file']   = $values['image'];
                    $config[$key]['url']    = $values['url'];
                }
            }
        }

        $this->model_shoppica_shoppica->editSetting('shoppica', 'shoppica_payment_images', serialize($config));
    }

    private function saveBackgroundVars($form_data)
    {
        $config = array();
        if (isset($form_data['images']) && !empty($form_data['images']) && is_array($form_data['images'])) {
            foreach ($form_data['images'] as $key => $values) {
                if (!empty($values['image'])) {
                    $config[$values['id']] = $values;
                }
            }
        }

        $this->model_shoppica_shoppica->editSetting('shoppica', 'shoppica_background', serialize($config));
    }

    private function setIntroBannerImages()
    {
        $this->load->model('tool/image');

        if (isset($this->request->get['intro_banner_path'])) {
            $path = (string) $this->request->get['intro_banner_path'];
        } else {
            $path = '0';
        }

        $images = array();
        $config = unserialize($this->config->get('modify_theme_' . $path));
        if (isset($config['intro_banner_images'])) {
            $images = (array) $config['intro_banner_images'];
            foreach ($images as $language_id => &$imgs) {
                foreach ($imgs as $key => &$values) {
                    if ($values['file'] && file_exists(DIR_IMAGE . $values['file'])) {
                        $values['preview'] = $this->model_tool_image->resize($values['file'], 100, 100);
                    } else {
                        unset($images[$key]);
                    }
                }
            }
        }

        $this->data['intro_banner_images'] = $images;

        $languages = $this->model_localisation_language->getLanguages();
        foreach ($languages as $language) {
            if (!isset($config['intro_banner_image_vars'][$language['language_id']])) {
                $config['intro_banner_image_vars'][$language['language_id']]['with_border'] = 0;
                $config['intro_banner_image_vars'][$language['language_id']]['rotation_type'] = 'slide';
            }
        }
        $this->data['intro_banner_image_vars'] = $config['intro_banner_image_vars'];

        $this->load->language('catalog/product');
        $this->data['text_image_manager'] = $this->language->get('text_image_manager');

        $this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
    }

    private function saveIntroBannerVars($form_data)
    {
        $category_id = false;
        if (isset($form_data['category_path'])) {
            $category_path = (string) $form_data['category_path'];
            $category_path_array = explode('_', $category_path);
            $category_id = end($category_path_array);
        } else {
            $category_path = 0;
        }

        if ($category_id === false) {

            return false;
        }

        $banner_type = 'nobanner';
        if (isset($form_data['banner_type'])) {
            $banner_type = (string) $form_data['banner_type'];
        }

        $config = unserialize($this->config->get('modify_theme_' . $category_path));
        $config['intro_banner_type'] = $banner_type;

        $config['intro_banner_products_size'] = (string) $form_data['products_size'];

        $config['intro_banner_images'] = array();
        $languages = $this->model_localisation_language->getLanguages();
        foreach ($languages as $language) {

            $maxHeight = 0;
            $lid = $language['language_id'];
            if (isset($form_data['images'][$lid]) && !empty($form_data['images'][$lid]) && is_array($form_data['images'][$lid])) {
                // Guess what I am trying to achieve :)
                $orders = array();
                foreach ($form_data['images'][$lid] as $key => $values) {
                    $order = (int) $values['order'];
                    $orders[] = $order;
                }
                sort($orders);

                $result = array();
                foreach ($form_data['images'][$lid] as $key => $values) {
                    $order = (int) $values['order'];
                    $key = array_search($order, $orders);
                    $result[$key] = $values;
                    unset($orders[$key]);
                }
                // Confused already ?
                ksort($result);

                $config['intro_banner_images'][$lid] = array();
                foreach ($result as $key => $values) {
                    if (!empty($values['image'])) {
                        list($width, $height) = getimagesize(DIR_IMAGE . $values['image']);

                        $config['intro_banner_images'][$lid][$key]['width']  = $width;
                        $config['intro_banner_images'][$lid][$key]['height'] = $height;
                        $config['intro_banner_images'][$lid][$key]['order']  = $key + 1;
                        $config['intro_banner_images'][$lid][$key]['file']   = $values['image'];
                        $config['intro_banner_images'][$lid][$key]['url']    = $values['url'];

                        if ($height > $maxHeight) {
                            $maxHeight = $height;
                        }
                    }
                }
            }

            if (!isset($form_data['image_vars'][$lid]['with_border'])) {
                $form_data['image_vars'][$lid]['with_border'] = 0;
            }

            $config['intro_banner_image_vars'][$lid]['with_border']   = (int) $form_data['image_vars'][$lid]['with_border'];
            $config['intro_banner_image_vars'][$lid]['rotation_type'] = $form_data['image_vars'][$lid]['rotation_type'];
            $config['intro_banner_image_vars'][$lid]['maxHeight']     = $maxHeight;
        }

        if (!isset($config['path'])) {
            $config['path'] = $category_path;
        }

        $this->model_shoppica_shoppica->editSetting('shoppica', 'modify_theme_' . $category_path, serialize($config));
        $this->cache->delete('shoppica_modify_theme_config');
    }

    public function modifyTheme()
    {
        $this->session->data['modify_theme'] = 1;
        $this->redirect(HTTP_CATALOG);
    }

    public function addIntroBannerProduct()
    {
        $response = 'false';
        if (!$this->validate()) {
            $this->response->setOutput($response, $this->config->get('config_compression'));

            return;
        }

        $product_id = false;
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        }

        $category_id = false;
        if (isset($this->request->get['category_path'])) {
            $path = explode('_', $this->request->get['category_path']);
            $category_id = end($path);
        }

        if (!empty($product_id) && category_id !== false) {
            $config = unserialize($this->config->get('modify_theme_' . $this->request->get['category_path']));
            if (empty($config)) {
                $config = array();
                $config['intro_banner_product_id'] = array();
            }
            $product_ids = (array) $config['intro_banner_product_id'];
            if (array_search($product_id, $product_ids) === false) {
                $this->load->model('shoppica/shoppica');
                $product_ids[] = $product_id;
                $config['intro_banner_product_id'] = $product_ids;
                if (!isset($config['path'])) {
                    $config['path'] = $this->request->get['category_path'];
                }
                if (!isset($config['intro_banner_type'])) {
                    $config['intro_banner_type'] = 'nobanner';
                }
                $this->model_shoppica_shoppica->editSetting('shoppica', 'modify_theme_' . $this->request->get['category_path'], serialize($config));
                $this->cache->delete('shoppica_modify_theme_config');
            }

            $response = 'true';
        }

        $this->response->setOutput($response, $this->config->get('config_compression'));
    }

    public function removeIntroBannerProduct()
    {
        $response = 'false';
        if (!$this->validate()) {
            $this->response->setOutput($response, $this->config->get('config_compression'));

            return;
        }
        
        $product_id = false;
        if (isset($this->request->get['product_id'])) {
            $product_id = (int) $this->request->get['product_id'];
        }

        $category_id = 0;
        if (isset($this->request->get['category_path'])) {
            $path = explode('_', $this->request->get['category_path']);
            $category_id = end($path);
        }

        if (!empty($product_id)) {
            $config = unserialize($this->config->get('modify_theme_' . $this->request->get['category_path']));
            $product_ids = (array) $config['intro_banner_product_id'];
            $key = array_search($product_id, $product_ids);
            if ($key !== false) {
                $this->load->model('shoppica/shoppica');

                unset($product_ids[$key]);
                $config['intro_banner_product_id'] = $product_ids;
                $this->model_shoppica_shoppica->editSetting('shoppica', 'modify_theme_' . $this->request->get['category_path'], serialize($config));
                $this->cache->delete('shoppica_modify_theme_config');
            }

            $response = 'true';
        }

        $this->response->setOutput($response, $this->config->get('config_compression'));
    }

    public function getIntroBannerProductsHtml()
    {
        $this->getProductsList();
        $this->template = 'module/shoppica_intro_banner_products.tpl';

        $this->response->setOutput($this->render(true), $this->config->get('config_compression'));
    }

    private function getProductsList()
    {
        $this->load->model('catalog/product');
        $this->load->model('shoppica/shoppica');
        $pagination_limit = 7;

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'pd.name';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['filter_name'])) {
            $filter_name = $this->request->get['filter_name'];
        } else {
            $filter_name = NULL;
        }

        if (isset($this->request->get['filter_model'])) {
            $filter_model = $this->request->get['filter_model'];
        } else {
            $filter_model = NULL;
        }

        if (isset($this->request->get['filter_price'])) {
            $filter_price = $this->request->get['filter_price'];
        } else {
            $filter_price = NULL;
        }

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . $this->request->get['filter_name'];
        }

        if (isset($this->request->get['filter_model'])) {
            $url .= '&filter_model=' . $this->request->get['filter_model'];
        }

        if (isset($this->request->get['filter_price'])) {
            $url .= '&filter_price=' . $this->request->get['filter_price'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $this->data['products'] = array();

        $data = array(
            'filter_name'     => $filter_name,
            'filter_model'    => $filter_model,
            'filter_price'    => $filter_price,
            'sort'            => $sort,
            'order'           => $order,
            'start'           => ($page - 1) * $pagination_limit,
            'limit'           => $pagination_limit
        );

        $this->load->model('tool/image');

        $product_total = $this->model_catalog_product->getTotalProducts($data);

        $category_id = 0;
        if (isset($this->request->get['category_path'])) {
            $path = explode('_', $this->request->get['category_path']);
            $category_id = end($path);
        }
        $config = unserialize($this->config->get('modify_theme_' . $this->request->get['category_path']));
        $product_ids = array();
        if (isset($config['intro_banner_product_id'])) {
            $product_ids = (array) $config['intro_banner_product_id'];
        }
        $results = $this->model_shoppica_shoppica->getProducts($data, $product_ids);

        foreach ($results as $result) {

            if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
                $image = $this->model_tool_image->resize($result['image'], 40, 40);
            } else {
                $image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
            }

            $special = false;
            $product_specials = $this->model_catalog_product->getProductSpecials($result['product_id']);
             if ($product_specials) {
                $special = reset($product_specials);
                if(($special['date_start'] != '0000-00-00' && $special['date_start'] > date('Y-m-d')) || ($special['date_end'] != '0000-00-00' && $special['date_end'] < date('Y-m-d'))) {
                    $special = false;
                }
            }

            $this->data['products'][] = array(
                'product_id' => $result['product_id'],
                'name'       => $result['name'],
                'model'      => $result['model'],
                'price'      => $result['price'],
                'special'    => $special['price'],
                'image'      => $image,
                'added'      => $result['added'],
                'quantity'   => $result['quantity'],
                'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
                'selected'   => isset($this->request->post['selected']) && in_array($result['product_id'], $this->request->post['selected'])
            );
        }

        $this->setLangVars(array('text_enabled', 'text_disabled', 'text_no_results', 'text_image_manager', 'column_image', 'column_name', 'column_model', 'column_price', 'button_filter'));

        $this->data['token'] = $this->session->data['token'];

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];

            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . $this->request->get['filter_name'];
        }

        if (isset($this->request->get['filter_model'])) {
            $url .= '&filter_model=' . $this->request->get['filter_model'];
        }

        if (isset($this->request->get['filter_price'])) {
            $url .= '&filter_price=' . $this->request->get['filter_price'];
        }

        if ($order == 'ASC') {
            $url .= '&order=DESC';
        } else {
            $url .= '&order=ASC';
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $this->data['sort_added']    = HTTPS_SERVER . 'index.php?route=module/shoppica/getIntroBannerProductsHtml&token=' . $this->session->data['token'] . '&sort=added' . $url;
        $this->data['sort_name']     = HTTPS_SERVER . 'index.php?route=module/shoppica/getIntroBannerProductsHtml&token=' . $this->session->data['token'] . '&sort=pd.name' . $url;
        $this->data['sort_model']    = HTTPS_SERVER . 'index.php?route=module/shoppica/getIntroBannerProductsHtml&token=' . $this->session->data['token'] . '&sort=p.model' . $url;
        $this->data['sort_price']    = HTTPS_SERVER . 'index.php?route=module/shoppica/getIntroBannerProductsHtml&token=' . $this->session->data['token'] . '&sort=p.price' . $url;
        $this->data['sort_order']    = HTTPS_SERVER . 'index.php?route=module/shoppica/getIntroBannerProductsHtml&token=' . $this->session->data['token'] . '&sort=p.sort_order' . $url;

        $url = '';

        if (isset($this->request->get['filter_name'])) {
            $url .= '&filter_name=' . $this->request->get['filter_name'];
        }

        if (isset($this->request->get['filter_model'])) {
            $url .= '&filter_model=' . $this->request->get['filter_model'];
        }

        if (isset($this->request->get['filter_price'])) {
            $url .= '&filter_price=' . $this->request->get['filter_price'];
        }

        if (isset($this->request->get['filter_quantity'])) {
            $url .= '&filter_quantity=' . $this->request->get['filter_quantity'];
        }

        if (isset($this->request->get['filter_status'])) {
            $url .= '&filter_status=' . $this->request->get['filter_status'];
        }

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $pagination = new Pagination();
        $pagination->total = $product_total;
        $pagination->page  = $page;
        $pagination->limit = $pagination_limit;
        $pagination->text  = $this->language->get('text_pagination');
        $pagination->url   = HTTPS_SERVER . 'index.php?route=module/shoppica/getIntroBannerProductsHtml&token=' . $this->session->data['token'] . $url . '&page={page}';

        $this->data['pagination'] = $pagination->render();

        $this->data['filter_name']     = $filter_name;
        $this->data['filter_model']    = $filter_model;
        $this->data['filter_price']    = $filter_price;

        $this->data['sort']  = $sort;
        $this->data['order'] = $order;
    }

    private function setVars($vars, $namespace = 'shoppica')
    {
        foreach ((array) $vars as $val) {
            $name = $namespace . '_' . $val;
            if (isset($this->request->post[$name])) {
                $this->data[$name] = $this->request->post[$name];
            } else {
                $this->data[$name] = $this->config->get($name);
            }
        }
    }

    private function setShoppicaLangVars($vars, $namespace)
    {
        $config = unserialize($this->config->get('shoppica_' . $namespace));
        foreach ($this->model_localisation_language->getLanguages() as $language) {
            $language_id = $language['language_id'];
            foreach ((array) $vars as $val) {
                $name = 'shoppica_' . $namespace;
                if (isset($this->request->post[$name][$language_id][$val])) {
                    $this->data[$name][$language_id][$val] = $this->request->post[$name][$language_id][$val];
                } else {
                    if (isset($config[$language_id][$val])) {
                        $this->data[$name][$language_id][$val] = $config[$language_id][$val];
                    } else {
                        $this->data[$name][$language_id][$val] = null;
                    }
                }
            }
        }
    }

    private function setLangVars($vars)
    {
        foreach ((array) $vars as $val) {
            $this->data[$val] = $this->language->get($val);
        }
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/shoppica')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {

            return true;
        } else {

            return false;
        }
    }

    private function getCategoriesArray($parent_id = 0, $level = 0, $current_path = '')
    {
        $level++;

        $results = $this->model_shoppica_shoppica->getCategories($parent_id);

        $data = array();
        foreach ($results as $result) {
            if (!$current_path) {
                $new_path = $result['category_id'];
            } else {
                $new_path = $current_path . '_' . $result['category_id'];
            }

            $data[] = array(
                'category_id' => $result['category_id'],
                'parent_id'   => $parent_id,
                'name'        => str_repeat('&nbsp;&nbsp;&nbsp;&nbsp;', $level) . $result['name'],
                'url'         => HTTPS_SERVER . 'index.php?route=module/shoppica&intro_banner_path=' . $new_path . '&token=' . $this->session->data['token'],
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
}
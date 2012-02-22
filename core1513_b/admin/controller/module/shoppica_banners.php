<?php
class ControllerModuleShoppicaBanners extends Controller
{
    private $error = array();

    public function index()
    {
        $language = $this->load->language('module/shoppica_banners');
        $this->data = array_merge($this->data, $language);

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('shoppica/banners');
        $this->load->model('setting/setting');

        if ($this->request->server['REQUEST_METHOD'] == 'POST' && $this->validate()) {
            $this->model_setting_setting->editSetting('shoppica_banners', $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        if (isset($this->error['image'])) {
            $this->data['error_image'] = $this->error['image'];
        } else {
            $this->data['error_image'] = array();
        }

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
            'href'      => $this->url->link('module/shoppica_banners', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = $this->url->link('module/shoppica_banners', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

        $sets = $this->config->get('shoppica_banner_images');
        if (!empty($sets)) {
            $sets = unserialize($sets);
        } else {
            $sets = array();
        }
        $this->data['banners_sets'] = $sets;

        $this->data['modules'] = array();

        if (isset($this->request->post['shoppica_banners_module'])) {
            $this->data['modules'] = $this->request->post['shoppica_banners_module'];
        } elseif ($this->config->get('shoppica_banners_module')) {
            $this->data['modules'] = $this->config->get('shoppica_banners_module');
        }

        $this->load->model('design/layout');

        $this->data['layouts'] = $this->model_design_layout->getLayouts();

        $this->template = 'module/shoppica_banners.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );

        $this->response->setOutput($this->render());
    }

    public function listSets()
    {
        $language = $this->load->language('module/shoppica_banners');
        $this->data = array_merge($this->data, $language);

        $this->document->setTitle($this->language->get('heading_title'));

        $this->addBreadCrumbs();
        $this->data['breadcrumbs'][] = array(
            'text'      => 'Banner Sets',
            'href'      => $this->url->link('module/shoppica_banners/listSets', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $sets = $this->config->get('shoppica_banner_images');
        if (!empty($sets)) {
            $sets = unserialize($sets);
        } else {
            $sets = array();
        }

        $this->data['sets'] = $sets;

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }

        if (isset($this->session->data['error'])) {
            $this->error['warning'] = $this->session->data['error'];
            unset($this->session->data['error']);
        }

         if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->template = 'module/shoppica_banner_set_list.tpl';
        $this->children = array(
            'common/header',
            'common/footer',
        );

        $this->response->setOutput($this->render());
    }

    public function editSet()
    {
        $language = $this->load->language('module/shoppica_banners');
        $this->data = array_merge($this->data, $language);

        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->model('setting/setting');
        $this->load->model('shoppica/shoppica');
        $this->load->model('localisation/language');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
            //$this->model_shoppica_shoppica->editSettingGroup('shoppica', $this->request->post['shoppica']);
            if (isset($this->request->post['banner'])) {
                $this->saveBannerImagesVars($this->request->post['banner']);
            } else {
                $this->saveBannerImagesVars(array());
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect(HTTPS_SERVER . 'index.php?route=module/shoppica_banners/listSets&token=' . $this->session->data['token']);
        } else {
            if (isset($this->session->data['success'])) {
                $this->data['success'] = $this->session->data['success'];
                unset($this->session->data['success']);
            } else {
                $this->data['success'] = '';
            }

            if (isset($this->request->get['setId'])) {
                $setId = (string) $this->request->get['setId'];
            } else {
                $setId = uniqid();
            }
        }

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }

        $this->addBreadCrumbs();
        $this->data['breadcrumbs'][] = array(
            'text'      => 'Banner Sets',
            'href'      => $this->url->link('module/shoppica_banners/listSets', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['action'] = HTTPS_SERVER . 'index.php?route=module/shoppica_banners/editSet&token=' . $this->session->data['token'];
        $this->data['cancel'] = HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token'];
        $this->data['modify_theme'] = HTTPS_SERVER . 'index.php?route=module/shoppica/modifyTheme&token=' . $this->session->data['token'];
        $this->data['setId'] = $setId;
        $this->data['languages'] = $this->model_localisation_language->getLanguages();

        $this->setBannerImages($setId);

        $this->data['token'] = $this->session->data['token'];

        $vars = array('position', 'status', 'sort_order');
        $this->setVars($vars);

        $this->template = 'module/shoppica_banner_set.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
    }

    public function deleteSet()
    {
        if (isset($this->request->get['setId'])) {
            $setId = (string) $this->request->get['setId'];
        }

        if (empty($setId)) {

            return;
        }

        $modules = explode(',', $this->config->get('shoppica_banners_module'));
        foreach ($modules as $module) {
            if ($setId == $this->config->get('shoppica_banners_' . $module . '_setId')) {
                $this->session->data['error'] = 'You cannot delete this set as it is currently used in a layout!';

                $this->redirect($this->url->link('module/shoppica_banners/listSets', 'token=' . $this->session->data['token'], 'SSL'));
            }
        }

        $config = $this->config->get('shoppica_banner_images');
        if (!empty($config)) {
            $config = unserialize($config);
        } else {
            $config = array();
        }

        if (empty($config) || !isset($config[$setId])) {

            return;
        }

        unset($config[$setId]);
        $this->load->model('shoppica/shoppica');
        $this->model_shoppica_shoppica->editSetting('shoppica', 'shoppica_banner_images', serialize($config));

        $this->session->data['success'] = 'The baner set has been deleted!';

        $this->redirect($this->url->link('module/shoppica_banners/listSets', 'token=' . $this->session->data['token'], 'SSL'));
    }

    private function setBannerImages($setId)
    {
        $this->load->model('tool/image');
        $this->load->language('catalog/product');

        $images = $this->config->get('shoppica_banner_images');
        if (!empty($images)) {
            $images = unserialize($images);
        } else {
            $images = array();
        }

        $languages = $this->data['languages'];
        if (!empty($images) && isset($images[$setId])) {
            $name = $images[$setId]['name'];

            if (!isset($images[$setId]['images']['lang'])) {
                // Compatibility with sites which upgraded from 1.0.9 and didn't have multilingual banners
                $banner_images = array();
                foreach ($languages as $language) {
                    $banner_images[$language['language_id']] = $images[$setId]['images'];
                }
            } else {
                foreach ($languages as $language) {
                    if (!isset($images[$setId]['images']['lang'][$language['language_id']])) {
                        $images[$setId]['images']['lang'][$language['language_id']] = array();
                    }
                }
                $banner_images = $images[$setId]['images']['lang'];
            }

            foreach ($languages as $language) {
                foreach ($banner_images[$language['language_id']] as $key => &$values) {
                    if ($values['file'] && file_exists(DIR_IMAGE . $values['file'])) {
                        $values['preview'] = $this->model_tool_image->resize($values['file'], 110, 70);
                        if (!isset($values['new_window'])) {
                            $values['new_window'] = 0;
                        }
                    } else {
                        unset($images[$language['language_id']][$key]);
                    }
                }
            }

        } else {
            $banner_images = array();
            foreach ($languages as $language) {
                $banner_images[$language['language_id']] = array();
            }
            $name = '';
        }

        $this->data['text_image_manager'] = $this->language->get('text_image_manager');
        $this->data['banner_images'] = $banner_images;
        $this->data['name'] = $name;
        $this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
    }

    private function saveBannerImagesVars($form_data)
    {
        $config = array();
        if (isset($form_data['images']) && !empty($form_data['images']) && is_array($form_data['images'])) {
            foreach ($form_data['images'] as $language_id => $form_images) {
                if (!isset($form_data['images'][$language_id]) || empty($form_images) || !is_array($form_images)) {
                    $config[$language_id] = '';
                    continue;
                }

                $images = array();
                // Guess what I am trying to achieve :)
                $orders = array();
                foreach ($form_images as $key => $values) {
                    $order = (int) $values['order'];
                    $orders[] = $order;
                }
                sort($orders);

                $result = array();
                foreach ($form_images as $key => $values) {
                    $order = (int) $values['order'];
                    $key = array_search($order, $orders);
                    $result[$key] = $values;
                    unset($orders[$key]);
                }
                // Confused already ?
                ksort($result);

                foreach ($result as $key => $values) {
                    if (!empty($values['image'])) {
                        $images[$key]['order']      = $key + 1;
                        $images[$key]['file']       = $values['image'];
                        $images[$key]['new_window'] = isset($values['new_window']) ? 1 : 0;
                        $images[$key]['url']        = $values['url'];
                    }
                }

                $config[$language_id] = $images;
            }
        }

        $old_config = $this->config->get('shoppica_banner_images');
        if (!empty($old_config)) {
            $old_config = unserialize($old_config);
        } else {
            $old_config = array();
        }

        $old_config[$form_data['setId']]['setId']          = $form_data['setId'];
        $old_config[$form_data['setId']]['name']           = $form_data['name'];
        $old_config[$form_data['setId']]['images']['lang'] = $config;

        $this->model_shoppica_shoppica->editSetting('shoppica', 'shoppica_banner_images', serialize($old_config));
    }

    private function addBreadCrumbs()
    {
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=common/home&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );

        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=extension/module&token=' . $this->session->data['token'],
            'text'      => $this->language->get('text_module'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'href'      => HTTPS_SERVER . 'index.php?route=module/shoppica_banners&token=' . $this->session->data['token'],
            'text'      => $this->language->get('heading_title'),
            'separator' => ' :: '
        );
    }

    private function setVars($vars, $namespace = 'shoppica_banners')
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

    private function validate() {
        if (!$this->user->hasPermission('modify', 'module/shoppica_banners')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {

            return true;
        } else {

            return false;
        }
    }
}
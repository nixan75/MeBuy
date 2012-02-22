<?php
class ControllerModuleShoppicaBanners extends Controller
{
    public function index($setting)
    {
        if ($this->config->get('shoppica_status') == 0 || $this->config->get('config_template') != 'shoppica') {

            return;
        }

        $sets = $this->config->get('shoppica_banner_images');
        if (!empty($sets)) {
            $sets = unserialize($sets);
        } else {
            $sets = false;
        }

        $images = array();
        if (false !== $sets && isset($setting['setId'])) {
            $language_id = $this->document->shoppica_language['language_id'];
            if (isset($sets[$setting['setId']]['images']['lang'])) {
                if (isset($sets[$setting['setId']]['images']['lang'][$language_id])) {
                    $images = (array) $sets[$setting['setId']]['images']['lang'][$language_id];
                }
            } else {
                // Compatibility with old, non-multilingual format
                $images = (array) $sets[$setting['setId']]['images'];
            }

            foreach($images as &$image) {
                if (!isset($image['new_window'])) {
                    $image['new_window'] = 0;
                }
            }
        }
        $this->data['images'] = $images;

        $this->id = 'shoppica_banners';

        $this->template = $this->config->get('config_template') . '/template/module/shoppica_banner_images_home.tpl';
        $this->render();
    }
}

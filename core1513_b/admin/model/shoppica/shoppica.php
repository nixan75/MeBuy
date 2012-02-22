<?php
class ModelShoppicaShoppica extends Model
{
    public function getCategories($parent_id = 0)
    {
        $category_data = $this->cache->get('category.' . $parent_id . '.' . $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id'));

        if (!$category_data && !is_array($category_data)) {
            $sql = "SELECT *
                    FROM "      . DB_PREFIX . "category c
                    LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)
                    LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id)
                    WHERE c.parent_id = '" . (int) $parent_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  AND c.status = '1' AND c.sort_order <> '-1'
                    ORDER BY c.sort_order, LCASE(cd.name)";
            $query = $this->db->query($sql);
            $category_data = $query->rows;

            $this->cache->set('category.' . $parent_id . '.' . $this->config->get('config_language_id') . '.' . (int) $this->config->get('config_store_id'), $category_data);
        }

        return $category_data;
    }

    public function getProducts($data = array(), $added_ids = array())
    {
        if ($data) {
            $added_ids[] = 0;
            $sql = "SELECT IF( p.product_id IN ( " . implode(',', (array) $added_ids) . " ) ,  '1',  '0' ) AS added, p . * , pd . *
                    FROM " . DB_PREFIX . "product p
                    LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
                    WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";

            if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
                $sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(strtolower($data['filter_name'])) . "%'";
            }

            if (isset($data['filter_model']) && !is_null($data['filter_model'])) {
                $sql .= " AND LCASE(p.model) LIKE '%" . $this->db->escape(strtolower($data['filter_model'])) . "%'";
            }

            if (isset($data['filter_price']) && !is_null($data['filter_price'])) {
                $sql .= " AND LCASE(p.price) LIKE '" . $this->db->escape(strtolower($data['filter_price'])) . "%'";
            }

            $sort_data = array(
                'pd.name',
                'p.model',
                'p.price',
                'p.sort_order',
                'added'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY pd.name";
            }

            if (isset($data['order']) && ($data['order'] == 'DESC')) {
                $sql .= " DESC";
            } else {
                $sql .= " ASC";
            }

            if (isset($data['start']) || isset($data['limit'])) {
                if ($data['start'] < 0) {
                    $data['start'] = 0;
                }

                if ($data['limit'] < 1) {
                    $data['limit'] = 20;
                }

                $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
            }

            $query = $this->db->query($sql);

            return $query->rows;
        } else {
            $product_data = $this->cache->get('product.' . $this->config->get('config_language_id'));

            if (!$product_data) {
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY pd.name ASC");

                $product_data = $query->rows;

                $this->cache->set('product.' . $this->config->get('config_language_id'), $product_data);
            }

            return $product_data;
        }
    }

    public function editSetting($group, $key, $value)
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "setting
                          WHERE `group` = 'shoppica' AND `key` = '{$key}'");
        $this->db->query("INSERT INTO " . DB_PREFIX . "setting
                          SET `group` = 'shoppica', `key` = '{$key}', `value` = '" . $this->db->escape($value) . "'");
    }

    public function editSettingGroup($group, $form_data)
    {
        foreach ($form_data as $key => $value) {
            $this->editSetting($group, $key, $value);
        }
    }

    public function getCurrentLanguage()
    {
        $this->load->model('localisation/language');
        
        $languages = $this->model_localisation_language->getLanguages();
        foreach ($languages as $language) {
            if ($language['code'] == $this->session->data['language']) {

                return $language;
            }
        }
    }
}
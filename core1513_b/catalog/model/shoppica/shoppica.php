<?php
require_once dirname(__FILE__) . '/utils.php';

class ModelShoppicaShoppica extends Model
{
    private $_color_themes = array(
        'theme1' => array(
            'main_color'             => '4cb1ca',
            'secondary_color'        => 'f12b63',
            'intro_color'            => 'e6f6fa',
            'intro_text_color'       => '103e47',
            'intro_title_color'      => '4cb1ca',
            'price_color'            => '4cb1ca',
            'price_text_color'       => 'ffffff',
            'promo_price_color'      => 'f12b63',
            'promo_price_text_color' => 'ffffff',
            'background_color'       => 'edf3f5',
            'texture'                => 'texture_3'
        ),
        'theme2' => array(
            'main_color'             => '71b013',
            'secondary_color'        => 'ff9900',
            'intro_color'            => 'dcf5ce',
            'intro_text_color'       => '385217',
            'intro_title_color'      => '65a819',
            'price_color'            => 'bfe388',
            'price_text_color'       => '395215',
            'promo_price_color'      => 'ff9900',
            'promo_price_text_color' => 'ffffff',
            'background_color'       => 'f9fff2',
            'texture'                => 'texture_2'
        ),
        'theme3' => array(
            'main_color'             => 'ff8c00',
            'secondary_color'        => '40aebd',
            'intro_color'            => 'ffecc7',
            'intro_text_color'       => '574324',
            'intro_title_color'      => 'f27100',
            'price_color'            => 'f5c275',
            'price_text_color'       => '4d3b17',
            'promo_price_color'      => '40aebd',
            'promo_price_text_color' => 'ffffff',
            'background_color'       => 'fffceb',
            'texture'                => 'texture_1'
        ),
        'theme4' => array(
            'main_color'             => 'b3a97d',
            'secondary_color'        => '4cb1ca',
            'intro_color'            => 'f0eddf',
            'intro_text_color'       => '8a8577',
            'intro_title_color'      => '7a7153',
            'price_color'            => 'e3dcbf',
            'price_text_color'       => '4d4938',
            'promo_price_color'      => '4cb1ca',
            'promo_price_text_color' => 'ffffff',
            'background_color'       => 'f7f5ef',
            'texture'                => 'texture_1'
        )
    );

    private $_theme_name;
    private $_namespace;

    private $_theme_names = array(
        'theme1' => 'Blue',
        'theme2' => 'Green',
        'theme3' => 'Orange',
        'theme4' => 'Tan'
    );

    public function setThemeName($theme_name)
    {
        $this->_theme_name = $theme_name;
    }

    public function setNamespace($namespace)
    {
        $this->_namespace = $namespace;
    }

    public function getUser($user_id)
    {
        $user_table = '`' . DB_PREFIX . 'user`';
        $user_group_table = '`' . DB_PREFIX . 'user_group`';
        $sql = "SELECT *
                FROM $user_table AS u
                INNER JOIN $user_group_table AS ug ON u.user_group_id  = ug.user_group_id
                WHERE user_id = '" . (int) $user_id . "'";
        $query = $this->db->query($sql);
        if ($query->num_rows > 0) {
            $query->row['permission'] = unserialize($query->row['permission']);
        }

        return $query->row;
    }

    public function getThemeNames()
    {
        return $this->_theme_names;
    }

    public function getColorThemes()
    {
        return $this->_color_themes;
    }

    public function saveModifiedTheme($data)
    {
        $key = 'modify_theme_' . $this->db->escape($data['path']);

        $config = $this->config->get($key);
        if (!empty($config)) {
            $config = unserialize($config);
        } else {
            $config = array();
        }

        $data = array_merge((array) $config, $data);

        $this->db->query('DELETE FROM ' . DB_PREFIX . "setting WHERE `group` = 'shoppica' AND `key` = '{$key}'");
        $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET `group` = 'shoppica', `key` = '{$key}', `value` = '" . $this->db->escape(serialize($data)) . "'");

        $this->cache->delete('shoppica_modify_theme_config');
    }

    public function getModifyThemeConfig()
    {
        $result = $this->cache->get('shoppica_modify_theme_config');
        if (empty($result)) {
            $query = $this->db->query('SELECT * FROM ' . DB_PREFIX . "setting WHERE `group` = 'shoppica' AND `key` LIKE 'modify_theme_%'");

            $result = array();
            foreach ($query->rows as $setting) {
                $value = unserialize($setting['value']);
                $result[$value['path']] = $value;
            }

            $this->cache->set('shoppica_modify_theme_config', $result);
        }

        return $result;
    }

    public function getStylesFile($path = null)
    {
        $config = $this->getCascadeConfig($path);

        $backgrounds = unserialize($this->config->get('shoppica_background'));
        if (empty($backgrounds)) {
            $backgrounds = array();
        }
        if (isset($backgrounds[$config['theme_colors']['texture']])) {
            $background = $backgrounds[$config['theme_colors']['texture']];
            $config['theme_colors']['texture_image']      = 'image/' . $background['image'];
            $config['theme_colors']['texture_repeat']     = $background['repeat'];
            $config['theme_colors']['texture_position']   = $background['position'];
            $config['theme_colors']['texture_attachment'] = $background['attachment'];
        } else {
            if ($config['theme_colors']['texture'] != 'no_texture') {
                $config['theme_colors']['texture_image'] = 'catalog/view/theme/' . $this->_theme_name . '/images/' . $config['theme_colors']['texture'] . '.png';
            } else {
                $config['theme_colors']['texture_image'] = 'none';
            }

            $config['theme_colors']['texture_repeat']     = 'repeat';
            $config['theme_colors']['texture_position']   = 'top left';
            $config['theme_colors']['texture_attachment'] = 'scroll';
        }

        $tpl = DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/shoppica_modify_theme.css.tpl';
        $string = file_get_contents($tpl);
        foreach ($config['theme_colors'] as $key => $value) {
            if (!is_array($value)) {
                $string = str_replace("%{$key}%", $value, $string);
            }
        }

        return str_replace("\r\n", '', $string);
    }

    public function getCascadeConfig($path = null)
    {
        static $result =array();

        if(empty($path)) {
            $path = '0';
        } else {
            settype($path, 'string');
        }

        if (!empty($result[$path])) {

            return $result[$path];
        }

        $ipath = $path;
        if ($path != '0') {
            $path = '0_' . $path;
        }

        $config = $this->getModifyThemeConfig();
        $vars = array();

        $parts = explode('_', $path);
        for ($i = 0, $j = count($parts); $i < $j; $i++) {
            if ($path != '0') {
                $path = substr($path, 2);
            }
            if (isset($config[$path]) && isset($config[$path]['predefined_theme']) && $config[$path]['predefined_theme'] != 'parent') {
                if ($config[$path]['predefined_theme'] == 'custom') {
                    $vars = $config[$path];

                    break;
                }
                if (in_array($config[$path]['predefined_theme'], array_keys($this->_color_themes))) {
                    $config[$path]['theme_colors'] = $this->_color_themes[$config[$path]['predefined_theme']];
                    $vars = $config[$path];

                    break;
                }
            }
            $path = implode('_', array_slice($parts, 0, $j-$i-1));
        }

        if (empty($vars)) {
            $vars['path']             = '0';
            $vars['is_parent']        = '1';
            $vars['predefined_theme'] = 'theme1';
            $vars['parent_theme']     = 'theme1';
            $vars['theme_colors']     = $this->_color_themes['theme1'];
            $vars['parent_vars']      = array();
            $vars['parent_vars']['theme_colors']  = $this->_color_themes['theme1'];
        } else {

            if ($vars['path'] != $ipath) {
                // Parent config
                $vars['is_parent'] = '1';
                $vars['parent_theme'] = $vars['predefined_theme'];
                $copy_vars = $vars;
                $vars['parent_vars']  = $copy_vars;

            } else {
                // Direct hit, a configuration exists for the initial path
                $vars['is_parent'] = '0';
                if ($path != '0') {
                    array_pop($parts);
                    array_shift($parts);
                    $parent_vars = $this->getCascadeConfig(implode('_', $parts));
                    $vars['parent_theme'] = $parent_vars['predefined_theme'];
                    $vars['parent_vars']  = $parent_vars;
                } else {
                    $vars['parent_vars']  = array();
                    $vars['parent_vars']['theme_colors']  = array();
                }
            }
        }

        $result[$ipath] = $vars;

        return $vars;
    }

    public function getCascadeConfigIntroBanner($path = null)
    {
        static $result =array();

        if(empty($path)) {
            $path = '0';
        } else {
            settype($path, 'string');
        }

        if (!empty($result[$path])) {

            return $result[$path];
        }

        if ($path != '0') {
            $path = '0_' . $path;
        }
        $config = $this->getModifyThemeConfig();
        $vars = array();
        $parts = explode('_', $path);

        for ($i = 0, $j = count($parts); $i < $j; $i++) {
            if ($path != '0') {
                $path = substr($path, 2);
            }
            if (!isset($config[$path]) || !isset($config[$path]['intro_banner_type']) || $config[$path]['intro_banner_type'] != 'parent') {
                if (isset($config[$path]['intro_banner_type'])) {
                    $vars = $config[$path];
                }

                break;
            }
            $path = implode('_', array_slice($parts, 0, $j-$i-1));
        }

        if (empty($vars)) {
            $vars['intro_banner_type'] = 'nobanner';
        }

        return $vars;
    }

    public function getManufacturersByCategory($category_ids)
    {
        $manufacturers = $this->cache->get('manufacturers.' . (int) $this->config->get('config_store_id') . implode('_', $category_ids));
        $manufacturers = false;
        if (!$manufacturers) {
            $sql = "SELECT DISTINCT(m.manufacturer_id), m.*
                    FROM "       . DB_PREFIX . "manufacturer m
                    LEFT JOIN "  . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id)
                    INNER JOIN " . DB_PREFIX . "product AS p ON m.manufacturer_id = p.manufacturer_id
                    INNER JOIN " . DB_PREFIX . "product_to_category AS p2c ON p.product_id = p2c.product_id
                    WHERE m2s.store_id = '" . (int) $this->config->get('config_store_id') . "'
                          AND p2c.category_id IN (" . implode(',', $category_ids) . ")
                    ORDER BY m.sort_order, LCASE(m.name) ASC";
            $query = $this->db->query($sql);
            $manufacturers = $query->rows;

            //$this->cache->set('shoppica_manufacturers_by_category.' . (int) $this->config->get('config_store_id') . implode('_', $category_ids));
        }

        return $manufacturers;
    }

    public function getManufacturersByCategoryWithProductsCount($category_ids)
    {
        $manufacturers = $this->cache->get('manufacturers.' . (int) $this->config->get('config_store_id') . implode('_', $category_ids));
        $manufacturers = false;
        $store_id = (int) $this->config->get('config_store_id');

        if (!$manufacturers) {
            $sql = "SELECT m.manufacturer_id, m.name, COUNT(*) AS products_count FROM (
                      SELECT DISTINCT (p.product_id), m. *
                      FROM "       . DB_PREFIX . "manufacturer m
                      LEFT JOIN "  . DB_PREFIX . "manufacturer_to_store m2s ON ( m.manufacturer_id = m2s.manufacturer_id )
                      INNER JOIN " . DB_PREFIX . "product AS p ON m.manufacturer_id = p.manufacturer_id
                      LEFT JOIN "  . DB_PREFIX . "product_to_store AS p2s ON p.product_id = p2s.product_id
                      INNER JOIN " . DB_PREFIX . "product_to_category AS p2c ON p.product_id = p2c.product_id
                      LEFT JOIN "  . DB_PREFIX . "category_to_store AS c2s ON p2c.category_id = c2s.category_id
                      WHERE m2s.store_id = '" . $store_id . "' AND
                            p2s.store_id = '" . $store_id . "' AND
                            c2s.store_id = '" . $store_id . "' AND
                            p2c.category_id IN (" . implode(',', $category_ids) . ")
                    ) AS m
                    GROUP BY m.manufacturer_id
                    ORDER BY m.sort_order, LCASE(m.name) ASC";
            $query = $this->db->query($sql);
            $manufacturers = $query->rows;

            //$this->cache->set('shoppica_manufacturers_by_category_with_products_count.' . (int) $this->config->get('config_store_id') . implode('_', $category_ids));
        }

        return $manufacturers;
    }

    public function getCategoriesWithProducts($parent_id = 0)
    {
        $category_data = $this->cache->get('category_products.' . $parent_id . '.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'));

        if (!$category_data && !is_array($category_data)) {
            $sql = "SELECT DISTINCT(c.category_id), c.*, cd.*
                    FROM "       . DB_PREFIX . "category c
                    LEFT JOIN "  . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)
                    LEFT JOIN "  . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id)
                    INNER JOIN " . DB_PREFIX . "product_to_category AS p2c ON c.category_id = p2c.category_id
                    WHERE c.parent_id = '" . (int) $parent_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int) $this->config->get('config_store_id') . "'  AND c.status = '1' AND c.sort_order <> '-1'
                    ORDER BY c.sort_order, LCASE(cd.name)";
            $query = $this->db->query($sql);

            $category_data = $query->rows;

            //$this->cache->set('category_products.' . $parent_id . '.' . $this->config->get('config_language_id') . '.' . (int)$this->config->get('config_store_id'), $category_data);
        }

        return $category_data;
    }

    public function getTotalProductsByManufacturerAndCategory($manufacturer_id, $category_id)
    {
        $this->load->model('catalog/category');
        $ids = array_merge((array) $category_id, $this->getCategoriesByParent($category_id));
        $sql = "SELECT COUNT(DISTINCT(p.product_id)) AS total
                FROM "       . DB_PREFIX . "product AS p
                INNER JOIN " . DB_PREFIX . "product_to_category AS p2c ON p2c.product_id = p.product_id AND p2c.category_id IN(" . implode(',', $ids) . ")
                LEFT JOIN "  . DB_PREFIX . "product_to_store p2s ON p.product_id = p2s.product_id
                WHERE p.status = '1' AND p.date_available <= NOW() AND p.manufacturer_id = '" . (int) $manufacturer_id . "'";
        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getProductsByManufacturerAndCategory($manufacturer_id, $category_id, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20)
    {
        $this->load->model('catalog/category');
        $ids = array_merge((array) $category_id, $this->getCategoriesByParent($category_id));

    if ($this->customer->isLogged()) {
      $customer_group_id = (int) $this->customer->getCustomerGroupId();
    } else {
      $customer_group_id = (int) $this->config->get('config_customer_group_id');
    }

        $sql = "SELECT DISTINCT(p.product_id), p.image, p.price, p.tax_class_id, p.model, p.quantity, p.date_available,
                       pd.name, pd.name, pd.description, pd.meta_description,
                       m.manufacturer_id, m.name AS manufacturer,
                       (SELECT price
                        FROM " . DB_PREFIX . "product_discount AS pd2
                        WHERE pd2.product_id = p.product_id
                            AND pd2.customer_group_id = '" . $customer_group_id . "'
                            AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW())
                            AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW()))
                        ORDER BY pd2.priority ASC, pd2.price ASC
                        LIMIT 1) AS discount,
                        (SELECT price
                         FROM " . DB_PREFIX . "product_special AS ps
                         WHERE ps.product_id = p.product_id
                            AND ps.customer_group_id = '" . $customer_group_id . "'
                            AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW())
                            AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))
                         ORDER BY ps.priority ASC, ps.price ASC
                         LIMIT 1) AS special,
                        (SELECT AVG(rating) AS total
                         FROM " . DB_PREFIX . "review r1
                         WHERE r1.product_id = p.product_id AND r1.status = '1'
                         GROUP BY r1.product_id) AS rating
                FROM "       . DB_PREFIX . "product p
                INNER JOIN " . DB_PREFIX . "product_to_category AS p2c ON p2c.product_id = p.product_id AND p2c.category_id IN(" . implode(',', $ids) . ")
                LEFT JOIN "  . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)
                LEFT JOIN "  . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id)
                LEFT JOIN "  . DB_PREFIX . "manufacturer m ON (p.manufacturer_id = m.manufacturer_id)
                LEFT JOIN "  . DB_PREFIX . "stock_status ss ON (p.stock_status_id = ss.stock_status_id) AND ss.language_id = '" .    (int) $this->config->get('config_language_id') . "'
                WHERE p.status = '1'
                      AND p.date_available <= NOW()
                      AND pd.language_id = '" .    (int) $this->config->get('config_language_id') . "'
                      AND p2s.store_id = '" .      (int) $this->config->get('config_store_id') . "'
                      AND m.manufacturer_id = '" . (int) $manufacturer_id. "'";

        $sort_data = array(
            'pd.name',
            'p.sort_order',
            'special',
            'rating',
            'p.price',
            'p.model'
        );

        if (in_array($sort, $sort_data)) {
            if ($sort == 'pd.name' || $sort == 'p.model') {
                $sql .= " ORDER BY LCASE(" . $sort . ")";
            } else {
                $sql .= " ORDER BY " . $sort;
            }
        } else {
            $sql .= " ORDER BY p.sort_order";
        }

        if ($order == 'DESC') {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
        }

        if ($start < 0) {
            $start = 0;
        }

        $sql .= " LIMIT " . (int)$start . "," . (int)$limit;

        $query = $this->db->query($sql);

        return $query->rows;
    }

    public function getCategoriesByParent($parent_id, $current_path = '')
    {
        $ids = array();
        $results = $this->model_catalog_category->getCategories($parent_id);

        foreach ($results as $result) {
            if (!$current_path) {
                $new_path = $result['category_id'];
            } else {
                $new_path = $current_path . '_' . $result['category_id'];
            }

            $ids[] = $result['category_id'];
            $children = $this->getCategoriesByParent($result['category_id'], $new_path);
            $ids = array_merge_recursive($ids, $children);
        }

        return $ids;
    }

    public function addDescriptionsToProducts($products)
    {
        $ids = array();
        foreach ($products as $product) {
            if (isset($product['product_id'])) {
                $ids[] = $product['product_id'];
            }
        }

        if (!empty($ids)) {
            $ids = implode(',', $ids);
            $sql = 'SELECT product_id, description, meta_description
                    FROM ' . DB_PREFIX . 'product_description
                    WHERE product_id IN (' . $ids . ')
                          AND language_id = ' . (int) $this->config->get('config_language_id');
            $query = $this->db->query($sql);

            $descriptions = array();
            foreach ($query->rows as $description) {
                if (!empty($description['meta_description'])) {
                    $descriptions[$description['product_id']] = $description['meta_description'];
                } else {
                    $descriptions[$description['product_id']] = strip_tags(html_entity_decode($description['description'], ENT_QUOTES, 'UTF-8'));
                }
            }
            foreach ($products as &$product) {
                $product['description'] = $descriptions[$product['product_id']];
            }
        }

        return $products;
    }

    public function getProductsById($product_ids)
    {
        $ids = (array) $product_ids;
        if (empty($ids)) {

            return false;
        }

    if ($this->customer->isLogged()) {
      $customer_group_id = (int) $this->customer->getCustomerGroupId();
    } else {
      $customer_group_id = (int) $this->config->get('config_customer_group_id');
    }

        $ids = implode(',', $ids);
        $sql = "SELECT p.product_id, p.image, p.price, p.tax_class_id, p.model, p.quantity, p.date_available,
                       pd.name, pd.name, pd.description, pd.meta_description,
                       m.name AS manufacturer,
                       (SELECT price
                        FROM " . DB_PREFIX . "product_discount AS pd2
                        WHERE pd2.product_id = p.product_id
                            AND pd2.customer_group_id = '" . $customer_group_id . "'
                            AND pd2.quantity = '1' AND ((pd2.date_start = '0000-00-00' OR pd2.date_start < NOW())
                            AND (pd2.date_end = '0000-00-00' OR pd2.date_end > NOW()))
                        ORDER BY pd2.priority ASC, pd2.price ASC
                        LIMIT 1) AS discount,
                        (SELECT price
                         FROM " . DB_PREFIX . "product_special AS ps
                         WHERE ps.product_id = p.product_id
                            AND ps.customer_group_id = '" . $customer_group_id . "'
                            AND ((ps.date_start = '0000-00-00' OR ps.date_start < NOW())
                            AND (ps.date_end = '0000-00-00' OR ps.date_end > NOW()))
                         ORDER BY ps.priority ASC, ps.price ASC
                         LIMIT 1) AS special,
                        (SELECT AVG(rating) AS total
                         FROM " . DB_PREFIX . "review r1
                         WHERE r1.product_id = p.product_id
                            AND r1.status = '1'
                            GROUP BY r1.product_id) AS rating
                FROM "       . DB_PREFIX . 'product AS p
                INNER JOIN ' . DB_PREFIX . 'product_description AS pd ON p.product_id = pd.product_id
                INNER JOIN ' . DB_PREFIX . 'product_to_store p2s ON p.product_id = p2s.product_id
                LEFT JOIN '  . DB_PREFIX . 'manufacturer AS m ON (p.manufacturer_id = m.manufacturer_id)
                WHERE p.product_id IN (' . $ids . ')
                      AND pd.language_id = ' . (int) $this->config->get('config_language_id') . '
                      AND p.status = 1
                      AND p.date_available <= NOW()
                      AND p2s.store_id = ' . (int) $this->config->get('config_store_id');
        $query = $this->db->query($sql);

        if (!$query->num_rows) {

            return false;
        }

        $result = array();
        foreach ($query->rows as $row) {
            $product = array(
        'product_id'       => $row['product_id'],
        'name'             => $row['name'],
        'description'      => $row['description'],
        'meta_description' => $row['meta_description'],
        'model'            => $row['model'],
        'quantity'         => $row['quantity'],
        'image'            => $row['image'],
        'manufacturer'     => $row['manufacturer'],
        'price'            => ($row['discount'] ? $row['discount'] : $row['price']),
        'special'          => $row['special'],
        'tax_class_id'     => $row['tax_class_id'],
        'date_available'   => $row['date_available'],
        'rating'           => (int) $row['rating']
            );
            $result[] = $product;
        }

        return $result;
    }

    public function fetchTemplate($filename, $data)
    {
        $file = DIR_TEMPLATE . $filename;

        if (file_exists($file)) {
            extract($data);

            ob_start();

            require($file);

            $content = ob_get_contents();

            ob_end_clean();

            return $content;
        } else {

            exit('Error: Could not load template ' . $file . '!');
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


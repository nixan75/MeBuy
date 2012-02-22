<?php

class ControllerProductShoppica extends Controller
{
    public function index()
    {
        $this->language->load('product/category');
        $this->language->load('product/manufacturer');
        $this->language->load('product/compare');

        $this->load->model('catalog/manufacturer');
        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('catalog/review');
        $this->load->model('shoppica/shoppica');
        $this->load->model('tool/image');

        $this->data['breadcrumbs'] = array();
        $this->data['breadcrumbs'][] = array(
            'href'      => $this->url->link('common/home'),
            'text'      => $this->language->get('text_home'),
            'separator' => FALSE
        );

        $category_id = 0;
        if (isset($this->request->get['c_path'])) {
            $category_id = (int) $this->request->get['c_path'];
        }

        $manufacturer_id = 0;
        if (isset($this->request->get['man_id'])) {
            $manufacturer_id = (int) $this->request->get['man_id'];
        }

        $category_info = $this->model_catalog_category->getCategory($category_id);

        if (!$category_info || $category_id == 0 || $manufacturer_id == 0) {

            return $this->showErrorProductsByManufacturerAndCategory();
        }

        $this->data['breadcrumbs'][] = array(
            'href'      => $this->url->link('product/category', 'path=' . $category_id),
            'text'      => $category_info['name'],
            'separator' => $this->language->get('text_separator')
        );

        $this->document->setTitle($category_info['name']);
        $this->document->setDescription($category_info['meta_description']);
        $this->document->setKeywords($category_info['meta_keyword']);

        $this->data['text_sort']       = $this->language->get('text_sort');
        $this->data['text_error']      = $this->language->get('text_empty');
        $this->data['text_limit']      = $this->language->get('text_limit');
        $this->data['button_cart']     = $this->language->get('button_cart');
        $this->data['button_wishlist'] = $this->language->get('button_wishlist');
        $this->data['button_compare']  = $this->language->get('button_compare');
        $this->data['button_continue'] = $this->language->get('button_continue');

        $manufacturer_info = $this->model_catalog_manufacturer->getManufacturer($manufacturer_id);

        $this->data['category_name']     = $category_info['name'];
        $this->data['manufacturer_name'] = $manufacturer_info['name'];
        $this->data['text_compare']      = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
        $this->data['compare']           = $this->url->link('product/compare');

        $this->data['breadcrumbs'][] = array(
            'href'      => html_entity_decode($_SERVER['REQUEST_URI']),
            'text'      => $manufacturer_info['name'],
            'separator' => $this->language->get('text_separator')
        );

        $this->data['thumb'] = '';
        if ($manufacturer_info['image']) {
            $this->data['thumb'] = $this->model_tool_image->resize($manufacturer_info['image'], 80, 80);
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'p.sort_order';
        }

        if (isset($this->request->get['order'])) {
            $order = $this->request->get['order'];
        } else {
            $order = 'ASC';
        }

        if (isset($this->request->get['page'])) {
            $page = $this->request->get['page'];
        } else {
            $page = 1;
        }

        if (isset($this->request->get['limit'])) {
            $limit = $this->request->get['limit'];
        } else {
            $limit = $this->config->get('config_catalog_limit');
        }
        $start = ($page - 1) * $limit;

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $product_total = $this->model_shoppica_shoppica->getTotalProductsByManufacturerAndCategory($manufacturer_id, $category_id);

        $this->data['products'] = array();

        $results = $this->model_shoppica_shoppica->getProductsByManufacturerAndCategory($manufacturer_id, $category_id, $sort, $order, $start, $limit);

        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
            } else {
                $image = false;
            }

            if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $price = false;
            }

            if ((float)$result['special']) {
                $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
            } else {
                $special = false;
            }

            if ($this->config->get('config_tax')) {
                $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
            } else {
                $tax = false;
            }

            if ($this->config->get('config_review_status')) {
                $rating = (int) $result['rating'];
            } else {
                $rating = false;
            }

            $this->data['products'][] = array(
                'product_id'  => $result['product_id'],
                'thumb'       => $image,
                'name'        => $result['name'],
                'description' => substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 100) . '..',
                'price'       => $price,
                'special'     => $special,
                'tax'         => $tax,
                'rating'      => $rating,
                'href'        => $this->url->link('product/product', $url . '&manufacturer_id=' . $result['manufacturer_id'] . '&product_id=' . $result['product_id'])
            );
        }

        $url = '';

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $this->data['sorts'] = array();

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_default'),
            'value' => 'p.sort_order-ASC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=p.sort_order&order=ASC&c_path=' . $category_id . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_name_asc'),
            'value' => 'pd.name-ASC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=pd.name&order=ASC&c_path=' . $category_id  . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_name_desc'),
            'value' => 'pd.name-DESC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=pd.name&order=DESC&c_path=' . $category_id . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_price_asc'),
            'value' => 'p.price-ASC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=p.price&order=ASC&c_path=' . $category_id . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_price_desc'),
            'value' => 'p.price-DESC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=p.price&order=DESC&c_path=' . $category_id . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_rating_desc'),
            'value' => 'rating-DESC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=rating&order=DESC&c_path=' . $category_id . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_rating_asc'),
            'value' => 'rating-ASC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=rating&order=ASC&c_path=' . $category_id . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_model_asc'),
            'value' => 'p.model-ASC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=p.model&order=ASC&c_path=' . $category_id . $url)
        );

        $this->data['sorts'][] = array(
            'text'  => $this->language->get('text_model_desc'),
            'value' => 'p.model-DESC',
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&sort=p.model&order=DESC&c_path=' . $category_id . $url)
        );

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $this->data['limits'] = array();

        $this->data['limits'][] = array(
            'text'  => $this->config->get('config_catalog_limit'),
            'value' => $this->config->get('config_catalog_limit'),
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&c_path=' . $category_id . $url . '&limit=' . $this->config->get('config_catalog_limit'))
        );

        $this->data['limits'][] = array(
            'text'  => 25,
            'value' => 25,
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&c_path=' . $category_id . $url . '&limit=25')
        );

        $this->data['limits'][] = array(
            'text'  => 50,
            'value' => 50,
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&c_path=' . $category_id . $url . '&limit=50')
        );

        $this->data['limits'][] = array(
            'text'  => 75,
            'value' => 75,
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&c_path=' . $category_id . $url . '&limit=75')
        );

        $this->data['limits'][] = array(
            'text'  => 100,
            'value' => 100,
            'href'  => $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&c_path=' . $category_id . $url . '&limit=100')
        );

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['limit'])) {
            $url .= '&limit=' . $this->request->get['limit'];
        }

        $pagination = new Pagination();
        $pagination->total = $product_total;
        $pagination->page  = $page;
        $pagination->limit = $limit;
        $pagination->text  = $this->language->get('text_pagination');
        $pagination->url   = $this->url->link('product/shoppica', 'man_id=' . $manufacturer_id . '&c_path=' . $category_id .  $url . '&page={page}');

        $this->data['pagination'] = $pagination->render();

        $this->data['sort'] = $sort;
        $this->data['order'] = $order;
        $this->data['limit'] = $limit;

        $this->data['heading_title'] = sprintf($this->language->get('shoppica_brand_products'), $manufacturer_info['name'], $category_info['name']);

        $this->template = 'shoppica/template/product/shoppica_brand_category.tpl';

        $this->children = array(
            'common/column_left',
            'common/column_right',
            'common/content_top',
            'common/content_bottom',
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render());
    }

    private function showErrorProductsByManufacturerAndCategory()
    {
        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        if (isset($this->request->get['path'])) {
            $this->document->breadcrumbs[] = array(
                'href'      => $this->url->link('product/category', 'path=' . $category_id),
                'text'      => $this->language->get('text_error'),
                'separator' => $this->language->get('text_separator')
            );
        }

        $this->document->setTitle($this->language->get('text_error'));

        $this->data['heading_title']   = $this->language->get('text_error');
        $this->data['text_error']      = $this->language->get('text_error');
        $this->data['button_continue'] = $this->language->get('button_continue');

        $this->data['continue'] = HTTP_SERVER . 'index.php?route=common/home';

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
            $this->template = $this->config->get('config_template') . '/template/error/not_found.tpl';
        } else {
            $this->template = 'default/template/error/not_found.tpl';
        }

        $this->children = array(
            'common/column_right',
            'common/column_left',
            'common/footer',
            'common/header'
        );

        $this->response->setOutput($this->render(TRUE), $this->config->get('config_compression'));
    }
}
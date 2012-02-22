<?php
abstract class Controller {
    protected $registry;
    protected $id;
    protected $layout;
    protected $template;
    protected $children = array();
    protected $data = array();
    protected $output;

    public function __construct($registry) {
        $this->registry = $registry;
    }

    public function __get($key) {
        return $this->registry->get($key);
    }

    public function __set($key, $value) {
        $this->registry->set($key, $value);
    }

    protected function forward($route, $args = array()) {
        return new Action($route, $args);
    }

    protected function redirect($url, $status = 302) {
        header('Status: ' . $status);
        header('Location: ' . str_replace('&amp;', '&', $url));
        exit();
    }

    protected function getChild($child, $args = array()) {
        $action = new Action($child, $args);
        $file = $action->getFile();
        $class = $action->getClass();
        $method = $action->getMethod();

global $vqmod; $file = $vqmod->modCheck($file);
        if (file_exists($file)) {
            require_once($file);

            $controller = new $class($this->registry);

            if (substr($child, 0, 6) == 'module') {
                $controller->data['module_instance']  = $args;
                $controller->data['module_position']  = $args['position'];
                $controller->data['module_layout_id'] = $args['layout_id'];
            }

            $controller->$method($args);

            return $controller->output;
        } else {
            trigger_error('Error: Could not load controller ' . $child . '!');
            exit();
        }
    }

    protected function render() {
        foreach ($this->children as $child) {
            $this->data[basename($child)] = $this->getChild($child);
        }

        
		global $vqmod;
		$file = $vqmod->modCheck(DIR_TEMPLATE . $this->template);
		if (file_exists($file)) {
		
            extract($this->data);

            ob_start();

            require($file);

            $this->output = ob_get_contents();

            ob_end_clean();

            return $this->output;
        } else {
            trigger_error('Error: Could not load template ' . DIR_TEMPLATE . $this->template . '!');
            exit();
        }
    }
}
?>
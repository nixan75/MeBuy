<?php 
class ControllerTotalDesconto extends Controller { 
	private $error = array(); 
	 
	public function index() { 
		$this->load->language('total/desconto');
                
                $this->load->model('setting/setting');
                if (($this->request->server['REQUEST_METHOD'] == 'POST') && ($this->validate())) {
			$this->model_setting_setting->editSetting('desconto', $this->request->post);
		
			$this->session->data['success'] = $this->language->get('text_success');
			
			$this->redirect($this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'));
		}
                
		$this->document->setTitle($this->language->get('heading_title'));
		
                $this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
                
                $this->data['text_desc_porcentagem'] = $this->language->get('text_desc_porcentagem');
		$this->data['text_pgto'] = $this->language->get('text_pgto');
                $this->data['text_minimo'] = $this->language->get('text_minimo');
                $this->data['text_btn_delete'] = $this->language->get('text_btn_delete');
                $this->data['text_btn_add'] = $this->language->get('text_btn_add');
                
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
					
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
                
                
                if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

   		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_total'),
			'href'      => $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('total/desconto', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
                
		
                
                
                 /* Inicio trecho adicionado surgimento  
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
                 */ 
                $this->load->model('setting/extension');
			
                $pagamento = array(); 
		$results = $this->model_setting_extension->getInstalled('payment');
			
                foreach ($results as  $value) {
                        $this->load->language('payment/' . $value);
                        $pagamento[] = array(
                                    'name'       =>$this->language->get('heading_title'),
                                    'code'       =>$value
                        );
                }

                $this->data['pgtos'] = $pagamento;
                /* Fim trecho adicionado surgimento  
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
#######################################################################################################################################
                 */ 
		
		
		

 		
		$this->data['modules'] = array();
		
		if (isset($this->request->post['desconto_module'])) {
			$this->data['modules'] = $this->request->post['desconto_module'];
		} elseif ($this->config->get('desconto_module')) { 
			$this->data['modules'] = $this->config->get('desconto_module');
		}
                
		$this->data['action'] = $this->url->link('total/desconto', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['desconto_status'])) {
			$this->data['desconto_status'] = $this->request->post['desconto_status'];
		} else {
			$this->data['desconto_status'] = $this->config->get('desconto_status');
		}
                
                if (isset($this->request->post['porcentagem'])) {
			$this->data['porcentagem'] = $this->request->post['porcentagem'];
		} else {
			$this->data['porcentagem'] = $this->config->get('porcentagem');
		}
                if (isset($this->request->post['forma_status'])) {
			$this->data['forma_status'] = $this->request->post['forma_status'];
		} else {
			$this->data['forma_status'] = $this->config->get('forma_status');
		}
                

		if (isset($this->request->post['desconto_sort_order'])) {
			$this->data['desconto_sort_order'] = $this->request->post['desconto_sort_order'];
		} else {
			$this->data['desconto_sort_order'] = $this->config->get('desconto_sort_order');
		}
																		
		$this->template = 'total/desconto.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);
				
		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'total/desconto')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>
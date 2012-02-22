<?php
class ModelTotalDesconto extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		$this->load->language('total/desconto');
                $sub_total = $this->cart->getSubTotal();
                $dados = $this->config->get('desconto_module');
                if (isset($this->session->data['payment_method']['code'])){
                    foreach ($dados as $dado) { 
                        if ($dado["forma_status"]==$this->session->data['payment_method']['code']){      
                            if ($dado["minimo"]<$sub_total){
                                $porcentagem = $dado["porcentagem"];
                                $porcentagem_calc = $porcentagem/100;
                                $total_desconto = $sub_total*$porcentagem_calc;
                                $this->load->language('payment/' . $dado["forma_status"]);
                                $name = $this->language->get('text_title');
                            }    
                        }
                    }
                   
                    if (isset($porcentagem)){
                        $total_data[] = array(
                            'code'       => 'desconto',
                            'title'      => $this->language->get('text_desconto1')." <span style='color:#FF0000;'>".$porcentagem."%</span> ".$this->language->get('text_desconto2')." <span style='color:#FF0000;'>".$name."</span>" ,
                            'text'       => "<span style='color:#FF0000;'>- ".$this->currency->format(max(0, $total_desconto))."</span>",
                            'value'      => $total_desconto,
                            'sort_order' => $this->config->get('total_sort_order')
                        );
                        $total -= $total_desconto;
                    }
                }   
	}
}
?>
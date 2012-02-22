<?php
class ModelAccountCustomerTaxGroup extends Model {
	public function addCustomerTaxGroup($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "cust_tax_group SET name = '" . $this->db->escape($data['name']) . "'");
	}
	
	public function editCustomerTaxGroup($cust_tax_group_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "cust_tax_group SET name = '" . $this->db->escape($data['name']) . "' WHERE cust_tax_group_id = '" . (int)$cust_tax_group_id . "'");
	}
	
	public function deleteCustomerTaxGroup($cust_tax_group_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "cust_tax_group WHERE cust_tax_group_id = '" . (int)$cust_tax_group_id . "'");
//		$this->db->query("DELETE FROM " . DB_PREFIX . "product_discount WHERE cust_tax_group_id = '" . (int)$cust_tax_group_id . "'");
	}
	
	public function getCustomerTaxGroup($cust_tax_group_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "cust_tax_group WHERE cust_tax_group_id = '" . (int)$cust_tax_group_id . "'" . " AND enabled = '1' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		return $query->row;
	}
	
	public function getCustomerTaxGroups($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "cust_tax_group" . " WHERE enabled = '1' AND language_id = '" . (int)$this->config->get('config_language_id') . "'";
		
		$sql .= " ORDER BY cust_tax_group_id";	
			
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
	}
	
	public function getTotalCustomerTaxGroups() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "cust_tax_group" . " WHERE enabled = '1' AND language_id = '" . (int)$this->config->get('config_language_id') . "'");
		
		return $query->row['total'];
	}
}
?>
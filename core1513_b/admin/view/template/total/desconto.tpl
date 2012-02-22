<?php echo $header; ?>

<link rel="stylesheet" href="view/javascript/jquery/validator2.2/css/validationEngine.jquery.css" type="text/css"/>
<!--
<? if ($this->language->get('code')=="pt-br") {?>
<script src="view/javascript/jquery/validator2.2/languages/jquery.validationEngine-pt.js" type="text/javascript" charset="utf-8">
</script>
<?}else{ ?>
-->
 <script src="view/javascript/jquery/validator2.2/languages/jquery.validationEngine-en.js" type="text/javascript" charset="utf-8">
</script>   
<?}?>
<script src="view/javascript/jquery/validator2.2/jquery.validationEngine.js" type="text/javascript" charset="utf-8">
</script>
<script>
    jQuery(document).ready(function(){
        // binds form submission and fields to the validation engine
        jQuery("#form").validationEngine();
    });
</script>     

<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/total.png" alt="" /><?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="desconto_status">
                <?php if ($desconto_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr> 
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="desconto_sort_order" value="<?php echo $desconto_sort_order; ?>" size="1" /></td> 
          </tr>
        </table>
          
          
        <table id="module" class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $text_pgto; ?></td>
            <td class="left"><?php echo $text_desc_porcentagem; ?></td>
            <td class="left"><?php echo $text_minimo; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td class="left">
                <select name="desconto_module[<?php echo $module_row; ?>][forma_status]">
                <?php
                    foreach ($pgtos as $result) {
                        if ($module['forma_status']==$result["code"]){
                            echo '<option value="'.$result["code"].'" selected>'.$result["name"].'</option>';      
                        }else{
                            echo '<option value="'.$result["code"].'">'.$result["name"].'</option>'; 
                        }            
                    }
                ?>
              </select>
            </td>
            
            <td class="left"><input type="text" name="desconto_module[<?php echo $module_row; ?>][porcentagem]" class="validate[required,custom[integer],maxSize[3],max[100]]" id="porcentagem<?php echo $module_row; ?>" value="<?php echo $module['porcentagem']; ?>" size="3" /></td>
            <td class="left"><input type="text" name="desconto_module[<?php echo $module_row; ?>][minimo]" class="validate[required,custom[integer],maxSize[6]]" id="minimo<?php echo $module_row; ?>" value="<?php echo $module['minimo']; ?>" size="6" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $text_btn_delete; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan=3"></td>
            <td class="left"><a onclick="addModule();" class="button"><span><?php echo $text_btn_add; ?></span></a></td>
          </tr>
        </tfoot>
      </table>  
      </form>
    </div>
  </div>
</div>

<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';	
	html += '    <td class="left"><select name="desconto_module[' + module_row + '][forma_status]">';
	<?php foreach ($pgtos as $result) {?>
	html += '      <option value="<?php echo $result["code"]; ?>"><?php echo $result["name"]; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><input type="text" name="desconto_module[' + module_row + '][porcentagem]" class="validate[required,custom[integer],maxSize[3],max[100]" id="porcentagem' + module_row + '" value="" size="3" /></td>';
        html += '    <td class="left"><input type="text" name="desconto_module[' + module_row + '][minimo]" class="validate[required,custom[integer],maxSize[6]]" id="minimo' + module_row + '" value="0" size="6" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $text_btn_delete; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<?php echo $footer; ?>

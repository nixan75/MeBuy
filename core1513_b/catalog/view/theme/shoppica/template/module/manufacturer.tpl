<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>
  <?php require 'manufacturer_content.tpl'; ?>
<?php else: ?>
  <?php require 'manufacturer_column.tpl'; ?>
<?php endif; ?>

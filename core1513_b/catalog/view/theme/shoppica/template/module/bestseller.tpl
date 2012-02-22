<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>
  <?php require 'bestseller_content.tpl'; ?>
<?php else: ?>
  <?php require 'bestseller_column.tpl'; ?>
<?php endif; ?>
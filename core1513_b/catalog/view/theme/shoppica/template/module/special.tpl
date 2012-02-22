<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>
  <?php require 'special_content.tpl'; ?>
<?php else: ?>
  <?php require 'special_column.tpl'; ?>
<?php endif; ?>
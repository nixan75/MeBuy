<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>
  <?php require 'welcome_content.tpl'; ?>
<?php else: ?>
  <?php require 'welcome_column.tpl'; ?>
<?php endif; ?>
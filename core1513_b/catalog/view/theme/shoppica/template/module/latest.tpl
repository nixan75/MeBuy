<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>
  <?php require 'latest_content.tpl'; ?>
<?php else: ?>
  <?php require 'latest_column.tpl'; ?>
<?php endif; ?>

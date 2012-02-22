<?php if ($module_position == 'content_top' || $module_position == 'content_bottom'): ?>
  <?php require 'featured_content.tpl'; ?>
<?php else: ?>
  <?php require 'featured_column.tpl'; ?>
<?php endif; ?>

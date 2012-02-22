<div class="s_categories_module s_box">
  <h2><?php echo $heading_title; ?></h2>
  <div class="s_list_1">
    <ul>
      <?php foreach ($categories as $category): ?>
      <li>
        <?php if ($category['category_id'] == $category_id): ?>
        <a href="<?php echo $category['href']; ?>" class="active"><strong><?php echo $category['name']; ?></strong></a>
        <?php if ($category['children']): ?>
        <ul>
          <?php foreach ($category['children'] as $child): ?>
          <li>
          <?php if ($child['category_id'] == $child_id): ?>
            <a href="<?php echo $child['href']; ?>" class="active"><strong><?php echo $child['name']; ?></strong></a>
          <?php else: ?>
            <a href="<?php echo $child['href']; ?>"><?php echo $child['name']; ?></a>
          <?php endif; ?>
          </li>
          <?php endforeach; ?>
        </ul>
        <?php endif; ?>
        <?php else: ?>
        <a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
        <?php endif; ?>
      </li>
      <?php endforeach; ?>
    </ul>
  </div>
</div>

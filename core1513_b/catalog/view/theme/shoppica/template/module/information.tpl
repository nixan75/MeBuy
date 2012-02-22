<div id="information_module" class="s_box">
  <h2><?php echo $heading_title; ?></h2>
  <ul class="s_list_1">
    <?php foreach ($informations as $information): ?>
    <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
    <?php endforeach; ?>
    <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
    <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
  </ul>
</div>

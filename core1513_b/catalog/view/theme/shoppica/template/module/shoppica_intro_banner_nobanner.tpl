<div id="intro_wrap">
  <div class="container_12">
    <div id="breadcrumbs" class="grid_12">
      <?php foreach ($this->document->breadcrumbs as $breadcrumb) { ?>
      <?php echo $breadcrumb['separator']; ?><a href="<?php echo str_replace('&', '&amp;', $breadcrumb['href']); ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php } ?>
    </div>
    <h1><?php echo $heading_title; ?></h1>
  </div>
</div>
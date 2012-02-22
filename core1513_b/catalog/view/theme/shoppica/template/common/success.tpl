<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <div id="intro_wrap">
      <div class="container_12">
        <h1><?php echo $heading_title; ?></h1>
      </div>
    </div>
  </div>
  <!-- end of intro -->

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <div id="content" class="container_16">

    <div id="success_message" class="grid_16">

      <div class="s_mb_20"><?php echo $text_message; ?></div>

      <span class="clear s_mb_25"></span>

      <div class="s_submit s_mb_30 clearfix">
        <a class="s_button_1 s_main_color_bgr" href="<?php echo $continue; ?>"><span class="s_text"><?php echo $button_continue; ?></span></a>
      </div>
      
    </div>

  </div>
  <!-- end of CONTENT -->
  
<?php echo $footer; ?> 
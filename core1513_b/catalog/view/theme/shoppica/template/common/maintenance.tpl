<?php if (isset($this->document->in_maintenance)):?>
<?php echo $header;?> 
<?php else: ?>
<html>
<head>
<title>Under maintenance</title>
</head>
<body>
<?php endif; ?>
<style type="text/css">
  h1 {
    margin-bottom: 100px;
    line-height: 32px;
  }
  #currency_switcher {
    right: 10px;
  }
</style>

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <div id="content">
    <?php echo $message; ?>
  </div>
  <!-- end of CONTENT -->
<?php if (isset($this->document->in_maintenance)):?>
<?php echo $footer; ?>
<?php else: ?>
</body>
</html>
<?php endif; ?>
<html>
<head>
<title>Install Error</title>
</head>
<body>
  <div id="shoppica_install_error">
    <p style="
      z-index: 1100;
      position: fixed;
      top: 50%;
      left: 50%;
      width: 550px;
      height: 340px;
      margin: -250px 0 0 -305px;
      padding: 30px;
      line-height: 20px;
      color: #000;
      font-size: 14px;
      background: #fff;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
      -moz-box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
      -webkit-box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
      -o-box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
    "><strong style="display: block; text-align: center; margin-bottom: 15px; font-size: 18px; color: red;">Warning!</strong>
      You see this message due one (or more) of the following reasons:<br /><br />
      1. You have not enabled your 'Shoppica Theme CP' module. Please, go to admin panel, enter Extensions->Modules and change the status of 'Shoppica Theme CP' to `enabled`.
      <br />
      <br />
      2. You have not properly updated your index.php file. It should contain these two lines (near the end):
      <br />
      <br />
      <span style="display: block; padding: 4px 7px 5px 7px; font-family: Courier New; color: green; border: 1px solid #eee;">
      // Shoppica<br />
      $controller->addPreAction(new Action('module/shoppica/init'));
      </span>
      <br />
      <span style="display: block; line-height: 14px; font-size: 11px;color: #666;">For more information about the theme installation, please read carefully the <a style="color: blue;" href="http://shoppica.net/docs/index.html">Shoppica Extended Documentation</a>.
      <br />
      <br />
      If you think you've made everything according to the installation instructions and this message continues to appear, please contact the support.</span>
    </p>
    <span id="shoppica_install_error_overlay" style="z-index: 1000; position: fixed; display: block; width: 100%; height: 100%; background: #fff; opacity: 0.9;"></span>
  </div>
</body>
</html>
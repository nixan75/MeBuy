<?php echo $header; ?>

  <!-- ---------------------- -->
  <!--     I N T R O          -->
  <!-- ---------------------- -->
  <div id="intro">
    <?php if ($this->document->shoppica_intro_banner): echo $this->document->shoppica_intro_banner; else: ?>

    <div id="intro_wrap">
      <div class="container_12">
        <div id="breadcrumbs" class="grid_12">
          <?php foreach ($breadcrumbs as $breadcrumb): ?>
          <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
          <?php endforeach; ?>
        </div>
        <h1><?php echo $heading_title; ?></h1>
      </div>
    </div>
    <?php endif; ?>
  </div>
  <!-- end of intro -->

  <!-- ---------------------- -->
  <!--      C O N T E N T     -->
  <!-- ---------------------- -->
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $container = 12; $main = 9; $side_col = 3; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_1') { $container = 12; $main = 12; $side_col = 3; } ?>
  <?php if (!$this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 16; $main = 12; $side_col = 4; } ?>
  <?php if ($this->document->shoppica_rightColumnEmpty && $this->config->get('shoppica_products_listing') == 'size_2') { $container = 12; $main = 12; $side_col = 3; } ?>

  <div id="content" class="container_<?php echo $container; ?>">

    <?php if ($this->document->shoppica_column_position == "left" && $column_right): ?>
    <div id="left_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

    <div class="checkout grid_<?php echo $main; ?>">

      <?php echo $content_top; ?>

      <div id="checkout">
        <div class="checkout-heading"><?php echo $this->document->shoppica_text_checkout_options; ?></div>
        <div class="checkout-content"></div>
      </div>
      <?php if (!$logged): ?>
      <div id="payment-address">
        <div class="checkout-heading"><span><?php echo $this->document->shoppica_text_checkout_account; ?></span></div>
        <div class="checkout-content"></div>
      </div>
      <?php else: ?>
      <div id="payment-address">
        <div class="checkout-heading"><span><?php echo $this->document->shoppica_text_checkout_payment_address; ?></span></div>
        <div class="checkout-content"></div>
      </div>
      <?php endif; ?>
      <?php if ($shipping_required): ?>
      <div id="shipping-address">
        <div class="checkout-heading"><?php echo $this->document->shoppica_text_checkout_shipping_address; ?></div>
        <div class="checkout-content"></div>
      </div>
      <div id="shipping-method">
        <div class="checkout-heading"><?php echo $this->document->shoppica_text_checkout_shipping_method; ?></div>
        <div class="checkout-content"></div>
      </div>
      <?php endif; ?>
      <div id="payment-method">
        <div class="checkout-heading"><?php echo $this->document->shoppica_text_checkout_payment_method; ?></div>
        <div class="checkout-content"></div>
      </div>
      <div id="confirm">
        <div class="checkout-heading"><?php echo $this->document->shoppica_text_checkout_confirm; ?></div>
        <div class="checkout-content"></div>
      </div>

      <?php echo $content_bottom; ?>

    </div>

    <?php if ($this->document->shoppica_column_position == "right" && $column_right): ?>
    <div id="right_col" class="grid_<?php echo $side_col; ?>">
    <?php echo $column_right; ?>
    </div>
    <?php endif; ?>

  </div>
  <!-- end of content -->

  <script type="text/javascript">
  $('#checkout .checkout-content input[name=\'account\']').live('change', function() {
    if ($(this).attr('value') == 'register') {
      $('#payment-address .checkout-heading').html('<?php echo $this->document->shoppica_text_checkout_account; ?>');
    } else {
      $('#payment-address .checkout-heading').html('<?php echo $this->document->shoppica_text_checkout_payment_address; ?>');
    }
  });

  $('.checkout-heading a').live('click', function() {
    $('.checkout-content').slideUp('slow');

    $(this).parent().parent().find('.checkout-content').slideDown('slow');
  });
  <?php if (!$logged): ?>
  $(document).ready(function() {
    $.ajax({
      url: 'index.php?route=checkout/login',
      dataType: 'json',
      success: function(json) {
        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['output']) {
          $('#checkout .checkout-content').html(json['output']);
          $('#checkout .checkout-content').slideDown('slow');
        }
      }
    });
  });
  <?php else: ?>
  $(document).ready(function() {
    $.ajax({
      url: 'index.php?route=checkout/address/payment',
      dataType: 'json',
      success: function(json) {
        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['output']) {
          $('#payment-address .checkout-content').html(json['output']);
          $('#payment-address .checkout-content').slideDown('slow');
        }
      }
    });
  });
  <?php endif; ?>

  // Checkout
  $('#button-account').live('click', function() {
    $.ajax({
      url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').attr('value'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-account').attr('disabled', true);
        $('#button-account').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-account').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $('.s_server_msg').remove();

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['output']) {
          $('#payment-address .checkout-content').html(json['output']);
          $('#checkout .checkout-content').slideUp('slow');
          $('#payment-address .checkout-content').slideDown('slow');
          $('.checkout-heading a').remove();
          $('#checkout .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
        }
      }
    });
  });

  // Login
  $('#button-login').live('click', function() {
    if (!$("#returning_customer_login").valid()) {

      return false;
    }

    $.ajax({
      url: 'index.php?route=checkout/login',
      type: 'post',
      data: $('#returning_customer_login :input'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-login').attr('disabled', true);
        $('#button-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-login').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $('.s_server_msg').remove();

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['total']) {
            $.ajax({
                url: 'index.php?route=module/shoppica/cartCallback',
                type: 'post',
                dataType: 'json',
                success: function(json) {
                    $('#cart_menu span.s_grand_total').html(json['total_sum']);
                    $('#cart_menu div.s_cart_holder').html(json['output']);
                }
            });
        }

        if (json['logged']) {
            $('#welcome_message').html(json['logged']);
        }

        if (json['error']) {
          $('#checkout .checkout-content').prepend('<div class="s_server_msg s_msg_red" style="display: none;"><p>' + json['error']['warning'] + '</p></div>');
          $('.s_server_msg').fadeIn('slow');
        } else {
          $.ajax({
            url: 'index.php?route=checkout/address/payment',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#payment-address .checkout-content').html(json['output']);
                $('#checkout .checkout-content').slideUp('slow');
                $('#payment-address .checkout-content').slideDown('slow');
                $('#payment-address .checkout-heading span').html('<?php echo $this->document->shoppica_text_checkout_payment_address; ?>');
                $('.checkout-heading a').remove();
              }
            }
          });
        }
      }
    });
  });

  // Register
  $('#button-register').live('click', function() {
    if (!$("#register_details_form").valid()) {

      return false;
    }

    $.ajax({
      url: 'index.php?route=checkout/register',
      type: 'post',
      data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-register').attr('disabled', true);
        $('#button-register').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-register').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $('.s_server_msg').remove();
        $("p.s_error_msg").remove();
        $("div.s_row_2").removeClass("s_error_row");

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['error']) {
          var elements = { "firstname" : "", "lastname" : "", "email" : "", "telephone" : "", "address_1" : "", "city" : "", "postcode" : "", "country" : "country_id", "zone" : "select:zone_id", "password" : "", "confirm"  : "" };
          highlightErrors(elements, json['error'], "payment-address");

          if (json['error']['warning']) {
            $('#payment-address .checkout-content').prepend('<div class="s_server_msg s_msg_red" style="display: none;"><p>' + json['error']['warning'] + '</p></div>');

            $('.s_server_msg').fadeIn('slow');
          }
        } else {
          <?php if ($shipping_required): ?>
          var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');

          if (shipping_address) {
            $.ajax({
              url: 'index.php?route=checkout/shipping',
              dataType: 'json',
              success: function(json) {
                if (json['redirect']) {
                  location = json['redirect'];
                }

                if (json['output']) {
                  $('#shipping-method .checkout-content').html(json['output']);
                  $('#payment-address .checkout-content').slideUp('slow');
                  $('#shipping-method .checkout-content').slideDown('slow');
                  $('#checkout .checkout-heading a').remove();
                  $('#payment-address .checkout-heading a').remove();
                  $('#shipping-address .checkout-heading a').remove();
                  $('#shipping-method .checkout-heading a').remove();
                  $('#payment-method .checkout-heading a').remove();

                  $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                  $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');

                  $.ajax({
                    url: 'index.php?route=checkout/address/shipping',
                    dataType: 'json',
                    success: function(json) {
                      if (json['redirect']) {
                        location = json['redirect'];
                      }

                      if (json['output']) {
                        $('#shipping-address .checkout-content').html(json['output']);
                      }
                    }
                  });
                }
              }
            });
          } else {
            $.ajax({
              url: 'index.php?route=checkout/address/shipping',
              dataType: 'json',
              success: function(json) {
                if (json['redirect']) {
                  location = json['redirect'];
                }

                if (json['output']) {
                  $('#shipping-address .checkout-content').html(json['output']);
                  $('#payment-address .checkout-content').slideUp('slow');
                  $('#shipping-address .checkout-content').slideDown('slow');
                  $('#checkout .checkout-heading a').remove();
                  $('#payment-address .checkout-heading a').remove();
                  $('#shipping-address .checkout-heading a').remove();
                  $('#shipping-method .checkout-heading a').remove();
                  $('#payment-method .checkout-heading a').remove();
                  $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                }
              }
            });
          }
          <?php else: ?>
          $.ajax({
            url: 'index.php?route=checkout/payment',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#payment-method .checkout-content').html(json['output']);
                $('#payment-address .checkout-content').slideUp('slow');
                $('#payment-method .checkout-content').slideDown('slow');
                $('#checkout .checkout-heading a').remove();
                $('#payment-address .checkout-heading a').remove();
                $('#payment-method .checkout-heading a').remove();

                $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }
            }
          });
          <?php endif; ?>

          $.ajax({
            url: 'index.php?route=checkout/address/payment',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#payment-address .checkout-content').html(json['output']);
                $('#payment-address .checkout-heading span').html('<?php echo $this->document->shoppica_text_checkout_payment_address; ?>');
              }
            }
          });
        }
      }
    });
  });

  // Payment Address
  $('#payment-address a.payment_button-address').live('click', function() {
    var submit_button = this;
    if ($("#payment-address-new").is(":checked") && !$("#payment_form").valid()) {

      return false;
    }

    $.ajax({
      url: 'index.php?route=checkout/address/payment',
      type: 'post',
      data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address select'),
      dataType: 'json',
      beforeSend: function() {
        $(submit_button).attr('disabled', true);
        $(submit_button).after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $(submit_button).attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $("p.s_error_msg").remove();
        $("div.s_row_2").removeClass("s_error_row");

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['error']) {

          var elements = { "firstname" : "", "lastname" : "", "email" : "", "telephone" : "", "address_1" : "", "city" : "", "postcode" : "", "country" : "country_id", "zone" : "select:zone_id" };
          highlightErrors(elements, json['error'], "payment-address");
        } else {
          <?php if ($shipping_required): ?>
          $.ajax({
            url: 'index.php?route=checkout/address/shipping',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#shipping-address .checkout-content').html(json['output']);
                $('#payment-address .checkout-content').slideUp('slow');
                $('#shipping-address .checkout-content').slideDown('slow');
                $('#payment-address .checkout-heading a').remove();
                $('#shipping-address .checkout-heading a').remove();
                $('#shipping-method .checkout-heading a').remove();
                $('#payment-method .checkout-heading a').remove();

                $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }
            }
          });
          <?php else: ?>
          $.ajax({
            url: 'index.php?route=checkout/payment',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#payment-method .checkout-content').html(json['output']);
                $('#payment-address .checkout-content').slideUp('slow');
                $('#payment-method .checkout-content').slideDown('slow');
                $('#payment-address .checkout-heading a').remove();
                $('#payment-method .checkout-heading a').remove();

                $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }
            }
          });
          <?php endif; ?>

          $.ajax({
            url: 'index.php?route=checkout/address/payment',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#payment-address .checkout-content').html(json['output']);
              }
            }
          });
        }
      }
    });
  });

  // Shipping Address
  $('#shipping-address a.shipping_button-address').live('click', function() {
    if ($("#shipping-address-new").is(":checked") && !$("#shipping_form").valid()) {

      return false;
    }

    $.ajax({
      url: 'index.php?route=checkout/address/shipping',
      type: 'post',
      data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
      dataType: 'json',
      beforeSend: function() {
        $('#shipping-address #button-address').attr('disabled', true);
        $('#shipping-address #button-address').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#shipping-address #button-address').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $("p.s_error_msg").remove();
        $("div.s_row_2").removeClass("s_error_row");

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['error']) {
          var elements = { "firstname" : "", "lastname" : "", "email" : "", "telephone" : "", "address_1" : "", "city" : "", "postcode" : "", "country" : "country_id", "zone" : "select:zone_id" };
          highlightErrors(elements, json['error'], "shipping-address");
        } else {
          $.ajax({
            url: 'index.php?route=checkout/shipping',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#shipping-method .checkout-content').html(json['output']);
                $('#shipping-address .checkout-content').slideUp('slow');
                $('#shipping-method .checkout-content').slideDown('slow');
                $('#shipping-address .checkout-heading a').remove();
                $('#shipping-method .checkout-heading a').remove();
                $('#payment-method .checkout-heading a').remove();
                $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }

              $.ajax({
                url: 'index.php?route=checkout/address/shipping',
                dataType: 'json',
                success: function(json) {
                  if (json['redirect']) {
                    location = json['redirect'];
                  }

                  if (json['output']) {
                    $('#shipping-address .checkout-content').html(json['output']);
                  }
                }
              });
            }
          });
        }
      }
    });
  });

  // Guest
  $('#button-guest').live('click', function() {
    if (!$("#guest_details_form").valid()) {

      return false;
    }

    $.ajax({
      url: 'index.php?route=checkout/guest',
      type: 'post',
      data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address select'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-guest').attr('disabled', true);
        $('#button-guest').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-guest').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $("p.s_error_msg").remove();
        $("div.s_row_2").removeClass("s_error_row");

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['error']) {

          var elements = { "firstname" : "", "lastname" : "", "email" : "", "telephone" : "", "address_1" : "", "city" : "", "postcode" : "", "country" : "country_id", "zone" : "select:zone_id" };
          highlightErrors(elements, json['error'], "payment-address");

        } else {
          <?php if ($shipping_required): ?>
          var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');

          if (shipping_address) {
            $.ajax({
              url: 'index.php?route=checkout/shipping',
              dataType: 'json',
              success: function(json) {
                if (json['redirect']) {
                  location = json['redirect'];
                }

                if (json['output']) {
                  $('#shipping-method .checkout-content').html(json['output']);
                  $('#payment-address .checkout-content').slideUp('slow');
                  $('#shipping-method .checkout-content').slideDown('slow');
                  $('#payment-address .checkout-heading a').remove();
                  $('#shipping-address .checkout-heading a').remove();
                  $('#shipping-method .checkout-heading a').remove();
                  $('#payment-method .checkout-heading a').remove();
                  $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                  $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                }

                $.ajax({
                  url: 'index.php?route=checkout/guest/shipping',
                  dataType: 'json',
                  success: function(json) {
                    if (json['redirect']) {
                      location = json['redirect'];
                    }

                    if (json['output']) {
                      $('#shipping-address .checkout-content').html(json['output']);
                    }
                  }
                });
              }
            });
          } else {
            $.ajax({
              url: 'index.php?route=checkout/guest/shipping',
              dataType: 'json',
              success: function(json) {
                if (json['redirect']) {
                  location = json['redirect'];
                }

                if (json['output']) {
                  $('#shipping-address .checkout-content').html(json['output']);
                  $('#payment-address .checkout-content').slideUp('slow');
                  $('#shipping-address .checkout-content').slideDown('slow');
                  $('#payment-address .checkout-heading a').remove();
                  $('#shipping-address .checkout-heading a').remove();
                  $('#shipping-method .checkout-heading a').remove();
                  $('#payment-method .checkout-heading a').remove();
                  $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
                }
              }
            });
          }
          <?php else: ?>
          $.ajax({
            url: 'index.php?route=checkout/payment',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#payment-method .checkout-content').html(json['output']);
                $('#payment-address .checkout-content').slideUp('slow');
                $('#payment-method .checkout-content').slideDown('slow');
                $('#payment-address .checkout-heading a').remove();
                $('#payment-method .checkout-heading a').remove();
                $('#payment-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }
            }
          });
          <?php endif; ?>
        }
      }
    });
  });

  // Guest Shipping
  $('#button-guest-shipping').live('click', function() {
    if (!$("#guest_shipping_form").valid()) {

      return false;
    }

    $.ajax({
      url: 'index.php?route=checkout/guest/shipping',
      type: 'post',
      data: $('#shipping-address input[type=\'text\'], #shipping-address select'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-guest-shipping').attr('disabled', true);
        $('#button-guest-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-guest-shipping').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $("p.s_error_msg").remove();
        $("div.s_row_2").removeClass("s_error_row");

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['error']) {

          var elements = { "firstname" : "", "lastname" : "", "email" : "", "address_1" : "", "address_2" : "","city" : "", "postcode" : "", "country" : "country_id", "zone" : "select:zone_id" };
          highlightErrors(elements, json['error'], "shipping-address");

        } else {
          $.ajax({
            url: 'index.php?route=checkout/shipping',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#shipping-method .checkout-content').html(json['output']);
                $('#shipping-address .checkout-content').slideUp('slow');
                $('#shipping-method .checkout-content').slideDown('slow');
                $('#shipping-address .checkout-heading a').remove();
                $('#shipping-method .checkout-heading a').remove();
                $('#payment-method .checkout-heading a').remove();

                $('#shipping-address .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }
            }
          });
        }
      }
    });
  });

  $('#button-shipping').live('click', function() {
    $.ajax({
      url: 'index.php?route=checkout/shipping',
      type: 'post',
      data: $('#shipping-method input[type=\'radio\']:checked, #shipping-method textarea'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-shipping').attr('disabled', true);
        $('#button-shipping').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-shipping').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $('.s_server_msg').remove();

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['error']) {
          if (json['error']['warning']) {
            $('#shipping-method .checkout-content').prepend('<div class="s_server_msg s_msg_red" style="display: none;"><p>' + json['error']['warning'] + '</p></div>');

            $('.s_server_smg').fadeIn('slow');
          }
        } else {
          $.ajax({
            url: 'index.php?route=checkout/payment',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#payment-method .checkout-content').html(json['output']);
                $('#shipping-method .checkout-content').slideUp('slow');
                $('#payment-method .checkout-content').slideDown('slow');
                $('#shipping-method .checkout-heading a').remove();
                $('#payment-method .checkout-heading a').remove();
                $('#shipping-method .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }
            },
            error: function(xhr, ajaxOptions, thrownError) {
              alert(thrownError);
            }
          });
        }
      }
    });
  });

  $('#button-payment').live('click', function() {
    $.ajax({
      url: 'index.php?route=checkout/payment',
      type: 'post',
      data: $('#payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
      dataType: 'json',
      beforeSend: function() {
        $('#button-payment').attr('disabled', true);
        $('#button-payment').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
      },
      complete: function() {
        $('#button-payment').attr('disabled', false);
        $('.wait').remove();
      },
      success: function(json) {
        $('.s_server_msg').remove();

        if (json['redirect']) {
          location = json['redirect'];
        }

        if (json['error']) {
          if (json['error']['warning']) {
            $('#payment-method .checkout-content').prepend('<div class="s_server_msg s_msg_red" style="display: none;"><p>' + json['error']['warning'] + '</p></div>');
            $('.s_server_msg').fadeIn('slow');
          }
        } else {
          $.ajax({
            url: 'index.php?route=checkout/confirm',
            dataType: 'json',
            success: function(json) {
              if (json['redirect']) {
                location = json['redirect'];
              }

              if (json['output']) {
                $('#confirm .checkout-content').html(json['output']);
                $('#payment-method .checkout-content').slideUp('slow');
                $('#confirm .checkout-content').slideDown('slow');
                $('#payment-method .checkout-heading a').remove();
                $('#payment-method .checkout-heading').append('<a><?php echo $text_modify; ?></a>');
              }
            },
            error: function(xhr, ajaxOptions, thrownError) {
              alert(thrownError);
            }
          });
        }
      }
    });
  });

  function highlightErrors(elements, json, wrapper_id) {
    jQuery.each(elements, function(i, val) {
      if (json[i]) {
        var selector = "input";
        var el_name = val ? val : i;

        if (val) {
          var el_parts = val.split(":");
          if (el_parts.length == 2) {
            var selector = el_parts[0];
            var el_name = el_parts[1];
          }
        }

        var element = $("#" + wrapper_id + " " + selector + "[name='" + el_name + "']");

        element.after('<p class="s_error_msg">' + json[i] + '</p>');
        element.parent("div.s_row_2").addClass("s_error_row");
      }
    });
  }

  </script>

  <link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/stylesheet/prettyPhoto.css" media="all" />
  <script type="text/javascript" src="catalog/view/theme/<?php echo $this->config->get('config_template') ?>/js/jquery/jquery.prettyPhoto.js"></script>
  <script type="text/javascript" src="http<?php if(isHTTPS()) echo 's'?>://ajax.aspnetcdn.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>


  <script type="text/javascript">
    jQuery.validator.setDefaults({
        errorElement: "p",
        errorClass: "s_error_msg",
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        },
        highlight: function(element, errorClass, validClass) {
            $(element).addClass("error_element").removeClass(validClass);
            $(element).parent("div").addClass("s_error_row");
        },
        unhighlight: function(element, errorClass, validClass) {
            $(element).removeClass("error_element").addClass(validClass);
            $(element).parent("div").removeClass("s_error_row");
        }
    });
  </script>

<?php echo $footer; ?>
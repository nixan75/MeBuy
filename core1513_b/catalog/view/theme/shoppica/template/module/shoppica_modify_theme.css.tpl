body.s_layout_fixed {
  background-color: #%background_color%;
  background-image: url(%texture_image%);
  background-repeat: %texture_repeat%;
  background-position: %texture_position%;
  background-attachment: %texture_attachment%;
}
.s_main_color,
#twitter li span a,
.s_button_add_to_cart,
.s_box h2,
.box .box-heading,
.checkout-heading a,
#welcome_message a
{
  color: #%main_color%;
}
#footer_categories h2:hover a,
#footer_categories h2 a:hover
{
  color: #%main_color% !important;
}
.s_main_color_bgr,
#cart .s_icon,
#shop_contacts .s_icon,
.s_list_1 li,
.s_button_add_to_cart .s_icon,
#intro .s_button_prev,
#intro .s_button_next,
.buttons .button,
#cart_menu .s_icon,
.ui-notify-message .s_success_24,
.s_button_wishlist .s_icon,
.s_button_compare .s_icon,
.s_product_row .s_row_number,
.jcarousel-prev,
.jcarousel-next
{
  background-color: #%main_color%;
}
.s_secondary_color,
a:hover,
#categories > ul > li > a,
#footer_categories h2,
#footer_categories h2 a,
.pagination a,
#view_mode .s_selected a,
#welcome_message a:hover
{
  color: #%secondary_color%;
}
#content a:hover,
#shop_info a:hover,
#footer a:hover,
#intro h1 a:hover,
#intro h2 a:hover,
#content a:hover,
#shop_info a:hover,
#footer a:hover,
#breadcrumbs a:hover
{
  color: #%secondary_color% !important;
}
.s_secondary_color_bgr,
#site_search .s_search_button,
#view_mode .s_selected .s_icon,
#view_mode a:hover .s_icon,
#menu_home a:hover,
.pagination a:hover,
.s_button_add_to_cart:hover .s_icon,
.s_button_remove:hover,
.ui-notify-message .s_failure_24,
#product_share .s_review_write:hover .s_icon,
.s_button_wishlist:hover .s_icon,
.s_button_compare:hover .s_icon
{
  background-color: #%secondary_color%;
}
#intro {
  background-color: #%intro_color%;
}
#intro, #breadcrumbs a {
  color: #%intro_text_color%;
}
#intro h1, #intro h1 *, #intro h2, #intro h2 * {
  color: #%intro_title_color%;
  ~background-color: #%intro_color%;
}
#intro .s_rating {
  ~background-color: #%intro_color%;
}
.s_price
{
  background-color: #%price_color%;
}
.s_promo_price
{
  background-color: #%promo_price_color%;
}
.s_price,
.s_price .s_currency
{
  color: #%price_text_color%;
}
.s_promo_price,
.s_old_price,
.s_promo_price .s_currency
{
  color: #%promo_price_text_color%;
}

*::-moz-selection {
  background-color: #%main_color%;
}
*::-webkit-selection {
  background-color: #%main_color%;
}
*::selection {
  background-color: #%main_color%;
}


const api_endpoint_postDish ='https://benet-eddar-backend.vercel.app/api_post_dish';
const api_endpoint_postMenu ='https://benet-eddar-backend.vercel.app/api_post_Menu';
const api_endpoint_postMenu_Dishes ='https://benet-eddar-backend.vercel.app/api_post_Menu_Dishes';
const api_endpoint_modifyCookInfos ='https://benet-eddar-backend.vercel.app/api_modifyCookInfos';
const api_endpoint_modifyCookPassword ='https://benet-eddar-backend.vercel.app/api_modifyCookPassword';
const api_endpoint_add_Promo_Code ='https://benet-eddar-backend.vercel.app/api__add_Promo_Code';
const api_endpoint_get_Promo_Codes ='https://benet-eddar-backend.vercel.app/api_get_Promo_Codes';
const api_endpoint_get_menus_and_dishes_for_user = 'https://benet-eddar-backend.vercel.app/users.getMenusAndDishesForUser';
const api_endpoint_get_cook_info = 'https://benet-eddar-backend.vercel.app/cooks';
const api_endpoint_user_sign = 'https://benet-eddar-backend.vercel.app/users.signup';
const api_endpoint_user_login = 'https://benet-eddar-backend.vercel.app/users.login';
const _api_endpoint_base = 'https://benet-eddar-backend.vercel.app';
const api_delete_post='https://benet-eddar-backend.vercel.app/post.delete';


String getApiEndpointForCookMenus(String? cookId) {
  return '$_api_endpoint_base/cooks/$cookId/menus';
}
String getApiEndpointForCookRegister(String? cookId) {
  return '$_api_endpoint_base/cook/$cookId/register';
}
String getApiEndpointForCookOrders(String? cookId) {
  return '$_api_endpoint_base/cooks/$cookId/orders';
}
String getApiEndpointForCookTreatedOrders(String? cookId) {
  return '$_api_endpoint_base/cooks/$cookId/treatedOrders';
}

String getApiEndpointForCookDetails(String? cookId) {
  return '$_api_endpoint_base/get_cook_details/$cookId';
}
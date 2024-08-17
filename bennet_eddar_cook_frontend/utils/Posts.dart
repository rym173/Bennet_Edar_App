import 'dart:convert';
import 'package:dio/dio.dart';
import '../constants/endpoints.dart';
import '../models/Dish.dart';
import '../../main.dart';
import 'dart:io';
import 'package:bennet_eddar_cook/utils/user_info.dart';

class Posts {
  static Future<String> remote_Picture_URL(int cookID , String name, String localPath) async {
    final String imageUrl;
    try {
      String filename = '$cookID$name${DateTime.now().millisecondsSinceEpoch}.jpg';
      final spaceRef = storageRef.child("Dishes/$cookID/$filename");
      await spaceRef.putFile(File(localPath));
      imageUrl = await spaceRef.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      print("Exception $e");
      return ' ';
    }
  }
  static Future<int?> postDish(Dish dish) async {
    String remote_url = await remote_Picture_URL(dish.cookID, dish.name , dish.picture_Path);

    try {
      final dio = Dio();
      Map<String, dynamic> form_data = {
        'cookID': dish.cookID,
        'name': dish.name,
        'description': dish.description,
        'Start_date': dish.startDate,
        'End_date': dish.endDate,
        'price': dish.price,
        'Dish_pic': remote_url,
      };

      var response = await dio.post(
        api_endpoint_postDish,
        data: FormData.fromMap(form_data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.data}');
        Map<String, dynamic> responseData = jsonDecode(response.toString());
        if (responseData.containsKey('data')) {
          int dishId = responseData['data']['Dish_ID'];
          print('Dish posted successfully with ID: $dishId');
          return dishId;
        } else {
          throw Exception('No "data" field in the API response');
        }
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to post dish: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to post dish: $error');
    }
  }

  static Future<int?> postMenu(Map data) async {
    try {
      final dio = Dio();
      Map<String, dynamic> form_data = {
        'cookID': data['cookID'],
        'name': data['name'],
      };

      var response = await dio.post(
        api_endpoint_postMenu,
        data: FormData.fromMap(form_data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.data}');
        Map<String, dynamic> responseData = jsonDecode(response.toString());
        if (responseData.containsKey('data')) {
          int menuId = responseData['data']['Menu_ID'];
          print('Menu posted successfully with ID: $menuId');
          return menuId;
        } else {
          throw Exception('No "data" field in the API response');
        }
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to post menu: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to post menu: $error');
    }
  }

  static Future<int?> postMenu_Dish(int MenuID , int dishId) async {
    try {
          final dio = Dio();
          Map<String, int> form_data = {
            'Menu_ID':MenuID,
            'Dish_ID':dishId,
          };

          var response = await dio.post(
            api_endpoint_postMenu_Dishes,
            data: FormData.fromMap(form_data),
            options: Options(
              headers: {
                'Content-Type': 'application/json',
              },
            ),
          );

          if (response.statusCode == 200) {
            print('API Response: ${response.data}');
            Map<String, dynamic> responseData = jsonDecode(response.toString());
            if (responseData.containsKey('data')) {
              int Id = responseData['data']['id'];
              print('Posted successfully with ID: $Id');
              return Id;
            } else {
              throw Exception('No "data" field in the API response');
            }
          } else {
            print('Error: ${response.statusCode}');
            throw Exception('Failed to post menu: ${response.statusCode}');
          }
        } catch (error) {
          print('Error: $error');
          throw Exception('Failed to post : $error');
        }
  }


  static Future<int?> postMenu_Dishes(Map Menu_Details, List<Dish> Dishes) async {
    var MenuID = await postMenu(Menu_Details);
    List<int> DishesIDs = [];

    for (Dish dish in Dishes) {
      int? dishId = await postDish(dish);
      if (dishId != null) {
        DishesIDs.add(dishId);
      } else {
        print('Did not receive the ID for ${dish.name}');
      }

      print(DishesIDs);
    }

    if (MenuID != null && DishesIDs.length==Dishes.length ){
      for (int dishId in DishesIDs){
        postMenu_Dish(MenuID, dishId);
    }
    }else {
      print("Incomplete posting");
    }
    return null;
  }
  static Future<List<dynamic>> getMenusAndDishesForCook(String? cookId) async {
  final response = await Dio().get(
    getApiEndpointForCookMenus(cookId),
    options: Options(
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  if (response.statusCode == 200) {
    // Parse the response body
    List<dynamic> menusAndDishes = jsonDecode(response.data);
    return menusAndDishes;
  } else {
    throw Exception('Failed to load menus and dishes');
  }
}

  static Future<List<dynamic>> getMenusAndDishesForCurrentCook() async {
    String? cookId = await getUserId();
    print('Cook ID: $cookId');
    return getMenusAndDishesForCook(cookId);
  }
  static Future<void> deletePost(int postId) async {

    Dio dio = Dio();
    try {
      final response = await dio.post(
        api_delete_post,
        data: {
          'postID': postId,
        },
      );
      print(response);


      if (response.statusCode == 200 && response.data['status'] != 500) {
        print('Post deleted successfully');
      } else {
        throw Exception('Failed to delete post: ${response.data['message']}');
      }
    } catch (e) {
      print('Request error: $e');
    }
  }

  static Future<int?> addPromoCode(Map data) async {
    try {
      final dio = Dio();
      Map<String, dynamic> form_data = {
        'cookID': data['cookID'],
        'name': data['name'],
        'pourcentage' : data['pourcentage'],
        'utilisation' : data['utilisation'],
        'availability' : data['availability']
      };

      var response = await dio.post(
        api_endpoint_add_Promo_Code,
        data: FormData.fromMap(form_data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.data}');
        Map<String, dynamic> responseData = jsonDecode(response.toString());
        if (responseData.containsKey('data')) {
          int PCId = responseData['data']['id'];
          print('Promo code added successfully with ID: $PCId');
          return PCId;
        } else {
          throw Exception('No "data" field in the API response');
        }
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to post PC: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to post PC: $error');
    }
  }

 static Future<List<dynamic>> getPromoCodesForCook(int cookId) async {
  try {
    final dio = Dio();
    Map<String, dynamic> form_data = {
      'Cook_ID': cookId,
    };

    var response = await dio.post(
      api_endpoint_get_Promo_Codes,
      data: FormData.fromMap(form_data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
        },
      ),
    );
    if (response.statusCode == 200) {
      print('API Response: ${response.data}');
      
      Map<String, dynamic> responseData = jsonDecode(response.toString());

      if (responseData.containsKey('data')) {
        List<dynamic> promoCodes = responseData['data'];
        return promoCodes;
      } else {
        throw Exception('No "data" field in the API response');
      }
    } else {
      throw Exception('Failed to get promo codes. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to get promo codes: $error');
  }
}
}
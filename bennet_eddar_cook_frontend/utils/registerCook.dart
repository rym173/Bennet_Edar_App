import 'dart:convert';
import 'package:bennet_eddar_cook/utils/user_info.dart';
import 'package:dio/dio.dart';
import '../constants/endpoints.dart';

class registerCook {
  static Future<Map<dynamic, dynamic>> addCook(Map data) async {
    try {
      final dio = Dio();
      Map<String, dynamic> formData = {
        'Cook_Name': data['Cook_Name'],
        'Bio': data['Bio'],
        'Profile_Pic': data['Profile_Pic'],
      };
      
      String? cookId = await getUserId();
      var response = await dio.post(
        getApiEndpointForCookRegister(cookId),
        data: FormData.fromMap(formData),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('API Response: ${response.data}');
        Map retData = jsonDecode(response.toString());
        if (retData.containsKey('message') && retData['message'].isNotEmpty) {
          String errorMsg = retData['message'];
          throw Exception('Error : $errorMsg');
        } else {
          // Handle success scenario
          print('Cook registered successfully');
          return retData['data'];
        }
      } else {
        // Handle non-200 status code (error) scenario
        print('Error: ${response.statusCode}');
        throw Exception('Failed to register cook: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Failed to register cook: $error');
    }
  }
}

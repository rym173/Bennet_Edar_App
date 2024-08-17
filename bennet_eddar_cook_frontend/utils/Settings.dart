import 'package:dio/dio.dart';
import '../constants/endpoints.dart';
import '../utils/userAuthentication.dart';


class Settings{
  static Future<bool> updateUserInfos(int cookID ,String name , String email , int phoneNumber) async {

    try {
      final dio = Dio();
      Map <String, dynamic> form_data = {
        'UserID': cookID,
        'Name':name,
        'Email':email,
        'Phone':phoneNumber , 
      };

      var response = await dio.post(
        api_endpoint_modifyCookInfos,
        data : FormData.fromMap(form_data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Data updated successfully');
        return true;
      } else {
        print('Failed to update data');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }

  static Future <bool> updatePassword (int cookID , String password) async {
    String newPassword = UserAuthentication.hashPassword(password, 'unique_salt_for_each_user');
    try {
      final dio = Dio();
      Map <String, dynamic> form_data = {
        'UserID': cookID,
        'Password' : newPassword,
      };

      var response = await dio.post(
        api_endpoint_modifyCookPassword,
        data : FormData.fromMap(form_data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Password updated successfully');
        return true;
      } else {
        print('Failed to update Password');
        return false;
      }
    } catch (error) {
      print('Error: $error');
      return false;
    }
  }
}
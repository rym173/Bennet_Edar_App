import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/endpoints.dart';
import '../main.dart';
import '../models/user.dart';

class UserAuthentication {
  static String hashPassword(String password, String salt) {
    var bytes = utf8.encode(password + salt);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<User?> getLoggedUser() async {
    String? uid = prefs?.getString("user_id");
    String? email = prefs?.getString("user_email");
    String? password = prefs?.getString("user_password");
    String? location = prefs?.getString("user_location");
    String? name = prefs?.getString("user_name");
    String? phoneString = prefs?.getString("user_phone");
    int? phone = phoneString != null ? int.tryParse(phoneString) : null;

if (phone != null) {
  // Successfully converted 'phoneString' to an integer
  print('Phone number as integer: $phone');
} else {
  // Handle the case where 'phoneString' is null or not a valid integer
  print('Invalid phone number or phoneString is null');
}
if (uid != null) {
  // Successfully converted 'phoneString' to an integer
  print('uid: $uid');
} else {
  // Handle the case where 'phoneString' is null or not a valid integer
  print('uid is null');
}

    if (uid != null &&
        email != null &&
        password != null &&
        uid.isNotEmpty &&
        email.isNotEmpty &&
        location!= null &&
        name!= null &&
        phone!= null 
        ) {
      return User(
          uid: uid, name: name, email: email, password: password, location: location,phone: phone);
    } else {
      return null;
    }
  }

static Future<String> loginUser(String email, String password) async {
  String hashedPassword = hashPassword(password, 'unique_salt_for_each_user');
  //verify::
  Map<String, dynamic> formData = {'email': email, 'password': hashedPassword};

  var response = await dio.post(
    api_endpoint_user_login,
    data: FormData.fromMap(formData),
    options: Options(
      headers: {
        'Content-Type': 'application/json',
      },
    ),

  );
   print(response);
   String errorMsg = '';
  Map retData = jsonDecode(response.toString());
  print(retData);

  if (retData['status'] == 200) {
    Map<String, dynamic> data = retData['data'];

    if (prefs != null) {
      prefs!.setString("user_id", "${data['UserID']}");
      prefs!.setString("user_email", data['Email']);
      prefs!.setString("user_password", data['Password']);
      prefs!.setString("user_name", data['Name']);
      prefs!.setString("user_location", data['Location']);
      prefs!.setString("user_phone", "${data['Phone']}");
  
      
    }
    print("user_id: ${data['UserID']}");
    return 'success';
  } errorMsg = retData['message'];
    return errorMsg;
  }


  static Future<bool> logoutUser(User user) async {
    await Future.delayed(const Duration(seconds: 5));
    return true;
  }

static Future<String> signupUser(Map data) async {
  try {
    String password = data['password'];
    String hashedPassword = hashPassword(password, 'unique_salt_for_each_user');
    Map<String, dynamic> formData = {
      'email': data['email'],
      'password': hashedPassword,
      'location': data['location'],
      'phone': data['phone'],
      'name': data['name']
    };

    var response = await dio.post(api_endpoint_user_sign, data: FormData.fromMap(formData)
       );
    print(response);

    String errorMsg = '';
    Map retData = jsonDecode(response.toString());
    if (retData['status'] == 200) {
      Map<String, dynamic> userData = retData['data'];

      // Log all user data to see what's received
      print('User data from response: $userData');
      print(userData['Email']);

      if (prefs != null) {
        prefs!.setString("user_id", "${userData['UserID']}");

        // Check if 'email' is not null before setting it
        if (userData['Email'] != null) {
          prefs!.setString("user_email", userData['Email']);
        } else {
          // Handle the case where 'email' is null or empty
          print('User email is null or empty');
          return 'Error: User email is null or empty';
        }

        prefs!.setString("user_password", userData['Password']);
        prefs!.setString("user_name", userData['Name']);
        prefs!.setString("user_location", userData['Location']);

        // Check if 'phone' is not null before converting it to a String
        if (userData['Phone'] != null) {
          prefs!.setString("user_phone", "${userData['Phone']}");
        } else {
          // Handle the case where 'phone' is null
          print('User phone is null');
          return 'Error: User phone is null';
        }
      }

      return 'success';
    }

    errorMsg = retData['message'];
    return ' $errorMsg';
  } catch (e) {
    print('Exception during signupUser: $e');
    return 'Error: ${e.toString()}';
  }
}

static Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  // Efface les données de l'utilisateur
  await prefs.remove('user_id');
  await prefs.remove('user_email');
  await prefs.remove('user_password');
  await prefs.remove('user_location');
  await prefs.remove('user_name');
  await prefs.remove('user_phone');

  // Navigue vers la page de connexion
  Navigator.pushReplacementNamed(context, '/signIn');
}


}

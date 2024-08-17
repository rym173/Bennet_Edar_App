
import 'package:bennet_eddar_cook/utils/userAuthentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
Future<String?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('user_id');
  return userId;
}

Future<String> getImageUrl(String imagePath) async {
  final firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  String downloadURL = await storage.ref(imagePath).getDownloadURL();
  return downloadURL;
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userName = prefs.getString('user_name') ?? '';
  return userName;
}


Future<String> getUserEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userEmail = prefs.getString('user_email') ?? '';
  return userEmail;
}

Future <int?> getUserPhoneNumber () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? phoneString = prefs.getString("user_phone");
  int? phone = phoneString != null ? int.tryParse(phoneString) : null;
  return phone;
}

Future<bool> modifyUserInfos(String key, String newValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String existingValue = prefs.getString(key) ?? '';
  existingValue = newValue;
  prefs.setString(key, existingValue);
  return true;
}

Future<bool> modifyUserPassword(String newValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String existingValue = prefs.getString('user_password') ?? '';
  existingValue = UserAuthentication.hashPassword(newValue, 'unique_salt_for_each_user');
  prefs.setString('user_password', existingValue);
  print('shared preference password changed');
  return true;
}

Future <String> getUserPassword () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? password = prefs.getString("user_password")?? '';
  return password;
}
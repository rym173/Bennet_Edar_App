import 'package:bennet_eddar_cook/screens/AccountSettings/AccountSettings.dart';
import 'package:bennet_eddar_cook/screens/Home&Details/HomePage.dart';
import 'package:bennet_eddar_cook/screens/IntroductoryPages/Welcome.dart';
import 'package:bennet_eddar_cook/screens/PostMenu/PostMenu.dart';
import 'package:bennet_eddar_cook/widgets/BottomBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:bennet_eddar_cook/widgets/BottomBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/sign_in/signIn.dart';
//import 'screens/sign_up/signUpphoneNumber.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/sign_in/forget_password/forgetPassword.dart';
//import 'screens/sign_in/forget_password/resetCode.dart';
//import 'screens/sign_up/signUpVerifyPhoneNumber.dart';
//import 'screens/ordering/addToOrder.dart';
import 'screens/LocationIdentification/EnterLocation.dart';
import 'screens/LocationIdentification/TypeLocation.dart';
import 'package:bennet_eddar_cook/utils/userAuthentication.dart';
import 'models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
//import 'package:provider/provider.dart';

final dio = Dio();
SharedPreferences? prefs;
User? user;
final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();
bool isConnected= false;
late int cookID ;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  await my_init_app();
  // Initialize Firebase App Check
  await FirebaseAppCheck.instance.activate(webProvider: ReCaptchaEnterpriseProvider('***'));
  runApp(
    const MyApp(),
  );
}

Future<bool> my_init_app() async {
  prefs = await SharedPreferences.getInstance();
  user = await UserAuthentication.getLoggedUser();
  return true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => ChangeNotifier()),
      ],
      child: MaterialApp(
        title: 'Bennet Eddar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
       home: user == null ? Welcome() : BottomBar(),
        routes: {
          '/welcome': (context) => const Welcome(),
          '/signIn': (context) => const SignInScreen(),
           //'/signUpVerifyPhoneNumber': (context) => signUpVerifyPhoneNumber(),
          '/forgetPassword': (context) => const ForgetPasswordScreen(),
          //'/resetCode': (context) => ResetCodeSentScreen(),
          //'/resetPage': (context) => ResetPage(),
          '/homePage': (context) => const CookProfile(),
          //'/addToOrder': (context) => AddToOrderScreen(),
          '/typeLocation': (context) => const TypeLocation(),
          '/enterLocation': (context) => const EnterLocation(),
          '/accountSettings': (context) => const AccountSettings(),
          '/cookProfile': (context) => const CookProfile(),
          '/postMenu':(context) => const PostMenu(),
          '/bottomBar': (context) => const BottomBar(),
        },
      ),
    );
  }
}

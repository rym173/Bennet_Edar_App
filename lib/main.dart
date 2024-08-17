import 'package:bennet_eddar_app/firebase_options.dart';
import 'package:bennet_eddar_app/screens/AccountSettings/AccountSettings.dart';
import 'package:bennet_eddar_app/screens/cookProfile/CookProfile.dart';
import 'package:bennet_eddar_app/screens/Home&Details/HomePage.dart';
import 'package:bennet_eddar_app/screens/IntroductoryPages/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'screens/sign_in/signIn.dart';
import 'screens/sign_up/signUpphoneNumber.dart';
import 'screens/sign_in/forget_password/forgetPassword.dart';
import 'screens/sign_in/forget_password/resetCode.dart';
import 'screens/sign_in/forget_password/resetPage.dart';
import 'screens/sign_up/signUpVerifyPhoneNumber.dart';
import 'screens/ordering/addToOrder.dart';
import 'screens/ordering/ordered_item_model.dart'; 
import 'screens/search/searchResultPage.dart';
import 'screens/LocationIdentification/EnterLocation.dart';
import 'screens/LocationIdentification/TypeLocation.dart';
import 'package:firebase_storage/firebase_storage.dart';


final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();
Future<bool> my_init_app() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return true;
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await my_init_app();
  runApp(
    ChangeNotifierProvider(
      create: (context) => OrderedItemsModel(), 
      child: MyApp(),
    ),
  );
}
/*class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Welcome(),
      /*  routes: {
       HomeScreen.pageRoute: (ctx) => HomeScreen(),
       WelcomeScreen.pageRoute: (ctx) => WelcomeScreen(),
       CustomizeScreen.pageRoute: (ctx) => CustomizeScreen(),
     },*/
    );
  }
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benet Eddar',
      theme: ThemeData(
      ),
      initialRoute: '/Welcome',
      routes: {
        '/Welcome': (context) => Welcome(),
        '/Home': (context) => HomePage(),
        '/signIn': (context) => SignInScreen(),
        '/CookProfile': (context) => CookProfile(),
        '/signUpphoneNumber': (context) => SignUpScreenPhoneNumber(),
        '/forgetPassword': (context) => ForgetPasswordScreen(),
        '/resetCodeSent': (context) => ResetCodeSentScreen(),
        '/resetPassword': (context) => ResetPage(),
        '/verifyPhoneNumber': (context) => VerifyPhoneNumberScreen(),
        '/addToOrder': (context) => AddToOrderScreen(menuId: '1',),
        '/SearchResult': (context) => SearchResultPage(),
        '/TypeLocation': (context) => TypeLocation(),
        '/EnterLocation': (context) => EnterLocation(),
        '/Settings': (context) => AccountSettings(),
        
      },
    );
  }
}

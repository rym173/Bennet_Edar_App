import 'dart:async';
import 'package:bennet_eddar_cook/screens/sign_in/link_text_widget.dart';
import 'package:bennet_eddar_cook/screens/SignUp/SignUp.dart';
import 'package:bennet_eddar_cook/widgets/button_widget.dart';
import 'package:bennet_eddar_cook/widgets/input_square_widget.dart';
import 'package:bennet_eddar_cook/widgets/title_subtitle_widget.dart';
import 'package:bennet_eddar_cook/widgets/top_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class VerifyPhoneNumberScreen extends StatefulWidget {
  final String location;
  final String phoneNumber;

  const VerifyPhoneNumberScreen({super.key, required this.location, required this.phoneNumber});

  @override
  _VerifyPhoneNumberScreenState createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  String verificationId = "";
  int _resendToken = 0;
  int _secondsRemaining = 60; // Initial time to expire in seconds
  late Timer _timer;
  

  // Function to update the time remaining every second
  void _updateTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          // Stop the timer when time expires
          timer.cancel();
        }
      });
    });
  }

  // Function to reset the timer and initiate phone number verification
  Future<void> _resendCode() async {
    setState(() {
      _secondsRemaining = 60; // Reset time to expire
      _resendToken++; // Increment resend token
    });

    // Initiate phone number verification
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
      forceResendingToken: _resendToken,
    );

    // Start the timer
    _updateTimer();

    // Display a message (e.g., use a SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code sent again'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Function to handle phone verification completion
  void _verificationCompleted(PhoneAuthCredential credential) {
    print('Auto verification completed: $credential');
  }

  // Function to handle phone verification failure
  void _verificationFailed(FirebaseAuthException authException) {
    print('Verification failed: $authException');
    // Handle verification failure (e.g., show an error message)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code incorrecte'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Function to handle code sent
  void _codeSent(String verificationId, int? resendToken) {
    print('Code sent: $verificationId');
    setState(() {
      this.verificationId = verificationId;
      _resendToken = resendToken ?? 0; // Ensure resend token is not null
    });

    // Start the timer
    _updateTimer();
  }

  // Function to handle code auto retrieval timeout
  void _codeAutoRetrievalTimeout(String verificationId) {
    print('Auto retrieval timeout: $verificationId');
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const AppTopBar(title: 'Inscription'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppTitle(text: 'Vérifiez votre numéro de téléphone'),
                  SizedBox(height: screenHeight * 0.03),
                  const AppSubtitle(
                    text: 'Entrez le code à 6 chiffres envoyé à votre numéro de téléphone',
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < 6; i++)
                        InputSquare(
                          controller: controllers[i],
                          focusNode: focusNodes[i],
                          
                        ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  AppElevatedButton(
                    onPressed: () {
                      String verificationCode = controllers
                          .map((controller) => controller.text)
                          .join();

                      signInWithPhoneNumber(verificationCode);
                    },
                    label: 'VÉRIFIER LE CODE',
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text('Code toujours pas reçu ?'),
                    SizedBox(width: screenWidth*0.01,),
                    AppLink(
                    onPressed: _resendCode,
                    text: 'Renvoyer le code',
                  ),
                  ],
                  ),
                  
                  SizedBox(height: screenHeight * 0.04),
                  Text('Durée d\'expiration: $_secondsRemaining secondes'),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> signInWithPhoneNumber(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Log the verification code
      print('Verification code entered: $smsCode');

      // Navigate to SignUpScreen with location and phone number
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp(
            location: widget.location,
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } catch (e) {
      print('Error verifying phone number: $e');
          ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code incorrecte'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
      // Handle verification failure
    }
  }

  // Function to initiate phone number verification
  Future<void> verifyPhoneNumber() async {
    try {
      verificationCompleted(PhoneAuthCredential credential) async {
        // This callback will be called if the automatic verification is done
        // For example, if you're automatically signed in with Google
        // credential.
        print('Auto verification completed: $credential');
      }

      verificationFailed(FirebaseAuthException authException) {
        // This callback will be called if verification failed
        print('Verification failed: $authException');
      }

      codeSent(String verificationId, int? resendToken) async {
        // This callback will be called when the verification code is sent
        print('Code sent: $verificationId');
        setState(() {
          this.verificationId = verificationId;
          _resendToken = resendToken ?? 0; // Ensure resend token is not null
        });
      }

      codeAutoRetrievalTimeout(String verificationId) {
        // This callback will be called when the automatic retrieval of the
        // verification code times out
        print('Auto retrieval timeout: $verificationId');
      }

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );

      // Start the timer
      _updateTimer();
    } catch (e) {
      print('Error verifying phone number: $e');
      // Handle verification initiation failure
    }
  }

  @override
  void initState() {
    super.initState();
    // Initiate phone number verification when the screen is loaded
    verifyPhoneNumber();
  }
}


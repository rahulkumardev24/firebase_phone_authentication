import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/screen/otp_screen.dart';
import 'package:mobile_authentication/screen/phone_auth_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PhoneAuthScreen()
    );
  }
}



/// ---------------------PHONE AUTHENTICATION----------------------///
/// SIMPLE STEPS
/// Step 1
/// Project set up => Done
/// Step 2
/// connect with firebase => Done
/// Step 3
/// add dependency => Done
/// some steps for phone authentications
/// internet permission
/// SHA:1 Key
/// SHA:256 key
/// DONE
/// Step 4
/// create ui => DONE
/// Step 5
/// implement phone authentication => Done
/// Step 6
/// final test => Done
/// Check on real Device
/// It is working
///
/// something we change show i will review
/// If You face billing account error then first create billing account

